// POST /api/auth-login
// Body: { email, password }
// Returns: { token, user }

const { supabase }                 = require('./_utils/db');
const { signToken, comparePassword } = require('./_utils/auth');
const { json, error, preflight }   = require('./_utils/cors');

exports.handler = async (event) => {
  if (event.httpMethod === 'OPTIONS') return preflight();
  if (event.httpMethod !== 'POST')    return error('Method not allowed', 405);

  let body;
  try { body = JSON.parse(event.body || '{}'); }
  catch { return error('Invalid JSON', 400); }

  const { email, password } = body;
  if (!email || !password) return error('Email and password required');

  try {
    // Find user
    const { data: user, error: userErr } = await supabase
      .from('users')
      .select('id, email, password_hash, first_name, last_name, city, province, is_active')
      .eq('email', email.toLowerCase().trim())
      .single();

    if (userErr || !user || !user.is_active)
      return error('Invalid email or password', 401);

    // Verify password
    const valid = await comparePassword(password, user.password_hash);
    if (!valid) return error('Invalid email or password', 401);

    // Get seller profile
    const { data: seller } = await supabase
      .from('sellers')
      .select('id, shop_name')
      .eq('user_id', user.id)
      .single();

    const token = signToken({
      userId:   user.id,
      sellerId: seller?.id   || null,
      shopName: seller?.shop_name || null,
      email:    user.email,
    });

    return json({
      token,
      user: {
        id:         user.id,
        email:      user.email,
        first_name: user.first_name,
        last_name:  user.last_name,
        city:       user.city,
        province:   user.province,
        shop_name:  seller?.shop_name || null,
      },
    });

  } catch (err) {
    console.error('[auth-login]', err);
    return error('Login failed', 500);
  }
};

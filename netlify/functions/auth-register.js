// POST /api/auth-register
// Multi-step seller onboarding.
// Step 1: create user account  → returns JWT
// Step 2: save shop details    → requires JWT
// Step 3: save first listing   → requires JWT

const { supabase }                       = require('./_utils/db');
const { signToken, getUserFromRequest,
        hashPassword }                   = require('./_utils/auth');
const { json, error, preflight }         = require('./_utils/cors');

// ── helpers ──────────────────────────────
const isValidEmail = (e) => /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(e);
const VALID_PROVS  = ['AB','BC','MB','NB','NL','NS','NT','NU','ON','PE','QC','SK','YT'];

exports.handler = async (event) => {
  if (event.httpMethod === 'OPTIONS') return preflight();
  if (event.httpMethod !== 'POST')    return error('Method not allowed', 405);

  let body;
  try { body = JSON.parse(event.body || '{}'); }
  catch { return error('Invalid JSON', 400); }

  const { step } = body;

  // ════════════════════════════════════════
  // STEP 1 — Account creation
  // ════════════════════════════════════════
  if (step === 1) {
    const { first_name, last_name, email, password, city, province } = body;

    if (!first_name || !last_name)   return error('First and last name required');
    if (!isValidEmail(email))        return error('Invalid email address');
    if (!password || password.length < 8) return error('Password must be at least 8 characters');
    if (!city)                       return error('City required');
    if (!VALID_PROVS.includes(province)) return error('Invalid province code');

    const password_hash = await hashPassword(password);

    // Insert user
    const { data: userRows, error: userErr } = await supabase
      .from('users')
      .insert([{ first_name, last_name, email, password_hash, city, province }])
      .select('id, email, first_name, last_name, city, province');

    if (userErr) {
      if (userErr.message.includes('unique') || userErr.code === '23505')
        return error('Email already registered', 409);
      console.error('[register step1]', userErr);
      return error('Could not create account', 500);
    }

    const user = userRows[0];

    // Create placeholder seller (shop_name filled in step 2)
    const placeholderShop = `shop-${user.id.slice(0, 8)}`;
    const { data: sellerRows, error: sellerErr } = await supabase
      .from('sellers')
      .insert([{
        user_id:       user.id,
        shop_name:     placeholderShop,
        city,
        province,
        fulfil_option: 'pickup',
        payout_method: 'etransfer',
      }])
      .select('id');

    if (sellerErr) {
      console.error('[register step1 seller]', sellerErr);
      return error('Could not create seller profile', 500);
    }

    const token = signToken({
      userId:   user.id,
      sellerId: sellerRows[0].id,
      email,
    });

    return json({ token, user: { id: user.id, email, first_name, city, province } }, 201);
  }

  // ════════════════════════════════════════
  // STEP 2 — Shop details
  // ════════════════════════════════════════
  if (step === 2) {
    const user = getUserFromRequest({ headers: { get: (k) => event.headers[k.toLowerCase()] } });
    if (!user) return error('Unauthorized', 401);

    const { shop_name, tagline, about, printers, fulfil_option, payout_method } = body;
    if (!shop_name || shop_name.trim().length < 3)
      return error('Shop name must be at least 3 characters');

    const { error: updErr } = await supabase
      .from('sellers')
      .update({
        shop_name:     shop_name.trim(),
        tagline:       tagline   || null,
        about:         about     || null,
        printers:      printers  || [],
        fulfil_option: fulfil_option || 'pickup',
        payout_method: payout_method || 'etransfer',
        updated_at:    new Date().toISOString(),
      })
      .eq('id', user.sellerId);

    if (updErr) {
      if (updErr.message.includes('unique') || updErr.code === '23505')
        return error('Shop name already taken', 409);
      console.error('[register step2]', updErr);
      return error('Could not save shop details', 500);
    }

    return json({ success: true });
  }

  // ════════════════════════════════════════
  // STEP 3 — First listing
  // ════════════════════════════════════════
  if (step === 3) {
    const user = getUserFromRequest({ headers: { get: (k) => event.headers[k.toLowerCase()] } });
    if (!user) return error('Unauthorized', 401);

    const { title, description, category, material, price, compare_price, lead_time, tags } = body;

    if (!title || title.trim().length < 5) return error('Title must be at least 5 characters');
    if (!category)                         return error('Category required');
    if (!price || isNaN(price) || price <= 0) return error('Valid price required');

    // Get seller's city/province
    const { data: seller } = await supabase
      .from('sellers')
      .select('city, province')
      .eq('id', user.sellerId)
      .single();

    const { data: listingRows, error: listErr } = await supabase
      .from('listings')
      .insert([{
        seller_id:       user.sellerId,
        title:           title.trim(),
        description:     description || null,
        category,
        material:        material || null,
        printer_type:    material || null,
        price:           parseFloat(price),
        compare_price:   compare_price ? parseFloat(compare_price) : null,
        lead_time_days:  lead_time || null,
        tags:            tags || [],
        city:            seller?.city     || '',
        province:        seller?.province || '',
        is_new:          true,
        is_active:       true,
      }])
      .select('id, title, price');

    if (listErr) {
      console.error('[register step3]', listErr);
      return error('Could not create listing', 500);
    }

    return json({ success: true, listing: listingRows[0] }, 201);
  }

  return error('Invalid step — must be 1, 2, or 3', 400);
};

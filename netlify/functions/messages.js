// POST /api/messages
// Body: { listing_id, seller_id, buyer_name, buyer_email, subject, body }

const { supabase }         = require('./_utils/db');
const { json, error, preflight } = require('./_utils/cors');

const isValidEmail = (e) => /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(e);

exports.handler = async (event) => {
  if (event.httpMethod === 'OPTIONS') return preflight();
  if (event.httpMethod !== 'POST')    return error('Method not allowed', 405);

  let body;
  try { body = JSON.parse(event.body || '{}'); }
  catch { return error('Invalid JSON', 400); }

  const { listing_id, seller_id, buyer_name, buyer_email, subject, body: msgBody } = body;

  if (!seller_id)              return error('seller_id required');
  if (!buyer_name)             return error('Your name is required');
  if (!isValidEmail(buyer_email)) return error('Valid email required');
  if (!subject || subject.trim().length < 3) return error('Subject too short');
  if (!msgBody || msgBody.trim().length < 10) return error('Message too short (min 10 chars)');

  try {
    const { data, error: dbErr } = await supabase
      .from('messages')
      .insert([{
        listing_id: listing_id || null,
        seller_id,
        buyer_name:  buyer_name.trim(),
        buyer_email: buyer_email.toLowerCase().trim(),
        subject:     subject.trim(),
        body:        msgBody.trim(),
      }])
      .select('id, created_at');

    if (dbErr) {
      console.error('[messages]', dbErr);
      return error('Could not send message', 500);
    }

    return json({ success: true, id: data[0].id }, 201);

  } catch (err) {
    console.error('[messages]', err);
    return error(err.message, 500);
  }
};

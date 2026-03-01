// GET /api/shop?id=SELLER_UUID
// Returns full seller profile + all their listings + recent reviews

const { supabase } = require('./_utils/db');
const { json, error, preflight } = require('./_utils/cors');

exports.handler = async (event) => {
  if (event.httpMethod === 'OPTIONS') return preflight();
  if (event.httpMethod !== 'GET') return error('Method not allowed', 405);

  try {
    const id = (event.queryStringParameters || {}).id;
    if (!id) return error('Missing seller id', 400);

    // ── 1. Seller profile ──────────────────────────────────────
    const { data: seller, error: sellerErr } = await supabase
      .from('sellers')
      .select('*')
      .eq('id', id)
      .eq('is_active', true)
      .single();

    if (sellerErr || !seller) return error('Shop not found', 404);

    // ── 2. All active listings for this seller ─────────────────
    const { data: listings, error: listErr } = await supabase
      .from('listings')
      .select('*')
      .eq('seller_id', id)
      .eq('is_active', true)
      .order('avg_rating', { ascending: false })
      .order('created_at', { ascending: false });

    if (listErr) throw listErr;

    // ── 3. Recent reviews across all seller listings ───────────
    const listingIds = (listings || []).map(l => l.id);
    let reviews = [];
    if (listingIds.length > 0) {
      const { data: rev, error: revErr } = await supabase
        .from('reviews')
        .select('*')
        .in('listing_id', listingIds)
        .order('created_at', { ascending: false })
        .limit(30);
      if (!revErr) reviews = rev || [];
    }

    // ── 4. Attach listing title to each review ─────────────────
    const titleMap = {};
    (listings || []).forEach(l => { titleMap[l.id] = l.title; });
    reviews = reviews.map(r => ({
      ...r,
      listing_title: titleMap[r.listing_id] || '',
    }));

    return json({
      seller,
      listings: listings || [],
      reviews,
    });

  } catch (err) {
    console.error('[shop]', err);
    return error(err.message, 500);
  }
};

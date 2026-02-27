// GET /api/listing?id=X
// Returns: listing detail + reviews + related listings from same seller

const { supabase } = require('./_utils/db');
const { json, error, preflight } = require('./_utils/cors');

exports.handler = async (event) => {
  if (event.httpMethod === 'OPTIONS') return preflight();
  if (event.httpMethod !== 'GET') return error('Method not allowed', 405);

  try {
    const id = parseInt((event.queryStringParameters || {}).id, 10);
    if (!id || isNaN(id)) return error('Missing or invalid id', 400);

    // ── LISTING + SELLER ──
    const { data: listing, error: listErr } = await supabase
      .from('listings')
      .select(`
        *,
        seller:sellers (
          id, shop_name, tagline, about,
          city, province,
          avg_rating, total_reviews, total_sales, is_verified
        )
      `)
      .eq('id', id)
      .eq('is_active', true)
      .single();

    if (listErr || !listing) return error('Listing not found', 404);

    // Increment view count (fire-and-forget)
    supabase
      .from('listings')
      .update({ view_count: (listing.view_count || 0) + 1 })
      .eq('id', id)
      .then(() => {});

    // ── REVIEWS ──
    const { data: reviews } = await supabase
      .from('reviews')
      .select('id, buyer_name, buyer_city, rating, comment, created_at')
      .eq('listing_id', id)
      .order('created_at', { ascending: false })
      .limit(12);

    // ── RELATED: other listings from same seller ──
    const { data: related } = await supabase
      .from('listings')
      .select('id, title, price, featured_image_url, avg_rating, total_reviews, category')
      .eq('seller_id', listing.seller_id)
      .eq('is_active', true)
      .neq('id', id)
      .order('created_at', { ascending: false })
      .limit(4);

    return json({ listing, reviews: reviews || [], related: related || [] });

  } catch (err) {
    console.error('[listing]', err);
    return error(err.message, 500);
  }
};

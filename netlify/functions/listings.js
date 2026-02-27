// GET /api/listings
// Query params: cat, city, sort, q, pickup, custom, under25, resin, limit, offset

const { supabase } = require('./_utils/db');
const { json, error, preflight } = require('./_utils/cors');

exports.handler = async (event) => {
  if (event.httpMethod === 'OPTIONS') return preflight();
  if (event.httpMethod !== 'GET') return error('Method not allowed', 405);

  try {
    const p = event.queryStringParameters || {};
    const category  = p.cat    || null;
    const city      = p.city   || null;
    const sort      = p.sort   || 'featured';
    const q         = (p.q    || '').trim();
    const pickup    = p.pickup  === 'true';
    const custom    = p.custom  === 'true';
    const under25   = p.under25 === 'true';
    const resin     = p.resin   === 'true';
    const limit     = Math.min(parseInt(p.limit  || '60', 10), 100);
    const offset    = Math.max(parseInt(p.offset || '0',  10), 0);

    let query = supabase
      .from('listings_with_seller')
      .select('*', { count: 'exact' });

    // ── FILTERS ──
    if (category && category !== 'all') query = query.eq('category', category);
    if (city     && city     !== 'all') query = query.eq('city', city);
    if (pickup)   query = query.eq('pickup_available', true);
    if (custom)   query = query.eq('custom_orders',    true);
    if (under25)  query = query.lt('price', 25);
    if (resin)    query = query.eq('printer_type', 'Resin');

    if (q) {
      // Search title + shop_name (Supabase ilike, case-insensitive)
      query = query.or(`title.ilike.%${q}%,shop_name.ilike.%${q}%,city.ilike.%${q}%`);
    }

    // ── SORT ──
    switch (sort) {
      case 'newest':     query = query.order('created_at',   { ascending: false }); break;
      case 'price-asc':  query = query.order('price',        { ascending: true  }); break;
      case 'price-desc': query = query.order('price',        { ascending: false }); break;
      case 'rating':     query = query.order('avg_rating',   { ascending: false })
                                      .order('total_reviews',{ ascending: false }); break;
      case 'popular':    query = query.order('total_reviews',{ ascending: false }); break;
      default: // featured
        query = query.order('is_on_sale', { ascending: false })
                     .order('is_new',     { ascending: false })
                     .order('avg_rating', { ascending: false });
    }

    // ── PAGINATION ──
    query = query.range(offset, offset + limit - 1);

    const { data, error: dbErr, count } = await query;
    if (dbErr) throw dbErr;

    return json({ listings: data || [], total: count || 0, limit, offset });

  } catch (err) {
    console.error('[listings]', err);
    return error(err.message, 500);
  }
};

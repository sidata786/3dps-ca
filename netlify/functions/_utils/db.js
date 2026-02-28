const { createClient } = require('@supabase/supabase-js');

const url = process.env.SUPABASE_URL;
const key = process.env.SUPABASE_SERVICE_KEY;

// Lazy-init so a missing env var returns a proper 500 rather than crashing the lambda
let _supabase = null;
function getSupabase() {
  if (!_supabase) {
    if (!url || !key) throw new Error('Missing SUPABASE_URL or SUPABASE_SERVICE_KEY');
    _supabase = createClient(url, key, { auth: { persistSession: false } });
  }
  return _supabase;
}

// Proxy object so callers can still write `supabase.from(...)` unchanged
const supabase = new Proxy({}, {
  get(_, prop) {
    return (...args) => getSupabase()[prop](...args);
  }
});

module.exports = { supabase };

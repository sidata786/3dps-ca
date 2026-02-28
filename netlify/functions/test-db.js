// Diagnostic: test supabase import and connection in isolation
exports.handler = async () => {
  const result = { step: 'start' };
  try {
    result.step = 'require';
    const { createClient } = require('@supabase/supabase-js');
    result.step = 'createClient';
    const client = createClient(
      process.env.SUPABASE_URL,
      process.env.SUPABASE_SERVICE_KEY,
      { auth: { persistSession: false } }
    );
    result.step = 'query';
    const { data, error } = await client.from('listings').select('id').limit(1);
    result.step = 'done';
    result.data = data;
    result.dbError = error ? error.message : null;
  } catch (err) {
    result.caught = err.message;
    result.stack = err.stack ? err.stack.split('\n').slice(0, 5).join('\n') : null;
  }
  return {
    statusCode: 200,
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(result),
  };
};

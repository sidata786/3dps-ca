const CORS_HEADERS = {
  'Access-Control-Allow-Origin':  '*',
  'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
  'Access-Control-Allow-Headers': 'Content-Type, Authorization',
  'Content-Type':                 'application/json',
};

function json(data, status = 200) {
  return new Response(JSON.stringify(data), {
    status,
    headers: CORS_HEADERS,
  });
}

function error(message, status = 400) {
  return json({ error: message }, status);
}

function preflight() {
  return new Response(null, { status: 204, headers: CORS_HEADERS });
}

module.exports = { CORS_HEADERS, json, error, preflight };

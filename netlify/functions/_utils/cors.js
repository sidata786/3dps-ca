const CORS_HEADERS = {
  'Access-Control-Allow-Origin':  '*',
  'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
  'Access-Control-Allow-Headers': 'Content-Type, Authorization',
  'Content-Type':                 'application/json',
};

// Netlify Functions v1 expect plain objects, not `new Response()`
function json(data, status = 200) {
  return {
    statusCode: status,
    headers: CORS_HEADERS,
    body: JSON.stringify(data),
  };
}

function error(message, status = 400) {
  return json({ error: message }, status);
}

function preflight() {
  return {
    statusCode: 204,
    headers: CORS_HEADERS,
    body: '',
  };
}

module.exports = { CORS_HEADERS, json, error, preflight };

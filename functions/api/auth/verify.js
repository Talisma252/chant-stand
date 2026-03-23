import { verifyJWT } from '../_middleware.js';

export async function onRequestGet({ request, env }) {
    const auth = request.headers.get('Authorization');
    if (!auth || !auth.startsWith('Bearer ')) return json({ error: 'Unauthorised' }, 401);
    const payload = await verifyJWT(auth.slice(7), env.JWT_SECRET);
    if (!payload) return json({ error: 'Invalid or expired token' }, 401);
    return json({ valid: true, role: payload.role });
}

function json(data, status = 200) {
    return new Response(JSON.stringify(data), { status, headers: { 'Content-Type': 'application/json' } });
}

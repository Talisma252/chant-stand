import { createJWT } from '../_middleware.js';

export async function onRequestPost({ request, env }) {
    try {
        const { password } = await request.json();
        if (!password) return json({ error: 'Password required' }, 400);
        if (password !== env.EDITOR_PASSWORD) return json({ error: 'Invalid password' }, 401);

        const now = Math.floor(Date.now() / 1000);
        const payload = { role: 'editor', iat: now, exp: now + 86400 };
        const token = await createJWT(payload, env.JWT_SECRET);
        return json({ token, expires_at: payload.exp });
    } catch (e) {
        return json({ error: 'Invalid request' }, 400);
    }
}

function json(data, status = 200) {
    return new Response(JSON.stringify(data), { status, headers: { 'Content-Type': 'application/json' } });
}

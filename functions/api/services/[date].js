import { verifyJWT } from '../_middleware.js';

export async function onRequestGet({ params, env }) {
    const date = params.date;
    if (!date || !/^\d{4}-\d{2}-\d{2}$/.test(date)) return json({ error: 'Valid YYYY-MM-DD date required' }, 400);

    try {
        const feast = await env.DB.prepare("SELECT en, ro, tone FROM feasts WHERE date = ?").bind(date).first();
        const { results: services } = await env.DB.prepare("SELECT id, name_en, name_ro, time, has_en, has_ro FROM services WHERE date = ? ORDER BY time").bind(date).all();

        return json({
            date,
            feast: feast || null,
            services: (services || []).map(s => ({ ...s, has_en: !!s.has_en, has_ro: !!s.has_ro })),
        }, 200, { 'Cache-Control': 'public, max-age=60' });
    } catch (e) {
        return json({ error: 'Failed to load services' }, 500);
    }
}

// POST /api/services/:date — Add a service to a date (authenticated)
export async function onRequestPost({ request, params, env }) {
    const auth = request.headers.get('Authorization');
    if (!auth || !auth.startsWith('Bearer ')) return json({ error: 'Unauthorised' }, 401);
    const payload = await verifyJWT(auth.slice(7), env.JWT_SECRET);
    if (!payload || payload.role !== 'editor') return json({ error: 'Invalid or expired token' }, 401);

    const date = params.date;
    if (!date || !/^\d{4}-\d{2}-\d{2}$/.test(date)) return json({ error: 'Valid YYYY-MM-DD date required' }, 400);

    try {
        const body = await request.json();
        const { id, name_en, name_ro, time, has_en, has_ro } = body;

        if (!id || !name_en) return json({ error: 'id and name_en are required' }, 400);

        // Check for duplicate
        const existing = await env.DB.prepare("SELECT id FROM services WHERE id = ? AND date = ?").bind(id, date).first();
        if (existing) return json({ error: 'Service already exists for this date' }, 409);

        await env.DB.prepare(
            "INSERT INTO services (id, date, name_en, name_ro, time, has_en, has_ro) VALUES (?, ?, ?, ?, ?, ?, ?)"
        ).bind(id, date, name_en, name_ro || '', time || '', has_en ? 1 : 0, has_ro ? 1 : 0).run();

        return json({ success: true, id, date });
    } catch (e) {
        return json({ error: 'Failed to add service' }, 500);
    }
}

// DELETE /api/services/:date — Remove a service (authenticated)
export async function onRequestDelete({ request, params, env }) {
    const auth = request.headers.get('Authorization');
    if (!auth || !auth.startsWith('Bearer ')) return json({ error: 'Unauthorised' }, 401);
    const payload = await verifyJWT(auth.slice(7), env.JWT_SECRET);
    if (!payload || payload.role !== 'editor') return json({ error: 'Invalid or expired token' }, 401);

    const date = params.date;
    const url = new URL(request.url);
    const serviceId = url.searchParams.get('id');

    if (!date || !serviceId) return json({ error: 'date and id are required' }, 400);

    try {
        await env.DB.prepare("DELETE FROM services WHERE id = ? AND date = ?").bind(serviceId, date).run();
        return json({ success: true });
    } catch (e) {
        return json({ error: 'Failed to delete service' }, 500);
    }
}

function json(data, status = 200, extra = {}) {
    return new Response(JSON.stringify(data), { status, headers: { 'Content-Type': 'application/json', ...extra } });
}

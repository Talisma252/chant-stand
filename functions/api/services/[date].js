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
        }, 200, { 'Cache-Control': 'public, max-age=300' });
    } catch (e) {
        return json({ error: 'Failed to load services' }, 500);
    }
}

function json(data, status = 200, extra = {}) {
    return new Response(JSON.stringify(data), { status, headers: { 'Content-Type': 'application/json', ...extra } });
}

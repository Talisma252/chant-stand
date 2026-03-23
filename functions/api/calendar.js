export async function onRequestGet({ request, env }) {
    const url = new URL(request.url);
    const year = parseInt(url.searchParams.get('year'), 10);
    const month = parseInt(url.searchParams.get('month'), 10);
    if (!year || !month || month < 1 || month > 12) return json({ error: 'Valid year and month required' }, 400);

    try {
        const { results } = await env.DB.prepare("SELECT date, en, ro, tone FROM feasts WHERE substr(date, 1, 7) = ?")
            .bind(`${year}-${String(month).padStart(2, '0')}`).all();
        return json({ feasts: results || [] }, 200, { 'Cache-Control': 'public, max-age=300' });
    } catch (e) {
        return json({ error: 'Failed to load calendar data' }, 500);
    }
}

function json(data, status = 200, extra = {}) {
    return new Response(JSON.stringify(data), { status, headers: { 'Content-Type': 'application/json', ...extra } });
}

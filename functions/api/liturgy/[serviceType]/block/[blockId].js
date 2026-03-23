import { verifyJWT } from '../../../_middleware.js';

export async function onRequestPut({ request, params, env }) {
    const auth = request.headers.get('Authorization');
    if (!auth || !auth.startsWith('Bearer ')) return json({ error: 'Unauthorised' }, 401);
    const payload = await verifyJWT(auth.slice(7), env.JWT_SECRET);
    if (!payload || payload.role !== 'editor') return json({ error: 'Invalid or expired token' }, 401);

    const { serviceType, blockId } = params;
    const id = parseInt(blockId, 10);
    if (isNaN(id)) return json({ error: 'Invalid block ID' }, 400);

    try {
        const body = await request.json();
        const { text_en, text_ro } = body;
        if (text_en === undefined && text_ro === undefined) return json({ error: 'text_en or text_ro required' }, 400);

        const existing = await env.DB.prepare("SELECT id FROM liturgy_blocks WHERE id = ? AND service_type = ?").bind(id, serviceType).first();
        if (!existing) return json({ error: 'Block not found' }, 404);

        const updates = [], values = [];
        if (text_en !== undefined) { updates.push('text_en = ?'); values.push(text_en); }
        if (text_ro !== undefined) { updates.push('text_ro = ?'); values.push(text_ro); }
        values.push(id);

        await env.DB.prepare(`UPDATE liturgy_blocks SET ${updates.join(', ')} WHERE id = ?`).bind(...values).run();
        return json({ success: true, block_id: id });
    } catch (e) {
        return json({ error: 'Failed to update block' }, 500);
    }
}

function json(data, status = 200) {
    return new Response(JSON.stringify(data), { status, headers: { 'Content-Type': 'application/json' } });
}

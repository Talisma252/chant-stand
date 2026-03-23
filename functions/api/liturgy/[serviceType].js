export async function onRequestGet({ params, env }) {
    const serviceType = params.serviceType;
    if (!['lit', 'mat', 'ves', 'h1', 'h3', 'h6', 'h9'].includes(serviceType)) {
        return json({ error: 'Invalid service type' }, 400);
    }

    try {
        const { results: blocks } = await env.DB.prepare(
            "SELECT id, sort_order, role, text_en, text_ro, anchor, is_divider, div_label FROM liturgy_blocks WHERE service_type = ? ORDER BY sort_order"
        ).bind(serviceType).all();

        if (!blocks || blocks.length === 0) return json({ service_type: serviceType, blocks: [] });

        const blockIds = blocks.map(b => b.id);
        const placeholders = blockIds.map(() => '?').join(',');
        const { results: notes } = await env.DB.prepare(
            `SELECT id, block_id, note_type, note_text, link_url, link_label FROM notes WHERE block_id IN (${placeholders}) ORDER BY sort_order`
        ).bind(...blockIds).all();

        const notesByBlock = {};
        (notes || []).forEach(n => {
            if (!notesByBlock[n.block_id]) notesByBlock[n.block_id] = [];
            notesByBlock[n.block_id].push(n);
        });

        return json({
            service_type: serviceType,
            blocks: blocks.map(b => ({ ...b, is_divider: !!b.is_divider, notes: notesByBlock[b.id] || [] })),
        }, 200, { 'Cache-Control': 'public, max-age=300' });
    } catch (e) {
        return json({ error: 'Failed to load liturgy data' }, 500);
    }
}

function json(data, status = 200, extra = {}) {
    return new Response(JSON.stringify(data), { status, headers: { 'Content-Type': 'application/json', ...extra } });
}

export async function onRequestGet({ params, env }) {
    const serviceType = params.serviceType;
    if (!['lit', 'mat', 'ves', 'h1', 'h3', 'h6', 'h9'].includes(serviceType)) {
        return json({ error: 'Invalid service type' }, 400);
    }

    try {
        // Get all blocks for this service type
        const { results: blocks } = await env.DB.prepare(
            "SELECT id, sort_order, role, text_en, text_ro, anchor, is_divider, div_label FROM liturgy_blocks WHERE service_type = ? ORDER BY sort_order"
        ).bind(serviceType).all();

        if (!blocks || blocks.length === 0) return json({ service_type: serviceType, blocks: [] });

        // Get all notes for blocks in this service type using a subquery (avoids bind limit)
        const { results: notes } = await env.DB.prepare(
            "SELECT n.id, n.block_id, n.note_type, n.note_text, n.link_url, n.link_label FROM notes n INNER JOIN liturgy_blocks b ON n.block_id = b.id WHERE b.service_type = ? ORDER BY n.sort_order"
        ).bind(serviceType).all();

        // Group notes by block_id
        const notesByBlock = {};
        (notes || []).forEach(n => {
            if (!notesByBlock[n.block_id]) notesByBlock[n.block_id] = [];
            notesByBlock[n.block_id].push({
                id: n.id,
                note_type: n.note_type,
                note_text: n.note_text,
                link_url: n.link_url,
                link_label: n.link_label,
            });
        });

        return json({
            service_type: serviceType,
            blocks: blocks.map(b => ({
                ...b,
                is_divider: !!b.is_divider,
                notes: notesByBlock[b.id] || [],
            })),
        }, 200, { 'Cache-Control': 'public, max-age=300' });
    } catch (e) {
        return json({ error: 'Failed to load liturgy data', detail: e.message }, 500);
    }
}

function json(data, status = 200, extra = {}) {
    return new Response(JSON.stringify(data), { status, headers: { 'Content-Type': 'application/json', ...extra } });
}

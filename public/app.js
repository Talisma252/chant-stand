/* ============================================================
   Digital Chant Stand — app.js
   Vanilla JavaScript SPA
   ============================================================ */

(function () {
    'use strict';

    // ---- State ----
    const state = {
        currentTab: 'calendar',
        calYear: new Date().getFullYear(),
        calMonth: new Date().getMonth(), // 0-indexed
        selectedDate: null,
        selectedService: null,
        language: localStorage.getItem('cs_lang') || 'en',
        fontSize: parseInt(localStorage.getItem('cs_fontsize') || '18', 10),
        showNotes: localStorage.getItem('cs_notes') !== 'false',
        choirMode: localStorage.getItem('cs_choir') === 'true',
        darkMode: localStorage.getItem('cs_dark') === 'true',
        wakeLock: null,
        editing: false,
        authToken: sessionStorage.getItem('cs_token') || null,
        feasts: {},    // keyed by 'YYYY-MM'
        liturgyCache: {},
    };

    const API = '/api';
    const MONTHS = ['January','February','March','April','May','June','July','August','September','October','November','December'];
    const DAYS = ['Sun','Mon','Tue','Wed','Thu','Fri','Sat'];

    // ---- DOM refs ----
    const $ = (sel) => document.querySelector(sel);
    const $$ = (sel) => document.querySelectorAll(sel);

    // ---- Init ----
    function init() {
        applyTheme();
        applyFontSize();
        applyLanguage();
        bindNav();
        bindCalendar();
        bindLiturgy();
        bindBooks();
        bindPrefs();
        bindEdit();
        bindAddService();
        renderCalendar();
        renderToday();
        loadCalendarFeasts();

        // Auto-load nearest Sunday's services so the app isn't empty
        autoLoadServices();

        // Register service worker
        if ('serviceWorker' in navigator) {
            navigator.serviceWorker.register('/sw.js').catch(() => {});
        }
    }

    // Auto-load today's services and Divine Liturgy so the app isn't empty
    function autoLoadServices() {
        const today = new Date();
        const dateStr = `${today.getFullYear()}-${String(today.getMonth() + 1).padStart(2, '0')}-${String(today.getDate()).padStart(2, '0')}`;
        state.selectedDate = dateStr;

        // Pre-load today's services for the Services tab
        loadServicesQuiet(dateStr);

        // Load the Divine Liturgy directly so the Liturgy tab has content
        loadLiturgy('lit');
    }

    // Load services without switching tab (for background pre-loading)
    async function loadServicesQuiet(date) {
        const label = $('#services-date-label');
        const list = $('#services-list');
        const feastDiv = $('#services-feast');

        const d = new Date(date + 'T12:00:00');
        label.textContent = d.toLocaleDateString('en-GB', { weekday: 'long', day: 'numeric', month: 'long', year: 'numeric' });
        feastDiv.classList.add('hidden');

        try {
            const res = await fetch(`${API}/services/${date}`);
            if (!res.ok) return;
            const data = await res.json();

            if (data.feast) {
                feastDiv.classList.remove('hidden');
                feastDiv.innerHTML = `
                    <div class="feast-en" style="font-weight:bold;color:var(--ocean);">${data.feast.en}</div>
                    <div class="feast-ro" style="font-family:var(--font-ro);font-style:italic;color:var(--text-muted);font-size:0.9rem;">${data.feast.ro}</div>
                    ${data.feast.tone != null ? `<div class="feast-tone" style="font-family:var(--font-label);font-size:0.75rem;color:var(--purple);margin-top:4px;">Tone ${data.feast.tone}</div>` : ''}
                `;
            }

            if (!data.services || data.services.length === 0) {
                list.innerHTML = '<div class="empty-state"><div class="empty-icon">⛪</div><p>No services scheduled for this date.</p></div>';
                return;
            }

            list.innerHTML = '';
            data.services.forEach(svc => {
                const card = document.createElement('div');
                card.className = 'service-card';
                card.innerHTML = `
                    <div class="service-info">
                        <h3>${svc.name_en}</h3>
                        <p>${svc.name_ro}</p>
                    </div>
                    <div class="service-meta">
                        ${svc.time ? `<span class="service-time">${svc.time}</span>` : ''}
                        ${svc.has_en ? '<span class="lang-badge en">EN</span>' : ''}
                        ${svc.has_ro ? '<span class="lang-badge ro">RO</span>' : ''}
                    </div>
                `;
                card.addEventListener('click', () => {
                    state.selectedService = svc.id;
                    loadLiturgy(svc.id);
                });
                list.appendChild(card);
            });
        } catch (e) {
            // Silently fail on pre-load
        }
    }

    // ---- Navigation ----
    function bindNav() {
        $$('.nav-btn').forEach(btn => {
            btn.addEventListener('click', () => {
                const tab = btn.dataset.tab;
                switchTab(tab);
                // Auto-load today's services if Services tab opened and empty
                if (tab === 'services' && !$('#services-list').children.length) {
                    const today = new Date();
                    const dateStr = `${today.getFullYear()}-${String(today.getMonth() + 1).padStart(2, '0')}-${String(today.getDate()).padStart(2, '0')}`;
                    state.selectedDate = dateStr;
                    loadServicesQuiet(dateStr);
                }
            });
        });
    }

    function switchTab(tab) {
        state.currentTab = tab;
        $$('.tab-content').forEach(el => el.classList.remove('active'));
        $$('.nav-btn').forEach(el => el.classList.remove('active'));
        $(`#tab-${tab}`).classList.add('active');
        $(`.nav-btn[data-tab="${tab}"]`).classList.add('active');
    }

    // ---- Calendar ----
    function bindCalendar() {
        $('#cal-prev').addEventListener('click', () => {
            state.calMonth--;
            if (state.calMonth < 0) { state.calMonth = 11; state.calYear--; }
            renderCalendar();
            loadCalendarFeasts();
        });
        $('#cal-next').addEventListener('click', () => {
            state.calMonth++;
            if (state.calMonth > 11) { state.calMonth = 0; state.calYear++; }
            renderCalendar();
            loadCalendarFeasts();
        });
    }

    function renderCalendar() {
        const year = state.calYear;
        const month = state.calMonth;
        $('#cal-month-label').textContent = `${MONTHS[month]} ${year}`;

        const grid = $('#calendar-grid');
        grid.innerHTML = '';

        // Day headers
        DAYS.forEach(d => {
            const h = document.createElement('div');
            h.className = 'cal-header';
            h.textContent = d;
            grid.appendChild(h);
        });

        const firstDay = new Date(year, month, 1).getDay();
        const daysInMonth = new Date(year, month + 1, 0).getDate();
        const today = new Date();
        const monthKey = `${year}-${String(month + 1).padStart(2, '0')}`;
        const feasts = state.feasts[monthKey] || [];

        // Empty cells before first day
        for (let i = 0; i < firstDay; i++) {
            const empty = document.createElement('div');
            empty.className = 'cal-day empty';
            grid.appendChild(empty);
        }

        // Day cells
        for (let d = 1; d <= daysInMonth; d++) {
            const cell = document.createElement('div');
            cell.className = 'cal-day';
            cell.textContent = d;

            const dateStr = `${year}-${String(month + 1).padStart(2, '0')}-${String(d).padStart(2, '0')}`;

            // Is today?
            if (year === today.getFullYear() && month === today.getMonth() && d === today.getDate()) {
                cell.classList.add('today');
            }

            // Has feast?
            const feast = feasts.find(f => f.date === dateStr);
            if (feast) {
                cell.classList.add('has-feast');
                if (feast.en && feast.en.includes('Parish Patron')) {
                    cell.classList.add('patron-feast');
                }
            }

            cell.addEventListener('click', () => {
                state.selectedDate = dateStr;
                showFeastDetail(feast);
                loadServices(dateStr);
            });

            grid.appendChild(cell);
        }
    }

    function showFeastDetail(feast) {
        const detail = $('#cal-feast-detail');
        if (!feast) {
            detail.classList.add('hidden');
            return;
        }
        detail.classList.remove('hidden');
        detail.innerHTML = `
            <div class="feast-en">${feast.en}</div>
            <div class="feast-ro">${feast.ro}</div>
            ${feast.tone != null ? `<div class="feast-tone">Tone ${feast.tone}</div>` : ''}
        `;
    }

    async function loadCalendarFeasts() {
        const monthKey = `${state.calYear}-${String(state.calMonth + 1).padStart(2, '0')}`;
        if (state.feasts[monthKey]) {
            renderCalendar(); // re-render with feast data
            return;
        }

        try {
            const res = await fetch(`${API}/calendar?year=${state.calYear}&month=${state.calMonth + 1}`);
            if (res.ok) {
                const data = await res.json();
                state.feasts[monthKey] = data.feasts || [];
                renderCalendar();
            }
        } catch (e) {
            console.warn('Failed to load calendar feasts:', e);
        }
    }

    function renderToday() {
        const today = new Date();
        const strip = $('#today-strip');
        const dateStr = today.toLocaleDateString('en-GB', { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' });
        strip.innerHTML = `<div class="today-date">${dateStr}</div>`;

        // Try to show today's feast
        const todayISO = `${today.getFullYear()}-${String(today.getMonth() + 1).padStart(2, '0')}-${String(today.getDate()).padStart(2, '0')}`;
        const monthKey = `${today.getFullYear()}-${String(today.getMonth() + 1).padStart(2, '0')}`;

        // Will be populated after feasts load
        setTimeout(() => {
            const feasts = state.feasts[monthKey] || [];
            const feast = feasts.find(f => f.date === todayISO);
            if (feast) {
                strip.innerHTML += `<div class="today-feast">${feast.en}</div>`;
            }
        }, 1000);
    }

    // ---- Services ----
    async function loadServices(date) {
        switchTab('services');
        const label = $('#services-date-label');
        const list = $('#services-list');
        const feastDiv = $('#services-feast');

        const d = new Date(date + 'T12:00:00');
        label.textContent = d.toLocaleDateString('en-GB', { weekday: 'long', day: 'numeric', month: 'long', year: 'numeric' });
        list.innerHTML = '<div class="loading">Loading services...</div>';
        feastDiv.classList.add('hidden');

        try {
            const res = await fetch(`${API}/services/${date}`);
            if (!res.ok) throw new Error('Failed to load');
            const data = await res.json();

            // Show feast
            if (data.feast) {
                feastDiv.classList.remove('hidden');
                feastDiv.innerHTML = `
                    <div class="feast-en" style="font-weight:bold;color:var(--ocean);">${data.feast.en}</div>
                    <div class="feast-ro" style="font-family:var(--font-ro);font-style:italic;color:var(--text-muted);font-size:0.9rem;">${data.feast.ro}</div>
                    ${data.feast.tone != null ? `<div class="feast-tone" style="font-family:var(--font-label);font-size:0.75rem;color:var(--purple);margin-top:4px;">Tone ${data.feast.tone}</div>` : ''}
                `;
            }

            // Show services
            if (!data.services || data.services.length === 0) {
                list.innerHTML = '<div class="empty-state"><div class="empty-icon">⛪</div><p>No services scheduled for this date.</p></div>';
                return;
            }

            list.innerHTML = '';
            data.services.forEach(svc => {
                const card = document.createElement('div');
                card.className = 'service-card';
                card.innerHTML = `
                    <div class="service-info">
                        <h3>${svc.name_en}</h3>
                        <p>${svc.name_ro}</p>
                    </div>
                    <div class="service-meta">
                        ${svc.time ? `<span class="service-time">${svc.time}</span>` : ''}
                        ${svc.has_en ? '<span class="lang-badge en">EN</span>' : ''}
                        ${svc.has_ro ? '<span class="lang-badge ro">RO</span>' : ''}
                    </div>
                `;
                card.addEventListener('click', () => {
                    state.selectedService = svc.id;
                    loadLiturgy(svc.id);
                });
                list.appendChild(card);
            });
            // Reset add service panel (keep hidden until user clicks + Add)
            $('#add-service-panel').classList.add('hidden');
        } catch (e) {
            list.innerHTML = '<div class="empty-state"><div class="empty-icon">⚠️</div><p>Could not load services. Please try again.</p></div>';
        }
    }

    // ---- Liturgy ----
    function bindLiturgy() {
        // Language switcher
        $$('.lang-btn').forEach(btn => {
            btn.addEventListener('click', () => {
                $$('.lang-btn').forEach(b => b.classList.remove('active'));
                btn.classList.add('active');
                state.language = btn.dataset.lang;
                localStorage.setItem('cs_lang', state.language);
                applyLanguage();
            });
        });

        // Set initial active lang button
        $$('.lang-btn').forEach(b => {
            b.classList.toggle('active', b.dataset.lang === state.language);
        });

        // Font size
        $('#btn-font-down').addEventListener('click', () => {
            if (state.fontSize > 14) {
                state.fontSize -= 2;
                localStorage.setItem('cs_fontsize', state.fontSize);
                applyFontSize();
            }
        });
        $('#btn-font-up').addEventListener('click', () => {
            if (state.fontSize < 30) {
                state.fontSize += 2;
                localStorage.setItem('cs_fontsize', state.fontSize);
                applyFontSize();
            }
        });

        // Back button — return to previous tab
        $('#btn-liturgy-back').addEventListener('click', () => {
            // Go back to services if we came from there, otherwise calendar
            if (state.selectedDate) {
                switchTab('services');
            } else {
                switchTab('calendar');
            }
        });
    }

    async function loadLiturgy(serviceType) {
        switchTab('liturgy');
        const content = $('#liturgy-content');
        const chips = $('#bookmark-chips');
        const title = $('#liturgy-title');
        content.innerHTML = '<div class="loading">Loading liturgy...</div>';
        chips.innerHTML = '';

        // Set title
        const svcNames = {
            lit: 'Divine Liturgy', mat: 'Matins', ves: 'Vespers',
            h1: 'First Hour', h3: 'Third Hour', h6: 'Sixth Hour', h9: 'Ninth Hour',
        };
        title.textContent = svcNames[serviceType] || serviceType;

        // Check cache
        if (state.liturgyCache[serviceType]) {
            renderLiturgy(state.liturgyCache[serviceType]);
            return;
        }

        try {
            const res = await fetch(`${API}/liturgy/${serviceType}`);
            if (!res.ok) throw new Error('Failed to load');
            const data = await res.json();

            // Handle empty content
            if (!data.blocks || data.blocks.length === 0) {
                content.innerHTML = `
                    <div class="empty-state" style="padding:40px 20px;">
                        <div class="empty-icon">📖</div>
                        <h3 style="font-family:var(--font-label);margin-bottom:8px;">${svcNames[serviceType] || serviceType}</h3>
                        <p>This service has not been added yet.</p>
                        <p style="font-size:0.85rem;color:var(--text-muted);margin-top:12px;">
                            The Choir Lead can add content using Edit Mode (✏️),
                            or you can use the GOARCH Digital Chant Stand as a reference:
                        </p>
                        <a href="https://dcs.goarch.org/goa/dcs/dcs.html" target="_blank" rel="noopener"
                           style="display:inline-block;margin-top:12px;font-family:var(--font-label);font-size:0.8rem;padding:10px 20px;background:var(--ocean);color:var(--white);border-radius:var(--radius);text-decoration:none;min-height:44px;line-height:24px;">
                            Open GOARCH DCS
                        </a>
                    </div>
                `;
                return;
            }

            state.liturgyCache[serviceType] = data;
            renderLiturgy(data);
        } catch (e) {
            content.innerHTML = '<div class="empty-state"><div class="empty-icon">📖</div><p>Could not load liturgy text. Please try again.</p></div>';
        }
    }

    function renderLiturgy(data) {
        const content = $('#liturgy-content');
        const chips = $('#bookmark-chips');
        content.innerHTML = '';
        chips.innerHTML = '';

        const blocks = data.blocks || [];
        const bookmarks = [];

        blocks.forEach(block => {
            // Divider
            if (block.is_divider && block.div_label) {
                const divider = document.createElement('div');
                divider.className = 'liturgy-divider';
                if (block.anchor) divider.id = `anchor-${block.anchor}`;
                divider.innerHTML = `
                    <span class="divider-ornament">☩</span>
                    <span class="divider-label">${block.div_label}</span>
                    <span class="divider-ornament">☩</span>
                `;
                content.appendChild(divider);

                // Add bookmark chip
                if (block.anchor) {
                    bookmarks.push({ anchor: block.anchor, label: block.div_label });
                }
            }

            // Text block (may also be a divider with text)
            if (block.text_en || block.text_ro) {
                const el = document.createElement('div');
                el.className = 'liturgy-block';
                el.dataset.role = block.role;
                el.dataset.blockId = block.id;

                if (block.anchor && !block.is_divider) {
                    el.id = `anchor-${block.anchor}`;
                }

                let html = '';
                if (block.text_en) {
                    html += `<span class="lt-en">${escapeHtml(block.text_en).replace(/\n/g, '<br>')}</span>`;
                }
                if (block.text_ro) {
                    html += `<span class="lt-ro">${escapeHtml(block.text_ro).replace(/\n/g, '<br>')}</span>`;
                }

                el.innerHTML = html;

                // Notes panel
                if (block.notes && block.notes.length > 0 && state.showNotes) {
                    const notesPanel = document.createElement('div');
                    notesPanel.className = 'inotes';

                    const toggle = document.createElement('button');
                    toggle.className = 'inotes-toggle';
                    toggle.textContent = '♩ Notes & Scores';
                    toggle.addEventListener('click', () => {
                        notesPanel.querySelector('.inotes-body').classList.toggle('open');
                    });

                    const body = document.createElement('div');
                    body.className = 'inotes-body';

                    block.notes.forEach(note => {
                        const item = document.createElement('div');
                        item.className = 'note-item';
                        let noteHtml = `<span class="note-badge ${note.note_type}">${note.note_type}</span>`;
                        if (note.note_text) {
                            noteHtml += `<div class="note-text">${escapeHtml(note.note_text)}</div>`;
                        }
                        if (note.link_url) {
                            const url = note.link_url;
                            // If it's a local PDF score, show inline iframe
                            if (url.startsWith('/scores/') && url.endsWith('.pdf')) {
                                // Append #view=FitH to hide sidebar and fit width
                                noteHtml += `<div class="score-embed">
                                    <iframe src="${escapeHtml(url)}#toolbar=0&navpanes=0&view=FitH" class="score-iframe" loading="lazy"></iframe>
                                </div>`;
                            } else {
                                noteHtml += `<a href="${escapeHtml(url)}" target="_blank" rel="noopener" class="note-link">${escapeHtml(note.link_label || 'Open')}</a>`;
                            }
                        }
                        item.innerHTML = noteHtml;
                        body.appendChild(item);
                    });

                    notesPanel.appendChild(toggle);
                    notesPanel.appendChild(body);
                    el.appendChild(notesPanel);
                }

                content.appendChild(el);
            }
        });

        // Render bookmark chips
        bookmarks.forEach(bm => {
            const chip = document.createElement('button');
            chip.className = 'bookmark-chip';
            chip.textContent = bm.label;
            chip.addEventListener('click', () => {
                const target = document.getElementById(`anchor-${bm.anchor}`);
                if (target) {
                    target.scrollIntoView({ behavior: 'smooth', block: 'start' });
                    $$('.bookmark-chip').forEach(c => c.classList.remove('active'));
                    chip.classList.add('active');
                }
            });
            chips.appendChild(chip);
        });

        applyLanguage();
    }

    // ---- Books ----
    function bindBooks() {
        $$('.book-item').forEach(item => {
            item.addEventListener('click', () => {
                const serviceType = item.dataset.service;
                state.selectedService = serviceType;
                loadLiturgy(serviceType);
            });
        });
    }

    // ---- Preferences ----
    function bindPrefs() {
        // Default language
        const langSelect = $('#pref-lang');
        langSelect.value = state.language;
        langSelect.addEventListener('change', () => {
            state.language = langSelect.value;
            localStorage.setItem('cs_lang', state.language);
            // Update lang switcher buttons
            $$('.lang-btn').forEach(b => {
                b.classList.toggle('active', b.dataset.lang === state.language);
            });
            applyLanguage();
        });

        // Notes toggle
        const notesToggle = $('#pref-notes');
        notesToggle.checked = state.showNotes;
        notesToggle.addEventListener('change', () => {
            state.showNotes = notesToggle.checked;
            localStorage.setItem('cs_notes', state.showNotes);
            // Re-render liturgy if loaded
            if (state.selectedService && state.liturgyCache[state.selectedService]) {
                renderLiturgy(state.liturgyCache[state.selectedService]);
            }
        });

        // Choir mode
        const choirToggle = $('#pref-choir');
        choirToggle.checked = state.choirMode;
        choirToggle.addEventListener('change', () => {
            state.choirMode = choirToggle.checked;
            localStorage.setItem('cs_choir', state.choirMode);
            if (state.choirMode) {
                state.fontSize = 24;
            } else {
                state.fontSize = 18;
            }
            localStorage.setItem('cs_fontsize', state.fontSize);
            applyFontSize();
        });

        // Dark mode
        const darkToggle = $('#pref-dark');
        darkToggle.checked = state.darkMode;
        darkToggle.addEventListener('change', () => {
            state.darkMode = darkToggle.checked;
            localStorage.setItem('cs_dark', state.darkMode);
            applyTheme();
        });

        // Wake lock
        const wakeLockToggle = $('#pref-wakelock');
        wakeLockToggle.addEventListener('change', async () => {
            if (wakeLockToggle.checked) {
                try {
                    if ('wakeLock' in navigator) {
                        state.wakeLock = await navigator.wakeLock.request('screen');
                    }
                } catch (e) {
                    console.warn('Wake lock not available:', e);
                    wakeLockToggle.checked = false;
                }
            } else {
                if (state.wakeLock) {
                    state.wakeLock.release();
                    state.wakeLock = null;
                }
            }
        });

        // Export
        $('#btn-export').addEventListener('click', () => {
            window.print();
        });

        // Change password (placeholder)
        $('#btn-change-password').addEventListener('click', () => {
            alert('Password change requires authentication. Please contact the Choir Lead.');
        });
    }

    // ---- Edit Mode ----
    function bindEdit() {
        $('#btn-edit').addEventListener('click', async () => {
            if (state.editing) return;

            // Check for auth token
            if (!state.authToken) {
                const password = prompt('Enter Choir Lead password:');
                if (!password) return;

                try {
                    const res = await fetch(`${API}/auth/login`, {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/json' },
                        body: JSON.stringify({ password }),
                    });

                    if (!res.ok) {
                        alert('Incorrect password.');
                        return;
                    }

                    const data = await res.json();
                    state.authToken = data.token;
                    sessionStorage.setItem('cs_token', data.token);
                } catch (e) {
                    alert('Authentication failed. Please try again.');
                    return;
                }
            }

            enterEditMode();
        });

        $('#btn-save-edit').addEventListener('click', saveEdits);
        $('#btn-exit-edit').addEventListener('click', exitEditMode);
        $('#btn-find-replace').addEventListener('click', openFindReplace);
        $('#fr-close').addEventListener('click', closeFindReplace);
        $('#fr-search').addEventListener('click', runFindReplace);
        $('#fr-apply').addEventListener('click', applyReplacements);

        // Enter key triggers search
        $('#fr-find').addEventListener('keydown', (e) => { if (e.key === 'Enter') runFindReplace(); });
        $('#fr-replace').addEventListener('keydown', (e) => { if (e.key === 'Enter') runFindReplace(); });
    }

    function enterEditMode() {
        state.editing = true;
        $('#edit-bar').classList.remove('hidden');
        document.body.style.paddingTop = `${$('#app-header').offsetHeight}px`;

        // Make liturgy blocks editable
        $$('.liturgy-block .lt-en, .liturgy-block .lt-ro').forEach(el => {
            el.contentEditable = 'true';
        });
        $$('.liturgy-block').forEach(el => {
            el.setAttribute('contenteditable', 'true');
        });
    }

    async function saveEdits() {
        const serviceType = state.selectedService;
        if (!serviceType) {
            alert('No service loaded to save.');
            return;
        }

        const blocks = $$('.liturgy-block[data-block-id]');
        let saved = 0;
        let failed = 0;

        for (const block of blocks) {
            const blockId = block.dataset.blockId;
            const enEl = block.querySelector('.lt-en');
            const roEl = block.querySelector('.lt-ro');

            const body = {};
            if (enEl) body.text_en = enEl.innerText;
            if (roEl) body.text_ro = roEl.innerText;

            try {
                const res = await fetch(`${API}/liturgy/${serviceType}/block/${blockId}`, {
                    method: 'PUT',
                    headers: {
                        'Content-Type': 'application/json',
                        'Authorization': `Bearer ${state.authToken}`,
                    },
                    body: JSON.stringify(body),
                });

                if (res.ok) {
                    saved++;
                } else if (res.status === 401) {
                    alert('Session expired. Please log in again.');
                    state.authToken = null;
                    sessionStorage.removeItem('cs_token');
                    exitEditMode();
                    return;
                } else {
                    failed++;
                }
            } catch (e) {
                failed++;
            }
        }

        // Invalidate cache
        delete state.liturgyCache[serviceType];

        if (failed === 0) {
            alert(`Saved ${saved} blocks successfully.`);
        } else {
            alert(`Saved ${saved} blocks. ${failed} failed to save.`);
        }
    }

    function exitEditMode() {
        state.editing = false;
        $('#edit-bar').classList.add('hidden');
        $('#add-service-panel').classList.add('hidden');
        document.body.style.paddingTop = `${$('#app-header').offsetHeight}px`;

        $$('.liturgy-block').forEach(el => {
            el.removeAttribute('contenteditable');
        });
        $$('.liturgy-block .lt-en, .liturgy-block .lt-ro').forEach(el => {
            el.contentEditable = 'false';
        });
    }

    // ---- Add Service (no auth required — open to choir lead and deacon) ----
    const SERVICE_TYPES = {
        lit: { en: 'Divine Liturgy', ro: 'Sfânta Liturghie' },
        mat: { en: 'Matins', ro: 'Utrenia' },
        ves: { en: 'Great Vespers', ro: 'Vecernia Mare' },
        h1:  { en: 'First Hour', ro: 'Ceasul I' },
        h3:  { en: 'Third Hour', ro: 'Ceasul al III-lea' },
        h6:  { en: 'Sixth Hour', ro: 'Ceasul al VI-lea' },
        h9:  { en: 'Ninth Hour', ro: 'Ceasul al IX-lea' },
    };

    function bindAddService() {
        // Toggle panel
        $('#btn-show-add-svc').addEventListener('click', () => {
            if (!state.selectedDate) {
                alert('Please select a date from the calendar first.');
                return;
            }
            $('#add-service-panel').classList.toggle('hidden');
        });

        // Preset buttons — one-tap add
        $$('.add-svc-preset').forEach(btn => {
            btn.addEventListener('click', () => {
                const typeId = btn.dataset.type;
                const time = btn.dataset.time;
                quickAddService(typeId, time);
            });
        });

        // Custom add button
        $('#btn-add-service').addEventListener('click', addService);
    }

    async function quickAddService(typeId, time) {
        if (!state.selectedDate) {
            alert('Please select a date from the calendar first.');
            return;
        }
        const svcType = SERVICE_TYPES[typeId];
        await postService(typeId, svcType.en, svcType.ro, time, true, true);
    }

    async function addService() {
        if (!state.selectedDate) return;
        const typeId = $('#add-svc-type').value;
        const time = $('#add-svc-time').value;
        const hasEn = $('#add-svc-en').checked;
        const hasRo = $('#add-svc-ro').checked;
        const svcType = SERVICE_TYPES[typeId];
        await postService(typeId, svcType.en, svcType.ro, time, hasEn, hasRo);
    }

    async function postService(id, nameEn, nameRo, time, hasEn, hasRo) {
        try {
            const res = await fetch(`${API}/services/${state.selectedDate}`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ id, name_en: nameEn, name_ro: nameRo, time, has_en: hasEn, has_ro: hasRo }),
            });

            if (res.status === 409) {
                alert('This service already exists for this date.');
                return;
            }
            if (!res.ok) {
                const err = await res.json().catch(() => ({}));
                alert('Failed: ' + (err.error || 'Unknown error'));
                return;
            }

            // Reload services and hide panel
            $('#add-service-panel').classList.add('hidden');
            loadServices(state.selectedDate);
        } catch (e) {
            alert('Failed to add service. Please try again.');
        }
    }

    // ---- Find & Replace ----
    let frMatches = []; // stores match info for current search

    function openFindReplace() {
        if (!state.editing) return;
        $('#fr-panel').classList.remove('hidden');
        $('#fr-find').value = '';
        $('#fr-replace').value = '';
        $('#fr-results').innerHTML = '';
        $('#fr-summary').classList.add('hidden');
        frMatches = [];
        $('#fr-find').focus();
    }

    function closeFindReplace() {
        $('#fr-panel').classList.add('hidden');
        frMatches = [];
        // Remove any highlights from the liturgy
        $$('.liturgy-block .fr-highlight').forEach(el => {
            el.outerHTML = el.textContent;
        });
    }

    function runFindReplace() {
        const findText = $('#fr-find').value.trim();
        const replaceText = $('#fr-replace').value;
        if (!findText) return;

        const caseSensitive = $('#fr-case').checked;
        const searchEn = $('#fr-lang-en').checked;
        const searchRo = $('#fr-lang-ro').checked;

        if (!searchEn && !searchRo) {
            alert('Select at least one language to search.');
            return;
        }

        frMatches = [];
        const results = $('#fr-results');
        results.innerHTML = '';

        // Search through all liturgy blocks in the DOM
        const blocks = $$('.liturgy-block[data-block-id]');

        blocks.forEach(block => {
            const blockId = block.dataset.blockId;
            const role = block.dataset.role;

            // Find the nearest preceding divider label for context
            let section = '';
            let el = block.previousElementSibling;
            while (el) {
                if (el.classList.contains('liturgy-divider')) {
                    const label = el.querySelector('.divider-label');
                    if (label) section = label.textContent;
                    break;
                }
                el = el.previousElementSibling;
            }

            const targets = [];
            if (searchEn) {
                const enEl = block.querySelector('.lt-en');
                if (enEl) targets.push({ el: enEl, lang: 'EN' });
            }
            if (searchRo) {
                const roEl = block.querySelector('.lt-ro');
                if (roEl) targets.push({ el: roEl, lang: 'RO' });
            }

            targets.forEach(({ el: textEl, lang }) => {
                const text = textEl.innerText;
                const flags = caseSensitive ? 'g' : 'gi';
                const regex = new RegExp(escapeRegex(findText), flags);
                let match;

                while ((match = regex.exec(text)) !== null) {
                    const matchIndex = frMatches.length;
                    const start = Math.max(0, match.index - 40);
                    const end = Math.min(text.length, match.index + findText.length + 40);
                    let snippet = text.slice(start, end);

                    // Highlight the match in the snippet
                    const matchStart = match.index - start;
                    const before = escapeHtml(snippet.slice(0, matchStart));
                    const matched = escapeHtml(snippet.slice(matchStart, matchStart + findText.length));
                    const after = escapeHtml(snippet.slice(matchStart + findText.length));
                    const highlightedSnippet = `${start > 0 ? '...' : ''}${before}<mark>${matched}</mark>${after}${end < text.length ? '...' : ''}`;

                    frMatches.push({
                        blockId,
                        textEl,
                        lang,
                        role,
                        section,
                        originalText: match[0],
                        replaceWith: replaceText,
                        index: match.index,
                        selected: true,
                    });

                    const matchEl = document.createElement('div');
                    matchEl.className = 'fr-match selected';
                    matchEl.innerHTML = `
                        <input type="checkbox" class="fr-match-check" data-match="${matchIndex}" checked>
                        <div>
                            <div class="fr-match-text">${highlightedSnippet}</div>
                            <div class="fr-match-section">${section ? section + ' — ' : ''}${lang}</div>
                        </div>
                        <span class="fr-match-role ${role}">${role}</span>
                    `;

                    const checkbox = matchEl.querySelector('.fr-match-check');
                    checkbox.addEventListener('change', () => {
                        frMatches[matchIndex].selected = checkbox.checked;
                        matchEl.classList.toggle('selected', checkbox.checked);
                        updateFRSummary();
                    });

                    // Click the row to toggle
                    matchEl.addEventListener('click', (e) => {
                        if (e.target === checkbox) return;
                        checkbox.checked = !checkbox.checked;
                        checkbox.dispatchEvent(new Event('change'));
                    });

                    results.appendChild(matchEl);
                }
            });
        });

        if (frMatches.length === 0) {
            results.innerHTML = '<div class="empty-state" style="padding:20px;"><p>No matches found.</p></div>';
            $('#fr-summary').classList.add('hidden');
        } else {
            updateFRSummary();
            $('#fr-summary').classList.remove('hidden');
        }
    }

    function updateFRSummary() {
        const selected = frMatches.filter(m => m.selected).length;
        const total = frMatches.length;
        let countEl = $('#fr-summary .fr-count');
        if (!countEl) {
            countEl = document.createElement('div');
            countEl.className = 'fr-count';
            $('#fr-summary').insertBefore(countEl, $('#fr-apply'));
        }
        countEl.textContent = `${selected} of ${total} matches selected`;
    }

    function applyReplacements() {
        const replaceText = $('#fr-replace').value;
        const caseSensitive = $('#fr-case').checked;
        const findText = $('#fr-find').value.trim();
        if (!findText) return;

        const selectedMatches = frMatches.filter(m => m.selected);
        if (selectedMatches.length === 0) {
            alert('No matches selected.');
            return;
        }

        // Group by textEl to handle multiple replacements in the same element
        const byElement = new Map();
        selectedMatches.forEach(m => {
            if (!byElement.has(m.textEl)) byElement.set(m.textEl, []);
            byElement.get(m.textEl).push(m);
        });

        let replaced = 0;

        byElement.forEach((matches, textEl) => {
            let text = textEl.innerText;
            // Process matches in reverse order (by index) to preserve positions
            const sorted = matches.sort((a, b) => b.index - a.index);
            sorted.forEach(m => {
                const before = text.slice(0, m.index);
                const after = text.slice(m.index + m.originalText.length);
                text = before + replaceText + after;
                replaced++;
            });
            // Update the DOM — preserve <br> for newlines
            textEl.innerHTML = escapeHtml(text).replace(/\n/g, '<br>');
        });

        alert(`Replaced ${replaced} occurrences. Remember to Save your changes.`);
        closeFindReplace();
    }

    function escapeRegex(str) {
        return str.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
    }

    // ---- Helpers ----
    function applyTheme() {
        document.body.classList.toggle('dark', state.darkMode);
    }

    function applyFontSize() {
        document.documentElement.style.setProperty('--font-size', `${state.fontSize}px`);
    }

    function applyLanguage() {
        const content = $('#liturgy-content');
        content.classList.remove('lang-en', 'lang-ro', 'lang-both');
        content.classList.add(`lang-${state.language}`);
    }

    function escapeHtml(text) {
        if (!text) return '';
        const div = document.createElement('div');
        div.textContent = text;
        return div.innerHTML;
    }

    // ---- Boot ----
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else {
        init();
    }
})();

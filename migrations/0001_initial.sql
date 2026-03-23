-- ============================================================
-- Digital Chant Stand — D1 Migration
-- Schema + Seed Data
-- ============================================================

CREATE TABLE IF NOT EXISTS feasts (
    date TEXT PRIMARY KEY,
    en TEXT NOT NULL,
    ro TEXT NOT NULL,
    tone INTEGER
);

CREATE TABLE IF NOT EXISTS services (
    id TEXT NOT NULL,
    date TEXT NOT NULL,
    name_en TEXT NOT NULL,
    name_ro TEXT NOT NULL,
    time TEXT,
    has_en INTEGER DEFAULT 1,
    has_ro INTEGER DEFAULT 0,
    PRIMARY KEY (id, date)
);

CREATE TABLE IF NOT EXISTS liturgy_blocks (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    service_type TEXT NOT NULL,
    sort_order INTEGER NOT NULL,
    role TEXT NOT NULL CHECK(role IN ('priest', 'deacon', 'choir', 'rubric', 'people')),
    text_en TEXT,
    text_ro TEXT,
    anchor TEXT,
    is_divider INTEGER DEFAULT 0,
    div_label TEXT
);

CREATE TABLE IF NOT EXISTS notes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    block_id INTEGER NOT NULL,
    note_type TEXT NOT NULL,
    note_text TEXT,
    link_url TEXT,
    link_label TEXT,
    sort_order INTEGER DEFAULT 0,
    FOREIGN KEY (block_id) REFERENCES liturgy_blocks(id)
);

CREATE TABLE IF NOT EXISTS settings (
    key TEXT PRIMARY KEY,
    value TEXT
);

CREATE INDEX IF NOT EXISTS idx_feasts_month ON feasts(substr(date, 1, 7));
CREATE INDEX IF NOT EXISTS idx_services_date ON services(date);
CREATE INDEX IF NOT EXISTS idx_blocks_service ON liturgy_blocks(service_type, sort_order);
CREATE INDEX IF NOT EXISTS idx_notes_block ON notes(block_id);

-- ---- SETTINGS ----

INSERT OR REPLACE INTO settings (key, value) VALUES
    ('parish_name_en', 'Ss. Brendan & Joseph of Partos Parish'),
    ('parish_name_ro', 'Parohia Sf. Brendan și Sf. Iosif de la Partoș'),
    ('parish_location', 'The Pepper Canister, Mount Street Crescent, Dublin 2'),
    ('diocese', 'Diocese of Ireland & Iceland'),
    ('default_language', 'en'),
    ('default_tone', '8');

-- ---- FEASTS ----

INSERT OR REPLACE INTO feasts (date, en, ro, tone) VALUES
    ('2026-01-06', 'Holy Theophany — Baptism of our Lord', 'Botezul Domnului — Boboteaza', NULL),
    ('2026-02-22', 'Sunday of the Publican and the Pharisee', 'Duminica Vameșului și a Fariseului', 5),
    ('2026-03-01', 'Sunday of the Prodigal Son', 'Duminica Fiului Risipitor', 6),
    ('2026-03-08', 'Sunday of the Last Judgement (Meatfare)', 'Duminica Înfricoșătoarei Judecăți', 7),
    ('2026-03-15', 'Forgiveness Sunday (Cheesefare)', 'Duminica Iertării', 8),
    ('2026-03-22', 'First Sunday of Great Lent — Triumph of Orthodoxy', 'Duminica Ortodoxiei', 1),
    ('2026-03-25', 'Annunciation of the Most Holy Theotokos', 'Buna Vestire', NULL),
    ('2026-03-29', 'Second Sunday of Great Lent — St Gregory Palamas', 'Duminica Sf. Grigorie Palama', 2),
    ('2026-04-05', 'Third Sunday of Great Lent — Veneration of the Cross', 'Duminica Sfintei Cruci', 3),
    ('2026-04-12', 'Fourth Sunday of Great Lent — St John Climacus', 'Duminica Sf. Ioan Scărarul', 4),
    ('2026-04-19', 'Palm Sunday — Entry of the Lord into Jerusalem', 'Duminica Floriilor', 1),
    ('2026-04-20', 'Great and Holy Monday', 'Sfânta și Marea Luni', NULL),
    ('2026-04-21', 'Great and Holy Tuesday', 'Sfânta și Marea Marți', NULL),
    ('2026-04-22', 'Great and Holy Wednesday', 'Sfânta și Marea Miercuri', NULL),
    ('2026-04-23', 'Great and Holy Thursday', 'Sfânta și Marea Joi', NULL),
    ('2026-04-24', 'Great and Holy Friday', 'Sfânta și Marea Vineri', NULL),
    ('2026-04-25', 'Great and Holy Saturday', 'Sfânta și Marea Sâmbătă', NULL),
    ('2026-04-26', 'GREAT AND HOLY PASCHA — The Resurrection of our Lord', 'SFINTELE PAȘTI — Învierea Domnului', 1),
    ('2026-05-16', '☘ ST BRENDAN THE NAVIGATOR — Parish Patron Feast', '☘ SF. BRENDAN NAVIGATORUL — Hramul Parohiei', NULL),
    ('2026-08-06', 'Transfiguration of our Lord', 'Schimbarea la Față a Domnului', NULL),
    ('2026-08-15', 'Dormition of the Most Holy Theotokos', 'Adormirea Maicii Domnului', NULL),
    ('2026-09-15', '☩ ST JOSEPH THE NEW OF PARTOS — Parish Patron Feast', '☩ SF. IOSIF CEL NOU DE LA PARTOȘ — Hramul Parohiei', NULL),
    ('2026-12-25', 'Nativity of our Lord Jesus Christ', 'Nașterea Domnului nostru Iisus Hristos', NULL);

-- ---- SERVICES ----

INSERT OR REPLACE INTO services (id, date, name_en, name_ro, time, has_en, has_ro) VALUES
    ('lit', '2026-03-22', 'Divine Liturgy', 'Sfânta Liturghie', '10:00', 1, 1),
    ('mat', '2026-03-22', 'Matins', 'Utrenia', '08:30', 1, 0),
    ('h3',  '2026-03-22', 'Third Hour', 'Ceasul al III-lea', '09:30', 1, 0),
    ('h6',  '2026-03-22', 'Sixth Hour', 'Ceasul al VI-lea', '09:45', 1, 0),
    ('lit', '2026-03-29', 'Divine Liturgy', 'Sfânta Liturghie', '10:00', 1, 1),
    ('ves', '2026-03-28', 'Great Vespers', 'Vecernia Mare', '18:00', 1, 0),
    ('lit', '2026-04-26', 'Paschal Divine Liturgy', 'Sfânta Liturghie Pascală', '00:30', 1, 1),
    ('mat', '2026-04-26', 'Paschal Matins', 'Utrenia Pascală', '00:00', 1, 1);

-- ---- DIVINE LITURGY (St John Chrysostom) ----

INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 10, 'rubric', 'The priest and deacon stand before the Holy Table. The deacon says:', 'Preotul și diaconul stau înaintea Sfintei Mese. Diaconul zice:', 'opening', 1, 'Opening'),
    ('lit', 20, 'deacon', 'Bless, Master.', 'Binecuvântează, stăpâne.', NULL, 0, NULL),
    ('lit', 30, 'priest', 'Blessed is the Kingdom of the Father and of the Son and of the Holy Spirit, now and ever and unto ages of ages.', 'Binecuvântată este Împărăția Tatălui și a Fiului și a Sfântului Duh, acum și pururea și în vecii vecilor.', NULL, 0, NULL),
    ('lit', 40, 'choir', 'Amen.', 'Amin.', NULL, 0, NULL);

-- Great Litany
INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 50, 'rubric', NULL, NULL, 'great-litany', 1, 'Great Litany'),
    ('lit', 60, 'deacon', 'In peace, let us pray to the Lord.', 'Cu pace, Domnului să ne rugăm.', NULL, 0, NULL),
    ('lit', 70, 'choir', 'Lord, have mercy.', 'Doamne, miluiește.', NULL, 0, NULL),
    ('lit', 80, 'deacon', 'For the peace from above and for the salvation of our souls, let us pray to the Lord.', 'Pentru pacea de sus și pentru mântuirea sufletelor noastre, Domnului să ne rugăm.', NULL, 0, NULL),
    ('lit', 90, 'choir', 'Lord, have mercy.', 'Doamne, miluiește.', NULL, 0, NULL),
    ('lit', 100, 'deacon', 'For the peace of the whole world, for the welfare of the holy churches of God, and for the union of all, let us pray to the Lord.', 'Pentru pacea a toată lumea, pentru bunăstarea sfintelor lui Dumnezeu biserici și pentru unirea tuturor, Domnului să ne rugăm.', NULL, 0, NULL),
    ('lit', 110, 'choir', 'Lord, have mercy.', 'Doamne, miluiește.', NULL, 0, NULL),
    ('lit', 120, 'deacon', 'For this holy house and for those who enter it with faith, reverence, and the fear of God, let us pray to the Lord.', 'Pentru sfânt locașul acesta și pentru cei ce cu credință, cu evlavie și cu frică de Dumnezeu intră în el, Domnului să ne rugăm.', NULL, 0, NULL),
    ('lit', 130, 'choir', 'Lord, have mercy.', 'Doamne, miluiește.', NULL, 0, NULL),
    ('lit', 140, 'deacon', 'For our Metropolitan Daniel, for our Bishop Athenagoras, for the honourable presbytery, the diaconate in Christ, and for all the clergy and the people, let us pray to the Lord.', 'Pentru Mitropolitul nostru Daniel, pentru Episcopul nostru Athenagoras, pentru cinstita preoțime, cea întru Hristos diaconie și tot clerul și poporul, Domnului să ne rugăm.', NULL, 0, NULL),
    ('lit', 150, 'choir', 'Lord, have mercy.', 'Doamne, miluiește.', NULL, 0, NULL),
    ('lit', 160, 'deacon', 'For this country, for the President and all in civil authority, let us pray to the Lord.', 'Pentru țara aceasta, pentru Președinte și pentru toată conducerea ei, Domnului să ne rugăm.', NULL, 0, NULL),
    ('lit', 170, 'choir', 'Lord, have mercy.', 'Doamne, miluiește.', NULL, 0, NULL),
    ('lit', 180, 'deacon', 'For this city, for every city and countryside, and for the faithful dwelling in them, let us pray to the Lord.', 'Pentru orașul acesta, pentru tot orașul și țara și pentru cei ce cu credință locuiesc într-însele, Domnului să ne rugăm.', NULL, 0, NULL),
    ('lit', 190, 'choir', 'Lord, have mercy.', 'Doamne, miluiește.', NULL, 0, NULL),
    ('lit', 200, 'deacon', 'For seasonable weather, for abundance of the fruits of the earth, and for peaceful times, let us pray to the Lord.', 'Pentru bună-întocmirea văzduhurilor, pentru îmbelșugarea roadelor pământului și pentru vremuri pașnice, Domnului să ne rugăm.', NULL, 0, NULL),
    ('lit', 210, 'choir', 'Lord, have mercy.', 'Doamne, miluiește.', NULL, 0, NULL),
    ('lit', 220, 'deacon', 'For travellers by sea, by land, and by air; for the sick and the suffering; for captives and their salvation, let us pray to the Lord.', 'Pentru cei ce călătoresc pe ape, pe uscat și prin aer, pentru cei bolnavi, pentru cei ce se ostenesc, pentru cei robiți și pentru mântuirea lor, Domnului să ne rugăm.', NULL, 0, NULL),
    ('lit', 230, 'choir', 'Lord, have mercy.', 'Doamne, miluiește.', NULL, 0, NULL),
    ('lit', 240, 'deacon', 'That we may be delivered from all affliction, wrath, danger, and necessity, let us pray to the Lord.', 'Pentru ca să ne izbăvim noi de tot necazul, mânia, primejdia și nevoia, Domnului să ne rugăm.', NULL, 0, NULL),
    ('lit', 250, 'choir', 'Lord, have mercy.', 'Doamne, miluiește.', NULL, 0, NULL),
    ('lit', 260, 'deacon', 'Help us, save us, have mercy on us, and keep us, O God, by Thy grace.', 'Apără, mântuiește, miluiește și ne păzește pe noi, Dumnezeule, cu harul Tău.', NULL, 0, NULL),
    ('lit', 270, 'choir', 'Lord, have mercy.', 'Doamne, miluiește.', NULL, 0, NULL),
    ('lit', 280, 'deacon', 'Commemorating our most holy, most pure, most blessed and glorious Lady, the Theotokos and ever-virgin Mary, with all the saints, let us commend ourselves and each other, and all our life unto Christ our God.', 'Pe Preasfânta, curata, preabinecuvântata, slăvita Stăpâna noastră, de Dumnezeu Născătoarea și pururea Fecioara Maria, cu toți sfinții pomenind-o, pe noi înșine și unii pe alții și toată viața noastră lui Hristos Dumnezeu să o dăm.', NULL, 0, NULL),
    ('lit', 290, 'choir', 'To Thee, O Lord.', 'Ție, Doamne.', NULL, 0, NULL),
    ('lit', 300, 'priest', 'For unto Thee are due all glory, honour, and worship: to the Father and to the Son and to the Holy Spirit, now and ever and unto ages of ages.', 'Că Ție se cuvine toată slava, cinstea și închinăciunea, Tatălui și Fiului și Sfântului Duh, acum și pururea și în vecii vecilor.', NULL, 0, NULL),
    ('lit', 310, 'choir', 'Amen.', 'Amin.', NULL, 0, NULL);

-- First Antiphon
INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 320, 'rubric', NULL, NULL, 'antiphon-1', 1, 'First Antiphon'),
    ('lit', 330, 'rubric', 'Typical Psalm 102 (Sunday)', 'Psalmul 102 (Duminica)', NULL, 0, NULL),
    ('lit', 340, 'choir', 'Bless the Lord, O my soul, and all that is within me bless His holy name. Bless the Lord, O my soul, and forget not all His benefits. He forgives all your iniquities, He heals all your diseases, He redeems your life from the pit, He crowns you with steadfast love and mercy. The Lord is compassionate and merciful, long-suffering and of great goodness. Bless the Lord, O my soul, and all that is within me bless His holy name. Blessed art Thou, O Lord.', 'Binecuvântează, suflete al meu, pe Domnul și toate cele dinlăuntrul meu, numele cel sfânt al Lui. Binecuvântează, suflete al meu, pe Domnul și nu uita toate răsplătirile Lui. Pe Cel ce curățește toate fărădelegile tale, pe Cel ce vindecă toate bolile tale. Îndurat și milostiv este Domnul, îndelung-răbdător și mult-milostiv. Binecuvântează, suflete al meu, pe Domnul. Binecuvântat ești, Doamne.', NULL, 0, NULL);

-- Small Litany
INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 350, 'rubric', NULL, NULL, 'small-litany-1', 1, 'Small Litany'),
    ('lit', 360, 'deacon', 'Again and again, in peace, let us pray to the Lord.', 'Iară și iară, cu pace, Domnului să ne rugăm.', NULL, 0, NULL),
    ('lit', 370, 'choir', 'Lord, have mercy.', 'Doamne, miluiește.', NULL, 0, NULL),
    ('lit', 420, 'priest', 'For Thine is the might, and Thine is the kingdom, and the power and the glory: of the Father and of the Son and of the Holy Spirit, now and ever and unto ages of ages.', 'Că a Ta este stăpânirea și a Ta este Împărăția și puterea și slava, a Tatălui și a Fiului și a Sfântului Duh, acum și pururea și în vecii vecilor.', NULL, 0, NULL),
    ('lit', 430, 'choir', 'Amen.', 'Amin.', NULL, 0, NULL);

-- Second Antiphon
INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 440, 'rubric', NULL, NULL, 'antiphon-2', 1, 'Second Antiphon'),
    ('lit', 460, 'choir', 'Praise the Lord, O my soul! I will praise the Lord as long as I live; I will sing praises to my God while I have being. Put not your trust in princes, in sons of men, in whom there is no salvation. Blessed is he whose help is the God of Jacob, whose hope is in the Lord his God.', 'Laudă, suflete al meu, pe Domnul! Lăuda-voi pe Domnul în viața mea, cânta-voi Dumnezeului meu cât voi trăi. Nu vă încredeți în cei puternici, în fiii oamenilor, în care nu este mântuire. Fericit cel ce are ajutor pe Dumnezeul lui Iacov.', NULL, 0, NULL),
    ('lit', 470, 'choir', 'Only-begotten Son and immortal Word of God, Who for our salvation didst will to be incarnate of the holy Theotokos and ever-virgin Mary, Who without change didst become man and wast crucified, O Christ our God, trampling down death by death, Who art one of the Holy Trinity, glorified with the Father and the Holy Spirit: save us!', 'Unule-Născut, Fiule și Cuvântul lui Dumnezeu, Cel ce ești fără de moarte și ai primit, pentru mântuirea noastră, a Te întrupa din Sfânta Născătoare de Dumnezeu și pururea Fecioara Maria; Care, neschimbat, Te-ai întrupat și, răstignindu-Te, Hristoase Dumnezeule, cu moartea pe moarte ai călcat; Unul fiind din Sfânta Treime, împreună slăvit cu Tatăl și cu Duhul Sfânt, mântuiește-ne pe noi!', 'only-begotten', 0, NULL);

-- Little Entrance
INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 520, 'rubric', NULL, NULL, 'little-entrance', 1, 'Little Entrance'),
    ('lit', 530, 'rubric', 'The clergy process with the Holy Gospel.', 'Procesiune cu Sfânta Evanghelie.', NULL, 0, NULL),
    ('lit', 540, 'deacon', 'Wisdom! Let us attend!', 'Înțelepciune! Drepți!', NULL, 0, NULL),
    ('lit', 550, 'choir', 'Come, let us worship and fall down before Christ. O Son of God, Who art risen from the dead, save us who sing to Thee: Alleluia!', 'Veniți să ne închinăm și să cădem la Hristos. Mântuiește-ne pe noi, Fiul lui Dumnezeu, Cel ce ai înviat din morți, pe noi, cei ce-Ți cântăm Ție: Aliluia!', NULL, 0, NULL);

-- Troparia
INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 560, 'rubric', NULL, NULL, 'troparia', 1, 'Troparia'),
    ('lit', 570, 'rubric', 'Resurrectional Troparion — Tone 8 (default).', 'Troparul Învierii — Glasul 8 (implicit).', NULL, 0, NULL),
    ('lit', 580, 'choir', 'From the heights Thou didst descend, O compassionate One, and Thou didst submit to the three-day burial, that Thou might deliver us from passion; Thou art our life and our Resurrection, O Lord, glory to Thee!', 'Din înălțime Te-ai pogorât, Milostive, îngropare ai primit de trei zile, ca să ne slobozești pe noi din patimi; Viața și Învierea noastră, Doamne, slavă Ție!', 'troparion', 0, NULL);

-- Trisagion
INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 590, 'rubric', NULL, NULL, 'trisagion', 1, 'Trisagion'),
    ('lit', 600, 'deacon', 'Let us pray to the Lord.', 'Domnului să ne rugăm.', NULL, 0, NULL),
    ('lit', 610, 'priest', 'For holy art Thou, O our God, and unto Thee we ascribe glory: to the Father and to the Son and to the Holy Spirit, now and ever...', 'Că sfânt ești, Dumnezeul nostru, și Ție slavă înălțăm, Tatălui și Fiului și Sfântului Duh, acum și pururea...', NULL, 0, NULL),
    ('lit', 620, 'deacon', '...and unto ages of ages.', '...și în vecii vecilor.', NULL, 0, NULL),
    ('lit', 630, 'choir', 'Holy God, Holy Mighty, Holy Immortal, have mercy on us. (three times)\n\nGlory to the Father and to the Son and to the Holy Spirit, now and ever and unto ages of ages. Amen.\n\nHoly Immortal, have mercy on us.\n\nHoly God, Holy Mighty, Holy Immortal, have mercy on us.', 'Sfinte Dumnezeule, Sfinte tare, Sfinte fără de moarte, miluiește-ne pe noi. (de trei ori)\n\nSlavă Tatălui și Fiului și Sfântului Duh, și acum și pururea și în vecii vecilor. Amin.\n\nSfinte fără de moarte, miluiește-ne pe noi.\n\nSfinte Dumnezeule, Sfinte tare, Sfinte fără de moarte, miluiește-ne pe noi.', NULL, 0, NULL);

-- Epistle
INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 640, 'rubric', NULL, NULL, 'epistle', 1, 'Epistle'),
    ('lit', 650, 'deacon', 'Let us attend!', 'Să luăm aminte!', NULL, 0, NULL),
    ('lit', 660, 'priest', 'Peace be unto all.', 'Pace tuturor.', NULL, 0, NULL),
    ('lit', 670, 'choir', 'And to thy spirit.', 'Și duhului tău.', NULL, 0, NULL),
    ('lit', 690, 'rubric', '[The Epistle reading for the day is inserted here]', '[Apostolul zilei se citește aici]', NULL, 0, NULL),
    ('lit', 700, 'choir', 'Alleluia! Alleluia! Alleluia!', 'Aliluia! Aliluia! Aliluia!', NULL, 0, NULL);

-- Gospel
INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 710, 'rubric', NULL, NULL, 'gospel', 1, 'Gospel'),
    ('lit', 720, 'deacon', 'Wisdom! Let us attend! Let us hear the Holy Gospel.', 'Înțelepciune! Drepți! Să ascultăm Sfânta Evanghelie.', NULL, 0, NULL),
    ('lit', 730, 'priest', 'Peace be unto all.', 'Pace tuturor.', NULL, 0, NULL),
    ('lit', 740, 'choir', 'And to thy spirit.', 'Și duhului tău.', NULL, 0, NULL),
    ('lit', 750, 'deacon', 'The reading from the Holy Gospel according to [Evangelist].', 'Din Sfânta Evanghelie de la [Evanghelistul], citire.', NULL, 0, NULL),
    ('lit', 760, 'choir', 'Glory to Thee, O Lord, glory to Thee!', 'Slavă Ție, Doamne, slavă Ție!', NULL, 0, NULL),
    ('lit', 770, 'rubric', '[The Gospel reading for the day is read here]', '[Evanghelia zilei se citește aici]', NULL, 0, NULL),
    ('lit', 780, 'choir', 'Glory to Thee, O Lord, glory to Thee!', 'Slavă Ție, Doamne, slavă Ție!', NULL, 0, NULL);

-- Augmented Litany
INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 790, 'rubric', NULL, NULL, 'augmented-litany', 1, 'Augmented Litany'),
    ('lit', 800, 'deacon', 'Let us all say with all our soul and with all our mind, let us say:', 'Să zicem toți din tot sufletul și din tot cugetul nostru, să zicem:', NULL, 0, NULL),
    ('lit', 810, 'choir', 'Lord, have mercy.', 'Doamne, miluiește.', NULL, 0, NULL),
    ('lit', 840, 'deacon', 'Have mercy on us, O God, according to Thy great mercy, we pray Thee: hear us and have mercy.', 'Miluiește-ne pe noi, Dumnezeule, după mare mila Ta, rugămu-ne Ție, auzi-ne și ne miluiește.', NULL, 0, NULL),
    ('lit', 850, 'choir', 'Lord, have mercy. Lord, have mercy. Lord, have mercy.', 'Doamne, miluiește. Doamne, miluiește. Doamne, miluiește.', NULL, 0, NULL),
    ('lit', 870, 'choir', 'Amen.', 'Amin.', NULL, 0, NULL);

-- Cherubic Hymn
INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 930, 'rubric', NULL, NULL, 'cherubic-hymn', 1, 'Cherubic Hymn'),
    ('lit', 940, 'choir', 'Let us who mystically represent the Cherubim, and who sing the thrice-holy hymn to the life-creating Trinity, now lay aside all earthly cares.', 'Noi, care pe Heruvimi cu taină închipuim și făcătoarei de viață Treimi întreit-sfântă cântare aducem, toată grija cea lumească acum să o lepădăm.', NULL, 0, NULL);

-- Great Entrance
INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 950, 'rubric', NULL, NULL, 'great-entrance', 1, 'Great Entrance'),
    ('lit', 960, 'rubric', 'The priest carries the holy gifts through the nave to the Holy Table.', 'Preotul aduce Sfintele Daruri prin naos la Sfânta Masă.', NULL, 0, NULL),
    ('lit', 970, 'priest', 'May the Lord God remember all of you in His Kingdom, always, now and ever and unto ages of ages.', 'Pe voi pe toți să vă pomenească Domnul Dumnezeu în Împărăția Sa, totdeauna, acum și pururea și în vecii vecilor.', NULL, 0, NULL),
    ('lit', 980, 'choir', 'Amen.\n\nThat we may receive the King of all, who comes invisibly upborne by the angelic hosts. Alleluia, alleluia, alleluia!', 'Amin.\n\nCa pe Împăratul tuturor să-L primim, pe Cel nevăzut înconjurat de cetele îngerești. Aliluia, aliluia, aliluia!', NULL, 0, NULL);

-- Creed
INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 990, 'rubric', NULL, NULL, 'creed', 1, 'The Creed'),
    ('lit', 1000, 'deacon', 'The doors! The doors! In wisdom, let us attend!', 'Ușile! Ușile! Cu înțelepciune să luăm aminte!', NULL, 0, NULL),
    ('lit', 1010, 'people', 'I believe in one God, the Father Almighty, Maker of heaven and earth, and of all things visible and invisible.\n\nAnd in one Lord Jesus Christ, the Son of God, the Only-begotten, begotten of the Father before all ages; Light of Light, true God of true God, begotten, not made, of one essence with the Father, by Whom all things were made.\n\nWho for us men and for our salvation came down from heaven, and was incarnate of the Holy Spirit and the Virgin Mary, and was made man.\n\nAnd was crucified also for us under Pontius Pilate, and suffered and was buried.\n\nAnd the third day He rose again, according to the Scriptures.\n\nAnd ascended into heaven, and sitteth at the right hand of the Father.\n\nAnd He shall come again with glory to judge the living and the dead, Whose kingdom shall have no end.\n\nAnd I believe in the Holy Spirit, the Lord, the Giver of life, Who proceedeth from the Father, Who with the Father and the Son together is worshipped and glorified, Who spake by the prophets.\n\nAnd I believe in one, holy, catholic, and apostolic Church.\n\nI acknowledge one baptism for the remission of sins.\n\nI look for the resurrection of the dead, and the life of the age to come. Amen.', 'Cred într-unul Dumnezeu, Tatăl Atotțiitorul, Făcătorul cerului și al pământului, văzutelor tuturor și nevăzutelor.\n\nȘi într-unul Domn Iisus Hristos, Fiul lui Dumnezeu, Unul-Născut, Care din Tatăl S-a născut mai înainte de toți vecii; Lumină din Lumină, Dumnezeu adevărat din Dumnezeu adevărat, Născut iar nu făcut, Cel de o ființă cu Tatăl, prin Care toate s-au făcut.\n\nCare pentru noi oamenii și pentru a noastră mântuire S-a pogorât din ceruri și S-a întrupat de la Duhul Sfânt și din Fecioara Maria și S-a făcut om.\n\nȘi S-a răstignit pentru noi în zilele lui Ponțiu Pilat, a pătimit și S-a îngropat.\n\nȘi a înviat a treia zi după Scripturi.\n\nȘi S-a înălțat la ceruri și șade de-a dreapta Tatălui.\n\nȘi iarăși va să vină cu slavă, să judece viii și morții, a Cărui împărăție nu va avea sfârșit.\n\nȘi întru Duhul Sfânt, Domnul de viață Făcătorul, Care din Tatăl purcede, Cel ce împreună cu Tatăl și cu Fiul este închinat și slăvit, Care a grăit prin prooroci.\n\nÎntru una, sfântă, sobornicească și apostolească Biserică.\n\nMărturisesc un botez spre iertarea păcatelor.\n\nAștept învierea morților și viața veacului ce va să fie. Amin.', NULL, 0, NULL);

-- Anaphora
INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 1020, 'rubric', NULL, NULL, 'anaphora', 1, 'The Anaphora'),
    ('lit', 1030, 'deacon', 'Let us stand aright! Let us stand with fear! Let us attend, that we may offer the Holy Oblation in peace.', 'Să stăm bine, să stăm cu frică, să luăm aminte, Sfânta Jertfă cu pace a o aduce.', NULL, 0, NULL),
    ('lit', 1040, 'choir', 'A mercy of peace, a sacrifice of praise.', 'Mila păcii, jertfa laudei.', NULL, 0, NULL),
    ('lit', 1050, 'priest', 'The grace of our Lord Jesus Christ, and the love of God the Father, and the communion of the Holy Spirit, be with you all.', 'Harul Domnului nostru Iisus Hristos și dragostea lui Dumnezeu Tatăl și împărtășirea Sfântului Duh să fie cu voi cu toți.', NULL, 0, NULL),
    ('lit', 1060, 'choir', 'And with thy spirit.', 'Și cu duhul tău.', NULL, 0, NULL),
    ('lit', 1070, 'priest', 'Let us lift up our hearts.', 'Sus să avem inimile.', NULL, 0, NULL),
    ('lit', 1080, 'choir', 'We lift them up unto the Lord.', 'Avem către Domnul.', NULL, 0, NULL),
    ('lit', 1090, 'priest', 'Let us give thanks unto the Lord.', 'Să mulțumim Domnului.', NULL, 0, NULL),
    ('lit', 1100, 'choir', 'It is meet and right to worship the Father, the Son, and the Holy Spirit: the Trinity, one in essence and undivided.', 'Cu vrednicie și cu dreptate este a ne închina Tatălui și Fiului și Sfântului Duh, Treimea cea de o ființă și nedespărțită.', NULL, 0, NULL),
    ('lit', 1110, 'priest', 'Singing the triumphant hymn, shouting, proclaiming, and saying:', 'Cântarea de biruință cântând, strigând, glăsuind și grăind:', NULL, 0, NULL),
    ('lit', 1120, 'choir', 'Holy, holy, holy, Lord of Sabaoth! Heaven and earth are full of Thy glory! Hosanna in the highest! Blessed is He that cometh in the name of the Lord! Hosanna in the highest!', 'Sfânt, sfânt, sfânt, Domnul Savaot! Plin este cerul și pământul de slava Ta! Osana întru cei de sus! Binecuvântat este Cel ce vine întru numele Domnului! Osana întru cei de sus!', 'sanctus', 0, NULL),
    ('lit', 1130, 'priest', 'Take, eat; this is My Body, which is broken for you, for the remission of sins.', 'Luați, mâncați, acesta este Trupul Meu, Care se frânge pentru voi, spre iertarea păcatelor.', 'words-institution', 0, NULL),
    ('lit', 1140, 'choir', 'Amen.', 'Amin.', NULL, 0, NULL),
    ('lit', 1150, 'priest', 'Drink of it, all of you; this is My Blood of the New Testament, which is shed for you and for many, for the remission of sins.', 'Beți dintru acesta toți, acesta este Sângele Meu, al Legii celei Noi, Care pentru voi și pentru mulți se varsă, spre iertarea păcatelor.', NULL, 0, NULL),
    ('lit', 1160, 'choir', 'Amen.', 'Amin.', NULL, 0, NULL),
    ('lit', 1170, 'priest', 'Thine own of Thine own we offer unto Thee, on behalf of all and for all.', 'Ale Tale dintru ale Tale, Ție Îți aducem de toate și pentru toate.', 'thine-own', 0, NULL),
    ('lit', 1180, 'choir', 'We praise Thee, we bless Thee, we give thanks unto Thee, O Lord, and we pray unto Thee, O our God.', 'Pe Tine Te lăudăm, pe Tine Te binecuvântăm, Ție Îți mulțumim, Doamne, și ne rugăm Ție, Dumnezeului nostru.', NULL, 0, NULL);

-- Hymn to Theotokos
INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 1190, 'rubric', NULL, NULL, 'hymn-theotokos', 1, 'Hymn to the Theotokos'),
    ('lit', 1200, 'choir', 'It is truly meet to bless thee, O Theotokos, ever-blessed and most pure, and the Mother of our God. More honourable than the Cherubim, and more glorious beyond compare than the Seraphim, without defilement thou gavest birth to God the Word. True Theotokos, we magnify thee!', 'Cuvine-se cu adevărat să te fericim, Născătoare de Dumnezeu, cea pururea fericită și prea nevinovată și Maica Dumnezeului nostru. Ceea ce ești mai cinstită decât Heruvimii și mai slăvită fără de asemănare decât Serafimii, care fără stricăciune pe Dumnezeu Cuvântul ai născut, pe tine, cea cu adevărat Născătoare de Dumnezeu, te mărim!', 'axion', 0, NULL);

-- Lord's Prayer
INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 1210, 'rubric', NULL, NULL, 'lords-prayer', 1, 'The Lord''s Prayer'),
    ('lit', 1220, 'priest', 'And make us worthy, O Master, that with boldness and without condemnation we may dare to call upon Thee, the heavenly God, as Father, and to say:', 'Și ne învrednicește pe noi, Stăpâne, cu îndrăzneală fără de osândă, să cutezăm a Te chema pe Tine, Dumnezeul cel ceresc, Tată și a zice:', NULL, 0, NULL),
    ('lit', 1230, 'people', 'Our Father, Who art in heaven, hallowed be Thy name. Thy kingdom come. Thy will be done, on earth as it is in heaven. Give us this day our daily bread; and forgive us our trespasses, as we forgive those who trespass against us; and lead us not into temptation, but deliver us from evil.', 'Tatăl nostru, Care ești în ceruri, sfințească-Se numele Tău, vie Împărăția Ta, facă-Se voia Ta, precum în cer și pe pământ. Pâinea noastră cea spre ființă, dă-ne-o nouă astăzi. Și ne iartă nouă greșealele noastre, precum și noi iertăm greșiților noștri. Și nu ne duce pe noi în ispită, ci ne izbăvește de cel rău.', NULL, 0, NULL),
    ('lit', 1240, 'priest', 'For Thine is the kingdom, and the power, and the glory: of the Father and of the Son and of the Holy Spirit, now and ever and unto ages of ages.', 'Că a Ta este Împărăția și puterea și slava, a Tatălui și a Fiului și a Sfântului Duh, acum și pururea și în vecii vecilor.', NULL, 0, NULL),
    ('lit', 1250, 'choir', 'Amen.', 'Amin.', NULL, 0, NULL);

-- Pre-Communion
INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 1260, 'rubric', NULL, NULL, 'pre-communion', 1, 'Pre-Communion'),
    ('lit', 1320, 'priest', 'Holy things are for the holy!', 'Sfintele, Sfinților!', 'holy-things', 0, NULL),
    ('lit', 1330, 'choir', 'One is Holy, One is Lord: Jesus Christ, to the glory of God the Father. Amen.', 'Unul Sfânt, Unul Domn, Iisus Hristos, întru slava lui Dumnezeu Tatăl. Amin.', NULL, 0, NULL);

-- Communion
INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 1340, 'rubric', NULL, NULL, 'communion', 1, 'Communion'),
    ('lit', 1350, 'choir', 'Praise the Lord from the heavens, praise Him in the highest! Alleluia!', 'Lăudați pe Domnul din ceruri, lăudați-L pe El întru cele înalte! Aliluia!', 'communion-hymn', 0, NULL),
    ('lit', 1370, 'deacon', 'With the fear of God, and with faith and love, draw near!', 'Cu frică de Dumnezeu, cu credință și cu dragoste, apropiați-vă!', NULL, 0, NULL),
    ('lit', 1380, 'choir', 'Blessed is He that cometh in the name of the Lord! God is the Lord, and hath appeared unto us!', 'Binecuvântat este cel ce vine întru numele Domnului! Dumnezeu este Domnul și S-a arătat nouă!', NULL, 0, NULL);

-- Post-Communion
INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 1390, 'rubric', NULL, NULL, 'post-communion', 1, 'Post-Communion'),
    ('lit', 1410, 'choir', 'We have seen the true Light! We have received the heavenly Spirit! We have found the true Faith! Worshipping the undivided Trinity, who hath saved us.', 'Am văzut Lumina cea adevărată, am primit Duhul cel ceresc, am aflat credința cea adevărată, nedespărțitei Sfintei Treimi închinându-ne, că Aceasta ne-a mântuit pe noi.', 'true-light', 0, NULL),
    ('lit', 1430, 'choir', 'Amen. Let our mouths be filled with Thy praise, O Lord, that we may sing of Thy glory; for Thou hast made us worthy to partake of Thy holy, divine, immortal, and life-creating Mysteries. Keep us in Thy holiness, that all the day we may meditate upon Thy righteousness. Alleluia, alleluia, alleluia!', 'Amin. Să se umple gurile noastre de lauda Ta, Doamne, ca să lăudăm slava Ta, că ne-ai învrednicit pe noi a ne împărtăși cu Sfintele, cele fără de moarte, preacuratele și de viață făcătoarele Tale Taine. Aliluia, aliluia, aliluia!', NULL, 0, NULL);

-- Dismissal
INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 1440, 'rubric', NULL, NULL, 'dismissal', 1, 'Dismissal'),
    ('lit', 1510, 'priest', 'Let us go forth in peace.', 'Cu pace să ieșim.', NULL, 0, NULL),
    ('lit', 1520, 'choir', 'In the name of the Lord.', 'Întru numele Domnului.', NULL, 0, NULL),
    ('lit', 1560, 'priest', 'O Lord, Who blessest those who bless Thee, and sanctifiest those who put their trust in Thee: save Thy people and bless Thine inheritance. Preserve the fullness of Thy Church. Sanctify those who love the beauty of Thy house. Grant peace to Thy world, to Thy churches, to the priests, to all civil authorities, and to all Thy people. For every good gift and every perfect gift is from above, coming down from Thee, the Father of lights, and unto Thee we ascribe glory, thanksgiving, and worship: to the Father and to the Son and to the Holy Spirit, now and ever and unto ages of ages.', 'Cel ce binecuvântezi pe cei ce Te binecuvântează, Doamne, și sfințești pe cei ce nădăjduiesc spre Tine, mântuiește poporul Tău și binecuvântează moștenirea Ta. Pace lumii Tale dăruiește, Bisericilor Tale, preoților, cârmuitorilor și la tot poporul Tău. Că toată darea cea bună și tot darul desăvârșit de sus este, pogorând de la Tine, Părintele luminilor, și Ție slavă și mulțumire și închinăciune înălțăm, Tatălui și Fiului și Sfântului Duh, acum și pururea și în vecii vecilor.', 'ambon-prayer', 0, NULL),
    ('lit', 1570, 'choir', 'Amen. Blessed be the name of the Lord, henceforth and forevermore. (three times)', 'Amin. Fie numele Domnului binecuvântat, de acum și până în veac. (de trei ori)', NULL, 0, NULL),
    ('lit', 1600, 'priest', 'Glory to Thee, O Christ our God and our hope, glory to Thee!', 'Slavă Ție, Hristoase Dumnezeule, nădejdea noastră, slavă Ție!', NULL, 0, NULL),
    ('lit', 1610, 'priest', 'May Christ our true God, through the prayers of His most pure Mother, of the holy, glorious, and all-laudable Apostles, of our father among the saints John Chrysostom Archbishop of Constantinople, of the holy patrons of this parish, the righteous Brendan the Navigator and Joseph the New of Partos, and of all the saints, have mercy on us and save us, forasmuch as He is good and loveth mankind.', 'Hristos, adevăratul Dumnezeul nostru, pentru rugăciunile preacuratei Maicii Sale, ale celui între sfinți Părintelui nostru Ioan Gură de Aur, ale sfinților ocrotitori ai acestei parohii, dreptul Brendan Navigatorul și Iosif cel Nou de la Partoș, și ale tuturor sfinților, să ne miluiască și să ne mântuiască pe noi, ca un bun și de oameni iubitor.', 'final-dismissal', 0, NULL),
    ('lit', 1620, 'choir', 'Amen. Lord, have mercy! Lord, have mercy! Lord, have mercy!', 'Amin. Doamne, miluiește! Doamne, miluiește! Doamne, miluiește!', NULL, 0, NULL);

-- ---- NOTES ----

INSERT INTO notes (block_id, note_type, note_text, link_url, link_label, sort_order)
    SELECT id, 'score', 'Kyrie Eleison — Tone 8. Standard three-fold response.', NULL, NULL, 0
    FROM liturgy_blocks WHERE service_type = 'lit' AND sort_order = 70;

INSERT INTO notes (block_id, note_type, note_text, link_url, link_label, sort_order)
    SELECT id, 'score', 'Psalm 102 — Typical Sunday Antiphon.', NULL, NULL, 0
    FROM liturgy_blocks WHERE service_type = 'lit' AND sort_order = 340;

INSERT INTO notes (block_id, note_type, note_text, link_url, link_label, sort_order)
    SELECT id, 'score', 'Resurrectional Troparion, Tone 8. Changes weekly.', NULL, NULL, 0
    FROM liturgy_blocks WHERE service_type = 'lit' AND sort_order = 580;

INSERT INTO notes (block_id, note_type, note_text, link_url, link_label, sort_order)
    SELECT id, 'score', 'Cherubic Hymn (Heruvicul) — sung slowly. Choir pauses for the Great Entrance.', NULL, NULL, 0
    FROM liturgy_blocks WHERE service_type = 'lit' AND sort_order = 940;

INSERT INTO notes (block_id, note_type, note_text, link_url, link_label, sort_order)
    SELECT id, 'score', 'Nicene-Constantinopolitan Creed. Recited by all the faithful together.', NULL, NULL, 0
    FROM liturgy_blocks WHERE service_type = 'lit' AND sort_order = 1010;

INSERT INTO notes (block_id, note_type, note_text, link_url, link_label, sort_order)
    SELECT id, 'score', 'Sunday Communion Hymn (Chinonicul) — Psalm 148.', NULL, NULL, 0
    FROM liturgy_blocks WHERE service_type = 'lit' AND sort_order = 1350;

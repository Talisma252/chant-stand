-- ============================================================
-- Digital Chant Stand — Migration 0002
-- Complete Divine Liturgy of St John Chrysostom
-- Source of truth: Parish printed booklet (28 pages)
-- Archaic English (Thee/Thy/Thine) for divine pronouns
-- Applied: 2026-03-29
-- ============================================================

-- Clear existing liturgy blocks and their notes
DELETE FROM notes WHERE block_id IN (SELECT id FROM liturgy_blocks WHERE service_type = 'lit');
DELETE FROM liturgy_blocks WHERE service_type = 'lit';

-- Update bishop name in settings
INSERT OR REPLACE INTO settings (key, value) VALUES
    ('bishop_name', 'Nectarie'),
    ('metropolitan_name', 'Iosif');

-- ============================================================
-- PAGES 1-2: OPENING & GREAT LITANY
-- ============================================================

INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 10, 'rubric', 'LITURGY OF ST JOHN CHRYSOSTOM', NULL, 'opening', 1, 'Opening'),
    ('lit', 20, 'rubric', 'PRIEST:', NULL, NULL, 0, NULL),
    ('lit', 30, 'priest', 'Blessed is the Kingdom of the Father and of the Son and of the Holy Spirit, now and forever and to the ages of ages.', 'Binecuvântată este Împărăția Tatălui și a Fiului și a Sfântului Duh, acum și pururea și în vecii vecilor.', NULL, 0, NULL),
    ('lit', 40, 'choir', 'Amen.', 'Amin.', NULL, 0, NULL);

-- Great Litany (Litany of Peace)
INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 50, 'rubric', NULL, NULL, 'great-litany', 1, 'The Litany of Peace or Great Litany'),
    ('lit', 55, 'rubric', 'PRIEST:', NULL, NULL, 0, NULL),
    ('lit', 60, 'deacon', 'In peace, let us pray to the Lord.', 'Cu pace, Domnului să ne rugăm.', NULL, 0, NULL),
    ('lit', 70, 'choir', 'Lord, have mercy.', 'Doamne, miluiește.', NULL, 0, NULL),
    ('lit', 80, 'deacon', 'For the peace from above and for the salvation of our souls, let us pray to the Lord.', 'Pentru pacea de sus și pentru mântuirea sufletelor noastre, Domnului să ne rugăm.', NULL, 0, NULL),
    ('lit', 90, 'choir', 'Lord, have mercy.', 'Doamne, miluiește.', NULL, 0, NULL),
    ('lit', 100, 'deacon', 'For the peace of the whole world, for the stability of the holy churches of God, and for the unity of all, let us pray to the Lord.', 'Pentru pacea a toată lumea, pentru bunăstarea sfintelor lui Dumnezeu biserici și pentru unirea tuturor, Domnului să ne rugăm.', NULL, 0, NULL),
    ('lit', 110, 'choir', 'Lord, have mercy.', 'Doamne, miluiește.', NULL, 0, NULL),
    ('lit', 120, 'deacon', 'For this holy house and for those who enter it with faith, reverence, and the fear of God, let us pray to the Lord.', 'Pentru sfânt locașul acesta și pentru cei ce cu credință, cu evlavie și cu frică de Dumnezeu intră în el, Domnului să ne rugăm.', NULL, 0, NULL),
    ('lit', 130, 'choir', 'Lord, have mercy.', 'Doamne, miluiește.', NULL, 0, NULL),
    ('lit', 140, 'deacon', 'For pious and Orthodox Christians, let us pray to the Lord.', 'Pentru binecredincioșii și dreptmăritorii creștini, Domnului să ne rugăm.', NULL, 0, NULL),
    ('lit', 150, 'choir', 'Lord, have mercy.', 'Doamne, miluiește.', NULL, 0, NULL),
    ('lit', 160, 'deacon', 'For our Metropolitan Iosif, for our Bishop Nectarie, for the honourable presbytery, the diaconate in Christ, and for all the clergy and the people, let us pray to the Lord.', 'Pentru Înalt Prea Sfințitul Mitropolitul nostru Iosif, pentru Prea Sfințitul Episcopul nostru Nectarie, pentru cinstita preoțime, cea întru Hristos diaconie și tot clerul și poporul, Domnului să ne rugăm.', NULL, 0, NULL),
    ('lit', 170, 'choir', 'Lord, have mercy.', 'Doamne, miluiește.', NULL, 0, NULL),
    ('lit', 180, 'deacon', 'For our country, for the president, and for all in public service, let us pray to the Lord.', 'Pentru țara aceasta, pentru Președinte și pentru toată conducerea ei, Domnului să ne rugăm.', NULL, 0, NULL),
    ('lit', 190, 'choir', 'Lord, have mercy.', 'Doamne, miluiește.', NULL, 0, NULL),
    ('lit', 200, 'deacon', 'For this city, and for every city and land, and for the faithful who live in them, let us pray to the Lord.', 'Pentru orașul acesta, pentru tot orașul și țara și pentru cei ce cu credință locuiesc într-însele, Domnului să ne rugăm.', NULL, 0, NULL),
    ('lit', 210, 'choir', 'Lord, have mercy.', 'Doamne, miluiește.', NULL, 0, NULL),
    ('lit', 220, 'deacon', 'For favorable weather, for an abundance of the fruits of the earth, and for peaceful times, let us pray to the Lord.', 'Pentru bună-întocmirea văzduhurilor, pentru îmbelșugarea roadelor pământului și pentru vremuri pașnice, Domnului să ne rugăm.', NULL, 0, NULL),
    ('lit', 230, 'choir', 'Lord, have mercy.', 'Doamne, miluiește.', NULL, 0, NULL),
    ('lit', 240, 'deacon', 'For those who travel by land, sea, and air, for the sick, the suffering, the captives and for their salvation, let us pray to the Lord.', 'Pentru cei ce călătoresc pe uscat, pe ape și prin aer, pentru cei bolnavi, pentru cei ce se ostenesc, pentru cei robiți și pentru mântuirea lor, Domnului să ne rugăm.', NULL, 0, NULL),
    ('lit', 250, 'choir', 'Lord, have mercy.', 'Doamne, miluiește.', NULL, 0, NULL),
    ('lit', 260, 'deacon', 'For our deliverance from all affliction, wrath, danger, and necessity, let us pray to the Lord.', 'Pentru ca să ne izbăvim noi de tot necazul, mânia, primejdia și nevoia, Domnului să ne rugăm.', NULL, 0, NULL),
    ('lit', 270, 'choir', 'Lord, have mercy.', 'Doamne, miluiește.', NULL, 0, NULL),
    ('lit', 280, 'deacon', 'Help us, save us, have mercy on us, and protect us, O God, by Thy grace.', 'Apără, mântuiește, miluiește și ne păzește pe noi, Dumnezeule, cu harul Tău.', NULL, 0, NULL),
    ('lit', 290, 'choir', 'Lord, have mercy.', 'Doamne, miluiește.', NULL, 0, NULL),
    ('lit', 300, 'deacon', 'Commemorating our most holy, pure, blessed, and glorious Lady, the Theotokos and ever-virgin Mary, with all the saints, let us commend ourselves and one another and our whole life to Christ our God.', 'Pe Preasfânta, curata, preabinecuvântata, slăvita Stăpâna noastră, de Dumnezeu Născătoarea și pururea Fecioara Maria, cu toți sfinții pomenind-o, pe noi înșine și unii pe alții și toată viața noastră lui Hristos Dumnezeu să o dăm.', NULL, 0, NULL),
    ('lit', 310, 'choir', 'To Thee, O Lord.', 'Ție, Doamne.', NULL, 0, NULL);

-- Prayer of the First Antiphon
INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 320, 'rubric', 'PRIEST', NULL, 'prayer-antiphon-1', 1, 'The Prayer of the First Antiphon'),
    ('lit', 330, 'priest', 'Lord, our God, Whose dominion is incomparable and glory incomprehensible; Whose mercy is immeasurable, and love for mankind ineffable: Look upon us and upon this holy house in Thy loving-kindness, and grant to us and to those who pray with us Thine abundant mercy and compassion.', 'Doamne, Dumnezeul nostru, a Cărui stăpânire este neasemănată și slavă neajunsă; a Cărui milă este nemăsurată și iubire de oameni negrăită: Caută spre noi și spre sfânt locașul acesta, cu milostivire, și dăruiește nouă și celor ce se roagă împreună cu noi, bogata Ta milă și îndurarea Ta.', NULL, 0, NULL),
    ('lit', 340, 'priest', 'For unto Thee are due all glory, honour, and worship: to the Father and to the Son and to the Holy Spirit, now and forever and to the ages of ages.', 'Că Ție se cuvine toată slava, cinstea și închinăciunea, Tatălui și Fiului și Sfântului Duh, acum și pururea și în vecii vecilor.', NULL, 0, NULL),
    ('lit', 350, 'choir', 'Amen.', 'Amin.', NULL, 0, NULL);

-- ============================================================
-- PAGE 3: FIRST ANTIPHON
-- ============================================================

INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 360, 'rubric', NULL, NULL, 'antiphon-1', 1, 'First Antiphon — Mode 2'),
    ('lit', 370, 'rubric', 'The following verses as the ones most often chanted. Should be double-checked against the version in digital chant stand for variations based on the day.', NULL, NULL, 0, NULL),
    ('lit', 380, 'choir', 'Verse 1: Bless the Lord, O my soul, and everything within me, bless His holy name.\n\nThrough the intercessions of the Theotokos, Savior, save us.\n\nVerse 2: Bless the Lord, O my soul, and forget not all His rewards.\n\nThrough the intercessions of the Theotokos, Savior, save us.\n\nVerse 3: The Lord prepared His throne in heaven, and His Kingdom rules over all.\n\nThrough the intercessions of the Theotokos, Savior, save us.\n\nGlory to the Father and the Son and the Holy Spirit. Both now and ever and to the ages of ages. Amen.\n\nThrough the intercessions of the Theotokos, Savior, save us.', 'Stih 1: Binecuvântează, suflete al meu, pe Domnul și toate cele dinlăuntrul meu, numele cel sfânt al Lui.\n\nPentru rugăciunile Născătoarei de Dumnezeu, Mântuitorule, mântuiește-ne pe noi.\n\nStih 2: Binecuvântează, suflete al meu, pe Domnul și nu uita toate răsplătirile Lui.\n\nPentru rugăciunile Născătoarei de Dumnezeu, Mântuitorule, mântuiește-ne pe noi.\n\nStih 3: Domnul în cer a gătit scaunul Său și Împărăția Lui peste tot stăpânește.\n\nPentru rugăciunile Născătoarei de Dumnezeu, Mântuitorule, mântuiește-ne pe noi.\n\nSlavă Tatălui și Fiului și Sfântului Duh. Și acum și pururea și în vecii vecilor. Amin.\n\nPentru rugăciunile Născătoarei de Dumnezeu, Mântuitorule, mântuiește-ne pe noi.', NULL, 0, NULL);

-- Small Litany
INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 390, 'rubric', NULL, NULL, 'small-litany-1', 1, 'The Small Litany'),
    ('lit', 395, 'rubric', 'PRIEST:', NULL, NULL, 0, NULL),
    ('lit', 400, 'deacon', 'Again and again, in peace, let us pray to the Lord.', 'Iară și iară, cu pace, Domnului să ne rugăm.', NULL, 0, NULL),
    ('lit', 410, 'choir', 'Lord, have mercy.', 'Doamne, miluiește.', NULL, 0, NULL),
    ('lit', 420, 'deacon', 'Help us, save us, have mercy on us, and protect us, O God, by Thy grace.', 'Apără, mântuiește, miluiește și ne păzește pe noi, Dumnezeule, cu harul Tău.', NULL, 0, NULL),
    ('lit', 430, 'choir', 'Lord, have mercy.', 'Doamne, miluiește.', NULL, 0, NULL),
    ('lit', 440, 'deacon', 'Commemorating our most holy, pure, blessed, and glorious Lady, the Theotokos and ever-virgin Mary, with all the saints', NULL, NULL, 0, NULL),
    ('lit', 450, 'choir', 'Most Holy Birth-giver of God, save us.', 'Preasfântă Născătoare de Dumnezeu, mântuiește-ne pe noi.', NULL, 0, NULL),
    ('lit', 460, 'deacon', 'Let us commend ourselves and one another and our whole life to Christ our God.', 'Pe noi înșine și unii pe alții și toată viața noastră lui Hristos Dumnezeu să o dăm.', NULL, 0, NULL),
    ('lit', 470, 'choir', 'To Thee, O Lord.', 'Ție, Doamne.', NULL, 0, NULL);

-- Prayer of the Second Antiphon
INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 475, 'rubric', 'PRIEST', NULL, 'prayer-antiphon-2', 1, 'The Prayer of the Second Antiphon'),
    ('lit', 480, 'priest', 'Lord, our God, save Thy people and bless Thine inheritance. Protect the fullness of Thy Church. Sanctify those who love the beauty of Thy house. Glorify them in return by Thy divine power, and forsake us not who have set our hope in Thee.', 'Doamne, Dumnezeul nostru, mântuiește poporul Tău și binecuvântează moștenirea Ta. Plinătatea Bisericii Tale o păzește. Sfințește pe cei ce iubesc podoaba casei Tale.', NULL, 0, NULL),
    ('lit', 490, 'priest', 'For Thine is the dominion, and Thine is the kingdom and the power and the glory, of the Father and of the Son and of the Holy Spirit, now and forever and to the ages of ages.', 'Că a Ta este stăpânirea și a Ta este Împărăția și puterea și slava, a Tatălui și a Fiului și a Sfântului Duh, acum și pururea și în vecii vecilor.', NULL, 0, NULL),
    ('lit', 500, 'choir', 'Amen.', 'Amin.', NULL, 0, NULL);

-- ============================================================
-- PAGE 4: SECOND ANTIPHON
-- ============================================================

INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 510, 'rubric', NULL, NULL, 'antiphon-2', 1, 'Second Antiphon — Mode 2'),
    ('lit', 520, 'rubric', 'The following verses as the ones most often chanted. Should be double-checked against the version in digital chant stand for variations based on the day.', NULL, NULL, 0, NULL),
    ('lit', 530, 'choir', 'Verse 1: Praise the Lord, O my soul! I shall praise the Lord while I live; I shall chant to my God as long as I exist.\n\nSave us, O Son of God, risen from the dead, as we chant to Thee, Alleluia.\n\nVerse 2: Blessed is he whose help is the God of Jacob; his hope is in the Lord his God.\n\nSave us, O Son of God, risen from the dead, as we chant to Thee, Alleluia.\n\nVerse 3: The Lord shall reign forever; Thy God, O Zion, to all generations.\n\nSave us, O Son of God, risen from the dead, as we chant to Thee, Alleluia.\n\nGlory to the Father and the Son and the Holy Spirit. Both now and ever and to the ages of ages. Amen.', 'Stih 1: Laudă, suflete al meu, pe Domnul! Lăuda-voi pe Domnul în viața mea, cânta-voi Dumnezeului meu cât voi trăi.\n\nMântuiește-ne pe noi, Fiul lui Dumnezeu, Cel ce ai înviat din morți, pe noi, cei ce-Ți cântăm Ție: Aliluia.\n\nStih 2: Fericit cel ce are ajutor pe Dumnezeul lui Iacov.\n\nMântuiește-ne pe noi, Fiul lui Dumnezeu, Cel ce ai înviat din morți, pe noi, cei ce-Ți cântăm Ție: Aliluia.\n\nStih 3: Împărăți-va Domnul în veac, Dumnezeul Tău, Sioane, în neam și în neam.\n\nMântuiește-ne pe noi, Fiul lui Dumnezeu, Cel ce ai înviat din morți, pe noi, cei ce-Ți cântăm Ție: Aliluia.\n\nSlavă Tatălui și Fiului și Sfântului Duh. Și acum și pururea și în vecii vecilor. Amin.', NULL, 0, NULL);

-- ============================================================
-- PAGE 5: ONLY BEGOTTEN SON
-- ============================================================

INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 540, 'choir', 'Only begotten Son and Logos of God, being immortal, and condescended for our salvation to take flesh from the holy Theotokos and ever-virgin Mary and, without change, became man. And crucified, Christ our God, Thou trampled death by death. Being one of the Holy Trinity, glorified with the Father and the Holy Spirit: Save us.', 'Unule-Născut, Fiule și Cuvântul lui Dumnezeu, Cel ce ești fără de moarte și ai primit, pentru mântuirea noastră, a Te întrupa din Sfânta Născătoare de Dumnezeu și pururea Fecioara Maria; Care, neschimbat, Te-ai întrupat și, răstignindu-Te, Hristoase Dumnezeule, cu moartea pe moarte ai călcat; Unul fiind din Sfânta Treime, împreună slăvit cu Tatăl și cu Duhul Sfânt, mântuiește-ne pe noi!', 'only-begotten', 0, NULL);

-- Small Litany (repeated)
INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 550, 'rubric', NULL, NULL, 'small-litany-2', 1, 'The Small Litany'),
    ('lit', 560, 'deacon', 'Again and again, in peace, let us pray to the Lord.', 'Iară și iară, cu pace, Domnului să ne rugăm.', NULL, 0, NULL),
    ('lit', 570, 'choir', 'Lord, have mercy.', 'Doamne, miluiește.', NULL, 0, NULL),
    ('lit', 580, 'deacon', 'Help us, save us, have mercy on us, and protect us, O God, by Thy grace.', 'Apără, mântuiește, miluiește și ne păzește pe noi, Dumnezeule, cu harul Tău.', NULL, 0, NULL),
    ('lit', 590, 'choir', 'Lord, have mercy.', 'Doamne, miluiește.', NULL, 0, NULL),
    ('lit', 600, 'deacon', 'Commemorating our most holy, pure, blessed, and glorious Lady, the Theotokos and ever-virgin Mary, with all the saints', NULL, NULL, 0, NULL),
    ('lit', 610, 'choir', 'Most Holy Birth-giver of God, save us.', 'Preasfântă Născătoare de Dumnezeu, mântuiește-ne pe noi.', NULL, 0, NULL),
    ('lit', 620, 'deacon', 'Let us commend ourselves and one another and our whole life to Christ our God.', 'Pe noi înșine și unii pe alții și toată viața noastră lui Hristos Dumnezeu să o dăm.', NULL, 0, NULL),
    ('lit', 630, 'choir', 'To Thee, O Lord.', 'Ție, Doamne.', NULL, 0, NULL);

-- ============================================================
-- PAGE 6: PRAYER OF THIRD ANTIPHON, BEATITUDES
-- ============================================================

-- Prayer of the Third Antiphon
INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 640, 'rubric', 'PRIEST', NULL, 'prayer-antiphon-3', 1, 'The Prayer of the Third Antiphon'),
    ('lit', 650, 'priest', 'Lord, Thou hast granted us to offer these common prayers in unison and hast promised that when two or three agree in Thy name, Thou wilt grant their requests. Fulfill now, O Lord, the petitions of Thy servants as may be of benefit to them, granting us in the present age the knowledge of Thy truth, and in the age to come eternal life.', 'Cel ce ne-ai dăruit nouă aceste rugăciuni obștești și împreună glăsuitoare și Care ai făgăduit că atunci când doi sau trei se unesc în numele Tău le vei îndeplini cererile, Însuți și acum împlinește cererile cele de folos ale robilor Tăi, dându-ne nouă în veacul de acum cunoașterea adevărului Tău, și în cel ce va să fie viață veșnică dăruindu-ne.', NULL, 0, NULL),
    ('lit', 660, 'priest', 'For Thou, O God, art good and lovest mankind, and to Thee we offer up glory, to the Father and to the Son and to the Holy Spirit, now and forever, and to the ages of ages.', 'Că bun și de oameni iubitor Dumnezeu ești și Ție slavă înălțăm, Tatălui și Fiului și Sfântului Duh, acum și pururea și în vecii vecilor.', NULL, 0, NULL),
    ('lit', 670, 'choir', 'Amen.', 'Amin.', NULL, 0, NULL);

-- Third Antiphon / Beatitudes
INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 680, 'rubric', 'CHOIR\nThe 3rd Antiphon.\nMode pl. 4.', NULL, 'antiphon-3', 1, 'Third Antiphon — The Beatitudes'),
    ('lit', 690, 'choir', 'Verse 1: This is the day the Lord made; let us greatly rejoice and be glad therein.', 'Stih: Aceasta este ziua pe care a făcut-o Domnul; să ne bucurăm și să ne veselim într-însa.', NULL, 0, NULL),
    ('lit', 700, 'rubric', 'THE BEATITUDES\nMode pl. 4.', NULL, NULL, 0, NULL),
    ('lit', 710, 'choir', 'In Thy kingdom. Remember us, O Lord, when Thou comest in Thy kingdom. Blessed are the poor in spirit, for theirs is the kingdom of heaven.\n\nBlessed are those who mourn, for they shall be comforted.\n\nBlessed are the meek, for they shall inherit the earth.\n\nBlessed are those who hunger and thirst for righteousness, for they shall be satisfied.\n\nBlessed are the merciful, for they shall obtain mercy.\n\nBlessed are the pure in heart, for they shall see God.\n\nBlessed are the peacemakers, for they shall be called sons of God.\n\nBlessed are those who are persecuted for righteousness'' sake, for theirs is the kingdom of heaven.\n\nBlessed are you when men revile you and persecute you and utter all kinds of evil against you falsely for my sake.\n\nRejoice and be glad, for your reward is great in heaven.', 'Întru Împărăția Ta, pomenește-ne pe noi, Doamne, când vei veni întru Împărăția Ta. Fericiți cei săraci cu duhul, că a acelora este Împărăția Cerurilor.\n\nFericiți cei ce plâng, că aceia se vor mângâia.\n\nFericiți cei blânzi, că aceia vor moșteni pământul.\n\nFericiți cei flămânzi și însetați de dreptate, că aceia se vor sătura.\n\nFericiți cei milostivi, că aceia se vor milui.\n\nFericiți cei curați cu inima, că aceia vor vedea pe Dumnezeu.\n\nFericiți făcătorii de pace, că aceia fiii lui Dumnezeu se vor chema.\n\nFericiți cei prigoniți pentru dreptate, că a acelora este Împărăția Cerurilor.\n\nFericiți veți fi când vă vor ocărî și vă vor prigoni și vor zice tot cuvântul rău împotriva voastră, mințind, pentru Mine.\n\nBucurați-vă și vă veseliți, că plata voastră multă este în ceruri.', 'beatitudes', 0, NULL);

-- ============================================================
-- PAGE 7: THE SMALL ENTRANCE
-- ============================================================

INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 720, 'rubric', NULL, NULL, 'little-entrance', 1, 'The Small Entrance'),
    ('lit', 730, 'rubric', 'PRIEST\nTHE ENTRANCE PRAYER', NULL, NULL, 0, NULL),
    ('lit', 740, 'priest', 'Master, Lord our God, Who hast established the orders and hosts of angels and archangels in heaven to minister to Thy glory, grant that holy angels may enter with us, that together we may celebrate and glorify Thy goodness. For to Thee belong all glory, honour, and worship, to the Father and to the Son and to the Holy Spirit, now and forever and to the ages of ages.', 'Stăpâne, Doamne, Dumnezeul nostru, Cel ce ai așezat în ceruri cetele și oștirile îngerilor și ale arhanghelilor spre slujirea slavei Tale, fă ca împreună cu intrarea noastră să fie și intrarea sfinților Tăi îngeri, care împreună slujesc și împreună slăvesc bunătatea Ta.', NULL, 0, NULL),
    ('lit', 750, 'rubric', 'Blessed be the entrance of Thy holy ones always, now and forever and to the ages of ages. Amen.', NULL, NULL, 0, NULL),
    ('lit', 760, 'rubric', 'Wisdom. Arise.', NULL, NULL, 0, NULL),
    ('lit', 770, 'rubric', 'CHOIR\nEntrance Hymn. Mode 2.', NULL, NULL, 0, NULL),
    ('lit', 780, 'choir', 'Come, let us worship and bow down before Christ. Save us, O Son of God, risen from the dead, as we chant to Thee, Alleluia.', 'Veniți să ne închinăm și să cădem la Hristos. Mântuiește-ne pe noi, Fiul lui Dumnezeu, Cel ce ai înviat din morți, pe noi, cei ce-Ți cântăm Ție: Aliluia!', NULL, 0, NULL),
    ('lit', 785, 'rubric', 'Note: replace by "who is wondrous in the Saints" in daily liturgies.', NULL, NULL, 0, NULL);

-- ============================================================
-- PAGE 8: HYMNS AFTER THE SMALL ENTRANCE (TROPARIA)
-- ============================================================

INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 790, 'rubric', NULL, NULL, 'troparia', 1, 'Hymns After the Small Entrance'),
    ('lit', 800, 'rubric', 'For Sundays the following order is usually followed:\n\nResurrectional Apolytikion according to Mode\n[Variable — inserted weekly]', NULL, NULL, 0, NULL),
    ('lit', 810, 'rubric', 'Apolytikia of the Holy Church (below)', NULL, NULL, 0, NULL),
    ('lit', 820, 'rubric', 'St Brendan — Tone 8', NULL, 'troparion-brendan', 0, NULL),
    ('lit', 830, 'choir', 'The image of God was truly preserved in you, O Father, for you took up the Cross and followed after Christ. By so doing you taught us to disregard the flesh for it passes away, but to care instead for the soul, since it is immortal. Therefore, O Venerable Brendan, your spirit rejoices with the Angels.', NULL, NULL, 0, NULL),
    ('lit', 840, 'rubric', 'St Joseph — Tone 8', NULL, 'troparion-joseph', 0, NULL),
    ('lit', 850, 'choir', 'From your youth you obeyed the Lord in all things, by your prayers, labours, and fasting. Therefore, seeing your struggles, God appointed you as a Hierarch and Shepherd of His Church; and after death, you dwell in the abodes of the Saints. O Holy Father Joseph, entreat Christ God to grant the forgiveness of sins, to us who faithfully and lovingly, honour your holy memory.', NULL, NULL, 0, NULL),
    ('lit', 860, 'rubric', 'St Patrick — Tone 3', NULL, 'troparion-patrick', 0, NULL),
    ('lit', 870, 'choir', 'Holy Bishop Patrick, faithful shepherd of Christ''s royal flock, you filled Ireland with the radiance of the Gospel: The mighty strength of the Trinity! Now that you stand before the Savior, pray that He may preserve us in faith and love! Glory to the Father and the Son and the Holy Spirit. Now and forever and to the ages of ages, Amen.', NULL, NULL, 0, NULL),
    ('lit', 880, 'rubric', 'Saint Columba\nTroparion — Tone 5', NULL, 'troparion-columba', 0, NULL),
    ('lit', 890, 'choir', 'By your God-inspired life you embodied both the mission and the dispersion of the Church, most glorious Father Columba. Using your repentance and voluntary exile, Christ our God raised you up as a beacon of the True Faith, an apostle to the heathen and an indicator of the Way of salvation. Wherefore O holy one, cease not to intercede for us, that our souls may be saved.', NULL, NULL, 0, NULL),
    ('lit', 900, 'rubric', 'Kontakion of the day according to Mode and/or Feast.\n[Variable — inserted weekly]', NULL, 'kontakion', 0, NULL);

-- ============================================================
-- PAGE 9: TRISAGION
-- ============================================================

INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 910, 'rubric', 'Priest: Let us pray to the Lord.', NULL, 'trisagion-prayer', 1, 'The Prayer of the Trisagion Hymn'),
    ('lit', 920, 'choir', 'Lord, have mercy.', 'Doamne, miluiește.', NULL, 0, NULL),
    ('lit', 930, 'rubric', 'PRIEST', NULL, NULL, 0, NULL),
    ('lit', 940, 'priest', 'O Holy God, Who is resting among the holy ones, praised by the Seraphim with the thrice-holy voice, glorified by the Cherubim, and worshiped by every celestial power, Thou hast brought all things into being out of nothing. Thou hast created man according to Thine image and likeness and adorned him with all the gifts of Thy grace. Thou givest wisdom and understanding to the one who asks, and Thou overlookest not the sinner, but hast set repentance as the way of salvation. Thou hast granted us, Thy humble and unworthy servants, to stand even at this hour before the glory of Thy holy Altar of sacrifice and to offer to Thee due worship and praise. Master, accept the Trisagion Hymn also from the lips of us sinners, and visit us in Thy goodness. Forgive all our voluntary and involuntary transgressions, sanctify our souls and bodies, and grant that we may worship Thee in holiness all the days of our lives, through the intercessions of the holy Theotokos and of all the saints who have pleased Thee throughout the ages.', 'Sfinte Dumnezeule, Cel ce între sfinți Te odihnești, Cel ce cu glasul cel întreit sfânt ești lăudat de Serafimi și slăvit de Heruvimi și închinat de toată puterea cerească.', NULL, 0, NULL),
    ('lit', 950, 'priest', 'For Thou, our God, art holy, and to Thee we offer up glory, to the Father and to the Son and to the Holy Spirit, now and forever and to the ages of ages.', 'Că sfânt ești, Dumnezeul nostru, și Ție slavă înălțăm, Tatălui și Fiului și Sfântului Duh, acum și pururea și în vecii vecilor.', NULL, 0, NULL),
    ('lit', 960, 'choir', 'Amen.', 'Amin.', NULL, 0, NULL);

-- Trisagion Hymn
INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 970, 'rubric', NULL, NULL, 'trisagion', 1, 'Trisagion Hymn'),
    ('lit', 980, 'choir', 'Holy God, Holy Mighty, Holy Immortal, have mercy on us. (3)', 'Sfinte Dumnezeule, Sfinte tare, Sfinte fără de moarte, miluiește-ne pe noi. (de trei ori)', NULL, 0, NULL),
    ('lit', 990, 'choir', 'Glory to the Father and the Son and the Holy Spirit. Now and forever and to the ages of ages, Amen.', 'Slavă Tatălui și Fiului și Sfântului Duh. Și acum și pururea și în vecii vecilor. Amin.', NULL, 0, NULL),
    ('lit', 1000, 'choir', 'Holy Immortal, have mercy on us.', 'Sfinte fără de moarte, miluiește-ne pe noi.', NULL, 0, NULL),
    ('lit', 1010, 'rubric', 'PRIEST: With strength.', NULL, NULL, 0, NULL),
    ('lit', 1020, 'choir', 'Holy God, Holy Mighty, Holy Immortal, have mercy on us. (with ending)', 'Sfinte Dumnezeule, Sfinte tare, Sfinte fără de moarte, miluiește-ne pe noi.', NULL, 0, NULL);

-- ============================================================
-- PAGES 9-10: EPISTLE READING
-- ============================================================

INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 1030, 'rubric', NULL, NULL, 'epistle', 1, 'Epistle Reading'),
    ('lit', 1040, 'rubric', 'PRIEST:', NULL, NULL, 0, NULL),
    ('lit', 1050, 'deacon', 'Let us be attentive.', 'Să luăm aminte.', NULL, 0, NULL),
    ('lit', 1060, 'rubric', 'READER', NULL, NULL, 0, NULL),
    ('lit', 1070, 'rubric', 'Prokeimenon.', NULL, NULL, 0, NULL),
    ('lit', 1080, 'rubric', 'PRIEST: Wisdom.', NULL, NULL, 0, NULL),
    ('lit', 1090, 'rubric', 'READER: The reading is from...', NULL, NULL, 0, NULL),
    ('lit', 1100, 'deacon', 'Let us be attentive.', 'Să luăm aminte.', NULL, 0, NULL),
    ('lit', 1110, 'rubric', 'READER: Reading', NULL, NULL, 0, NULL),
    ('lit', 1120, 'priest', 'Peace be with/unto thee.', 'Pace ție.', NULL, 0, NULL),
    ('lit', 1130, 'choir', 'And with thy spirit.', 'Și duhului tău.', NULL, 0, NULL),
    ('lit', 1140, 'rubric', 'Preparation for the reading of the Holy Gospel', NULL, NULL, 0, NULL),
    ('lit', 1150, 'choir', 'Alleluia. Alleluia. Alleluia. (3 times)', 'Aliluia. Aliluia. Aliluia. (de trei ori)', 'alleluia-apostle', 0, NULL),
    ('lit', 1160, 'rubric', 'Then one of the verses of the day.\nAlleluia. Alleluia. Alleluia. (3 times)\n\nAnother verse if needed\nAlleluia. Alleluia. Alleluia. (3 times)', NULL, NULL, 0, NULL);

-- ============================================================
-- PAGE 10: PRAYER OF THE HOLY GOSPEL & GOSPEL
-- ============================================================

INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 1170, 'rubric', NULL, NULL, 'gospel-prayer', 1, 'The Prayer of the Holy Gospel'),
    ('lit', 1180, 'priest', 'Shine in our hearts, O Master Who lovest mankind, the pure light of Thy divine knowledge, and open the eyes of our mind that we may comprehend the proclamations of Thy Gospels. Instill in us also reverence for Thy blessed commandments so that, having trampled down all carnal desires, we may lead a spiritual life, both thinking and doing all those things that are pleasing to Thee. For Thou, Christ our God, art the illumination of our souls and bodies, and to Thee we offer up glory, together with Thy Father, Who is without beginning, and Thine all-holy, good, and life-creating Spirit, now and forever and to the ages of ages. Amen.', NULL, NULL, 0, NULL);

INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 1190, 'rubric', NULL, NULL, 'gospel', 1, 'The Gospel'),
    ('lit', 1200, 'deacon', 'Wisdom. Arise. Let us hear the Holy Gospel.', 'Înțelepciune! Drepți! Să ascultăm Sfânta Evanghelie.', NULL, 0, NULL),
    ('lit', 1210, 'priest', 'Peace be with all.', 'Pace tuturor.', NULL, 0, NULL),
    ('lit', 1220, 'choir', 'And with thy spirit.', 'Și duhului tău.', NULL, 0, NULL),
    ('lit', 1230, 'deacon', 'The reading is from the Holy Gospel according to... Let us be attentive.', 'Din Sfânta Evanghelie de la... citire. Să luăm aminte.', NULL, 0, NULL),
    ('lit', 1240, 'choir', 'Glory to Thee, O Lord, glory to Thee!', 'Slavă Ție, Doamne, slavă Ție!', NULL, 0, NULL),
    ('lit', 1250, 'rubric', 'Priest: Gospel Reading', NULL, NULL, 0, NULL),
    ('lit', 1260, 'choir', 'Glory to Thee, O Lord, glory to Thee!', 'Slavă Ție, Doamne, slavă Ție!', NULL, 0, NULL),
    ('lit', 1270, 'priest', 'Peace be with you.', 'Pace ție.', NULL, 0, NULL),
    ('lit', 1280, 'choir', 'And with thy spirit.', 'Și duhului tău.', NULL, 0, NULL),
    ('lit', 1285, 'rubric', 'THE SERMON', NULL, 'sermon', 0, NULL);

-- ============================================================
-- PAGE 11: LITANY OF FERVENT SUPPLICATION
-- ============================================================

INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 1290, 'rubric', NULL, NULL, 'augmented-litany', 1, 'The Litany of Fervent Supplication'),
    ('lit', 1300, 'deacon', 'Let us all say with all our soul and with all our mind, let us all say.', 'Să zicem toți din tot sufletul și din tot cugetul nostru, să zicem.', NULL, 0, NULL),
    ('lit', 1310, 'choir', 'Lord, have mercy.', 'Doamne, miluiește.', NULL, 0, NULL),
    ('lit', 1320, 'deacon', 'Lord almighty, God of our fathers, we pray Thee, hear us and have mercy.', 'Doamne Atotțiitorule, Dumnezeul părinților noștri, rugămu-ne Ție, auzi-ne și ne miluiește.', NULL, 0, NULL),
    ('lit', 1330, 'choir', 'Lord, have mercy.', 'Doamne, miluiește.', NULL, 0, NULL),
    ('lit', 1340, 'deacon', 'Have mercy on us, O God, according to Thy great mercy, we pray Thee, hear us and have mercy.', 'Miluiește-ne pe noi, Dumnezeule, după mare mila Ta, rugămu-ne Ție, auzi-ne și ne miluiește.', NULL, 0, NULL),
    ('lit', 1350, 'choir', 'Lord, have mercy. Lord, have mercy. Lord, have mercy.', 'Doamne, miluiește. Doamne, miluiește. Doamne, miluiește.', NULL, 0, NULL),
    ('lit', 1360, 'deacon', 'Again we pray for our Metropolitan Iosif and our Bishop Nectarie.', 'Încă ne rugăm pentru Înalt Prea Sfințitul Mitropolitul nostru Iosif și Prea Sfințitul Episcopul nostru Nectarie.', NULL, 0, NULL),
    ('lit', 1370, 'choir', 'Lord, have mercy. Lord, have mercy. Lord, have mercy.', 'Doamne, miluiește. Doamne, miluiește. Doamne, miluiește.', NULL, 0, NULL),
    ('lit', 1380, 'deacon', 'Again we pray for our brethren: the priests, the hieromonks, the hierodeacons, the monastics, and all our brotherhood in Christ.', NULL, NULL, 0, NULL),
    ('lit', 1390, 'choir', 'Lord, have mercy. Lord, have mercy. Lord, have mercy.', 'Doamne, miluiește. Doamne, miluiește. Doamne, miluiește.', NULL, 0, NULL),
    ('lit', 1400, 'deacon', 'Again we pray for mercy, life, peace, health, salvation, protection, forgiveness, and remission of the sins of the servants of God, all pious Orthodox Christians residing and visiting in this city: the parishioners, the members of the parish council, the stewards, and benefactors of this holy church.', NULL, NULL, 0, NULL),
    ('lit', 1410, 'choir', 'Lord, have mercy. Lord, have mercy. Lord, have mercy.', 'Doamne, miluiește. Doamne, miluiește. Doamne, miluiește.', NULL, 0, NULL),
    ('lit', 1420, 'rubric', 'Extra prayers here in the Slavic Typikon, with the same response: Lord, have mercy (3)', NULL, NULL, 0, NULL),
    ('lit', 1430, 'deacon', 'Again we pray for the blessed and ever-memorable founders of this holy church, and for all our fathers and brethren who have fallen asleep before us, who here have been piously laid to their rest, as well as the Orthodox everywhere.', NULL, NULL, 0, NULL),
    ('lit', 1440, 'choir', 'Lord, have mercy. Lord, have mercy. Lord, have mercy.', 'Doamne, miluiește. Doamne, miluiește. Doamne, miluiește.', NULL, 0, NULL),
    ('lit', 1450, 'deacon', 'Again we pray for those who bear fruit and do good works in this holy and all-venerable church, for those who labor and those who sing, and for the people here present who await Thy great and rich mercy.', NULL, NULL, 0, NULL),
    ('lit', 1460, 'choir', 'Lord, have mercy. Lord, have mercy. Lord, have mercy.', 'Doamne, miluiește. Doamne, miluiește. Doamne, miluiește.', NULL, 0, NULL);

-- Prayer of Fervent Supplication
INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 1470, 'rubric', NULL, NULL, 'prayer-fervent', 1, 'The Prayer of Fervent Supplication'),
    ('lit', 1480, 'priest', 'Lord our God, accept this fervent supplication from Thy servants, and have mercy on us in accordance with the abundance of Thy mercy, and send down Thy compassion upon us and upon all Thy people who await Thy great and rich mercy.', NULL, NULL, 0, NULL),
    ('lit', 1490, 'priest', 'For Thou art a merciful God Who lovest mankind, and to Thee we offer up glory, to the Father and to the Son and to the Holy Spirit, now and forever and to the ages of ages.', NULL, NULL, 0, NULL),
    ('lit', 1500, 'choir', 'Amen.', 'Amin.', NULL, 0, NULL);

-- ============================================================
-- PAGE 12: PRAYERS FOR THE CATECHUMENS
-- ============================================================

INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 1510, 'rubric', NULL, NULL, 'catechumens', 1, 'The Prayers for the Catechumens'),
    ('lit', 1520, 'deacon', 'Catechumens, pray to the Lord.', 'Cei chemați, rugați-vă Domnului.', NULL, 0, NULL),
    ('lit', 1530, 'choir', 'Lord, have mercy.', 'Doamne, miluiește.', NULL, 0, NULL),
    ('lit', 1540, 'deacon', 'Let us, the faithful, pray for the catechumens.', NULL, NULL, 0, NULL),
    ('lit', 1550, 'choir', 'Lord, have mercy.', 'Doamne, miluiește.', NULL, 0, NULL),
    ('lit', 1560, 'deacon', 'That the Lord will have mercy on them.', NULL, NULL, 0, NULL),
    ('lit', 1570, 'choir', 'Lord, have mercy.', 'Doamne, miluiește.', NULL, 0, NULL),
    ('lit', 1580, 'deacon', 'That He will teach them the word of truth.', NULL, NULL, 0, NULL),
    ('lit', 1590, 'choir', 'Lord, have mercy.', 'Doamne, miluiește.', NULL, 0, NULL),
    ('lit', 1600, 'deacon', 'That He will reveal to them the gospel of righteousness.', NULL, NULL, 0, NULL),
    ('lit', 1610, 'choir', 'Lord, have mercy.', 'Doamne, miluiește.', NULL, 0, NULL),
    ('lit', 1620, 'deacon', 'That He will unite them to His holy, catholic, and apostolic Church.', NULL, NULL, 0, NULL),
    ('lit', 1630, 'choir', 'Lord, have mercy.', 'Doamne, miluiește.', NULL, 0, NULL),
    ('lit', 1640, 'deacon', 'Save them, have mercy on them, help them, and protect them, O God, by Thy grace.', NULL, NULL, 0, NULL),
    ('lit', 1650, 'choir', 'Lord, have mercy.', 'Doamne, miluiește.', NULL, 0, NULL),
    ('lit', 1660, 'deacon', 'Catechumens, bow your heads to the Lord.', NULL, NULL, 0, NULL),
    ('lit', 1670, 'choir', 'To Thee, O Lord.', 'Ție, Doamne.', NULL, 0, NULL);

-- Prayer for the Catechumens
INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 1680, 'rubric', 'PRIEST: THE PRAYER FOR THE CATECHUMENS', NULL, NULL, 0, NULL),
    ('lit', 1690, 'priest', 'Lord our God, Who dwellest on high and watchest over the humble, Thou hast sent forth Thine only-begotten Son and God, our Lord Jesus Christ, for the salvation of the human race. Look down upon Thy servants, the catechumens, who have inclined their necks to Thee, and grant them at a proper time the baptism of rebirth, the remission of sins, and the garment of incorruption. Unite them to Thy holy, catholic, and apostolic Church, and number them among Thy chosen flock.', NULL, NULL, 0, NULL),
    ('lit', 1700, 'priest', 'So that with us they also may glorify Thy most honorable and majestic name, of the Father and of the Son and of the Holy Spirit, now and forever and to the ages of ages.', NULL, NULL, 0, NULL),
    ('lit', 1710, 'choir', 'Amen.', 'Amin.', NULL, 0, NULL);

-- ============================================================
-- PAGE 13: SUPPLICATION & PRAYERS OF THE FAITHFUL
-- ============================================================

INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 1720, 'rubric', 'Priest: Those who are catechumens, depart, catechumens depart, all those who are catechumens, depart. Let none of the catechumens remain.', NULL, NULL, 0, NULL);

INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 1730, 'rubric', NULL, NULL, 'supplication-faithful', 1, 'The Supplication of the Faithful'),
    ('lit', 1740, 'deacon', 'Again and again, in peace, let all of us, the faithful, pray to the Lord.', NULL, NULL, 0, NULL),
    ('lit', 1750, 'choir', 'Lord, have mercy.', 'Doamne, miluiește.', NULL, 0, NULL),
    ('lit', 1760, 'deacon', 'Help us, save us, have mercy on us, and protect us, O God, by Thy grace.', NULL, NULL, 0, NULL),
    ('lit', 1770, 'choir', 'Lord, have mercy.', 'Doamne, miluiește.', NULL, 0, NULL),
    ('lit', 1780, 'rubric', 'Wisdom.', NULL, NULL, 0, NULL);

INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 1790, 'rubric', NULL, NULL, 'prayer-faithful-1', 1, 'The First Prayer of the Faithful'),
    ('lit', 1800, 'priest', 'We give thanks to Thee, O Lord God of Hosts, Who hast made us worthy to stand even now before Thy holy Altar of sacrifice and to fall down before Thee seeking Thy compassion for our sins and those committed in ignorance by the people. Accept, O God, our supplication. Make us worthy to offer to Thee prayers, supplications, and bloodless sacrifices for all Thy people. By the power of Thy Holy Spirit, make us, whom Thou hast appointed to this, Thy ministry, free of blame or stumbling and, with the witness of a clear conscience, able to call upon Thee at every time and in every place, so that, hearing us, Thou may be merciful to us in the abundance of Thy goodness.', NULL, NULL, 0, NULL),
    ('lit', 1810, 'priest', 'For to Thee belong all glory, honour, and worship, to the Father and to the Son and to the Holy Spirit, now and forever and to the ages of ages.', NULL, NULL, 0, NULL),
    ('lit', 1820, 'choir', 'Amen.', 'Amin.', NULL, 0, NULL),
    ('lit', 1830, 'deacon', 'Again and again, in peace, let us pray to the Lord.', NULL, NULL, 0, NULL),
    ('lit', 1840, 'choir', 'Lord, have mercy.', 'Doamne, miluiește.', NULL, 0, NULL),
    ('lit', 1850, 'deacon', 'Help us, save us, have mercy on us, and protect us, O God, by Thy grace.', NULL, NULL, 0, NULL),
    ('lit', 1860, 'choir', 'Lord, have mercy.', 'Doamne, miluiește.', NULL, 0, NULL),
    ('lit', 1870, 'rubric', 'Wisdom.', NULL, NULL, 0, NULL);

INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 1880, 'rubric', NULL, NULL, 'prayer-faithful-2', 1, 'The Second Prayer of the Faithful'),
    ('lit', 1890, 'priest', 'Again and countless times we fall down before Thee, and we implore Thee, O Good One, Who lovest mankind: That Thou, having regarded our prayer, may cleanse our souls and bodies from every defilement of flesh and spirit, and grant to us to stand before Thy holy Altar of sacrifice, free of guilt and condemnation. Grant also, O God, to those who pray with us, progress in life, faith, and spiritual understanding. Grant that they always worship Thee with awe and love, partake of Thy Holy Mysteries without guilt or condemnation, and be deemed worthy of Thy celestial Kingdom.', NULL, NULL, 0, NULL),
    ('lit', 1900, 'priest', 'That, ever guarded by Thy might, we may ascribe glory to Thee, to the Father and to the Son and to the Holy Spirit, now and forever and to the ages of ages.', NULL, NULL, 0, NULL),
    ('lit', 1910, 'choir', 'Amen.', 'Amin.', NULL, 0, NULL);

-- ============================================================
-- PAGES 14-15: THE GREAT ENTRANCE & CHERUBIC HYMN
-- ============================================================

INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 1920, 'rubric', NULL, NULL, 'cherubic-hymn', 1, 'The Great Entrance'),
    ('lit', 1930, 'rubric', 'CHOIR: The Cherubic Hymn.', NULL, NULL, 0, NULL),
    ('lit', 1940, 'choir', 'Let us, who mystically represent the Cherubim and who sing the thrice-holy hymn to the life-creating Trinity, now lay aside all earthly care. So that we may receive the King of all.', 'Noi, care pe Heruvimi cu taină închipuim și făcătoarei de viață Treimi întreit-sfântă cântare aducem, toată grija cea lumească acum să o lepădăm. Ca pe Împăratul tuturor să-L primim.', 'cherubic', 0, NULL);

-- Prayer of the Cherubic Hymn
INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 1950, 'rubric', 'PRIEST: THE PRAYER OF THE CHERUBIC HYMN', NULL, 'prayer-cherubic', 0, NULL),
    ('lit', 1960, 'priest', 'No one bound by carnal desires and pleasures is worthy to approach, draw near, or minister to Thee, the King of Glory. For to serve Thee is great and awesome even for the heavenly powers. Yet, because of Thine ineffable and immeasurable love for mankind, Thou impassibly and immutably became man. Thou, as the Master of all, became our high priest and delivered unto us the sacred service of this liturgical sacrifice without the shedding of blood. Indeed, Lord our God, Thou alone dost reign over the celestial and the terrestrial; borne aloft on the cherubic throne, Lord of the Seraphim and King of Israel, the only holy and resting among the holy ones. I now beseech Thee, Who alone art good and inclined to hear: Look down upon me, Thy sinful and unprofitable servant, and cleanse my soul and heart of a wicked conscience; and enable me, by the power of Thy Holy Spirit, clothed with the grace of the priesthood, to stand before Thy holy Table and celebrate the Mystery of Thy holy and pure Body and Thy precious Blood. I come before Thee with my head bowed, and I implore Thee: Turn not Thy face away from me, nor reject me from among Thy children, but make me, Thy sinful and unworthy servant, worthy to offer these gifts to Thee. For Thou art the One Who both offers and is offered, the One Who is received and is distributed, O Christ our God, and to Thee we offer up glory, with Thy Father, Who is without beginning, and Thine all-holy and good and life-creating Spirit, now and forever and to the ages of ages. Amen.', NULL, NULL, 0, NULL);

-- Great Entrance
INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 1970, 'priest', 'May the Lord God remember all of us in His Kingdom always, now and forever and to the ages of ages.', 'Pe voi pe toți să vă pomenească Domnul Dumnezeu în Împărăția Sa, totdeauna, acum și pururea și în vecii vecilor.', 'great-entrance', 0, NULL),
    ('lit', 1980, 'rubric', 'Amen is chanted after each prayer.', NULL, NULL, 0, NULL),
    ('lit', 1985, 'choir', 'Amen.', 'Amin.', NULL, 0, NULL),
    ('lit', 1986, 'choir', 'Amen.', 'Amin.', NULL, 0, NULL),
    ('lit', 1987, 'choir', 'Amen.', 'Amin.', NULL, 0, NULL),
    ('lit', 1988, 'choir', 'Amen.', 'Amin.', NULL, 0, NULL),
    ('lit', 1989, 'choir', 'Amen.', 'Amin.', NULL, 0, NULL),
    ('lit', 1990, 'choir', 'Who is invisibly escorted by the angelic hosts. Alleluia. Alleluia. Alleluia.', 'Pe Cel nevăzut înconjurat de cetele îngerești. Aliluia, aliluia, aliluia.', NULL, 0, NULL);

-- ============================================================
-- PAGE 16: LITANY OF COMPLETION
-- ============================================================

INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 2000, 'rubric', NULL, NULL, 'litany-completion', 1, 'The Litany of Completion'),
    ('lit', 2010, 'deacon', 'Let us complete our prayer to the Lord.', 'Să plinim rugăciunea noastră Domnului.', NULL, 0, NULL),
    ('lit', 2020, 'choir', 'Lord, have mercy.', 'Doamne, miluiește.', NULL, 0, NULL),
    ('lit', 2030, 'deacon', 'For the precious Gifts here presented, let us pray to the Lord.', NULL, NULL, 0, NULL),
    ('lit', 2040, 'choir', 'Lord, have mercy.', 'Doamne, miluiește.', NULL, 0, NULL),
    ('lit', 2050, 'deacon', 'For this holy house and for those who enter it with faith, reverence, and the fear of God, let us pray to the Lord.', NULL, NULL, 0, NULL),
    ('lit', 2060, 'choir', 'Lord, have mercy.', 'Doamne, miluiește.', NULL, 0, NULL),
    ('lit', 2070, 'deacon', 'For our deliverance from all affliction, wrath, danger, and necessity, let us pray to the Lord.', NULL, NULL, 0, NULL),
    ('lit', 2080, 'choir', 'Lord, have mercy.', 'Doamne, miluiește.', NULL, 0, NULL),
    ('lit', 2090, 'deacon', 'Help us, save us, have mercy on us, and protect us, O God, by Thy grace.', NULL, NULL, 0, NULL),
    ('lit', 2100, 'choir', 'Lord, have mercy.', 'Doamne, miluiește.', NULL, 0, NULL),
    ('lit', 2110, 'deacon', 'That the whole day may be perfect, holy, peaceful, and sinless, let us ask the Lord.', NULL, NULL, 0, NULL),
    ('lit', 2120, 'choir', 'Grant this, O Lord.', 'Dă, Doamne.', NULL, 0, NULL),
    ('lit', 2130, 'deacon', 'For an angel of peace, a faithful guide, a guardian of our souls and bodies, let us ask the Lord.', NULL, NULL, 0, NULL),
    ('lit', 2140, 'choir', 'Grant this, O Lord.', 'Dă, Doamne.', NULL, 0, NULL),
    ('lit', 2150, 'deacon', 'For pardon and remission of our sins and transgressions, let us ask the Lord.', NULL, NULL, 0, NULL),
    ('lit', 2160, 'choir', 'Grant this, O Lord.', 'Dă, Doamne.', NULL, 0, NULL),
    ('lit', 2170, 'deacon', 'For that which is good and beneficial for our souls, and for peace for the world, let us ask the Lord.', NULL, NULL, 0, NULL),
    ('lit', 2180, 'choir', 'Grant this, O Lord.', 'Dă, Doamne.', NULL, 0, NULL),
    ('lit', 2190, 'deacon', 'That we may complete the remaining time of our life in peace and repentance, let us ask the Lord.', NULL, NULL, 0, NULL),
    ('lit', 2200, 'choir', 'Grant this, O Lord.', 'Dă, Doamne.', NULL, 0, NULL),
    ('lit', 2210, 'deacon', 'And let us ask for a Christian end to our life, peaceful, without shame and suffering, and for a good defense before the awesome judgment seat of Christ.', NULL, NULL, 0, NULL),
    ('lit', 2220, 'choir', 'Grant this, O Lord.', 'Dă, Doamne.', NULL, 0, NULL),
    ('lit', 2230, 'deacon', 'Commemorating our most holy, pure, blessed, and glorious Lady, the Theotokos and ever-virgin Mary, with all the saints,', NULL, NULL, 0, NULL),
    ('lit', 2240, 'choir', 'Most Holy Birth-giver of God, save us.', 'Preasfântă Născătoare de Dumnezeu, mântuiește-ne pe noi.', NULL, 0, NULL),
    ('lit', 2250, 'deacon', 'Let us commend ourselves and one another and our whole life to Christ our God.', NULL, NULL, 0, NULL),
    ('lit', 2260, 'choir', 'To Thee, O Lord.', 'Ție, Doamne.', NULL, 0, NULL);

-- ============================================================
-- PAGE 17: OFFERTORY PRAYER & PRE-CREED
-- ============================================================

INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 2270, 'rubric', NULL, NULL, 'offertory-prayer', 1, 'The Offertory Prayer'),
    ('lit', 2280, 'priest', 'Lord God Almighty, Thou alone art holy. Thou dost accept the sacrifice of praise from those who call upon Thee with their whole heart, even so, accept from us sinners our supplication, and bring it to Thy holy Altar of sacrifice. Enable us to offer to Thee gifts and spiritual sacrifices for our own sins and the failings of Thy people. Deem us worthy to find grace in Thy sight, that our sacrifice may be well pleasing to Thee, and that the good Spirit of Thy grace may rest upon us and upon these gifts presented and upon all Thy people.', NULL, NULL, 0, NULL),
    ('lit', 2290, 'priest', 'Through the mercies of Thine only begotten Son, with Whom Thou art blessed, together with Thine all-holy, good, and life-creating Spirit, now and forever and to the ages of ages.', NULL, NULL, 0, NULL),
    ('lit', 2300, 'choir', 'Amen.', 'Amin.', NULL, 0, NULL),
    ('lit', 2310, 'priest', 'Peace be with all.', 'Pace tuturor.', NULL, 0, NULL),
    ('lit', 2320, 'choir', 'And with thy spirit.', 'Și cu duhul tău.', NULL, 0, NULL),
    ('lit', 2330, 'deacon', 'Let us love one another, that with oneness of mind we may confess:', 'Să ne iubim unii pe alții, ca într-un gând să mărturisim:', NULL, 0, NULL),
    ('lit', 2340, 'choir', 'Father, Son, and Holy Spirit: Trinity, one in essence and unseparable.', 'Pe Tatăl, pe Fiul și pe Sfântul Duh, Treimea cea de o ființă și nedespărțită.', NULL, 0, NULL),
    ('lit', 2350, 'rubric', 'Or, for concelebrations:', NULL, NULL, 0, NULL),
    ('lit', 2360, 'choir', 'I will love Thee, O Lord, my strength. The Lord is my foundation, my refuge, my deliverer.', 'Iubi-Te-voi, Doamne, virtutea mea; Domnul este întărirea mea și scăparea mea.', NULL, 0, NULL),
    ('lit', 2370, 'priest', 'Christ is in the midst of us.', 'Hristos în mijlocul nostru.', NULL, 0, NULL),
    ('lit', 2380, 'people', 'He is and shall be.', 'Este și va fi.', NULL, 0, NULL),
    ('lit', 2390, 'priest', 'Now and forever and to the ages of ages.', 'Acum și pururea și în vecii vecilor.', NULL, 0, NULL),
    ('lit', 2400, 'people', 'Amen.', 'Amin.', NULL, 0, NULL);

-- ============================================================
-- PAGE 18: THE CREED
-- ============================================================

INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 2410, 'rubric', NULL, NULL, 'creed', 1, 'The Creed / The Symbol of Faith'),
    ('lit', 2420, 'deacon', 'The doors! The doors! In wisdom, let us be attentive!', 'Ușile! Ușile! Cu înțelepciune să luăm aminte!', NULL, 0, NULL),
    ('lit', 2430, 'people', 'I believe in one God, Father Almighty, Creator of heaven and earth, and of all things visible and invisible. And in one Lord Jesus Christ, the only-begotten Son of God, begotten of the Father before all ages; Light of Light, true God of true God, begotten, not created, of one essence with the Father through Whom all things were made. Who for us men and for our salvation came down from heaven and was incarnate of the Holy Spirit and the Virgin Mary and became man. He was crucified for us under Pontius Pilate, and suffered and was buried; And He rose on the third day, according to the Scriptures. He ascended into heaven and is seated at the right hand of the Father; And He will come again with glory to judge the living and the dead. His kingdom shall have no end.\n\nAnd in the Holy Spirit, the Lord, the Creator of life, Who proceeds from the Father, Who together with the Father and the Son is worshipped and glorified, Who spoke through the prophets. In one, holy, catholic, and apostolic Church. I confess one baptism for the forgiveness of sins. I look for the resurrection of the dead, and the life of the age to come. Amen.', 'Cred într-unul Dumnezeu, Tatăl Atotțiitorul, Făcătorul cerului și al pământului, văzutelor tuturor și nevăzutelor.\n\nȘi într-unul Domn Iisus Hristos, Fiul lui Dumnezeu, Unul-Născut, Care din Tatăl S-a născut mai înainte de toți vecii; Lumină din Lumină, Dumnezeu adevărat din Dumnezeu adevărat, Născut iar nu făcut, Cel de o ființă cu Tatăl, prin Care toate s-au făcut.\n\nCare pentru noi oamenii și pentru a noastră mântuire S-a pogorât din ceruri și S-a întrupat de la Duhul Sfânt și din Fecioara Maria și S-a făcut om.\n\nȘi S-a răstignit pentru noi în zilele lui Ponțiu Pilat, a pătimit și S-a îngropat.\n\nȘi a înviat a treia zi după Scripturi.\n\nȘi S-a înălțat la ceruri și șade de-a dreapta Tatălui.\n\nȘi iarăși va să vină cu slavă, să judece viii și morții, a Cărui împărăție nu va avea sfârșit.\n\nȘi întru Duhul Sfânt, Domnul de viață Făcătorul, Care din Tatăl purcede, Cel ce împreună cu Tatăl și cu Fiul este închinat și slăvit, Care a grăit prin prooroci.\n\nÎntru una, sfântă, sobornicească și apostolească Biserică.\n\nMărturisesc un botez spre iertarea păcatelor.\n\nAștept învierea morților și viața veacului ce va să fie. Amin.', NULL, 0, NULL);

-- ============================================================
-- PAGES 18-19: THE HOLY ANAPHORA
-- ============================================================

INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 2440, 'rubric', NULL, NULL, 'anaphora', 1, 'The Holy Anaphora'),
    ('lit', 2450, 'deacon', 'Let us stand aright! Let us stand in awe! Let us be attentive, that we may present the Holy Offering in peace.', 'Să stăm bine, să stăm cu frică, să luăm aminte, Sfânta Jertfă cu pace a o aduce.', NULL, 0, NULL),
    ('lit', 2460, 'choir', 'A mercy of peace, a sacrifice of praise.', 'Mila păcii, jertfa laudei.', NULL, 0, NULL),
    ('lit', 2470, 'priest', 'The grace of our Lord Jesus Christ, and the love of God and Father, and the communion of the Holy Spirit, be with you all.', 'Harul Domnului nostru Iisus Hristos și dragostea lui Dumnezeu Tatăl și împărtășirea Sfântului Duh să fie cu voi cu toți.', NULL, 0, NULL),
    ('lit', 2480, 'choir', 'And with thy spirit.', 'Și cu duhul tău.', NULL, 0, NULL),
    ('lit', 2490, 'priest', 'Let us lift up our hearts.', 'Sus să avem inimile.', NULL, 0, NULL),
    ('lit', 2500, 'choir', 'We lift them up to the Lord.', 'Avem către Domnul.', NULL, 0, NULL),
    ('lit', 2510, 'priest', 'Let us give thanks to the Lord.', 'Să mulțumim Domnului.', NULL, 0, NULL),
    ('lit', 2520, 'choir', 'It is proper and right.', 'Cu vrednicie și cu dreptate.', NULL, 0, NULL),
    ('lit', 2530, 'priest', 'It is proper and right to hymn Thee, to bless Thee, to praise Thee, to give thanks to Thee, and to worship Thee in every place of Thy dominion. For Thou, O God, art ineffable, inconceivable, invisible, incomprehensible, existing forever, forever the same, Thou and Thine only begotten Son and Thy Holy Spirit. Thou brought us out of nothing into being, and when we had fallen away, Thou raised us up again. Thou left nothing undone until Thou had led us up to heaven and granted us Thy Kingdom, which is to come. For all these things, we thank Thee and Thine only begotten Son and Thy Holy Spirit: for all things we know and do not know, for blessings manifest and hidden that have been bestowed on us. We thank Thee also for this Liturgy, which Thou hast deigned to receive from our hands, even though thousands of archangels and tens of thousands of angels stand around Thee, the Cherubim and Seraphim, six-winged, manyeyed, soaring aloft upon their wings, singing the triumphal hymn, exclaiming, proclaiming, and saying...', NULL, NULL, 0, NULL);

-- Sanctus
INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 2540, 'choir', 'Holy, holy, holy, Lord Sabaoth, heaven and earth are filled with Thy glory. Hosanna in the highest. Praised is He Who comes in the name of the Lord. Hosanna in the highest.', 'Sfânt, sfânt, sfânt, Domnul Savaot! Plin este cerul și pământul de slava Ta! Osana întru cei de sus! Binecuvântat este Cel ce vine întru numele Domnului! Osana întru cei de sus!', 'sanctus', 0, NULL);

-- Institution Narrative
INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 2550, 'priest', 'Together with these blessed powers, Master, Who lovest mankind, we also exclaim and say: Holy art Thou and most holy, Thou and Thine only begotten Son and Thy Holy Spirit. Holy art Thou and most holy, and sublime is Thy glory. Thou so loved Thy world that Thou gavest Thine only begotten Son so that everyone who believes in Him should not perish, but have eternal life. When He had come and fulfilled for our sake the entire plan of salvation, on the night in which He was delivered up, or rather when He delivered Himself up for the life of the world, He took bread in His holy, pure, and blameless hands, and, giving thanks and blessing, He hallowed and broke it, and gave it to His holy disciples and apostles, saying:', NULL, NULL, 0, NULL),
    ('lit', 2560, 'priest', 'Take, eat, this is My Body, which is broken for you for the remission of sins.', 'Luați, mâncați, acesta este Trupul Meu, Care se frânge pentru voi, spre iertarea păcatelor.', 'words-institution', 0, NULL),
    ('lit', 2570, 'choir', 'Amen.', 'Amin.', NULL, 0, NULL),
    ('lit', 2580, 'priest', 'Likewise, after partaking of the supper, He took the cup, saying,', NULL, NULL, 0, NULL),
    ('lit', 2590, 'priest', 'Drink of this, all of you; this is My Blood of the new covenant, which is shed for you and for many for the remission of sins.', 'Beți dintru acesta toți, acesta este Sângele Meu, al Legii celei Noi, Care pentru voi și pentru mulți se varsă, spre iertarea păcatelor.', NULL, 0, NULL),
    ('lit', 2600, 'choir', 'Amen.', 'Amin.', NULL, 0, NULL);

-- Anamnesis
INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 2610, 'priest', 'Remembering, therefore, this saving commandment and all that has been done for our sake: the Cross, the tomb, the Resurrection on the third day, the Ascension into heaven, the enthronement at the right hand, and the second and glorious coming again.', 'Aducându-ne aminte, așadar, de această poruncă mântuitoare și de toate cele ce s-au făcut pentru noi: de Cruce, de groapă, de Învierea cea de a treia zi, de suirea la ceruri, de șederea de-a dreapta și de a doua și slăvita venire iarăși.', NULL, 0, NULL),
    ('lit', 2620, 'priest', 'Thine own of Thine own we offer to Thee, in all and for all.', 'Ale Tale dintru ale Tale, Ție Îți aducem de toate și pentru toate.', 'thine-own', 0, NULL),
    ('lit', 2630, 'choir', 'We praise Thee, we bless Thee, we give thanks to Thee, and we pray to Thee, Lord our God.', 'Pe Tine Te lăudăm, pe Tine Te binecuvântăm, Ție Îți mulțumim, Doamne, și ne rugăm Ție, Dumnezeului nostru.', NULL, 0, NULL);

-- ============================================================
-- PAGE 20: EPICLESIS
-- ============================================================

INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 2640, 'rubric', NULL, NULL, 'epiclesis', 1, 'The Epiclesis'),
    ('lit', 2650, 'priest', 'Once again we offer to Thee this spiritual worship without the shedding of blood, and we beseech and pray and entreat Thee: Send down Thy Holy Spirit upon us and upon the gifts here presented,', NULL, 'epiclesis-prayer', 0, NULL),
    ('lit', 2660, 'priest', 'And make this Bread the precious Body of Thy Christ.', NULL, NULL, 0, NULL),
    ('lit', 2670, 'people', 'Amen.', 'Amin.', NULL, 0, NULL),
    ('lit', 2680, 'priest', 'And that which is in this Cup, the precious Blood of Thy Christ.', NULL, NULL, 0, NULL),
    ('lit', 2690, 'people', 'Amen.', 'Amin.', NULL, 0, NULL),
    ('lit', 2700, 'priest', 'Changing them by Thy Holy Spirit.', NULL, NULL, 0, NULL),
    ('lit', 2710, 'people', 'Amen. Amen. Amen.', 'Amin. Amin. Amin.', NULL, 0, NULL),
    ('lit', 2720, 'priest', 'So that they may be for those who partake of them for vigilance of soul, remission of sins, communion of Thy Holy Spirit, fullness of the Kingdom of Heaven, boldness before Thee, not for judgment or condemnation. Again, we offer Thee this spiritual worship for those who have reposed in the faith: forefathers, fathers, patriarchs, prophets, apostles, preachers, evangelists, martyrs, confessors, ascetics, and for every righteous spirit made perfect in faith, Especially for our most holy, pure, blessed, and glorious Lady, the Theotokos and ever-virgin Mary.', NULL, NULL, 0, NULL);

-- ============================================================
-- PAGE 20: HYMN TO THE THEOTOKOS
-- ============================================================

INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 2730, 'rubric', NULL, NULL, 'hymn-theotokos', 1, 'Hymn to the Theotokos'),
    ('lit', 2740, 'choir', 'It is truly right to bless, Theotokos, ever blessed, most pure, and Mother of our God. More honourable than the Cherubim, and beyond compare more glorious than the Seraphim, without corruption you gave birth to God the Logos. We magnify you, the true Theotokos.', 'Cuvine-se cu adevărat să te fericim, Născătoare de Dumnezeu, cea pururea fericită și prea nevinovată și Maica Dumnezeului nostru. Ceea ce ești mai cinstită decât Heruvimii și mai slăvită fără de asemănare decât Serafimii, care fără stricăciune pe Dumnezeu Cuvântul ai născut, pe tine, cea cu adevărat Născătoare de Dumnezeu, te mărim!', 'axion', 0, NULL);

-- ============================================================
-- PAGES 20-21: POST-ANAPHORA COMMEMORATIONS
-- ============================================================

INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 2750, 'priest', 'For Saint John the prophet, forerunner, and Baptist; for the holy, glorious, and most praiseworthy apostles; for Saint.....whose memory we celebrate; and for all Thy saints, through whose supplications, visit us, O God. And remember all who have fallen asleep in the hope of the resurrection to life eternal. Here the Priest commemorates by name those departed whom he wishes. Grant them rest, O our God, where the light of Thy countenance keeps watch. Again we beseech Thee, Lord, remember all Orthodox bishops who rightly teach the word of Thy truth, the presbyterate, the diaconate in Christ, and every priestly and monastic order. Again we offer Thee this spiritual worship for the whole world, for the holy, catholic, and apostolic Church,', NULL, NULL, 0, NULL),
    ('lit', 2760, 'priest', 'and for those living pure and reverent lives. For civil authorities and our armed forces, grant that they may govern in peace, Lord, so that in their tranquility we, too, may live calm and serene lives, in all piety and virtue.', NULL, NULL, 0, NULL),
    ('lit', 2770, 'priest', 'Among the first remember, Lord, our Metropolitan Iosif and our Bishop Nectarie. Grant them to Thy holy churches in peace, safety, honour, and health, unto length of days, rightly teaching the word of Thy truth.', NULL, NULL, 0, NULL),
    ('lit', 2780, 'priest', 'And remember those whom each one of us has in mind, and all the people.', NULL, NULL, 0, NULL),
    ('lit', 2790, 'choir', 'And all the people.', 'Și pe toți și pe toate.', NULL, 0, NULL),
    ('lit', 2800, 'priest', 'Remember, Lord, this city in which we live, and every city and land, and the faithful who live in them. Remember, Lord, those who travel by land, sea, and air; the sick; the suffering; the captives; and their salvation. Remember those who bear fruit and do good works in Thy holy churches and those who are mindful of the poor, and upon us all send forth Thy mercies.', NULL, NULL, 0, NULL),
    ('lit', 2810, 'priest', 'And grant that with one voice and one heart we may glorify and praise Thy most honorable and majestic name, of the Father and of the Son and of the Holy Spirit, now and forever and to the ages of ages.', NULL, NULL, 0, NULL),
    ('lit', 2820, 'choir', 'Amen.', 'Amin.', NULL, 0, NULL),
    ('lit', 2830, 'priest', 'And the mercies of our great God and Savior, Jesus Christ, be with you all.', 'Și să fie milele marelui Dumnezeu și Mântuitorului nostru Iisus Hristos cu voi cu toți.', NULL, 0, NULL),
    ('lit', 2840, 'choir', 'And with thy spirit.', 'Și cu duhul tău.', NULL, 0, NULL);

-- Post-Anaphora Litany
INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 2850, 'deacon', 'Having commemorated all the saints, again and again, in peace, let us pray to the Lord.', 'Pe toți sfinții pomenindu-i, iară și iară cu pace, Domnului să ne rugăm.', NULL, 0, NULL),
    ('lit', 2860, 'choir', 'Lord, have mercy.', 'Doamne, miluiește.', NULL, 0, NULL),
    ('lit', 2870, 'deacon', 'For the precious Gifts here presented and consecrated, let us pray to the Lord.', NULL, NULL, 0, NULL),
    ('lit', 2880, 'choir', 'Lord, have mercy.', 'Doamne, miluiește.', NULL, 0, NULL),
    ('lit', 2890, 'deacon', 'That our God Who loves mankind, having accepted them at His holy and celestial and mystical altar as an offering of spiritual fragrance, may in return send down upon us the divine grace and the gift of the Holy Spirit, let us pray.', NULL, NULL, 0, NULL),
    ('lit', 2900, 'choir', 'Lord, have mercy.', 'Doamne, miluiește.', NULL, 0, NULL),
    ('lit', 2910, 'deacon', 'For our deliverance from all affliction, wrath, danger, and necessity, let us pray to the Lord.', NULL, NULL, 0, NULL),
    ('lit', 2920, 'choir', 'Lord, have mercy.', 'Doamne, miluiește.', NULL, 0, NULL),
    ('lit', 2930, 'deacon', 'Help us, save us, have mercy on us, and protect us, O God, by Thy grace.', NULL, NULL, 0, NULL),
    ('lit', 2940, 'choir', 'Lord, have mercy.', 'Doamne, miluiește.', NULL, 0, NULL),
    ('lit', 2950, 'deacon', 'Having asked for the unity of the faith and for the communion of the Holy Spirit, let us commend ourselves and one another and our whole life to Christ our God.', 'Unirea credinței și împărtășirea Sfântului Duh cerând, pe noi înșine și unii pe alții și toată viața noastră lui Hristos Dumnezeu să o dăm.', NULL, 0, NULL),
    ('lit', 2960, 'choir', 'To Thee, O Lord.', 'Ție, Doamne.', NULL, 0, NULL);

-- ============================================================
-- PAGE 22: LORD'S PRAYER
-- ============================================================

INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 2970, 'rubric', NULL, NULL, 'lords-prayer', 1, 'The Lord''s Prayer'),
    ('lit', 2980, 'priest', 'We entrust to Thee, loving Master, our whole life and hope, and we beseech, pray, and implore Thee:', NULL, NULL, 0, NULL),
    ('lit', 2990, 'priest', 'Grant us to partake of Thy heavenly and awesome Mysteries from this sacred and spiritual table with a clear conscience for the remission of sins, the forgiveness of transgressions, the communion of the Holy Spirit, the inheritance of the Kingdom of Heaven, and boldness before Thee, not unto judgment or condemnation.', NULL, NULL, 0, NULL),
    ('lit', 3000, 'priest', 'And grant us, Master, with boldness and without condemnation, to dare call Thee, the heavenly God, Father, and to say:', 'Și ne învrednicește pe noi, Stăpâne, cu îndrăzneală fără de osândă, să cutezăm a Te chema pe Tine, Dumnezeul cel ceresc, Tată și a zice:', NULL, 0, NULL),
    ('lit', 3010, 'rubric', 'PEOPLE:', NULL, NULL, 0, NULL),
    ('lit', 3020, 'people', 'Our Father, who art in heaven, hallowed be Thy name. Thy kingdom come, Thy will be done, on earth as it is in heaven. Give us this day our daily bread; and forgive us our trespasses, as we forgive those who trespass against us. And lead us not into temptation, but deliver us from evil.', 'Tatăl nostru, Care ești în ceruri, sfințească-Se numele Tău, vie Împărăția Ta, facă-Se voia Ta, precum în cer și pe pământ. Pâinea noastră cea spre ființă, dă-ne-o nouă astăzi. Și ne iartă nouă greșealele noastre, precum și noi iertăm greșiților noștri. Și nu ne duce pe noi în ispită, ci ne izbăvește de cel rău.', NULL, 0, NULL),
    ('lit', 3030, 'priest', 'For Thine is the Kingdom and the power and the glory, of the Father and of the Son and of the Holy Spirit, now and forever and to the ages of ages.', 'Că a Ta este Împărăția și puterea și slava, a Tatălui și a Fiului și a Sfântului Duh, acum și pururea și în vecii vecilor.', NULL, 0, NULL),
    ('lit', 3040, 'choir', 'Amen.', 'Amin.', NULL, 0, NULL),
    ('lit', 3050, 'priest', 'Peace be with all.', 'Pace tuturor.', NULL, 0, NULL),
    ('lit', 3060, 'choir', 'And with thy spirit.', 'Și cu duhul tău.', NULL, 0, NULL),
    ('lit', 3070, 'deacon', 'Let us bow our heads to the Lord.', 'Capetele noastre Domnului să le plecăm.', NULL, 0, NULL),
    ('lit', 3080, 'choir', 'To Thee, O Lord.', 'Ție, Doamne.', NULL, 0, NULL);

-- Pre-Communion Prayers
INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 3090, 'rubric', NULL, NULL, 'pre-communion', 1, 'Pre-Communion'),
    ('lit', 3100, 'priest', 'We give thanks to Thee, invisible King, Who by Thy boundless power fashioned the universe, and in the multitude of Thy mercy brought all things from nothing into being. Look down from heaven, O Master, upon those who have bowed their heads before Thee, for they have not bowed before flesh and blood, but before Thee, the awesome God. Therefore, O Master, make smooth and beneficial for us all, whatever lies ahead, according to the need of each: Sail with those who sail, travel with those who travel, heal the sick, Physician of our souls and bodies.', NULL, NULL, 0, NULL),
    ('lit', 3110, 'priest', 'Through the grace, compassion, and love for mankind of Thine only begotten Son, with whom Thou art blessed, together with Thine all-holy, good, and life-creating Spirit, now and forever and to the ages of ages.', NULL, NULL, 0, NULL),
    ('lit', 3120, 'choir', 'Amen.', 'Amin.', NULL, 0, NULL);

-- ============================================================
-- PAGE 22: THE HOLY COMMUNION
-- ============================================================

INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 3130, 'rubric', NULL, NULL, 'holy-communion-prayer', 1, 'The Holy Communion'),
    ('lit', 3140, 'priest', 'Hearken, O Lord Jesus Christ our God, from Thy holy dwelling place and from the throne of glory of Thy Kingdom, and come to sanctify us, Thou Who art enthroned with the Father on high and art present among us invisibly here. And with Thy mighty hand, grant Communion of Thy most pure Body and precious Blood to us, and through us to all the people.', NULL, NULL, 0, NULL),
    ('lit', 3150, 'rubric', 'Let us be attentive. The Holy to the Holy.', NULL, NULL, 0, NULL),
    ('lit', 3160, 'choir', 'One is Holy, one is Lord, Jesus Christ, to the glory of God the Father. Amen.', 'Unul Sfânt, Unul Domn, Iisus Hristos, întru slava lui Dumnezeu Tatăl. Amin.', 'holy-things', 0, NULL);

-- ============================================================
-- PAGES 23-24: COMMUNION HYMNS
-- ============================================================

INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 3170, 'rubric', NULL, NULL, 'communion', 1, 'Communion'),
    ('lit', 3180, 'rubric', 'Communion Hymn according to typikon of the day.\nThe hymn will be chanted until the Father signals the citation of the prayers before Holy Communion, and will continue after that.', NULL, NULL, 0, NULL),
    ('lit', 3190, 'rubric', 'Psalm 148 Choir: On Sundays', NULL, 'communion-hymn', 0, NULL),
    ('lit', 3200, 'choir', 'Praise the Lord from the heavens. Alleluia.', 'Lăudați pe Domnul din ceruri. Aliluia.', NULL, 0, NULL),
    ('lit', 3210, 'rubric', 'CHANTING THE VERSES', NULL, NULL, 0, NULL),
    ('lit', 3220, 'choir', 'Praise the Lord from the heavens, praise Him in the highest.\n2 Praise Him, all ye His angels; praise Him, all ye His hosts.\n3 Praise Him, O sun and moon; praise Him, all ye stars and light.\n4 Praise Him, ye heavens of heavens, and thou water that art above the heavens.\n5 Let them praise the name of the Lord; for He spake, and they came to be; He commanded, and they were created.\n6 He established them for ever, yea, for ever and ever; He hath set an ordinance, and it shall not pass away.\n7 Praise the Lord from the earth, ye dragons, and all ye abysses,\n8 Fire, hail, snow, ice, blast of tempest, which perform His word,\n9 The mountains and all the hills, fruitful trees, and all cedars,\n10 The beasts and all the cattle, creeping things and winged birds,\n11 Kings of the earth, and all peoples, princes and all the judges of the earth,\n12 Young men and virgins, elders with the younger; let them praise the name of the Lord, for exalted is the name of Him alone.\n13 His praise is above the earth and heaven, and He shall exalt the horn of His people.\n14 This is the hymn for all His saints, for the sons of Israel, and for the people that draw nigh unto Him.', 'Lăudați pe Domnul din ceruri, lăudați-L pe El întru cele înalte.\nLăudați-L pe El toți îngerii Lui, lăudați-L pe El toate puterile Lui.\nLăudați-L pe El soarele și luna, lăudați-L pe El toate stelele și lumina.\nLăudați-L pe El cerurile cerurilor și apa cea mai presus de ceruri.\nSă laude numele Domnului, că El a zis și s-au făcut, El a poruncit și s-au zidit.\nPusu-le-a pe ele în veac și în veacul veacului; poruncă a pus și nu o va trece.\nLăudați pe Domnul de pe pământ, balaurii și toate adâncurile.\nFocul, grindina, zăpada, gheața, viforul, cele ce faceți cuvântul Lui.\nMunții și toate dealurile, pomii cei roditori și toți cedrii.\nFiarele și toate dobitoacele, târâtoarele și păsările cele zburătoare.\nÎmpărații pământului și toate popoarele, căpeteniile și toți judecătorii pământului.\nTinerii și fecioarele, bătrânii cu cei mai tineri, să laude numele Domnului, că numai numele Lui s-a înălțat.\nLauda Lui pe pământ și în cer. Și va înălța puterea poporului Său.\nCântare tuturor cuvioșilor Lui, fiilor lui Israel, poporului ce se apropie de El.', NULL, 0, NULL),
    ('lit', 3230, 'rubric', 'Psalm 111/112 Choir: On Saturdays mostly', NULL, NULL, 0, NULL),
    ('lit', 3240, 'choir', 'The righteous will be remembered for ever. Alleluia.', 'Întru pomenire veșnică va fi dreptul. Aliluia.', NULL, 0, NULL);

-- ============================================================
-- PAGE 25: PSALM 135
-- ============================================================

INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 3250, 'rubric', 'Psalm 135 (sung during the communion of the clergy). Alleluia is inserted after each phrase.', 'Psalmul 135 (se cântă în timpul împărtășirii preoților). Aliluia se intercalează după fiecare stih.', 'psalm-135', 0, NULL),
    ('lit', 3260, 'choir', 'O give thanks unto the Lord, for He is good; for His mercy endureth for ever. Alleluia!\nO give thanks unto the God of gods; for His mercy endureth for ever. Alleluia!\nO give thanks unto the Lord of lords; for His mercy endureth for ever. Alleluia!\nTo Him Who alone hath wrought great wonders; for His mercy endureth for ever. Alleluia!\nTo Him that made the heavens with understanding; for His mercy endureth for ever. Alleluia!\nTo Him that established the earth upon the waters; for His mercy endureth for ever. Alleluia!\nTo Him Who alone hath made great lights; for His mercy endureth for ever. Alleluia!\nThe sun for dominion of the day; for His mercy endureth for ever. Alleluia!\nThe moon and the stars for dominion of the night; for His mercy endureth for ever. Alleluia!\nTo Him that smote Egypt with their firstborn; for His mercy endureth for ever. Alleluia!\nAnd led forth Israel out of the midst of them; for His mercy endureth for ever. Alleluia!\nWith a strong hand and a lofty arm; for His mercy endureth for ever. Alleluia!\nTo Him that divided the Red Sea into parts; for His mercy endureth for ever. Alleluia!\nAnd led Israel through the midst thereof; for His mercy endureth for ever. Alleluia!\nAnd overthrew Pharaoh and his host in the Red Sea; for His mercy endureth for ever. Alleluia!\nTo Him that led His people through the wilderness; for His mercy endureth for ever. Alleluia!\nTo Him that smote great kings; for His mercy endureth for ever. Alleluia!\nAnd slew mighty kings; for His mercy endureth for ever. Alleluia!\nSeon, king of the Amorites; for His mercy endureth for ever. Alleluia!\nAnd Og, king of the land of Basan; for His mercy endureth for ever. Alleluia!\nAnd gave their land for an inheritance; for His mercy endureth for ever. Alleluia!\nAn inheritance for Israel His servant; for His mercy endureth for ever. Alleluia!\nFor in our humiliation the Lord remembered us; for His mercy endureth for ever. Alleluia!\nAnd redeemed us from our enemies; for His mercy endureth for ever. Alleluia!\nHe that giveth food to all flesh; for His mercy endureth for ever. Alleluia!\nO give thanks unto the God of heaven; for His mercy endureth for ever. Alleluia!', 'Lăudați pe Domnul că este bun, că în veac este mila Lui. Aliluia!\nLăudați pe Dumnezeul dumnezeilor, că în veac este mila Lui. Aliluia!\nLăudați pe Domnul domnilor, că în veac este mila Lui. Aliluia!\nCelui ce face minuni mari, Lui singur, că în veac este mila Lui. Aliluia!\nCelui ce a făcut cerurile cu pricepere, că în veac este mila Lui. Aliluia!\nCelui ce a întărit pământul pe ape, că în veac este mila Lui. Aliluia!\nCelui ce a făcut luminătorii cei mari, Lui singur, că în veac este mila Lui. Aliluia!\nSoarele, spre stăpânirea zilei, că în veac este mila Lui. Aliluia!\nLuna și stelele, spre stăpânirea nopții, că în veac este mila Lui. Aliluia!\nCelui ce a bătut Egiptul cu cei întâi-născuți ai lor, că în veac este mila Lui. Aliluia!\nȘi a scos pe Israel din mijlocul lor, că în veac este mila Lui. Aliluia!\nCu mână tare și cu braț înalt, că în veac este mila Lui. Aliluia!\nCelui ce a despărțit Marea Roșie în două, că în veac este mila Lui. Aliluia!\nȘi a trecut pe Israel prin mijlocul ei, că în veac este mila Lui. Aliluia!\nȘi a răsturnat pe Faraon și oastea lui în Marea Roșie, că în veac este mila Lui. Aliluia!\nCelui ce a trecut pe poporul Său prin pustie, că în veac este mila Lui. Aliluia!\nCelui ce a bătut împărați mari, că în veac este mila Lui. Aliluia!\nȘi a ucis împărați puternici, că în veac este mila Lui. Aliluia!\nPe Seon, împăratul Amoreilor, că în veac este mila Lui. Aliluia!\nȘi pe Og, împăratul Vasanului, că în veac este mila Lui. Aliluia!\nȘi a dat pământul lor moștenire, că în veac este mila Lui. Aliluia!\nMoștenire lui Israel, sluga Sa, că în veac este mila Lui. Aliluia!\nCă întru smerenia noastră Și-a adus aminte de noi Domnul, că în veac este mila Lui. Aliluia!\nȘi ne-a izbăvit pe noi de vrăjmașii noștri, că în veac este mila Lui. Aliluia!\nCel ce dă hrană la tot trupul, că în veac este mila Lui. Aliluia!\nLăudați pe Dumnezeul cerurilor, că în veac este mila Lui. Aliluia!', NULL, 0, NULL),
    ('lit', 3270, 'priest', 'Save, O God, Thy people, and bless Thine inheritance.', 'Mântuiește, Dumnezeule, poporul Tău și binecuvântează moștenirea Ta.', NULL, 0, NULL);

-- Holy Communion
INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 3280, 'rubric', NULL, NULL, 'holy-communion', 1, 'The Holy Communion'),
    ('lit', 3290, 'deacon', 'With fear of God, faith, and love, draw near.', 'Cu frică de Dumnezeu, cu credință și cu dragoste, apropiați-vă.', NULL, 0, NULL),
    ('lit', 3300, 'choir', 'Blessed is he who comes in the name of the Lord.', 'Binecuvântat este cel ce vine întru numele Domnului.', NULL, 0, NULL);

-- ============================================================
-- PAGE 26: POST-COMMUNION
-- ============================================================

INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 3310, 'rubric', NULL, NULL, 'post-communion', 1, 'Post-Communion'),
    ('lit', 3320, 'choir', 'We have seen the true light; we have received the heavenly Spirit; we have found the true faith, worshipping the undivided Trinity, for the Trinity has saved us.', 'Am văzut Lumina cea adevărată, am primit Duhul cel ceresc, am aflat credința cea adevărată, nedespărțitei Sfintei Treimi închinându-ne, că Aceasta ne-a mântuit pe noi.', 'true-light', 0, NULL),
    ('lit', 3330, 'priest', 'Wash away, Lord, by Thy Holy Blood, the sins of Thy servants here remembered through the intercessions of the Theotokos and all Thy saints. Amen.', NULL, NULL, 0, NULL),
    ('lit', 3340, 'rubric', 'Be exalted, O God, above the heavens, and let Thy glory be over all the earth. Always, now and forever and to the ages of ages.', NULL, NULL, 0, NULL),
    ('lit', 3350, 'choir', 'Amen.', 'Amin.', NULL, 0, NULL),
    ('lit', 3360, 'choir', 'Let our mouths be filled with Thy praise, O Lord, for Thou hast made us worthy to partake of Thy Holy, Divine, Immortal and Life-giving Mysteries. Keep us in Thy holiness, all day long meditating upon Thy righteousness. Alleluia. Alleluia. Alleluia.', 'Să se umple gurile noastre de lauda Ta, Doamne, ca să lăudăm slava Ta, că ne-ai învrednicit pe noi a ne împărtăși cu Sfintele, cele fără de moarte, preacuratele și de viață făcătoarele Tale Taine. Întărește-ne pe noi întru sfințenia Ta, toată ziua să ne învățăm dreptatea Ta. Aliluia, aliluia, aliluia.', NULL, 0, NULL),
    ('lit', 3370, 'priest', 'Arise! Having partaken of the divine, holy, pure, immortal, heavenly, life-creating, and awesome Mysteries of Christ, let us worthily give thanks to the Lord.', NULL, NULL, 0, NULL),
    ('lit', 3380, 'choir', 'Glory to Thee, O Lord, glory to Thee.', 'Slavă Ție, Doamne, slavă Ție.', NULL, 0, NULL),
    ('lit', 3390, 'deacon', 'Help us, save us, have mercy on us, and protect us, O God, by Thy grace.', NULL, NULL, 0, NULL),
    ('lit', 3400, 'choir', 'Lord, have mercy.', 'Doamne, miluiește.', NULL, 0, NULL),
    ('lit', 3410, 'deacon', 'Having prayed for a perfect, holy, peaceful, and sinless day, let us commend ourselves and one another and our whole life to Christ our God.', NULL, NULL, 0, NULL),
    ('lit', 3420, 'choir', 'To Thee, O Lord.', 'Ție, Doamne.', NULL, 0, NULL);

-- ============================================================
-- PAGES 27-28: THANKSGIVING, AMBON PRAYER & DISMISSAL
-- ============================================================

-- Thanksgiving Prayer
INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 3430, 'rubric', NULL, NULL, 'thanksgiving', 1, 'The Thanksgiving Prayer'),
    ('lit', 3440, 'priest', 'We give thanks to Thee, O Lord our God, for the participation of Thy holy, pure, immortal and heavenly Mysteries, which Thou hast given us for the benefit, sanctification, and healing of our souls and bodies. Do Thou, O Master of all, grant that the communion of the Holy Body and Blood of Thy Christ may be unto us for faith unashamed, for love unfeigned, for increase of wisdom, for the healing of soul and body, for the repelling of every adversary, for the keeping of Thy commandments, and for an acceptable defense before the fearful judgment seat of Thy Christ.', NULL, NULL, 0, NULL);

-- Ambon Prayer
INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 3450, 'rubric', NULL, NULL, 'ambon-prayer', 1, 'The Ambon Prayer'),
    ('lit', 3460, 'priest', 'Lord, Who blesses those who bless Thee, and sanctifies those who put their trust in Thee, save Thy people and bless Thine inheritance. Preserve the fullness of Thy Church. Sanctify those who love the beauty of Thy house. Glorify them in return by Thy divine power, and do not forsake us who hope in Thee. Grant peace to Thy world, to Thy churches, to the priests, to our civil authorities, to the armed forces, and to all Thy people. For every good gift and every perfect gift is from above, coming down from Thee, the Father of lights, and to Thee we give glory, thanksgiving, and worship: to the Father and to the Son and to the Holy Spirit, now and forever and to the ages of ages.', NULL, NULL, 0, NULL),
    ('lit', 3470, 'choir', 'Amen.', 'Amin.', NULL, 0, NULL);

-- Praised be the name of the Lord (×3)
INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 3480, 'rubric', NULL, NULL, 'praised-be', 1, 'Praised Be the Name of the Lord'),
    ('lit', 3490, 'choir', 'Praised be the name of the Lord, from this time forth and to the ages. (×3)', 'Fie numele Domnului binecuvântat, de acum și până în veac. (×3)', NULL, 0, NULL);

-- Psalm 33 (selected verses)
INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 3500, 'rubric', NULL, NULL, 'psalm-33', 1, 'Psalm 33'),
    ('lit', 3510, 'reader', 'I will bless the Lord at all times; His praise shall continually be in my mouth. My soul makes its boast in the Lord; let the humble hear and be glad. O magnify the Lord with me, and let us exalt His name together.', 'Binecuvânta-voi pe Domnul în toată vremea, pururea lauda Lui în gura mea. În Domnul se va lăuda sufletul meu; să audă cei blânzi și să se veselească. Slăviți pe Domnul împreună cu mine și să înălțăm numele Lui împreună.', NULL, 0, NULL);

-- Final Blessing
INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 3520, 'rubric', NULL, NULL, 'final-blessing', 1, 'The Final Blessing'),
    ('lit', 3530, 'priest', 'The blessing of the Lord be upon you through His grace and love for mankind, always, now and forever and to the ages of ages.', 'Binecuvântarea Domnului să fie peste voi, cu al Său har și cu a Sa iubire de oameni, totdeauna, acum și pururea și în vecii vecilor.', NULL, 0, NULL),
    ('lit', 3540, 'choir', 'Amen.', 'Amin.', NULL, 0, NULL);

-- The Dismissal
INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 3550, 'rubric', NULL, NULL, 'dismissal', 1, 'The Dismissal'),
    ('lit', 3560, 'priest', 'Glory to Thee, O Christ our God, our hope, glory to Thee.', 'Slavă Ție, Hristoase Dumnezeul nostru, nădejdea noastră, slavă Ție.', NULL, 0, NULL),
    ('lit', 3570, 'choir', 'Glory to the Father and to the Son and to the Holy Spirit, both now and forever and to the ages of ages. Amen. Lord, have mercy. Lord, have mercy. Lord, have mercy. Father, bless.', 'Slavă Tatălui și Fiului și Sfântului Duh, și acum și pururea și în vecii vecilor. Amin. Doamne, miluiește. Doamne, miluiește. Doamne, miluiește. Părinte, binecuvântează.', NULL, 0, NULL),
    ('lit', 3580, 'priest', 'May He Who rose from the dead, Christ our true God, through the intercessions of His most pure Mother; of the holy, glorious, and all-laudable Apostles; of our father among the saints John Chrysostom, Archbishop of Constantinople; of the holy and righteous ancestors of God, Joachim and Anna; of the holy patron saints of this parish, the Venerable Brendan the Navigator of Clonfert, the Venerable Joseph the New of Partos, the holy Hierarch Patrick, Apostle of Ireland, and the Venerable Columba of Iona; and of all the saints: have mercy on us and save us, for He is good and the Lover of mankind.', 'Cel ce a înviat din morți, Hristos, Adevăratul Dumnezeul nostru, pentru rugăciunile Preacuratei Maicii Sale, ale Sfinților, slăviților și întru-tot-lăudaților Apostoli, ale celui între sfinți Părintelui nostru Ioan Gură de Aur, Arhiepiscopul Constantinopolului, ale Sfinților și drepților dumnezeiești Părinți Ioachim și Ana, ale sfinților ocrotitori ai acestei parohii, Cuviosul Brendan Călătorul din Clonfert, Cuviosul Iosif cel Nou de la Partoș, Sfântul Ierarh Patrick, Apostolul Irlandei, și Cuviosul Columba din Iona, și ale tuturor Sfinților, să ne miluiască și să ne mântuiască pe noi, ca un bun și de oameni iubitor.', NULL, 0, NULL),
    ('lit', 3590, 'choir', 'Amen.', 'Amin.', NULL, 0, NULL);

-- Many Years (Polychronion)
INSERT INTO liturgy_blocks (service_type, sort_order, role, text_en, text_ro, anchor, is_divider, div_label) VALUES
    ('lit', 3600, 'rubric', NULL, NULL, 'polychronion', 1, 'Polychronion'),
    ('lit', 3610, 'choir', 'To our great lord and father, Metropolitan Iosif, to our Bishop Nectarie, to the founders and benefactors of this holy church, and to all Orthodox Christians: grant, O Lord, many years!', 'Pe Înalt Prea Sfințitul Mitropolitul nostru Iosif, pe Prea Sfințitul Episcopul nostru Nectarie, pe ctitorii și binefăcătorii sfântului locașului acestuia și pe toți dreptmăritorii creștini, Doamne, îi păzește întru mulți ani!', NULL, 0, NULL),
    ('lit', 3620, 'choir', 'Many years! Many years! Many years!', 'Mulți ani! Mulți ani! Mulți ani!', NULL, 0, NULL);

-- ============================================================
-- NOTES: Score references
-- ============================================================

-- Insert notes for blocks that reference musical scores
-- Alleluia ×3 After Apostle (handwritten score)
INSERT INTO notes (block_id, note_type, note_text, link_url, link_label, sort_order)
    SELECT id, 'score', 'Handwritten score — Alleluia (×3) after the Apostle reading', NULL, NULL, 1
    FROM liturgy_blocks WHERE service_type = 'lit' AND anchor = 'alleluia-apostle' LIMIT 1;

-- Cherubic Hymn (handwritten score)
INSERT INTO notes (block_id, note_type, note_text, link_url, link_label, sort_order)
    SELECT id, 'score', 'Handwritten score — Cherubic Hymn (We who mystically represent the Cherubim)', NULL, NULL, 1
    FROM liturgy_blocks WHERE service_type = 'lit' AND anchor = 'cherubic-hymn' LIMIT 1;

-- Anaphora — hymn to the Theotokos (typeset score available)
INSERT INTO notes (block_id, note_type, note_text, link_url, link_label, sort_order)
    SELECT id, 'score', 'Typeset score available — It is truly right to bless Thee, O Theotokos (Axion Estin)', NULL, NULL, 1
    FROM liturgy_blocks WHERE service_type = 'lit' AND anchor = 'axion' LIMIT 1;

-- One is Holy (handwritten score)
INSERT INTO notes (block_id, note_type, note_text, link_url, link_label, sort_order)
    SELECT id, 'score', 'Handwritten score — One is Holy, One is Lord, Jesus Christ', NULL, NULL, 1
    FROM liturgy_blocks WHERE service_type = 'lit' AND anchor = 'holy-things' LIMIT 1;

-- Receive the Body of Christ (handwritten score)
INSERT INTO notes (block_id, note_type, note_text, link_url, link_label, sort_order)
    SELECT id, 'score', 'Handwritten score — Receive the Body of Christ, taste the Fountain of Immortality', NULL, NULL, 1
    FROM liturgy_blocks WHERE service_type = 'lit' AND anchor = 'communion-hymn' LIMIT 1;

-- Let our mouths be filled (handwritten score)
INSERT INTO notes (block_id, note_type, note_text, link_url, link_label, sort_order)
    SELECT id, 'score', 'Handwritten score — Let our mouths be filled with Thy praise, O Lord', NULL, NULL, 1
    FROM liturgy_blocks WHERE service_type = 'lit' AND sort_order = 3360 LIMIT 1;

-- We have seen the true light (typeset score available)
INSERT INTO notes (block_id, note_type, note_text, link_url, link_label, sort_order)
    SELECT id, 'score', 'Typeset score available — We have seen the true light', NULL, NULL, 1
    FROM liturgy_blocks WHERE service_type = 'lit' AND anchor = 'true-light' LIMIT 1;

-- Praised be the name of the Lord (typeset score available)
INSERT INTO notes (block_id, note_type, note_text, link_url, link_label, sort_order)
    SELECT id, 'score', 'Typeset score available — Praised be the name of the Lord', NULL, NULL, 1
    FROM liturgy_blocks WHERE service_type = 'lit' AND anchor = 'praised-be' LIMIT 1;

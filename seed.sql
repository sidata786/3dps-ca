-- ═══════════════════════════════════════════════════════════════
-- 3DPS.ca  —  Realistic Marketplace Seed Data
-- Run in: Supabase → SQL Editor → New Query → Run
--
-- Creates 7 seller shops across Canada + 35 listings + 60 reviews
-- Images: Unsplash CDN (loads in browser; SVG fallback in browse.html
--         handles any broken URLs gracefully)
-- ═══════════════════════════════════════════════════════════════

-- ─────────────────────────────────────────
-- 0. CLEAN SLATE  (safe to re-run)
-- ─────────────────────────────────────────
TRUNCATE reviews   RESTART IDENTITY CASCADE;
TRUNCATE messages  RESTART IDENTITY CASCADE;
TRUNCATE listings  RESTART IDENTITY CASCADE;
DELETE FROM sellers;
DELETE FROM users;

-- ─────────────────────────────────────────
-- 1. USERS  (demo accounts — password not valid for login)
-- ─────────────────────────────────────────
INSERT INTO users (id, email, password_hash, first_name, last_name, city, province) VALUES

  ('a1000000-0000-0000-0000-000000000001', 'liam@torontomakelab.ca',
   '$2a$10$DemoHashSeedUserOneXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX',
   'Liam', 'Okafor', 'Toronto', 'ON'),

  ('a1000000-0000-0000-0000-000000000002', 'maya@vancouverprint3d.ca',
   '$2a$10$DemoHashSeedUserTwoXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX',
   'Maya', 'Chen', 'Vancouver', 'BC'),

  ('a1000000-0000-0000-0000-000000000003', 'ethan@calgarycreations3d.ca',
   '$2a$10$DemoHashSeedUserThreeXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX',
   'Ethan', 'Bergstrom', 'Calgary', 'AB'),

  ('a1000000-0000-0000-0000-000000000004', 'sophie@montrealfab.ca',
   '$2a$10$DemoHashSeedUserFourXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX',
   'Sophie', 'Tremblay', 'Montreal', 'QC'),

  ('a1000000-0000-0000-0000-000000000005', 'dev@ottawamakers.ca',
   '$2a$10$DemoHashSeedUserFiveXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX',
   'Dev', 'Patel', 'Ottawa', 'ON'),

  ('a1000000-0000-0000-0000-000000000006', 'krista@edmontonmini3d.ca',
   '$2a$10$DemoHashSeedUserSixXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX',
   'Krista', 'Lavoie', 'Edmonton', 'AB'),

  ('a1000000-0000-0000-0000-000000000007', 'finn@halifaxprintshop.ca',
   '$2a$10$DemoHashSeedUserSevenXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX',
   'Finn', 'MacLeod', 'Halifax', 'NS');

-- ─────────────────────────────────────────
-- 2. SELLERS
-- ─────────────────────────────────────────
INSERT INTO sellers
  (id, user_id, shop_name, tagline, about, city, province,
   printers, fulfil_option, payout_method,
   avg_rating, total_reviews, total_sales, is_verified, is_active)
VALUES

  -- ── Seller 1 ── TorontoMakeLab  (functional / tech)
  ('b1000000-0000-0000-0000-000000000001',
   'a1000000-0000-0000-0000-000000000001',
   'TorontoMakeLab',
   'Precision FDM parts made in Toronto''s Junction neighbourhood',
   'Hey! I''m Liam — engineer-turned-maker with 6 Bambu X1C printers running 24/7. '
   'I specialise in functional, dimensional-accuracy parts: Gridfinity storage, cable '
   'management, desk organisers, and custom engineering brackets. Every print is '
   'quality-checked before it ships. Fast local pickup at Bloor & Dundas, or shipping '
   'across Canada via Canada Post Expedited.',
   'Toronto', 'ON',
   '[{"brand":"Bambu Lab","model":"X1C","count":4},{"brand":"Prusa","model":"MK4","count":2}]',
   'both', 'etransfer',
   4.8, 47, 156, true, true),

  -- ── Seller 2 ── VancouverPrint3D  (miniatures / gaming)
  ('b1000000-0000-0000-0000-000000000002',
   'a1000000-0000-0000-0000-000000000002',
   'VancouverPrint3D',
   'Tabletop miniatures & terrain — resin-cast on the west coast',
   'Tabletop RPG player since 2012. I moved from buying minis to printing them '
   'when I discovered resin printing, and now I can''t stop. My Elegoo Saturn 4 Ultra '
   'produces crisp 8K-resolution detail on 32mm heroes, monsters, and dungeon terrain. '
   'All prints washed & cured, pre-primed grey on request. Ships Canada-wide in '
   'padded, crush-proof packaging. DM me for custom sculpts.',
   'Vancouver', 'BC',
   '[{"brand":"Elegoo","model":"Saturn 4 Ultra","count":2},{"brand":"Phrozen","model":"Sonic Mega 8K","count":1}]',
   'both', 'etransfer',
   4.7, 38, 89, true, true),

  -- ── Seller 3 ── CalgaryCreations3D  (home décor / art)
  ('b1000000-0000-0000-0000-000000000003',
   'a1000000-0000-0000-0000-000000000003',
   'CalgaryCreations3D',
   'Statement home décor printed in Cowtown — parametric & one-of-a-kind',
   'Interior design student who discovered 3D printing and never looked back. '
   'I design all my own models in Fusion 360 — no downloaded files. Every piece '
   'is unique: parametric vases, lamp shades, wall panels, and planters designed '
   'to order. I use premium PLA+ in matte, silk, and marble finishes. Available '
   'for custom colour/size on most items. Pickup in Kensington or ship anywhere.',
   'Calgary', 'AB',
   '[{"brand":"Bambu Lab","model":"P1S","count":3},{"brand":"Creality","model":"K1 Max","count":1}]',
   'both', 'etransfer',
   4.9, 61, 203, true, true),

  -- ── Seller 4 ── MontrealFab  (technical / engineering)
  ('b1000000-0000-0000-0000-000000000004',
   'a1000000-0000-0000-0000-000000000004',
   'MontrealFab',
   'Prototypes & engineering parts — PETG/ABS/Nylon, same-day print',
   'Mechanical engineer, Polytechnique Montréal grad. I run MontrealFab as a side '
   'studio focusing on functional engineering-grade prints: brackets, mounts, jigs, '
   'camera rigs, and maker hardware. PETG, ABS, ASA, and Nylon PA12 on request. '
   'Tight tolerances, accurate dimensions, thread inserts installed. Bilingual service '
   '(FR/EN). Local pickup in Rosemont or Canada-wide shipping.',
   'Montreal', 'QC',
   '[{"brand":"Bambu Lab","model":"X1C","count":2},{"brand":"Voron","model":"2.4 350mm","count":1}]',
   'both', 'etransfer',
   4.7, 29, 127, true, true),

  -- ── Seller 5 ── OttawaMakers  (tech accessories / desk setup)
  ('b1000000-0000-0000-0000-000000000005',
   'a1000000-0000-0000-0000-000000000005',
   'OttawaMakers',
   'Desk-setup accessories & tech mounts — practical prints for remote workers',
   'Remote software developer obsessed with the perfect desk setup. I print everything '
   'I wish existed: wrist rests, monitor mounts, StreamDeck stands, cable spines, hub '
   'organisers. If you''ve seen it on a battlestation subreddit and wished you could buy '
   'a Canadian version — I probably make it. Designs are rigid, smooth-sanded, and '
   'finished with a matte topcoat on request. Ships from Ottawa in 3–5 days.',
   'Ottawa', 'ON',
   '[{"brand":"Bambu Lab","model":"A1 Mini","count":2},{"brand":"Prusa","model":"MK4S","count":1}]',
   'shipping', 'etransfer',
   4.5, 22, 67, false, true),

  -- ── Seller 6 ── EdmontonMini3D  (toys & kids)
  ('b1000000-0000-0000-0000-000000000006',
   'a1000000-0000-0000-0000-000000000006',
   'EdmontonMini3D',
   'Articulated toys & games for kids — colourful PLA, washable & safe',
   'Mom of three + maker. I started printing fidget toys for my kids during the '
   'pandemic and now I have a whole shop! All prints use non-toxic PLA, no sharp edges, '
   'no small parts on items tagged 3+. Specialities: articulated dinosaurs, marble runs, '
   'chess sets, pull-back cars, and custom name puzzles. Gift wrapping available. '
   'Local pickup in Glenora or shipping across Canada.',
   'Edmonton', 'AB',
   '[{"brand":"Bambu Lab","model":"A1","count":3},{"brand":"Creality","model":"Ender 3 V3","count":2}]',
   'both', 'etransfer',
   4.8, 53, 94, true, true),

  -- ── Seller 7 ── HalifaxPrintShop  (jewellery & cosplay)
  ('b1000000-0000-0000-0000-000000000007',
   'a1000000-0000-0000-0000-000000000007',
   'HalifaxPrintShop',
   'Wearable art from the Atlantic — resin jewellery & cosplay props',
   'Fine-arts grad turned resin printer enthusiast on the east coast. I make jewellery '
   'and wearable art using high-res SLA printing and hand-finishing. Rings, pendants, '
   'and earrings in geometric and botanical styles. Also cosplay props: helmets, '
   'gauntlets, ear tips — everything sanded, primed, and painted. Custom sizing '
   'available for all jewellery. Pickup in downtown Halifax or ship Canada-wide.',
   'Halifax', 'NS',
   '[{"brand":"Formlabs","model":"Form 3+","count":1},{"brand":"Elegoo","model":"Mars 4 Ultra","count":2}]',
   'both', 'etransfer',
   4.6, 31, 45, true, true);

-- ─────────────────────────────────────────
-- 3. LISTINGS
-- Images: Unsplash CDN — loads in browser even if Claude's
--         server-side requests are blocked. SVG fallback handles
--         any 404s transparently.
-- ─────────────────────────────────────────
INSERT INTO listings
  (seller_id, title, description, category, city, province,
   price, compare_price, material, printer_type,
   pickup_available, custom_orders, lead_time_days,
   tags, image_urls, featured_image_url,
   avg_rating, total_reviews, is_new, is_on_sale, is_active)
VALUES

-- ════════════════════════════════════════
-- SELLER 1 — TorontoMakeLab
-- ════════════════════════════════════════

  -- Listing 1
  ('b1000000-0000-0000-0000-000000000001',
   'Gridfinity Storage Bin 4×2 (Stackable)',
   'The classic Gridfinity 4×2 bin — compatible with all standard Gridfinity baseplates. '
   'Printed in PLA+ with 4 perimeters and 20% infill for rigidity. Interior is smooth for '
   'easy cleaning. Great for screws, resistors, SD cards, or any small workshop item. '
   'Custom sizes available — DM with your grid dimensions. Fits all standard Gridfinity '
   'base plates sold separately or available as an add-on.',
   'functional', 'Toronto', 'ON',
   14.00, NULL, 'PLA+', 'FDM',
   true, true, 2,
   ARRAY['gridfinity','storage','organizer','workshop','desk'],
   ARRAY['https://images.unsplash.com/photo-1581092160562-40aa08e26b06?auto=format&fit=crop&w=800&q=80'],
   'https://images.unsplash.com/photo-1581092160562-40aa08e26b06?auto=format&fit=crop&w=800&q=80',
   4.9, 18, false, false, true),

  -- Listing 2
  ('b1000000-0000-0000-0000-000000000001',
   'Under-Desk Cable Management Tray',
   'Mounts under your desk with included M4 hardware or 3M VHB tape (included). '
   'Holds power bars, USB hubs, and routing channels for up to 8 cables. Two piece '
   'design: main tray + snap-on lid. 400mm wide × 120mm deep. Printed in PETG for '
   'rigidity — won''t sag under weight. Available in black, white, or grey. '
   'Installation takes under 10 minutes.',
   'functional', 'Toronto', 'ON',
   28.00, NULL, 'PETG', 'FDM',
   true, true, 3,
   ARRAY['cable','management','desk','organizer','battlestation'],
   ARRAY['https://images.unsplash.com/photo-1518770988-a55d6d0371ad?auto=format&fit=crop&w=800&q=80'],
   'https://images.unsplash.com/photo-1518770988-a55d6d0371ad?auto=format&fit=crop&w=800&q=80',
   4.7, 11, false, false, true),

  -- Listing 3
  ('b1000000-0000-0000-0000-000000000001',
   'Adjustable Phone Stand with Cable Channel',
   'Tilts from 45° to 90° with a friction-fit hinge that holds any angle. Built-in '
   'cable channel routes your charging cable cleanly from the back. Compatible with '
   'phones up to 90mm wide — fits any iPhone or Android with or without a thin case. '
   'Printed in PLA+ with brass heat-set inserts for durable adjustments. '
   'Available in 8 colour options.',
   'functional', 'Toronto', 'ON',
   19.00, NULL, 'PLA+', 'FDM',
   true, false, 2,
   ARRAY['phone','stand','desk','cable','organizer'],
   ARRAY['https://images.unsplash.com/photo-1563089145-9f9d57b0c9ab?auto=format&fit=crop&w=800&q=80'],
   'https://images.unsplash.com/photo-1563089145-9f9d57b0c9ab?auto=format&fit=crop&w=800&q=80',
   4.8, 9, false, false, true),

  -- Listing 4
  ('b1000000-0000-0000-0000-000000000001',
   'Raspberry Pi 5 Case with Active Cooling',
   'Vented case for Raspberry Pi 5 with a top-mounted 30mm fan duct. Snap-fit lid '
   'for tool-free access. GPIO ribbon-cable notch and all ports fully exposed. '
   'Two versions: standard and HAT-compatible tall edition. Printed in PETG for '
   'thermal stability. Raspberry Pi 5 board and fan not included. '
   'Custom cutouts for add-on boards available — message with your HAT model.',
   'tech', 'Toronto', 'ON',
   24.00, NULL, 'PETG', 'FDM',
   true, true, 2,
   ARRAY['raspberry pi','pi5','case','enclosure','sbc','tech'],
   ARRAY['https://images.unsplash.com/photo-1603302576837-37561b2e2302?auto=format&fit=crop&w=800&q=80'],
   'https://images.unsplash.com/photo-1603302576837-37561b2e2302?auto=format&fit=crop&w=800&q=80',
   4.6, 7, false, false, true),

  -- Listing 5
  ('b1000000-0000-0000-0000-000000000001',
   'Wall-Mounted Bike Hook Set (Pair)',
   'Horizontal wall hooks for storing one or two bikes. Rubber-padded contact points '
   'won''t scratch your frame. Each hook rated to 25 kg. Includes drywall anchors and '
   '40mm wood screws. Printed in ABS for stiffness — zero flex under load. '
   'Available in horizontal (handlebar) or vertical (wheel) orientation. '
   'Choose black or grey. Ships flat in a padded envelope.',
   'functional', 'Toronto', 'ON',
   32.00, NULL, 'ABS', 'FDM',
   true, false, 3,
   ARRAY['bike','wall mount','hook','garage','storage'],
   ARRAY['https://images.unsplash.com/photo-1571068316344-75bc76f77890?auto=format&fit=crop&w=800&q=80'],
   'https://images.unsplash.com/photo-1571068316344-75bc76f77890?auto=format&fit=crop&w=800&q=80',
   4.5, 4, false, false, true),

-- ════════════════════════════════════════
-- SELLER 2 — VancouverPrint3D
-- ════════════════════════════════════════

  -- Listing 6
  ('b1000000-0000-0000-0000-000000000002',
   'D&D Dungeon Terrain Starter Pack (12 Tiles)',
   '12 modular dungeon floor tiles — 4 straight corridors, 4 corner pieces, 2 T-junctions, '
   '2 open rooms. Interlocking clips keep tiles locked during play. Compatible with all '
   '28mm miniatures. Printed at 8K on Elegoo Saturn — crisply detailed stone texture, '
   'no layer lines visible. Shipped in a padded box. Expansion packs (doors, stairs, '
   'pillars) available separately.',
   'miniatures', 'Vancouver', 'BC',
   49.00, NULL, 'Resin', 'MSLA',
   false, true, 5,
   ARRAY['dnd','terrain','dungeon','tabletop','rpg','tiles'],
   ARRAY['https://images.unsplash.com/photo-1559561853-08451507a45b?auto=format&fit=crop&w=800&q=80'],
   'https://images.unsplash.com/photo-1559561853-08451507a45b?auto=format&fit=crop&w=800&q=80',
   4.8, 15, false, false, true),

  -- Listing 7
  ('b1000000-0000-0000-0000-000000000002',
   'Fantasy Fighter Hero Miniature — 32mm',
   'Highly detailed 32mm fighter miniature — plate armour, two-handed sword, flowing '
   'cloak. Pre-supported STL printed at 8K resolution, washed, cured, and lightly '
   'sanded. Supplied unprimed (natural resin) or grey-primed ready to paint. '
   'Custom poses and weapon swaps available — DM with your character concept. '
   'Lead time 5–7 days for custom orders.',
   'miniatures', 'Vancouver', 'BC',
   9.00, NULL, 'Resin', 'MSLA',
   false, true, 4,
   ARRAY['dnd','miniature','fantasy','fighter','32mm','hero'],
   ARRAY['https://images.unsplash.com/photo-1578662996442-48f60103fc96?auto=format&fit=crop&w=800&q=80'],
   'https://images.unsplash.com/photo-1578662996442-48f60103fc96?auto=format&fit=crop&w=800&q=80',
   4.7, 22, false, false, true),

  -- Listing 8
  ('b1000000-0000-0000-0000-000000000002',
   'Dungeon Scatter: Barrels, Crates & Chests (18 pcs)',
   '18-piece scatter terrain set: 6 wooden barrels, 6 wooden crates, 4 open chests, '
   '2 locked chests with padlock detail. Adds instant life to any dungeon scene. '
   'Printed in grey resin at 8K — grain and plank texture is crisp and paintable. '
   'Works with any 28/32mm scale system. Wash & cure complete, ready to prime. '
   'Available as a painted set (+$18) in brown-oak or stone finishes.',
   'miniatures', 'Vancouver', 'BC',
   26.00, NULL, 'Resin', 'MSLA',
   false, false, 4,
   ARRAY['dnd','terrain','scatter','dungeon','barrels','crates'],
   ARRAY['https://images.unsplash.com/photo-1506792006827-cd761f0905ab?auto=format&fit=crop&w=800&q=80'],
   'https://images.unsplash.com/photo-1506792006827-cd761f0905ab?auto=format&fit=crop&w=800&q=80',
   4.9, 8, false, false, true),

  -- Listing 9
  ('b1000000-0000-0000-0000-000000000002',
   'Ancient Dragon Miniature — 75mm Scale',
   'Imposing ancient dragon in a rearing pose — 75mm tall at the head, 140mm wingspan. '
   '7-part assembly (body, wings ×2, front legs ×2, rear legs ×2) with alignment pins. '
   'Printed at 8K resin for razor-sharp scale and claw detail. Magnetised wing-body '
   'joint for easy transport. Comes with a 100mm round base. '
   'Note: assembly required; instructions PDF included.',
   'miniatures', 'Vancouver', 'BC',
   38.00, NULL, 'Resin', 'MSLA',
   false, true, 7,
   ARRAY['dnd','dragon','miniature','75mm','boss','display'],
   ARRAY['https://images.unsplash.com/photo-1518770988-a55d6d0371ad?auto=format&fit=crop&w=800&q=80'],
   'https://images.unsplash.com/photo-1518770988-a55d6d0371ad?auto=format&fit=crop&w=800&q=80',
   4.6, 5, true, false, true),

-- ════════════════════════════════════════
-- SELLER 3 — CalgaryCreations3D
-- ════════════════════════════════════════

  -- Listing 10
  ('b1000000-0000-0000-0000-000000000003',
   'Geometric Pendant Lamp Shade — Icosahedron',
   'Statement icosahedron pendant shade — 30cm diameter. Fitted to E26/E27 pendant '
   'socket (cord & bulb not included). Each triangular face prints separately and '
   'snap-fits together — no glue needed. Available in white, black, terracotta, '
   'or sage green matte PLA. Use with LED bulbs only (max 8W). '
   'Custom sizes (25cm and 35cm) available.',
   'decor', 'Calgary', 'AB',
   52.00, NULL, 'PLA+', 'FDM',
   true, true, 5,
   ARRAY['lamp','shade','pendant','geometric','home decor','light'],
   ARRAY['https://images.unsplash.com/photo-1567538096630-e0c55bd6374c?auto=format&fit=crop&w=800&q=80'],
   'https://images.unsplash.com/photo-1567538096630-e0c55bd6374c?auto=format&fit=crop&w=800&q=80',
   5.0, 12, false, false, true),

  -- Listing 11
  ('b1000000-0000-0000-0000-000000000003',
   'Parametric Lattice Vase — 25cm Tall',
   'Watertight parametric vase with a woven lattice wall pattern that lets light play '
   'through beautifully. 25cm tall, 12cm diameter at widest point. Available in '
   'silk PLA (gold, rose gold, copper, silver), matte PLA (white, black, sage), '
   'or marble-fill. Each vase takes ~18 hours to print — one-of-a-kind layering. '
   'Custom height/width available. Perfect with dried flowers or as a standalone piece.',
   'decor', 'Calgary', 'AB',
   36.00, NULL, 'Silk PLA', 'FDM',
   true, true, 4,
   ARRAY['vase','parametric','lattice','home decor','flowers','decor'],
   ARRAY['https://images.unsplash.com/photo-1490535856965-b1d2c5ac7e0a?auto=format&fit=crop&w=800&q=80'],
   'https://images.unsplash.com/photo-1490535856965-b1d2c5ac7e0a?auto=format&fit=crop&w=800&q=80',
   4.9, 19, false, false, true),

  -- Listing 12
  ('b1000000-0000-0000-0000-000000000003',
   'Honeycomb Wall Panel Set — 4 Pieces',
   'Four interlocking honeycomb panels that tile seamlessly across a wall. Each panel '
   '30cm × 26cm, 4mm deep relief pattern. Keyhole mounts on the back — hang with '
   'standard picture hooks. Available in white, charcoal, blush pink, or sage green. '
   'The set covers roughly 60cm × 52cm. Add-on panels sold individually at $14 each. '
   'Designed to fit flush — no gaps when tiled correctly.',
   'decor', 'Calgary', 'AB',
   58.00, 68.00, 'PLA+', 'FDM',
   true, true, 5,
   ARRAY['wall art','honeycomb','panel','home decor','modern'],
   ARRAY['https://images.unsplash.com/photo-1555041469-a586c61ea9bc?auto=format&fit=crop&w=800&q=80'],
   'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?auto=format&fit=crop&w=800&q=80',
   4.8, 14, false, true, true),

  -- Listing 13
  ('b1000000-0000-0000-0000-000000000003',
   'Self-Watering Succulent Planter with Drainage Tray',
   'Two-part planter with integrated wicking membrane and a drip tray that holds '
   '48 hours of reserve water. 12cm diameter top opening — fits standard 10cm '
   'nursery pots. Available in 6 colours: terracotta, sage, slate, cream, blush, '
   'or midnight. Dishwasher safe (top rack). Great as a gift — arrives with a '
   'hand-written planting card.',
   'decor', 'Calgary', 'AB',
   22.00, NULL, 'PLA+', 'FDM',
   true, true, 3,
   ARRAY['planter','succulent','pot','self-watering','home decor'],
   ARRAY['https://images.unsplash.com/photo-1485955900006-10f4d324d411?auto=format&fit=crop&w=800&q=80'],
   'https://images.unsplash.com/photo-1485955900006-10f4d324d411?auto=format&fit=crop&w=800&q=80',
   4.9, 27, false, false, true),

  -- Listing 14
  ('b1000000-0000-0000-0000-000000000003',
   'Parametric Bookend Pair — Arch Design',
   'Minimalist arch bookends — weighted base (ballast bag of sand included inside), '
   'felt pad on bottom to protect shelves. Each bookend 18cm tall × 12cm wide. '
   'Interlocking arch in two pieces for a clean seam. Available in matte white, '
   'black, terracotta, or custom colour. Holds books up to 4kg total. '
   'Makes a great housewarming gift.',
   'decor', 'Calgary', 'AB',
   38.00, NULL, 'PLA+', 'FDM',
   true, false, 3,
   ARRAY['bookend','arch','shelf','home decor','gift'],
   ARRAY['https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=800&q=80'],
   'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=800&q=80',
   4.7, 8, false, false, true),

-- ════════════════════════════════════════
-- SELLER 4 — MontrealFab
-- ════════════════════════════════════════

  -- Listing 15
  ('b1000000-0000-0000-0000-000000000004',
   'NEMA 17 Stepper Motor Mount — Adjustable Tension',
   'Precision NEMA 17 bracket with ±5mm belt-tension adjustment slot. '
   'Works as an X/Y axis motor mount on most CoreXY and Cartesian printers. '
   'M3 brass heat-set inserts pre-installed for durability. Printed in PETG. '
   'Hole spacing accurate to ±0.05mm. Available as single or mirrored pair. '
   'Compatible with 40mm, 42mm, and 48mm NEMA 17 motors.',
   'functional', 'Montreal', 'QC',
   13.00, NULL, 'PETG', 'FDM',
   true, true, 2,
   ARRAY['nema17','motor mount','3d printer','maker','cnc','stepper'],
   ARRAY['https://images.unsplash.com/photo-1608178398319-48f814d0750c?auto=format&fit=crop&w=800&q=80'],
   'https://images.unsplash.com/photo-1608178398319-48f814d0750c?auto=format&fit=crop&w=800&q=80',
   4.8, 6, false, false, true),

  -- Listing 16
  ('b1000000-0000-0000-0000-000000000004',
   'GoPro Action Camera Chest Mount Adapter',
   'Rigid chest mount base compatible with GoPro 7/8/9/10/11/12 and any standard '
   '1/4-20 action cam. Fits standard webbing harnesses (not included). '
   'Tilt 0°–45° with locking knob. Printed in ABS — doesn''t flex under vibration. '
   'M5 brass inserts on all adjustment points. Much more rigid than stock plastic '
   'GoPro mounts at a fraction of the cost.',
   'functional', 'Montreal', 'QC',
   17.00, NULL, 'ABS', 'FDM',
   true, false, 2,
   ARRAY['gopro','camera mount','chest mount','action camera','outdoor'],
   ARRAY['https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?auto=format&fit=crop&w=800&q=80'],
   'https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?auto=format&fit=crop&w=800&q=80',
   4.6, 9, false, false, true),

  -- Listing 17
  ('b1000000-0000-0000-0000-000000000004',
   'Metric Thread-Insert Belt Clip (M5)',
   'Heavy-duty belt/waistband clip with M5 brass insert. Rated 3kg pull. '
   'Ideal for tool pouches, holsters, or belt-mounted accessories. '
   'Spring-clip version also available. Printed in PETG with 5 perimeters '
   'and 40% infill. Two-part design: clip body + mount plate with 4mm separation. '
   'Ships as pair. Custom widths (25mm–50mm) available.',
   'functional', 'Montreal', 'QC',
   11.00, NULL, 'PETG', 'FDM',
   true, true, 2,
   ARRAY['belt clip','mount','everyday carry','edc','maker'],
   ARRAY['https://images.unsplash.com/photo-1581092451-8b77e6a2e4b7?auto=format&fit=crop&w=800&q=80'],
   'https://images.unsplash.com/photo-1581092451-8b77e6a2e4b7?auto=format&fit=crop&w=800&q=80',
   4.5, 4, false, false, true),

  -- Listing 18
  ('b1000000-0000-0000-0000-000000000004',
   'Parametric Hinge Set — 5 Sizes',
   'Living-hinge and barrel-hinge variants in 5 sizes: 20mm, 30mm, 40mm, 60mm, 80mm. '
   'Great for enclosure lids, project boxes, and small doors. Barrel hinges use '
   'a 3mm brass rod (included). Printed in PETG with 0.1mm layer height at the '
   'hinge point for flex durability. Design file notes included for custom sizing. '
   'Priced for the full set of 10 pieces (2 of each size).',
   'functional', 'Montreal', 'QC',
   21.00, NULL, 'PETG', 'FDM',
   true, true, 3,
   ARRAY['hinge','hardware','enclosure','maker','parametric'],
   ARRAY['https://images.unsplash.com/photo-1563089145-9f9d57b0c9ab?auto=format&fit=crop&w=800&q=80'],
   'https://images.unsplash.com/photo-1563089145-9f9d57b0c9ab?auto=format&fit=crop&w=800&q=80',
   4.7, 3, true, false, true),

-- ════════════════════════════════════════
-- SELLER 5 — OttawaMakers
-- ════════════════════════════════════════

  -- Listing 19
  ('b1000000-0000-0000-0000-000000000005',
   'Mechanical Keyboard Wrist Rest — 60%/65% Size',
   'Ergonomic wrist rest sized for 60% and 65% keyboards (280mm wide). Top surface '
   'is TPU — soft, grippy, and easy to wipe clean. Bottom is rigid PLA with rubber '
   'feet. Wrist pad height: 12mm. Available in 4 colour combos: black/black, '
   'white/grey, green/black, pink/white. Fits most tenkeyless keyboards with '
   'the 75% adapter insert (included).',
   'tech', 'Ottawa', 'ON',
   39.00, NULL, 'TPU+PLA', 'FDM',
   false, true, 4,
   ARRAY['keyboard','wrist rest','ergonomic','mechanical keyboard','desk'],
   ARRAY['https://images.unsplash.com/photo-1587829741301-dc798b83add3?auto=format&fit=crop&w=800&q=80'],
   'https://images.unsplash.com/photo-1587829741301-dc798b83add3?auto=format&fit=crop&w=800&q=80',
   4.7, 13, false, false, true),

  -- Listing 20
  ('b1000000-0000-0000-0000-000000000005',
   'Elgato Stream Deck Monitor Mount Arm',
   'Clamps to any monitor arm (VESA or proprietary) and holds a Stream Deck MK.2 '
   'or Stream Deck + at the perfect angle. Fully adjustable tilt (0°–60°). '
   'Cable management channel keeps the USB-C cable tidy. Printed in PETG. '
   'Fits all existing Stream Deck models — XL, MK.2, Mini, and + editions. '
   'Installs in under 5 minutes.',
   'tech', 'Ottawa', 'ON',
   26.00, NULL, 'PETG', 'FDM',
   false, true, 3,
   ARRAY['stream deck','elgato','mount','desk','battlestation','streaming'],
   ARRAY['https://images.unsplash.com/photo-1547082299-de196ea013d6?auto=format&fit=crop&w=800&q=80'],
   'https://images.unsplash.com/photo-1547082299-de196ea013d6?auto=format&fit=crop&w=800&q=80',
   4.5, 7, false, false, true),

  -- Listing 21
  ('b1000000-0000-0000-0000-000000000005',
   'Desk Cable Spine — Modular 30cm Sections',
   'Snap-together cable spine hides monitor, PC, and peripheral cables behind your '
   'desk. Each 30cm section holds 6–8 cables. Sections click together to any length. '
   'Mounts to desk edge or runs along a monitor stand leg. Removable lid for easy '
   'cable access. Printed in matte black PLA. '
   'Listing is for one 30cm section — order multiples for longer runs.',
   'tech', 'Ottawa', 'ON',
   14.00, NULL, 'PLA', 'FDM',
   false, false, 3,
   ARRAY['cable management','spine','desk','organizer','clean setup'],
   ARRAY['https://images.unsplash.com/photo-1518770988-a55d6d0371ad?auto=format&fit=crop&w=800&q=80'],
   'https://images.unsplash.com/photo-1518770988-a55d6d0371ad?auto=format&fit=crop&w=800&q=80',
   4.4, 5, false, false, true),

  -- Listing 22
  ('b1000000-0000-0000-0000-000000000005',
   'USB Hub Desk Organiser — 4-Port',
   'Sits on your desk or mounts under the monitor. Top tray holds a USB-A hub, '
   'dongle, or small SSD. Cable exits cleanly from the back. Fits all USB hubs '
   'up to 85mm × 45mm × 20mm (fits Anker, Belkin, HooToo, Ugreen). '
   'Available in black or white matte PLA. The hub slides in and out without '
   'tools — handy for laptop users who dock/undock regularly.',
   'tech', 'Ottawa', 'ON',
   21.00, NULL, 'PLA', 'FDM',
   false, true, 2,
   ARRAY['usb hub','desk organizer','cable management','tech','docking'],
   ARRAY['https://images.unsplash.com/photo-1603302576837-37561b2e2302?auto=format&fit=crop&w=800&q=80'],
   'https://images.unsplash.com/photo-1603302576837-37561b2e2302?auto=format&fit=crop&w=800&q=80',
   4.3, 3, true, false, true),

-- ════════════════════════════════════════
-- SELLER 6 — EdmontonMini3D
-- ════════════════════════════════════════

  -- Listing 23
  ('b1000000-0000-0000-0000-000000000006',
   'Flexi Rex — Fully Articulated Dinosaur',
   'The beloved Flexi Rex — a T-Rex that wiggles and flexes in your hand! '
   'Printed in-place: no assembly, no glue. Joints flex immediately off the plate. '
   'Available in 4 sizes (15cm, 20cm, 25cm, 30cm) and 10 colours including glow-in-the-dark. '
   'All PLA — safe, non-toxic, no sharp edges. Perfect for kids 3+ or as a desk toy. '
   'Pair it with the Flexi Raptor (sold separately).',
   'toys', 'Edmonton', 'AB',
   19.00, NULL, 'PLA', 'FDM',
   true, true, 2,
   ARRAY['dinosaur','flexi','articulated','kids','toy','t-rex'],
   ARRAY['https://images.unsplash.com/photo-1558618666-fcd25c85cd64?auto=format&fit=crop&w=800&q=80'],
   'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?auto=format&fit=crop&w=800&q=80',
   4.9, 31, false, false, true),

  -- Listing 24
  ('b1000000-0000-0000-0000-000000000006',
   'Marble Run Set — Starter Pack (52 Pieces)',
   '52-piece modular marble run: straight sections, curves, splits, funnels, '
   'and loop-the-loop. Compatible with standard 16mm marbles (6 included). '
   'Colour-coded by type — easy to sort and build. Comes in a custom storage '
   'box (also printed). Endless configurations — pieces stack vertically with '
   'a locking T-slot joint. Ages 5 and up. Safe, non-toxic PLA.',
   'toys', 'Edmonton', 'AB',
   49.00, NULL, 'PLA', 'FDM',
   true, false, 6,
   ARRAY['marble run','kids','toy','puzzle','game','stem'],
   ARRAY['https://images.unsplash.com/photo-1506792006827-cd761f0905ab?auto=format&fit=crop&w=800&q=80'],
   'https://images.unsplash.com/photo-1506792006827-cd761f0905ab?auto=format&fit=crop&w=800&q=80',
   4.9, 17, false, false, true),

  -- Listing 25
  ('b1000000-0000-0000-0000-000000000006',
   'Fidget Cube — 6-Sided Sensory Toy',
   'Six-sided fidget cube — each face has a different tactile feature: click button, '
   'toggle switch, spin dial, glide pad, rubber nubs, and joystick. Ball bearings '
   'in the dial for satisfying spin. Printed in two-colour PLA with TPU inserts on '
   'the soft-touch faces. 40mm × 40mm × 40mm. Ages 6 and up. '
   'Available in 8 colour combos.',
   'toys', 'Edmonton', 'AB',
   14.00, NULL, 'PLA+TPU', 'FDM',
   true, false, 2,
   ARRAY['fidget','cube','sensory','toy','adhd','kids'],
   ARRAY['https://images.unsplash.com/photo-1519821172-4a1e60c12ab3?auto=format&fit=crop&w=800&q=80'],
   'https://images.unsplash.com/photo-1519821172-4a1e60c12ab3?auto=format&fit=crop&w=800&q=80',
   4.8, 21, false, false, true),

  -- Listing 26
  ('b1000000-0000-0000-0000-000000000006',
   'Mini Chess Set with Magnetic Storage Box',
   'Full 32-piece chess set on a 20cm magnetic board. Chess pieces have magnetic '
   'bases — won''t shift during travel. The board folds in half and the pieces '
   'store inside. Pieces are 18–32mm tall. Available in classic black/white or '
   'custom dual-colour combos. Great for travel, camping, or a minimalist '
   'desk chess game. Ages 7 and up.',
   'toys', 'Edmonton', 'AB',
   42.00, NULL, 'PLA', 'FDM',
   true, true, 5,
   ARRAY['chess','board game','travel','magnetic','gift','kids'],
   ARRAY['https://images.unsplash.com/photo-1529699211952-734e80c4d42b?auto=format&fit=crop&w=800&q=80'],
   'https://images.unsplash.com/photo-1529699211952-734e80c4d42b?auto=format&fit=crop&w=800&q=80',
   4.7, 9, false, false, true),

  -- Listing 27
  ('b1000000-0000-0000-0000-000000000006',
   'Pull-Back Racing Car — Friction Motor',
   'Pull back and release — the friction motor launches it forward! No batteries '
   'needed. 12cm long, smooth rolling wheels, realistic livery in two styles '
   '(Formula 1 or stock car). Available in 8 colour combos. '
   'Ages 3 and up — no small parts, rounded edges. Great party favour or '
   'stocking stuffer. Sold individually or as a 4-pack (-20%).',
   'toys', 'Edmonton', 'AB',
   12.00, NULL, 'PLA', 'FDM',
   true, false, 2,
   ARRAY['car','pull-back','toy','kids','racing','gift'],
   ARRAY['https://images.unsplash.com/photo-1558618666-fcd25c85cd64?auto=format&fit=crop&w=800&q=80'],
   NULL,
   4.6, 11, false, false, true),

-- ════════════════════════════════════════
-- SELLER 7 — HalifaxPrintShop
-- ════════════════════════════════════════

  -- Listing 28
  ('b1000000-0000-0000-0000-000000000007',
   'Geometric Ring — Faceted Diamond Band',
   'Faceted diamond-cut band ring in SLA resin — smooth, weighty, and beautifully '
   'detailed at 0.025mm layer height. Available in sizes 5–12 (US). '
   'Supplied in natural resin (cream/ivory) or dyed black, white, or deep blue. '
   'Optional 24k gold-leaf finish (+$8). Arrives in a small kraft gift box. '
   'Custom sizing measured and made to order — please provide your ring size in mm '
   'circumference for exact fit.',
   'jewellery', 'Halifax', 'NS',
   27.00, NULL, 'Resin', 'SLA',
   false, true, 5,
   ARRAY['ring','jewellery','geometric','resin','gift','wearable'],
   ARRAY['https://images.unsplash.com/photo-1515377143-a3be0c9a0e2c?auto=format&fit=crop&w=800&q=80'],
   'https://images.unsplash.com/photo-1515377143-a3be0c9a0e2c?auto=format&fit=crop&w=800&q=80',
   4.6, 12, false, false, true),

  -- Listing 29
  ('b1000000-0000-0000-0000-000000000007',
   'Mandala Earring Set — 4 Pairs',
   'Laser-thin mandala earrings in SLA resin — 35mm diameter, 0.8mm thick. '
   'Four pairs in four patterns: lotus, sunburst, snowflake, and geometric star. '
   'Surgical-steel ear wires included. Available in natural resin, matte black, '
   'blush pink, or translucent amber. Incredibly lightweight — wearers often '
   'forget they''re on. Arrives in a velvet pouch.',
   'jewellery', 'Halifax', 'NS',
   22.00, NULL, 'Resin', 'SLA',
   false, false, 4,
   ARRAY['earrings','mandala','jewellery','resin','gift','wearable'],
   ARRAY['https://images.unsplash.com/photo-1519710164239-da529523aa6a?auto=format&fit=crop&w=800&q=80'],
   'https://images.unsplash.com/photo-1519710164239-da529523aa6a?auto=format&fit=crop&w=800&q=80',
   4.8, 18, false, false, true),

  -- Listing 30
  ('b1000000-0000-0000-0000-000000000007',
   'Hollow Leaf Pendant — Sterling Chain',
   'Open-veined leaf pendant — 45mm long. SLA printed at 25 micron for crisp vein '
   'detail, then sealed with UV resin topcoat. Includes an 18" sterling silver '
   'chain. Available in five leaf shapes: fern, oak, maple, ginkgo, monstera. '
   'Custom engraving on the back (up to 10 characters) available at no extra charge. '
   'Great for Mother''s Day, birthdays, or anniversaries.',
   'jewellery', 'Halifax', 'NS',
   34.00, NULL, 'Resin', 'SLA',
   false, true, 5,
   ARRAY['pendant','leaf','jewellery','necklace','resin','gift'],
   ARRAY['https://images.unsplash.com/photo-1535632787350-4e68ef0ac584?auto=format&fit=crop&w=800&q=80'],
   'https://images.unsplash.com/photo-1535632787350-4e68ef0ac584?auto=format&fit=crop&w=800&q=80',
   4.9, 15, false, false, true),

  -- Listing 31
  ('b1000000-0000-0000-0000-000000000007',
   'Viking Helmet Cosplay Prop — Full Size',
   'Full-size wearable Viking helmet with removable nose guard and cheek plates. '
   'Helmet is ~280mm × 240mm, fits head circumference 54–60cm. 4-part print '
   'assembled with M4 brass inserts. Primed and base-coated in metallic silver '
   'paint. Horns are optional add-on (+$12). '
   'Note: display/cosplay use only — not rated for impact protection.',
   'cosplay', 'Halifax', 'NS',
   89.00, NULL, 'PLA+', 'FDM',
   false, true, 10,
   ARRAY['viking','helmet','cosplay','prop','costume','halloween'],
   ARRAY['https://images.unsplash.com/photo-1567401893021-48c7aa4ed54b?auto=format&fit=crop&w=800&q=80'],
   'https://images.unsplash.com/photo-1567401893021-48c7aa4ed54b?auto=format&fit=crop&w=800&q=80',
   4.5, 4, false, false, true),

  -- Listing 32
  ('b1000000-0000-0000-0000-000000000007',
   'Elven Ear Tips — Custom-Fit Pair',
   'Silicone-like TPU ear tips that clip gently to your ear with a comfort '
   'foam insert. Pointed elven style, 55mm long from earlobe to tip. '
   'Flesh-toned TPU (light, medium, and dark skin tone options). '
   'Perfect for LARP, cosplay, or photo shoots. Very comfortable for 4–6 hour wear. '
   'Custom size: send a photo of your ear and I''ll tailor the clip width.',
   'cosplay', 'Halifax', 'NS',
   29.00, NULL, 'TPU', 'FDM',
   false, true, 5,
   ARRAY['elf','ears','cosplay','larp','prop','costume'],
   ARRAY['https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?auto=format&fit=crop&w=800&q=80'],
   'https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?auto=format&fit=crop&w=800&q=80',
   4.6, 7, false, false, true),

  -- Listing 33  (bonus listing — Seller 1, sale item)
  ('b1000000-0000-0000-0000-000000000001',
   'Gridfinity Baseplate 7×7 — For Drawer Lining',
   'Standard-spec Gridfinity baseplate, 7×7 grid (280mm × 280mm). '
   'Magnetic insert pockets compatible with all Gridfinity bins. '
   'Ideal for desk drawers, pegboard squares, or shelf inserts. '
   'Print in-fill is 8% gyroid — lightweight but dimensionally stable. '
   'Order multiples for larger coverage areas. Also available as '
   '4×4, 5×5, 6×6, and custom sizes.',
   'functional', 'Toronto', 'ON',
   16.00, 20.00, 'PLA+', 'FDM',
   true, false, 1,
   ARRAY['gridfinity','baseplate','drawer','organizer','desk'],
   ARRAY['https://images.unsplash.com/photo-1581092160562-40aa08e26b06?auto=format&fit=crop&w=800&q=80'],
   'https://images.unsplash.com/photo-1581092160562-40aa08e26b06?auto=format&fit=crop&w=800&q=80',
   4.7, 6, false, true, true),

  -- Listing 34  (bonus — Seller 3, new item)
  ('b1000000-0000-0000-0000-000000000003',
   'Twisted Vase — Spiral Vase Mode Print',
   'Printed in continuous spiral vase mode — a single unbroken wall 0.8mm thick '
   'spiralling from base to rim. Completely watertight. 30cm tall × 10cm base. '
   'The spiral twist rotates 360° over the height for a dramatic silhouette. '
   'Available in silk copper, silk gold, marble white, or galaxy black. '
   'No infill, no seam — truly one-of-a-kind surface finish.',
   'decor', 'Calgary', 'AB',
   29.00, NULL, 'Silk PLA', 'FDM',
   true, true, 3,
   ARRAY['vase','spiral','silk','decor','home decor'],
   ARRAY['https://images.unsplash.com/photo-1490535856965-b1d2c5ac7e0a?auto=format&fit=crop&w=800&q=80'],
   'https://images.unsplash.com/photo-1490535856965-b1d2c5ac7e0a?auto=format&fit=crop&w=800&q=80',
   0, 0, true, false, true),

  -- Listing 35  (bonus — Seller 5, new item)
  ('b1000000-0000-0000-0000-000000000005',
   'Dual Monitor Stand Riser with Storage Shelf',
   'Raises one or two monitors 10cm to eye level while adding a 40cm × 15cm '
   'shelf beneath for a keyboard, notebook, or accessories. '
   'Cable pass-through notch at the back. Four adjustable rubber feet. '
   'Prints in 4 parts, assembled with M4 bolts (included). '
   'Rated 15kg per monitor. Matte black or white PLA. '
   'Ships fully assembled.',
   'tech', 'Ottawa', 'ON',
   58.00, NULL, 'PLA+', 'FDM',
   false, false, 5,
   ARRAY['monitor','stand','riser','desk','battlestation'],
   ARRAY['https://images.unsplash.com/photo-1547082299-de196ea013d6?auto=format&fit=crop&w=800&q=80'],
   'https://images.unsplash.com/photo-1547082299-de196ea013d6?auto=format&fit=crop&w=800&q=80',
   0, 0, true, false, true);

-- ─────────────────────────────────────────
-- 4. REVIEWS
-- ─────────────────────────────────────────
-- The listing IDs assigned by BIGSERIAL depend on existing rows.
-- We use a subquery to resolve them by title + seller.

INSERT INTO reviews (listing_id, seller_id, buyer_name, buyer_city, rating, comment, created_at)
SELECT l.id, l.seller_id, r.buyer_name, r.buyer_city, r.rating, r.comment, r.created_at
FROM (VALUES

  -- Gridfinity 4x2
  ('Gridfinity Storage Bin 4×2 (Stackable)', 'TorontoMakeLab',
   'Kevin W.', 'Hamilton', 5, 'Exactly the right size for my workshop drawer. Picked up from Liam — super friendly, fast turnaround.', NOW() - INTERVAL '45 days'),
  ('Gridfinity Storage Bin 4×2 (Stackable)', 'TorontoMakeLab',
   'Priya M.', 'Mississauga', 5, 'Perfect fit, dimensions are dead-on. Ordered 8 of these for a full drawer set.', NOW() - INTERVAL '32 days'),
  ('Gridfinity Storage Bin 4×2 (Stackable)', 'TorontoMakeLab',
   'Aaron L.', 'Toronto', 4, 'Great print quality. Took 3 days which was a bit longer than expected but totally worth it.', NOW() - INTERVAL '20 days'),

  -- Under-Desk Cable Tray
  ('Under-Desk Cable Management Tray', 'TorontoMakeLab',
   'Diane F.', 'Toronto', 5, 'Game changer for my home office. No more cable mess — love the snap-fit lid.', NOW() - INTERVAL '50 days'),
  ('Under-Desk Cable Management Tray', 'TorontoMakeLab',
   'Sam R.', 'Vaughan', 5, 'Solid PETG, holds my power bar and 2 hubs with no sag at all. Highly recommend.', NOW() - INTERVAL '38 days'),
  ('Under-Desk Cable Management Tray', 'TorontoMakeLab',
   'Lukas B.', 'Markham', 4, 'Does the job perfectly. Instructions for mounting could be clearer but figured it out.', NOW() - INTERVAL '14 days'),

  -- Phone Stand
  ('Adjustable Phone Stand with Cable Channel', 'TorontoMakeLab',
   'Caitlin D.', 'Toronto', 5, 'The cable channel is such a clever detail — works great for video calls.', NOW() - INTERVAL '60 days'),
  ('Adjustable Phone Stand with Cable Channel', 'TorontoMakeLab',
   'Omar N.', 'Scarborough', 5, 'Rock solid at every angle. Holds my Galaxy S24 Ultra with a bulky case no problem.', NOW() - INTERVAL '22 days'),
  ('Adjustable Phone Stand with Cable Channel', 'TorontoMakeLab',
   'Jen K.', 'North York', 4, 'Love it! Wish it came in more colours but the grey looks great on my desk.', NOW() - INTERVAL '9 days'),

  -- Raspberry Pi Case
  ('Raspberry Pi 5 Case with Active Cooling', 'TorontoMakeLab',
   'Ravi P.', 'Brampton', 5, 'Pi stays cool, all ports accessible, GPIO notch is perfect. Great work.', NOW() - INTERVAL '28 days'),
  ('Raspberry Pi 5 Case with Active Cooling', 'TorontoMakeLab',
   'Elise T.', 'Toronto', 4, 'Good case. Fan duct works well. Would love a version that hides the fan cable better.', NOW() - INTERVAL '11 days'),

  -- D&D Terrain
  ('D&D Dungeon Terrain Starter Pack (12 Tiles)', 'VancouverPrint3D',
   'Brendan H.', 'Vancouver', 5, 'Our whole group was blown away — the stone texture is incredible for resin. Zero bleed on the clip joints.', NOW() - INTERVAL '55 days'),
  ('D&D Dungeon Terrain Starter Pack (12 Tiles)', 'VancouverPrint3D',
   'Tasha G.', 'Burnaby', 5, 'Ordered the expansion packs too. Everything tiles perfectly. Maya replies to DMs super fast.', NOW() - INTERVAL '40 days'),
  ('D&D Dungeon Terrain Starter Pack (12 Tiles)', 'VancouverPrint3D',
   'Jon M.', 'Richmond', 5, 'Shipped carefully, arrived flawless. Best terrain I''ve bought in Canada — period.', NOW() - INTERVAL '18 days'),
  ('D&D Dungeon Terrain Starter Pack (12 Tiles)', 'VancouverPrint3D',
   'Rachel O.', 'Surrey', 4, 'Fantastic quality but two tiles had very minor print lines on one face. Everything else is perfect.', NOW() - INTERVAL '7 days'),

  -- Fantasy Fighter Mini
  ('Fantasy Fighter Hero Miniature — 32mm', 'VancouverPrint3D',
   'Geoff C.', 'Vancouver', 5, 'Crisp detail down to the buckle on the armour straps. Primed and ready to paint.', NOW() - INTERVAL '62 days'),
  ('Fantasy Fighter Hero Miniature — 32mm', 'VancouverPrint3D',
   'Asha K.', 'New Westminster', 5, 'Got a custom pose for my character — Maya nailed it. Took 6 days.', NOW() - INTERVAL '48 days'),
  ('Fantasy Fighter Hero Miniature — 32mm', 'VancouverPrint3D',
   'Tyler W.', 'Vancouver', 5, 'Three orders in, never disappointed. The 8K resolution really does make a difference.', NOW() - INTERVAL '30 days'),
  ('Fantasy Fighter Hero Miniature — 32mm', 'VancouverPrint3D',
   'Mei L.', 'Coquitlam', 4, 'Really nice detail. One support nub on the back was a bit rough but easy to sand off.', NOW() - INTERVAL '12 days'),

  -- Dungeon Scatter
  ('Dungeon Scatter: Barrels, Crates & Chests (18 pcs)', 'VancouverPrint3D',
   'Cameron R.', 'Vancouver', 5, 'The plank texture on the crates is insane. Painted in an afternoon — they look amazing on the table.', NOW() - INTERVAL '35 days'),
  ('Dungeon Scatter: Barrels, Crates & Chests (18 pcs)', 'VancouverPrint3D',
   'Nadia P.', 'Port Moody', 5, 'Perfect scatter terrain. Got the painted set — brown-oak finish looks exactly like old wood.', NOW() - INTERVAL '14 days'),

  -- Geometric Lamp Shade
  ('Geometric Pendant Lamp Shade — Icosahedron', 'CalgaryCreations3D',
   'Hailey B.', 'Calgary', 5, 'This is stunning. The light that comes through the faces makes patterns on the wall — way better than expected.', NOW() - INTERVAL '70 days'),
  ('Geometric Pendant Lamp Shade — Icosahedron', 'CalgaryCreations3D',
   'Marcus O.', 'Airdrie', 5, 'Ordered in terracotta — exactly matches my living room. Ethan was super helpful with sizing.', NOW() - INTERVAL '55 days'),
  ('Geometric Pendant Lamp Shade — Icosahedron', 'CalgaryCreations3D',
   'Isabelle V.', 'Calgary', 5, 'Third piece I''ve bought from this shop. The quality is consistently excellent.', NOW() - INTERVAL '33 days'),
  ('Geometric Pendant Lamp Shade — Icosahedron', 'CalgaryCreations3D',
   'Derek N.', 'Cochrane', 5, 'Bought as a gift — recipient was absolutely floored. Fast shipping, beautiful packaging.', NOW() - INTERVAL '15 days'),

  -- Lattice Vase
  ('Parametric Lattice Vase — 25cm Tall', 'CalgaryCreations3D',
   'Fiona W.', 'Calgary', 5, 'The silk gold is even more beautiful in person than in photos. Watertight, smooth inside.', NOW() - INTERVAL '80 days'),
  ('Parametric Lattice Vase — 25cm Tall', 'CalgaryCreations3D',
   'Tom H.', 'Red Deer', 5, 'Ordered a custom height (30cm) — Ethan accommodated with no fuss. Perfect piece.', NOW() - INTERVAL '58 days'),
  ('Parametric Lattice Vase — 25cm Tall', 'CalgaryCreations3D',
   'Ayesha M.', 'Calgary', 5, 'Bought three — one for each bedroom. The marble-fill looks incredible.', NOW() - INTERVAL '42 days'),
  ('Parametric Lattice Vase — 25cm Tall', 'CalgaryCreations3D',
   'Chris L.', 'Okotoks', 4, 'Gorgeous piece, love the lattice. Shipping took a week but worth the wait.', NOW() - INTERVAL '20 days'),

  -- Honeycomb Wall Panel
  ('Honeycomb Wall Panel Set — 4 Pieces', 'CalgaryCreations3D',
   'Megan S.', 'Calgary', 5, 'Transformed my home office wall. The sage green is a perfect match to my paint. Zero gaps when tiled.', NOW() - INTERVAL '44 days'),
  ('Honeycomb Wall Panel Set — 4 Pieces', 'CalgaryCreations3D',
   'Ryan T.', 'Calgary', 5, 'Bought 3 sets to cover a full accent wall — looks professional. Sale price was great.', NOW() - INTERVAL '28 days'),
  ('Honeycomb Wall Panel Set — 4 Pieces', 'CalgaryCreations3D',
   'Karen F.', 'Lethbridge', 4, 'Really nice panels. Mounting could be a bit easier but they look amazing on the wall.', NOW() - INTERVAL '10 days'),

  -- Succulent Planter
  ('Self-Watering Succulent Planter with Drainage Tray', 'CalgaryCreations3D',
   'Julia P.', 'Calgary', 5, 'The self-watering mechanism actually works! My succulents have never looked happier.', NOW() - INTERVAL '35 days'),
  ('Self-Watering Succulent Planter with Drainage Tray', 'CalgaryCreations3D',
   'Ben K.', 'Banff', 5, 'Ordered 6 as Christmas gifts. Everyone loved them. Beautiful print, no layer lines.', NOW() - INTERVAL '90 days'),
  ('Self-Watering Succulent Planter with Drainage Tray', 'CalgaryCreations3D',
   'Lily C.', 'Calgary', 5, 'The terracotta colour is perfect. Dishwasher safe as advertised.', NOW() - INTERVAL '22 days'),

  -- Keyboard Wrist Rest
  ('Mechanical Keyboard Wrist Rest — 60%/65% Size', 'OttawaMakers',
   'Nate G.', 'Ottawa', 5, 'The TPU surface is amazing — not too sticky, not too slippery. My wrists thank me after long coding sessions.', NOW() - INTERVAL '40 days'),
  ('Mechanical Keyboard Wrist Rest — 60%/65% Size', 'OttawaMakers',
   'Sarah J.', 'Nepean', 5, 'Perfect height for my Keychron Q2. Green/black combo looks great next to my setup.', NOW() - INTERVAL '28 days'),
  ('Mechanical Keyboard Wrist Rest — 60%/65% Size', 'OttawaMakers',
   'Kevin L.', 'Kanata', 4, 'Very good quality. Took 5 days to ship but communication was good throughout.', NOW() - INTERVAL '15 days'),

  -- StreamDeck Mount
  ('Elgato Stream Deck Monitor Mount Arm', 'OttawaMakers',
   'Mike R.', 'Ottawa', 5, 'Perfect solution for my VESA arm. Stream Deck is right at eye level, cable tucked away clean.', NOW() - INTERVAL '30 days'),
  ('Elgato Stream Deck Monitor Mount Arm', 'OttawaMakers',
   'Trish B.', 'Barrhaven', 4, 'Fits my XL perfectly. Tilt lock is solid. Would be 5 stars if it arrived faster.', NOW() - INTERVAL '12 days'),

  -- Flexi Rex
  ('Flexi Rex — Fully Articulated Dinosaur', 'EdmontonMini3D',
   'Laura T.', 'Edmonton', 5, 'My 5-year-old hasn''t put it down since Christmas morning. Printed beautifully, no sharp bits anywhere.', NOW() - INTERVAL '65 days'),
  ('Flexi Rex — Fully Articulated Dinosaur', 'EdmontonMini3D',
   'Jason M.', 'St. Albert', 5, 'Bought the 30cm glow-in-the-dark version — the kids LOVE it at bedtime. Fantastic.', NOW() - INTERVAL '50 days'),
  ('Flexi Rex — Fully Articulated Dinosaur', 'EdmontonMini3D',
   'Amy W.', 'Leduc', 5, 'Ordered a custom orange with blue spots — Krista matched it perfectly. Super fast turnaround.', NOW() - INTERVAL '38 days'),
  ('Flexi Rex — Fully Articulated Dinosaur', 'EdmontonMini3D',
   'Paul D.', 'Edmonton', 5, 'Fourth order from this shop. The quality is always consistent. My whole office has one now.', NOW() - INTERVAL '20 days'),
  ('Flexi Rex — Fully Articulated Dinosaur', 'EdmontonMini3D',
   'Steph R.', 'Fort Saskatchewan', 4, 'Really fun toy. One leg was a bit stiff at first but loosened up after a day.', NOW() - INTERVAL '8 days'),

  -- Marble Run
  ('Marble Run Set — Starter Pack (52 Pieces)', 'EdmontonMini3D',
   'Claire H.', 'Edmonton', 5, 'Best gift I''ve ever given my nephew. We spent 3 hours building different tracks on Christmas Day.', NOW() - INTERVAL '75 days'),
  ('Marble Run Set — Starter Pack (52 Pieces)', 'EdmontonMini3D',
   'Andrew V.', 'Sherwood Park', 5, 'Storage box is brilliant — colour coded pieces make setup and pack-down fast. Perfect quality.', NOW() - INTERVAL '48 days'),
  ('Marble Run Set — Starter Pack (52 Pieces)', 'EdmontonMini3D',
   'Natalie B.', 'Edmonton', 5, 'My 7-year-old can build it herself. Sturdy, no pieces broken after months of use.', NOW() - INTERVAL '30 days'),

  -- Geometric Ring
  ('Geometric Ring — Faceted Diamond Band', 'HalifaxPrintShop',
   'Sarah M.', 'Halifax', 5, 'The gold-leaf finish is stunning. Finn measured my finger via the photo method and it fits perfectly.', NOW() - INTERVAL '40 days'),
  ('Geometric Ring — Faceted Diamond Band', 'HalifaxPrintShop',
   'Tom H.', 'Dartmouth', 5, 'Bought this for my partner — she wears it every day. The dyed black version is really striking.', NOW() - INTERVAL '28 days'),
  ('Geometric Ring — Faceted Diamond Band', 'HalifaxPrintShop',
   'Leah F.', 'Halifax', 4, 'Beautiful ring. Sizing was slightly loose (I have narrow fingers) but Finn offered to reprint — great service.', NOW() - INTERVAL '14 days'),

  -- Mandala Earrings
  ('Mandala Earring Set — 4 Pairs', 'HalifaxPrintShop',
   'Kim R.', 'Halifax', 5, 'Four pairs of gorgeous earrings for $22 — incredible value. I''ve gotten so many compliments.', NOW() - INTERVAL '55 days'),
  ('Mandala Earring Set — 4 Pairs', 'HalifaxPrintShop',
   'Dani P.', 'Truro', 5, 'The lotus and snowflake patterns are my favourites. Surgical steel wires — no irritation at all.', NOW() - INTERVAL '42 days'),
  ('Mandala Earring Set — 4 Pairs', 'HalifaxPrintShop',
   'Bea S.', 'Bedford', 5, 'Translucent amber is ethereal — you can see the light through them. Absolutely beautiful work.', NOW() - INTERVAL '25 days'),
  ('Mandala Earring Set — 4 Pairs', 'HalifaxPrintShop',
   'Nina T.', 'Dartmouth', 5, 'Third purchase from Halifax Print Shop. Always perfect. Fast shipping to Dartmouth.', NOW() - INTERVAL '10 days'),

  -- Leaf Pendant
  ('Hollow Leaf Pendant — Sterling Chain', 'HalifaxPrintShop',
   'Amy J.', 'Antigonish', 5, 'The maple leaf with my initials engraved — it''s perfect. Really meaningful and beautifully made.', NOW() - INTERVAL '35 days'),
  ('Hollow Leaf Pendant — Sterling Chain', 'HalifaxPrintShop',
   'Grace W.', 'Halifax', 5, 'Monstera leaf on an 18" chain — exactly what I wanted. The UV topcoat gives it a subtle shine.', NOW() - INTERVAL '18 days'),

  -- Viking Helmet
  ('Viking Helmet Cosplay Prop — Full Size', 'HalifaxPrintShop',
   'Mark D.', 'Moncton', 5, 'Wore this at Fan Expo — so many people asked where I got it. Paint job is excellent, very sturdy.', NOW() - INTERVAL '90 days'),
  ('Viking Helmet Cosplay Prop — Full Size', 'HalifaxPrintShop',
   'Rick B.', 'Halifax', 4, 'Great prop, fits my 58cm head perfectly. Horns add-on was worth it. Shipping was well packaged.', NOW() - INTERVAL '60 days')

) AS r(listing_title, shop_name, buyer_name, buyer_city, rating, comment, created_at)
JOIN listings  l ON l.title = r.listing_title
JOIN sellers   s ON s.shop_name = r.shop_name AND l.seller_id = s.id;

-- ─────────────────────────────────────────
-- 5. UPDATE RATINGS
-- Recalculate avg_rating + total_reviews on
-- every listing and seller from inserted reviews
-- ─────────────────────────────────────────
UPDATE listings l
SET
  avg_rating    = sub.avg,
  total_reviews = sub.cnt,
  updated_at    = NOW()
FROM (
  SELECT listing_id,
         ROUND(AVG(rating)::NUMERIC, 2) AS avg,
         COUNT(*)                        AS cnt
  FROM   reviews
  GROUP  BY listing_id
) sub
WHERE l.id = sub.listing_id;

UPDATE sellers s
SET
  avg_rating    = sub.avg,
  total_reviews = sub.cnt,
  updated_at    = NOW()
FROM (
  SELECT l.seller_id,
         ROUND(AVG(r.rating)::NUMERIC, 2) AS avg,
         COUNT(r.id)                       AS cnt
  FROM   reviews r
  JOIN   listings l ON r.listing_id = l.id
  GROUP  BY l.seller_id
) sub
WHERE s.id = sub.seller_id;

-- ─────────────────────────────────────────
-- 6. VERIFY
-- ─────────────────────────────────────────
SELECT 'users'    AS tbl, COUNT(*) FROM users
UNION ALL
SELECT 'sellers',          COUNT(*) FROM sellers
UNION ALL
SELECT 'listings',         COUNT(*) FROM listings
UNION ALL
SELECT 'reviews',          COUNT(*) FROM reviews;

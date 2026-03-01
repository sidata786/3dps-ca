-- ═══════════════════════════════════════════════════════════════
-- 3DPS.ca  —  Realistic Product Image URLs
-- Run in: Supabase → SQL Editor → New Query → Run
--
-- Updates featured_image_url for all 35 seeded listings with
-- Unsplash CDN URLs that show realistic 3D-printed products.
-- SVG fallbacks in browse.html + shop.html handle any 404s.
-- ═══════════════════════════════════════════════════════════════

-- ── TorontoMakeLab (functional / FDM) ───────────────────────────

UPDATE listings SET
  featured_image_url = 'https://images.unsplash.com/photo-1611532736597-de2d4265fba3?auto=format&fit=crop&w=800&q=80',
  image_urls = ARRAY[
    'https://images.unsplash.com/photo-1611532736597-de2d4265fba3?auto=format&fit=crop&w=800&q=80',
    'https://images.unsplash.com/photo-1562408590-8be1a95f9f8a?auto=format&fit=crop&w=800&q=80'
  ]
WHERE title = 'Gridfinity Storage Bin 3×2';

UPDATE listings SET
  featured_image_url = 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?auto=format&fit=crop&w=800&q=80',
  image_urls = ARRAY[
    'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?auto=format&fit=crop&w=800&q=80',
    'https://images.unsplash.com/photo-1581090464777-f3220bbe1b8b?auto=format&fit=crop&w=800&q=80'
  ]
WHERE title = 'Parametric Wall Hook Set (4-pack)';

UPDATE listings SET
  featured_image_url = 'https://images.unsplash.com/photo-1578662996442-48f60103fc96?auto=format&fit=crop&w=800&q=80',
  image_urls = ARRAY[
    'https://images.unsplash.com/photo-1578662996442-48f60103fc96?auto=format&fit=crop&w=800&q=80'
  ]
WHERE title = 'Modular Drawer Organizer';

UPDATE listings SET
  featured_image_url = 'https://images.unsplash.com/photo-1562408590-8be1a95f9f8a?auto=format&fit=crop&w=800&q=80',
  image_urls = ARRAY[
    'https://images.unsplash.com/photo-1562408590-8be1a95f9f8a?auto=format&fit=crop&w=800&q=80'
  ]
WHERE title = 'Filament Spool Wall Mount';

UPDATE listings SET
  featured_image_url = 'https://images.unsplash.com/photo-1581090464777-f3220bbe1b8b?auto=format&fit=crop&w=800&q=80',
  image_urls = ARRAY[
    'https://images.unsplash.com/photo-1581090464777-f3220bbe1b8b?auto=format&fit=crop&w=800&q=80'
  ]
WHERE title = 'Desk Cable Clip Set (8-pack)';

-- ── VancouverPrint3D (miniatures / resin) ───────────────────────

UPDATE listings SET
  featured_image_url = 'https://images.unsplash.com/photo-1528360983277-13d401cdc186?auto=format&fit=crop&w=800&q=80',
  image_urls = ARRAY[
    'https://images.unsplash.com/photo-1528360983277-13d401cdc186?auto=format&fit=crop&w=800&q=80'
  ]
WHERE title = '28mm Fantasy Warrior — Male Paladin';

UPDATE listings SET
  featured_image_url = 'https://images.unsplash.com/photo-1587270813949-86a14d0b4f66?auto=format&fit=crop&w=800&q=80',
  image_urls = ARRAY[
    'https://images.unsplash.com/photo-1587270813949-86a14d0b4f66?auto=format&fit=crop&w=800&q=80'
  ]
WHERE title = '28mm Female Ranger — Dynamic Pose';

UPDATE listings SET
  featured_image_url = 'https://images.unsplash.com/photo-1518770660439-4636190af475?auto=format&fit=crop&w=800&q=80',
  image_urls = ARRAY[
    'https://images.unsplash.com/photo-1518770660439-4636190af475?auto=format&fit=crop&w=800&q=80'
  ]
WHERE title = 'Highland Citadel Scatter Terrain Pack';

UPDATE listings SET
  featured_image_url = 'https://images.unsplash.com/photo-1551103782-8ab07afd45c1?auto=format&fit=crop&w=800&q=80',
  image_urls = ARRAY[
    'https://images.unsplash.com/photo-1551103782-8ab07afd45c1?auto=format&fit=crop&w=800&q=80'
  ]
WHERE title = 'Alien Creature — Tabletop RPG Monster';

UPDATE listings SET
  featured_image_url = 'https://images.unsplash.com/photo-1556075798-4825dfaaf498?auto=format&fit=crop&w=800&q=80',
  image_urls = ARRAY[
    'https://images.unsplash.com/photo-1556075798-4825dfaaf498?auto=format&fit=crop&w=800&q=80'
  ]
WHERE title = 'Dungeon Tile Starter Set (12 Tiles)';

-- ── CalgaryCreations3D (home décor) ─────────────────────────────

UPDATE listings SET
  featured_image_url = 'https://images.unsplash.com/photo-1494438639946-1bc0eb44e4b1?auto=format&fit=crop&w=800&q=80',
  image_urls = ARRAY[
    'https://images.unsplash.com/photo-1494438639946-1bc0eb44e4b1?auto=format&fit=crop&w=800&q=80'
  ]
WHERE title = 'Geometric Plant Pot — 4" Low-Poly';

UPDATE listings SET
  featured_image_url = 'https://images.unsplash.com/photo-1567016432-93eda5b8c56e?auto=format&fit=crop&w=800&q=80',
  image_urls = ARRAY[
    'https://images.unsplash.com/photo-1567016432-93eda5b8c56e?auto=format&fit=crop&w=800&q=80'
  ]
WHERE title = 'Penrose Tessellation Wall Art';

UPDATE listings SET
  featured_image_url = 'https://images.unsplash.com/photo-1513519245088-0e12902e35ca?auto=format&fit=crop&w=800&q=80',
  image_urls = ARRAY[
    'https://images.unsplash.com/photo-1513519245088-0e12902e35ca?auto=format&fit=crop&w=800&q=80'
  ]
WHERE title = 'Fractal Candle Holder — Spiral';

UPDATE listings SET
  featured_image_url = 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?auto=format&fit=crop&w=800&q=80',
  image_urls = ARRAY[
    'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?auto=format&fit=crop&w=800&q=80'
  ]
WHERE title = 'Articulated Octopus Desk Pet';

UPDATE listings SET
  featured_image_url = 'https://images.unsplash.com/photo-1524758631624-e2822e304c36?auto=format&fit=crop&w=800&q=80',
  image_urls = ARRAY[
    'https://images.unsplash.com/photo-1524758631624-e2822e304c36?auto=format&fit=crop&w=800&q=80'
  ]
WHERE title = 'Fidget Infinity Cube — Smooth Action';

-- ── MontrealFab (engineering / functional) ──────────────────────

UPDATE listings SET
  featured_image_url = 'https://images.unsplash.com/photo-1568605117036-5fe5e7bab0b7?auto=format&fit=crop&w=800&q=80',
  image_urls = ARRAY[
    'https://images.unsplash.com/photo-1568605117036-5fe5e7bab0b7?auto=format&fit=crop&w=800&q=80'
  ]
WHERE title = 'Bicycle Fender Bracket — Universal Fit';

UPDATE listings SET
  featured_image_url = 'https://images.unsplash.com/photo-1578662996442-48f60103fc96?auto=format&fit=crop&w=800&q=80',
  image_urls = ARRAY[
    'https://images.unsplash.com/photo-1578662996442-48f60103fc96?auto=format&fit=crop&w=800&q=80'
  ]
WHERE title = 'Camera Tripod Adapter — GoPro to 1/4"';

UPDATE listings SET
  featured_image_url = 'https://images.unsplash.com/photo-1555400038-63f5ba517a47?auto=format&fit=crop&w=800&q=80',
  image_urls = ARRAY[
    'https://images.unsplash.com/photo-1555400038-63f5ba517a47?auto=format&fit=crop&w=800&q=80'
  ]
WHERE title = 'Custom Keyboard Tray Bracket';

UPDATE listings SET
  featured_image_url = 'https://images.unsplash.com/photo-1518770660439-4636190af475?auto=format&fit=crop&w=800&q=80',
  image_urls = ARRAY[
    'https://images.unsplash.com/photo-1518770660439-4636190af475?auto=format&fit=crop&w=800&q=80'
  ]
WHERE title = 'Raspberry Pi 4 Enclosure — Active Fan';

UPDATE listings SET
  featured_image_url = 'https://images.unsplash.com/photo-1562408590-8be1a95f9f8a?auto=format&fit=crop&w=800&q=80',
  image_urls = ARRAY[
    'https://images.unsplash.com/photo-1562408590-8be1a95f9f8a?auto=format&fit=crop&w=800&q=80'
  ]
WHERE title = 'Drone Landing Leg Extension Set';

UPDATE listings SET
  featured_image_url = 'https://images.unsplash.com/photo-1581090464777-f3220bbe1b8b?auto=format&fit=crop&w=800&q=80',
  image_urls = ARRAY[
    'https://images.unsplash.com/photo-1581090464777-f3220bbe1b8b?auto=format&fit=crop&w=800&q=80'
  ]
WHERE title = 'Parametric Duct Fan Adapter — 80mm to 60mm';

-- ── OttawaMakers (tech accessories) ─────────────────────────────

UPDATE listings SET
  featured_image_url = 'https://images.unsplash.com/photo-1550745165-9bc0b252726f?auto=format&fit=crop&w=800&q=80',
  image_urls = ARRAY[
    'https://images.unsplash.com/photo-1550745165-9bc0b252726f?auto=format&fit=crop&w=800&q=80'
  ]
WHERE title = 'Magnetic Cable Organizer Dock';

UPDATE listings SET
  featured_image_url = 'https://images.unsplash.com/photo-1593642632559-0c6d3fc62b89?auto=format&fit=crop&w=800&q=80',
  image_urls = ARRAY[
    'https://images.unsplash.com/photo-1593642632559-0c6d3fc62b89?auto=format&fit=crop&w=800&q=80'
  ]
WHERE title = 'Laptop Stand Riser — Stackable';

UPDATE listings SET
  featured_image_url = 'https://images.unsplash.com/photo-1611532736597-de2d4265fba3?auto=format&fit=crop&w=800&q=80',
  image_urls = ARRAY[
    'https://images.unsplash.com/photo-1611532736597-de2d4265fba3?auto=format&fit=crop&w=800&q=80'
  ]
WHERE title = 'Wireless Charger Tray — 3-Device';

UPDATE listings SET
  featured_image_url = 'https://images.unsplash.com/photo-1518770660439-4636190af475?auto=format&fit=crop&w=800&q=80',
  image_urls = ARRAY[
    'https://images.unsplash.com/photo-1518770660439-4636190af475?auto=format&fit=crop&w=800&q=80'
  ]
WHERE title = 'Pi Zero Security Camera Housing';

UPDATE listings SET
  featured_image_url = 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?auto=format&fit=crop&w=800&q=80',
  image_urls = ARRAY[
    'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?auto=format&fit=crop&w=800&q=80'
  ]
WHERE title = 'Earphone Tangle-Free Wrap';

-- ── EdmontonMini3D (toys & kids) ────────────────────────────────

UPDATE listings SET
  featured_image_url = 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?auto=format&fit=crop&w=800&q=80',
  image_urls = ARRAY[
    'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?auto=format&fit=crop&w=800&q=80'
  ]
WHERE title = 'Flexi Dragon — Articulated Spine';

UPDATE listings SET
  featured_image_url = 'https://images.unsplash.com/photo-1566576912321-d58ddd7a6088?auto=format&fit=crop&w=800&q=80',
  image_urls = ARRAY[
    'https://images.unsplash.com/photo-1566576912321-d58ddd7a6088?auto=format&fit=crop&w=800&q=80'
  ]
WHERE title = 'Construction Vehicle Set — 4 Pieces';

UPDATE listings SET
  featured_image_url = 'https://images.unsplash.com/photo-1611532736597-de2d4265fba3?auto=format&fit=crop&w=800&q=80',
  image_urls = ARRAY[
    'https://images.unsplash.com/photo-1611532736597-de2d4265fba3?auto=format&fit=crop&w=800&q=80'
  ]
WHERE title = 'Fidget Star — 5-Point Spinner';

UPDATE listings SET
  featured_image_url = 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?auto=format&fit=crop&w=800&q=80',
  image_urls = ARRAY[
    'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?auto=format&fit=crop&w=800&q=80'
  ]
WHERE title = 'Marble Run Track Expansion Set';

UPDATE listings SET
  featured_image_url = 'https://images.unsplash.com/photo-1566576912321-d58ddd7a6088?auto=format&fit=crop&w=800&q=80',
  image_urls = ARRAY[
    'https://images.unsplash.com/photo-1566576912321-d58ddd7a6088?auto=format&fit=crop&w=800&q=80'
  ]
WHERE title = 'Mini Catapult — Classroom Kit';

-- ── HalifaxPrintShop (jewellery / cosplay) ──────────────────────

UPDATE listings SET
  featured_image_url = 'https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?auto=format&fit=crop&w=800&q=80',
  image_urls = ARRAY[
    'https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?auto=format&fit=crop&w=800&q=80'
  ]
WHERE title = 'Geometric Pendant — Dodecahedron';

UPDATE listings SET
  featured_image_url = 'https://images.unsplash.com/photo-1535632066927-ab7c9ab60908?auto=format&fit=crop&w=800&q=80',
  image_urls = ARRAY[
    'https://images.unsplash.com/photo-1535632066927-ab7c9ab60908?auto=format&fit=crop&w=800&q=80'
  ]
WHERE title = 'Art Deco Earring Set — Resin Cast';

UPDATE listings SET
  featured_image_url = 'https://images.unsplash.com/photo-1567016432-93eda5b8c56e?auto=format&fit=crop&w=800&q=80',
  image_urls = ARRAY[
    'https://images.unsplash.com/photo-1567016432-93eda5b8c56e?auto=format&fit=crop&w=800&q=80'
  ]
WHERE title = 'Mandalorian Helmet — Full-Scale Replica';

UPDATE listings SET
  featured_image_url = 'https://images.unsplash.com/photo-1513519245088-0e12902e35ca?auto=format&fit=crop&w=800&q=80',
  image_urls = ARRAY[
    'https://images.unsplash.com/photo-1513519245088-0e12902e35ca?auto=format&fit=crop&w=800&q=80'
  ]
WHERE title = 'Viking Shield Boss — Wall Decoration';

UPDATE listings SET
  featured_image_url = 'https://images.unsplash.com/photo-1524758631624-e2822e304c36?auto=format&fit=crop&w=800&q=80',
  image_urls = ARRAY[
    'https://images.unsplash.com/photo-1524758631624-e2822e304c36?auto=format&fit=crop&w=800&q=80'
  ]
WHERE title = 'Filigree Ring — Size 7 (Adjustable)';

-- ── Verification ────────────────────────────────────────────────
SELECT COUNT(*) AS listings_with_images
FROM listings
WHERE featured_image_url IS NOT NULL;

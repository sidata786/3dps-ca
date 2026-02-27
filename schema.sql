-- ═══════════════════════════════════════════════════════════
-- 3DPS.ca Database Schema
-- Run this in: Supabase → SQL Editor → New query
-- ═══════════════════════════════════════════════════════════

-- Extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pg_trgm";

-- ─────────────────────────────────────────
-- USERS
-- ─────────────────────────────────────────
CREATE TABLE IF NOT EXISTS users (
  id            UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  email         VARCHAR(255) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  first_name    VARCHAR(100) NOT NULL,
  last_name     VARCHAR(100) NOT NULL,
  city          VARCHAR(100) NOT NULL,
  province      VARCHAR(2)   NOT NULL,
  is_active     BOOLEAN      DEFAULT true,
  created_at    TIMESTAMPTZ  DEFAULT NOW(),
  updated_at    TIMESTAMPTZ  DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);

-- ─────────────────────────────────────────
-- SELLERS
-- ─────────────────────────────────────────
CREATE TABLE IF NOT EXISTS sellers (
  id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id         UUID NOT NULL UNIQUE REFERENCES users(id) ON DELETE CASCADE,
  shop_name       VARCHAR(100) NOT NULL UNIQUE,
  tagline         VARCHAR(200),
  about           TEXT,
  city            VARCHAR(100) NOT NULL,
  province        VARCHAR(2)   NOT NULL,
  printers        JSONB        DEFAULT '[]',
  fulfil_option   VARCHAR(20)  NOT NULL DEFAULT 'pickup',
  payout_method   VARCHAR(20)  NOT NULL DEFAULT 'etransfer',
  avg_rating      DECIMAL(3,2) DEFAULT 0,
  total_reviews   INT          DEFAULT 0,
  total_sales     INT          DEFAULT 0,
  is_verified     BOOLEAN      DEFAULT false,
  is_active       BOOLEAN      DEFAULT true,
  created_at      TIMESTAMPTZ  DEFAULT NOW(),
  updated_at      TIMESTAMPTZ  DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_sellers_user_id  ON sellers(user_id);
CREATE INDEX IF NOT EXISTS idx_sellers_city     ON sellers(city);

-- ─────────────────────────────────────────
-- LISTINGS
-- ─────────────────────────────────────────
CREATE TABLE IF NOT EXISTS listings (
  id                  BIGSERIAL    PRIMARY KEY,
  seller_id           UUID         NOT NULL REFERENCES sellers(id) ON DELETE CASCADE,
  title               VARCHAR(255) NOT NULL,
  description         TEXT,
  category            VARCHAR(50)  NOT NULL,
  city                VARCHAR(100) NOT NULL,
  province            VARCHAR(2)   NOT NULL,
  price               DECIMAL(10,2) NOT NULL,
  compare_price       DECIMAL(10,2),
  material            VARCHAR(100),
  printer_type        VARCHAR(20),
  pickup_available    BOOLEAN      DEFAULT false,
  custom_orders       BOOLEAN      DEFAULT false,
  lead_time_days      INT,
  tags                TEXT[]       DEFAULT '{}',
  specs               JSONB        DEFAULT '{}',
  image_urls          TEXT[]       DEFAULT '{}',
  featured_image_url  TEXT,
  view_count          INT          DEFAULT 0,
  avg_rating          DECIMAL(3,2) DEFAULT 0,
  total_reviews       INT          DEFAULT 0,
  is_active           BOOLEAN      DEFAULT true,
  is_new              BOOLEAN      DEFAULT true,
  is_on_sale          BOOLEAN      DEFAULT false,
  created_at          TIMESTAMPTZ  DEFAULT NOW(),
  updated_at          TIMESTAMPTZ  DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_listings_seller_id    ON listings(seller_id);
CREATE INDEX IF NOT EXISTS idx_listings_category     ON listings(category);
CREATE INDEX IF NOT EXISTS idx_listings_city         ON listings(city);
CREATE INDEX IF NOT EXISTS idx_listings_price        ON listings(price);
CREATE INDEX IF NOT EXISTS idx_listings_printer_type ON listings(printer_type);
CREATE INDEX IF NOT EXISTS idx_listings_is_active    ON listings(is_active);
CREATE INDEX IF NOT EXISTS idx_listings_tags         ON listings USING GIN(tags);
CREATE INDEX IF NOT EXISTS idx_listings_fts          ON listings USING GIN(
  to_tsvector('english', title || ' ' || COALESCE(description, ''))
);

-- ─────────────────────────────────────────
-- REVIEWS
-- ─────────────────────────────────────────
CREATE TABLE IF NOT EXISTS reviews (
  id          BIGSERIAL PRIMARY KEY,
  listing_id  BIGINT NOT NULL REFERENCES listings(id) ON DELETE CASCADE,
  seller_id   UUID   NOT NULL REFERENCES sellers(id)  ON DELETE CASCADE,
  buyer_name  VARCHAR(100) NOT NULL,
  buyer_city  VARCHAR(100),
  rating      SMALLINT NOT NULL CHECK (rating BETWEEN 1 AND 5),
  comment     TEXT,
  created_at  TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_reviews_listing_id ON reviews(listing_id);
CREATE INDEX IF NOT EXISTS idx_reviews_seller_id  ON reviews(seller_id);

-- ─────────────────────────────────────────
-- MESSAGES
-- ─────────────────────────────────────────
CREATE TABLE IF NOT EXISTS messages (
  id          BIGSERIAL PRIMARY KEY,
  listing_id  BIGINT       REFERENCES listings(id) ON DELETE SET NULL,
  seller_id   UUID   NOT NULL REFERENCES sellers(id) ON DELETE CASCADE,
  buyer_email VARCHAR(255) NOT NULL,
  buyer_name  VARCHAR(255) NOT NULL,
  subject     VARCHAR(255) NOT NULL,
  body        TEXT         NOT NULL,
  is_read     BOOLEAN      DEFAULT false,
  created_at  TIMESTAMPTZ  DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_messages_seller_id  ON messages(seller_id);
CREATE INDEX IF NOT EXISTS idx_messages_listing_id ON messages(listing_id);

-- ─────────────────────────────────────────
-- VIEW: listings joined with seller info
-- Used by /api/listings for single-query browse
-- ─────────────────────────────────────────
CREATE OR REPLACE VIEW listings_with_seller AS
SELECT
  l.id,
  l.title,
  l.category,
  l.city,
  l.province,
  l.price,
  l.compare_price,
  l.material,
  l.printer_type,
  l.pickup_available,
  l.custom_orders,
  l.tags,
  l.specs,
  l.image_urls,
  l.featured_image_url,
  l.avg_rating,
  l.total_reviews,
  l.is_new,
  l.is_on_sale,
  l.view_count,
  l.created_at,
  s.id          AS seller_id,
  s.shop_name,
  s.city        AS seller_city,
  s.province    AS seller_province,
  s.avg_rating  AS seller_rating,
  s.total_sales,
  s.is_verified
FROM  listings l
JOIN  sellers  s ON l.seller_id = s.id
WHERE l.is_active = true
AND   s.is_active = true;

-- ─────────────────────────────────────────
-- FUNCTION: update listing avg rating
-- Called after a new review is inserted
-- ─────────────────────────────────────────
CREATE OR REPLACE FUNCTION update_listing_rating(p_listing_id BIGINT)
RETURNS void LANGUAGE plpgsql AS $$
BEGIN
  UPDATE listings
  SET
    avg_rating    = (SELECT AVG(rating)   FROM reviews WHERE listing_id = p_listing_id),
    total_reviews = (SELECT COUNT(*)      FROM reviews WHERE listing_id = p_listing_id),
    updated_at    = NOW()
  WHERE id = p_listing_id;

  -- Also update seller avg
  UPDATE sellers
  SET
    avg_rating    = (
      SELECT AVG(r.rating)
      FROM reviews r
      JOIN listings l ON r.listing_id = l.id
      WHERE l.seller_id = sellers.id
    ),
    total_reviews = (
      SELECT COUNT(r.id)
      FROM reviews r
      JOIN listings l ON r.listing_id = l.id
      WHERE l.seller_id = sellers.id
    ),
    updated_at = NOW()
  WHERE id = (SELECT seller_id FROM listings WHERE id = p_listing_id);
END;
$$;

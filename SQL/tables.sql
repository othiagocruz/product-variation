-- Base product table
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    base_price DECIMAL(10,2),
    created_at TIMESTAMP DEFAULT NOW()
);

-- Product attributes/dimensions (color, size, flavor, etc.)
CREATE TABLE product_attributes (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE, -- 'color', 'size', 'flavor'
    display_name VARCHAR(100) NOT NULL -- 'Color', 'Size', 'Flavor'
);

-- Possible values for each attribute
CREATE TABLE attribute_values (
    id SERIAL PRIMARY KEY,
    attribute_id INTEGER REFERENCES product_attributes(id),
    value VARCHAR(100) NOT NULL, -- 'red', 'large', 'pumpkin spice'
    display_order INTEGER DEFAULT 0,
    UNIQUE(attribute_id, value)
);

-- Product variant combinations with specific pricing
CREATE TABLE product_variants (
    id SERIAL PRIMARY KEY,
    product_id INTEGER REFERENCES products(id),
    sku VARCHAR(100) UNIQUE NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INTEGER DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Links variants to their specific attribute values
CREATE TABLE variant_attributes (
    variant_id INTEGER REFERENCES product_variants(id) ON DELETE CASCADE,
    attribute_value_id INTEGER REFERENCES attribute_values(id),
    PRIMARY KEY (variant_id, attribute_value_id)
);

-- Optional: Price adjustments for specific attribute values
CREATE TABLE attribute_price_adjustments (
    id SERIAL PRIMARY KEY,
    product_id INTEGER REFERENCES products(id),
    attribute_value_id INTEGER REFERENCES attribute_values(id),
    adjustment DECIMAL(10,2) NOT NULL, -- +2.00, -1.50, etc.
    adjustment_type VARCHAR(10) DEFAULT 'fixed', -- 'fixed' or 'percentage'
    UNIQUE(product_id, attribute_value_id)
);

CREATE TABLE variant_images (
    id SERIAL PRIMARY KEY,
    variant_id INTEGER REFERENCES product_variants(id) ON DELETE CASCADE,
    image_url TEXT NOT NULL,
    image_type VARCHAR(50) DEFAULT 'main', -- 'main', 'thumbnail', 'gallery'
    display_order INTEGER DEFAULT 0,
    alt_text VARCHAR(255),
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_variant_images_variant_id ON variant_images(variant_id);
CREATE INDEX idx_variant_images_display_order ON variant_images(variant_id, display_order);
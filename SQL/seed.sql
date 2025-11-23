-- Clear existing data
TRUNCATE TABLE variant_attributes, product_variants, attribute_values, product_attributes, products RESTART IDENTITY CASCADE;

-- Insert Products
INSERT INTO products (name, description, base_price) VALUES 
('Artisan Chocolate', 'Premium handmade chocolates', 4.00),
('Gourmet Coffee', 'Specialty roasted coffee beans', 8.00),
('Organic Tea', 'Premium loose-leaf teas', 5.00),
('Handmade Soap', 'Natural artisanal soaps', 3.00),
('Ceramic Mug', 'Handcrafted ceramic mugs', 12.00),
('Bamboo Cutting Board', 'Eco-friendly kitchen essential', 15.00);

-- Insert Product Attributes
INSERT INTO product_attributes (name, display_name) VALUES 
('flavor', 'Flavor'),
('size', 'Size'),
('wrapping', 'Wrapping'),
('roast', 'Roast Level'),
('grind', 'Grind Type'),
('tea_type', 'Tea Type'),
('caffeine', 'Caffeine Level'),
('scent', 'Scent'),
('skin_type', 'Skin Type'),
('color', 'Color'),
('handle_type', 'Handle Type'),
('wood_type', 'Wood Type'),
('thickness', 'Thickness');

-- Insert Attribute Values (ONLY UNIQUE COMBINATIONS)
INSERT INTO attribute_values (attribute_id, value, display_order) VALUES 
-- Flavor attributes (attribute_id = 1)
(1, 'pumpkin spice', 1), (1, 'dark chocolate', 2), (1, 'milk chocolate', 3), (1, 'sea salt', 4),
-- Size attributes (attribute_id = 2) - ALL SIZES TOGETHER
(2, '2 oz', 1), (2, '8 oz', 2), (2, '12 oz', 3), (2, '16 oz', 4),
(2, '1 oz', 5), (2, '3 oz', 6), 
(2, 'single', 7), (2, '3-pack', 8),
(2, 'small (8x10")', 9), (2, 'medium (12x16")', 10), (2, 'large (18x24")', 11),
-- Wrapping attributes (attribute_id = 3)
(3, 'standard', 1), (3, 'gift', 2), (3, 'premium', 3),
-- Roast attributes (attribute_id = 4)
(4, 'light', 1), (4, 'medium', 2), (4, 'dark', 3), (4, 'espresso', 4),
-- Grind attributes (attribute_id = 5)
(5, 'whole bean', 1), (5, 'coarse', 2), (5, 'medium', 3), (5, 'fine', 4),
-- Tea Type attributes (attribute_id = 6)
(6, 'green tea', 1), (6, 'black tea', 2), (6, 'herbal', 3), (6, 'oolong', 4),
-- Caffeine attributes (attribute_id = 7)
(7, 'caffeine-free', 1), (7, 'low caffeine', 2), (7, 'high caffeine', 3),
-- Scent attributes (attribute_id = 8)
(8, 'lavender', 1), (8, 'eucalyptus', 2), (8, 'citrus', 3), (8, 'unscented', 4),
-- Skin Type attributes (attribute_id = 9)
(9, 'normal', 1), (9, 'dry', 2), (9, 'oily', 3), (9, 'sensitive', 4),
-- Color attributes (attribute_id = 10)
(10, 'white', 1), (10, 'black', 2), (10, 'blue', 3), (10, 'red', 4),
-- Handle Type attributes (attribute_id = 11)
(11, 'standard', 1), (11, 'ergonomic', 2), (11, 'wooden', 3),
-- Wood Type attributes (attribute_id = 12)
(12, 'bamboo', 1), (12, 'maple', 2), (12, 'walnut', 3),
-- Thickness attributes (attribute_id = 13)
(13, 'thin (0.5")', 1), (13, 'standard (0.75")', 2), (13, 'thick (1.5")', 3);

-- Insert Product Variants with REALISTIC pricing that varies by size/attributes
INSERT INTO product_variants (product_id, sku, price, stock_quantity) VALUES 
-- Chocolate variants (product_id = 1) - Price varies significantly by size
-- 2 oz: $4, 8 oz: $6, 12 oz: $8 (base), with small variations for flavor
(1, 'CHOC-PUMP-2-STD', 4.00, 50), 
(1, 'CHOC-PUMP-8-STD', 6.00, 30), 
(1, 'CHOC-PUMP-12-STD', 8.00, 20), 
(1, 'CHOC-DARK-2-STD', 4.00, 40),
(1, 'CHOC-DARK-8-STD', 6.00, 35), 
(1, 'CHOC-DARK-12-STD', 8.00, 25),
(1, 'CHOC-MILK-2-STD', 4.00, 45), 
(1, 'CHOC-MILK-8-STD', 6.00, 40),
(1, 'CHOC-SEASALT-2-STD', 4.50, 30),  -- Sea salt costs a bit more
(1, 'CHOC-SEASALT-8-STD', 6.50, 20),

-- Coffee variants (product_id = 2) - Price varies by size and roast
-- 8 oz: $8-10, 12 oz: $12-16, 16 oz: $16-20
(2, 'COF-LIGHT-WHOLE-8', 8.00, 60), 
(2, 'COF-LIGHT-WHOLE-12', 12.00, 40),
(2, 'COF-LIGHT-WHOLE-16', 16.00, 30),
(2, 'COF-MED-WHOLE-8', 8.50, 55), 
(2, 'COF-MED-WHOLE-12', 12.50, 45),
(2, 'COF-MED-WHOLE-16', 16.50, 25),
(2, 'COF-DARK-WHOLE-8', 9.00, 50), 
(2, 'COF-DARK-WHOLE-12', 13.00, 35),
(2, 'COF-DARK-WHOLE-16', 17.00, 20),
(2, 'COF-ESPRESSO-FINE-8', 10.00, 30),  -- Espresso costs more
(2, 'COF-ESPRESSO-FINE-12', 14.00, 25),
(2, 'COF-ESPRESSO-FINE-16', 18.00, 15),

-- Tea variants (product_id = 3) - Price varies by size
-- 1 oz: $5-6, 3 oz: $12-15
(3, 'TEA-GREEN-LOW-1', 5.00, 40), 
(3, 'TEA-GREEN-LOW-3', 12.00, 30),
(3, 'TEA-BLACK-HIGH-1', 5.50, 45), 
(3, 'TEA-BLACK-HIGH-3', 13.00, 35),
(3, 'TEA-HERBAL-FREE-1', 5.00, 50), 
(3, 'TEA-HERBAL-FREE-3', 12.00, 40),
(3, 'TEA-OOLONG-LOW-1', 6.00, 30),  -- Oolong costs more
(3, 'TEA-OOLONG-LOW-3', 15.00, 25),

-- Soap variants (product_id = 4) - Price varies by pack size
-- Single: $3-4, 3-pack: $8-10
(4, 'SOAP-LAVENDER-NORMAL-1', 3.00, 100), 
(4, 'SOAP-LAVENDER-NORMAL-3', 8.00, 60),
(4, 'SOAP-EUCALYPTUS-OILY-1', 3.50, 80), 
(4, 'SOAP-EUCALYPTUS-OILY-3', 9.00, 50),
(4, 'SOAP-CITRUS-DRY-1', 3.00, 90), 
(4, 'SOAP-CITRUS-DRY-3', 8.00, 55),
(4, 'SOAP-UNSCENTED-SENSITIVE-1', 4.00, 70),  -- Special formula costs more
(4, 'SOAP-UNSCENTED-SENSITIVE-3', 10.00, 40),

-- Mug variants (product_id = 5) - Price varies by size and handle type
-- 12 oz: $12-14, 16 oz: $14-18, 20 oz: $18-22
(5, 'MUG-WHITE-STD-12', 12.00, 30), 
(5, 'MUG-WHITE-STD-16', 14.00, 25),
(5, 'MUG-BLACK-STD-12', 12.00, 28), 
(5, 'MUG-BLACK-STD-16', 14.00, 22),
(5, 'MUG-BLUE-ERG-16', 16.00, 20),  -- Ergonomic costs more
(5, 'MUG-BLUE-ERG-20', 18.00, 15),
(5, 'MUG-RED-WOOD-16', 18.00, 18),  -- Wooden handle costs more
(5, 'MUG-RED-WOOD-20', 22.00, 12),

-- Cutting Board variants (product_id = 6) - Price varies by size, wood, and thickness
-- Small: $15-25, Medium: $25-50, Large: $50-80
(6, 'BOARD-BAMBOO-THIN-SM', 15.00, 20), 
(6, 'BOARD-BAMBOO-THIN-MD', 25.00, 15),
(6, 'BOARD-MAPLE-STD-SM', 25.00, 18),  -- Maple costs more than bamboo
(6, 'BOARD-MAPLE-STD-MD', 40.00, 12),
(6, 'BOARD-WALNUT-THICK-MD', 50.00, 10),  -- Walnut + thick = premium
(6, 'BOARD-WALNUT-THICK-LG', 80.00, 8);

-- Link variants to their attributes (variant_attributes)
INSERT INTO variant_attributes (variant_id, attribute_value_id) VALUES 
-- Chocolate variants (product_id = 1)
-- Flavor: pumpkin spice (1), dark chocolate (2), milk chocolate (3), sea salt (4)
-- Size: 2 oz (5), 8 oz (6), 12 oz (7)
-- Wrapping: standard (16)
(1, 1), (1, 5), (1, 16),   -- Pumpkin Spice, 2 oz, Standard
(2, 1), (2, 6), (2, 16),   -- Pumpkin Spice, 8 oz, Standard
(3, 1), (3, 7), (3, 16),   -- Pumpkin Spice, 12 oz, Standard
(4, 2), (4, 5), (4, 16),   -- Dark Chocolate, 2 oz, Standard
(5, 2), (5, 6), (5, 16),   -- Dark Chocolate, 8 oz, Standard
(6, 2), (6, 7), (6, 16),   -- Dark Chocolate, 12 oz, Standard
(7, 3), (7, 5), (7, 16),   -- Milk Chocolate, 2 oz, Standard
(8, 3), (8, 6), (8, 16),   -- Milk Chocolate, 8 oz, Standard
(9, 4), (9, 5), (9, 16),   -- Sea Salt, 2 oz, Standard
(10, 4), (10, 6), (10, 16), -- Sea Salt, 8 oz, Standard

-- Coffee variants (product_id = 2)
-- Roast: light (17), medium (18), dark (19), espresso (20)
-- Grind: whole bean (21), coarse (22), medium (23), fine (24)
-- Size: 8 oz (6), 12 oz (7), 16 oz (8)
(11, 17), (11, 21), (11, 6),  -- Light, Whole Bean, 8 oz
(12, 17), (12, 21), (12, 7),  -- Light, Whole Bean, 12 oz
(13, 17), (13, 21), (13, 8),  -- Light, Whole Bean, 16 oz
(14, 18), (14, 21), (14, 6),  -- Medium, Whole Bean, 8 oz
(15, 18), (15, 21), (15, 7),  -- Medium, Whole Bean, 12 oz
(16, 18), (16, 21), (16, 8),  -- Medium, Whole Bean, 16 oz
(17, 19), (17, 21), (17, 6),  -- Dark, Whole Bean, 8 oz
(18, 19), (18, 21), (18, 7),  -- Dark, Whole Bean, 12 oz
(19, 19), (19, 21), (19, 8),  -- Dark, Whole Bean, 16 oz
(20, 20), (20, 24), (20, 6),  -- Espresso, Fine, 8 oz
(21, 20), (21, 24), (21, 7),  -- Espresso, Fine, 12 oz
(22, 20), (22, 24), (22, 8),  -- Espresso, Fine, 16 oz

-- Tea variants (product_id = 3)
-- Tea Type: green tea (25), black tea (26), herbal (27), oolong (28)
-- Caffeine: caffeine-free (29), low caffeine (30), high caffeine (31)
-- Size: 1 oz (9), 3 oz (10)
(23, 25), (23, 30), (23, 9),  -- Green, Low Caffeine, 1 oz
(24, 25), (24, 30), (24, 10),  -- Green, Low Caffeine, 3 oz
(25, 26), (25, 31), (25, 9),  -- Black, High Caffeine, 1 oz
(26, 26), (26, 31), (26, 10),  -- Black, High Caffeine, 3 oz
(27, 27), (27, 29), (27, 9),  -- Herbal, Caffeine-free, 1 oz
(28, 27), (28, 29), (28, 10),  -- Herbal, Caffeine-free, 3 oz
(29, 28), (29, 30), (29, 9),  -- Oolong, Low Caffeine, 1 oz
(30, 28), (30, 30), (30, 10),  -- Oolong, Low Caffeine, 3 oz

-- Soap variants (product_id = 4)
-- Scent: lavender (32), eucalyptus (33), citrus (34), unscented (35)
-- Skin Type: normal (36), dry (37), oily (38), sensitive (39)
-- Size: single (11), 3-pack (12)
(31, 32), (31, 36), (31, 11),  -- Lavender, Normal, Single
(32, 32), (32, 36), (32, 12),  -- Lavender, Normal, 3-pack
(33, 33), (33, 38), (33, 11),  -- Eucalyptus, Oily, Single
(34, 33), (34, 38), (34, 12),  -- Eucalyptus, Oily, 3-pack
(35, 34), (35, 37), (35, 11),  -- Citrus, Dry, Single
(36, 34), (36, 37), (36, 12),  -- Citrus, Dry, 3-pack
(37, 35), (37, 39), (37, 11),  -- Unscented, Sensitive, Single
(38, 35), (38, 39), (38, 12),  -- Unscented, Sensitive, 3-pack

-- Mug variants (product_id = 5)
-- Color: white (40), black (41), blue (42), red (43)
-- Handle Type: standard (44), ergonomic (45), wooden (46)
-- Size: 12 oz (7), 16 oz (8), 20 oz (13)
(39, 40), (39, 44), (39, 7),  -- White, Standard, 12 oz
(40, 40), (40, 44), (40, 8),  -- White, Standard, 16 oz
(41, 41), (41, 44), (41, 7),  -- Black, Standard, 12 oz
(42, 41), (42, 44), (42, 8),  -- Black, Standard, 16 oz
(43, 42), (43, 45), (43, 8),  -- Blue, Ergonomic, 16 oz
(44, 42), (44, 45), (44, 13),  -- Blue, Ergonomic, 20 oz
(45, 43), (45, 46), (45, 8),  -- Red, Wooden, 16 oz
(46, 43), (46, 46), (46, 13),  -- Red, Wooden, 20 oz

-- Cutting Board variants (product_id = 6)
-- Wood Type: bamboo (47), maple (48), walnut (49)
-- Thickness: thin (50), standard (51), thick (52)
-- Size: small (14), medium (15), large (16)
(47, 47), (47, 50), (47, 14),  -- Bamboo, Thin, Small
(48, 47), (48, 50), (48, 15),  -- Bamboo, Thin, Medium
(49, 48), (49, 51), (49, 14),  -- Maple, Standard, Small
(50, 48), (50, 51), (50, 15),  -- Maple, Standard, Medium
(51, 49), (51, 52), (51, 15),  -- Walnut, Thick, Medium
(52, 49), (52, 52), (52, 16);  -- Walnut, Thick, Large


-- Insert placeholder images for all variants
INSERT INTO variant_images (variant_id, image_url, image_type, display_order, alt_text) VALUES 
-- Chocolate variants (1-10)
(1, 'https://picsum.photos/800/800?random=1', 'main', 0, 'Pumpkin Spice Chocolate - 2 oz'),
(1, 'https://picsum.photos/800/800?random=2', 'gallery', 1, 'Pumpkin Spice Chocolate packaging'),
(1, 'https://picsum.photos/800/800?random=3', 'gallery', 2, 'Pumpkin Spice Chocolate ingredients'),

(2, 'https://picsum.photos/800/800?random=4', 'main', 0, 'Pumpkin Spice Chocolate - 8 oz'),
(2, 'https://picsum.photos/800/800?random=5', 'gallery', 1, 'Pumpkin Spice Chocolate - 8 oz side view'),

(3, 'https://picsum.photos/800/800?random=6', 'main', 0, 'Pumpkin Spice Chocolate - 12 oz'),
(3, 'https://picsum.photos/800/800?random=7', 'gallery', 1, 'Pumpkin Spice Chocolate - 12 oz opened'),

(4, 'https://picsum.photos/800/800?random=8', 'main', 0, 'Dark Chocolate - 2 oz'),
(4, 'https://picsum.photos/800/800?random=9', 'gallery', 1, 'Dark Chocolate texture'),

(5, 'https://picsum.photos/800/800?random=10', 'main', 0, 'Dark Chocolate - 8 oz'),
(5, 'https://picsum.photos/800/800?random=11', 'gallery', 1, 'Dark Chocolate - 8 oz packaging'),

(6, 'https://picsum.photos/800/800?random=12', 'main', 0, 'Dark Chocolate - 12 oz'),
(6, 'https://picsum.photos/800/800?random=13', 'gallery', 1, 'Dark Chocolate - 12 oz gift box'),

(7, 'https://picsum.photos/800/800?random=14', 'main', 0, 'Milk Chocolate - 2 oz'),
(7, 'https://picsum.photos/800/800?random=15', 'gallery', 1, 'Milk Chocolate - 2 oz unwrapped'),

(8, 'https://picsum.photos/800/800?random=16', 'main', 0, 'Milk Chocolate - 8 oz'),
(8, 'https://picsum.photos/800/800?random=17', 'gallery', 1, 'Milk Chocolate - 8 oz pieces'),

(9, 'https://picsum.photos/800/800?random=18', 'main', 0, 'Sea Salt Chocolate - 2 oz'),
(9, 'https://picsum.photos/800/800?random=19', 'gallery', 1, 'Sea Salt Chocolate closeup'),

(10, 'https://picsum.photos/800/800?random=20', 'main', 0, 'Sea Salt Chocolate - 8 oz'),
(10, 'https://picsum.photos/800/800?random=21', 'gallery', 1, 'Sea Salt Chocolate - 8 oz packaging'),

-- Coffee variants (11-22)
(11, 'https://picsum.photos/800/800?random=22', 'main', 0, 'Light Roast Coffee - 8 oz'),
(11, 'https://picsum.photos/800/800?random=23', 'gallery', 1, 'Light Roast Coffee beans'),

(12, 'https://picsum.photos/800/800?random=24', 'main', 0, 'Light Roast Coffee - 12 oz'),
(12, 'https://picsum.photos/800/800?random=25', 'gallery', 1, 'Light Roast Coffee - 12 oz bag'),

(13, 'https://picsum.photos/800/800?random=26', 'main', 0, 'Light Roast Coffee - 16 oz'),
(13, 'https://picsum.photos/800/800?random=27', 'gallery', 1, 'Light Roast Coffee - 16 oz packaging'),

(14, 'https://picsum.photos/800/800?random=28', 'main', 0, 'Medium Roast Coffee - 8 oz'),
(14, 'https://picsum.photos/800/800?random=29', 'gallery', 1, 'Medium Roast Coffee beans'),

(15, 'https://picsum.photos/800/800?random=30', 'main', 0, 'Medium Roast Coffee - 12 oz'),
(15, 'https://picsum.photos/800/800?random=31', 'gallery', 1, 'Medium Roast Coffee - 12 oz bag'),

(16, 'https://picsum.photos/800/800?random=32', 'main', 0, 'Medium Roast Coffee - 16 oz'),
(16, 'https://picsum.photos/800/800?random=33', 'gallery', 1, 'Medium Roast Coffee - 16 oz packaging'),

(17, 'https://picsum.photos/800/800?random=34', 'main', 0, 'Dark Roast Coffee - 8 oz'),
(17, 'https://picsum.photos/800/800?random=35', 'gallery', 1, 'Dark Roast Coffee beans'),

(18, 'https://picsum.photos/800/800?random=36', 'main', 0, 'Dark Roast Coffee - 12 oz'),
(18, 'https://picsum.photos/800/800?random=37', 'gallery', 1, 'Dark Roast Coffee - 12 oz bag'),

(19, 'https://picsum.photos/800/800?random=38', 'main', 0, 'Dark Roast Coffee - 16 oz'),
(19, 'https://picsum.photos/800/800?random=39', 'gallery', 1, 'Dark Roast Coffee - 16 oz packaging'),

(20, 'https://picsum.photos/800/800?random=40', 'main', 0, 'Espresso Coffee - 8 oz'),
(20, 'https://picsum.photos/800/800?random=41', 'gallery', 1, 'Espresso Coffee fine grind'),

(21, 'https://picsum.photos/800/800?random=42', 'main', 0, 'Espresso Coffee - 12 oz'),
(21, 'https://picsum.photos/800/800?random=43', 'gallery', 1, 'Espresso Coffee - 12 oz bag'),

(22, 'https://picsum.photos/800/800?random=44', 'main', 0, 'Espresso Coffee - 16 oz'),
(22, 'https://picsum.photos/800/800?random=45', 'gallery', 1, 'Espresso Coffee - 16 oz packaging'),

-- Tea variants (23-30)
(23, 'https://picsum.photos/800/800?random=46', 'main', 0, 'Green Tea - 1 oz'),
(23, 'https://picsum.photos/800/800?random=47', 'gallery', 1, 'Green Tea leaves'),

(24, 'https://picsum.photos/800/800?random=48', 'main', 0, 'Green Tea - 3 oz'),
(24, 'https://picsum.photos/800/800?random=49', 'gallery', 1, 'Green Tea - 3 oz tin'),

(25, 'https://picsum.photos/800/800?random=50', 'main', 0, 'Black Tea - 1 oz'),
(25, 'https://picsum.photos/800/800?random=51', 'gallery', 1, 'Black Tea leaves'),

(26, 'https://picsum.photos/800/800?random=52', 'main', 0, 'Black Tea - 3 oz'),
(26, 'https://picsum.photos/800/800?random=53', 'gallery', 1, 'Black Tea - 3 oz packaging'),

(27, 'https://picsum.photos/800/800?random=54', 'main', 0, 'Herbal Tea - 1 oz'),
(27, 'https://picsum.photos/800/800?random=55', 'gallery', 1, 'Herbal Tea blend'),

(28, 'https://picsum.photos/800/800?random=56', 'main', 0, 'Herbal Tea - 3 oz'),
(28, 'https://picsum.photos/800/800?random=57', 'gallery', 1, 'Herbal Tea - 3 oz container'),

(29, 'https://picsum.photos/800/800?random=58', 'main', 0, 'Oolong Tea - 1 oz'),
(29, 'https://picsum.photos/800/800?random=59', 'gallery', 1, 'Oolong Tea leaves'),

(30, 'https://picsum.photos/800/800?random=60', 'main', 0, 'Oolong Tea - 3 oz'),
(30, 'https://picsum.photos/800/800?random=61', 'gallery', 1, 'Oolong Tea - 3 oz packaging'),

-- Soap variants (31-38)
(31, 'https://picsum.photos/800/800?random=62', 'main', 0, 'Lavender Soap - Single'),
(31, 'https://picsum.photos/800/800?random=63', 'gallery', 1, 'Lavender Soap unwrapped'),

(32, 'https://picsum.photos/800/800?random=64', 'main', 0, 'Lavender Soap - 3-pack'),
(32, 'https://picsum.photos/800/800?random=65', 'gallery', 1, 'Lavender Soap - 3-pack display'),

(33, 'https://picsum.photos/800/800?random=66', 'main', 0, 'Eucalyptus Soap - Single'),
(33, 'https://picsum.photos/800/800?random=67', 'gallery', 1, 'Eucalyptus Soap texture'),

(34, 'https://picsum.photos/800/800?random=68', 'main', 0, 'Eucalyptus Soap - 3-pack'),
(34, 'https://picsum.photos/800/800?random=69', 'gallery', 1, 'Eucalyptus Soap - 3-pack gift box'),

(35, 'https://picsum.photos/800/800?random=70', 'main', 0, 'Citrus Soap - Single'),
(35, 'https://picsum.photos/800/800?random=71', 'gallery', 1, 'Citrus Soap fresh'),

(36, 'https://picsum.photos/800/800?random=72', 'main', 0, 'Citrus Soap - 3-pack'),
(36, 'https://picsum.photos/800/800?random=73', 'gallery', 1, 'Citrus Soap - 3-pack arrangement'),

(37, 'https://picsum.photos/800/800?random=74', 'main', 0, 'Unscented Soap - Single'),
(37, 'https://picsum.photos/800/800?random=75', 'gallery', 1, 'Unscented Soap pure'),

(38, 'https://picsum.photos/800/800?random=76', 'main', 0, 'Unscented Soap - 3-pack'),
(38, 'https://picsum.photos/800/800?random=77', 'gallery', 1, 'Unscented Soap - 3-pack simple'),

-- Mug variants (39-46)
(39, 'https://picsum.photos/800/800?random=78', 'main', 0, 'White Ceramic Mug - 12 oz'),
(39, 'https://picsum.photos/800/800?random=79', 'gallery', 1, 'White Mug side view'),

(40, 'https://picsum.photos/800/800?random=80', 'main', 0, 'White Ceramic Mug - 16 oz'),
(40, 'https://picsum.photos/800/800?random=81', 'gallery', 1, 'White Mug - 16 oz with handle'),

(41, 'https://picsum.photos/800/800?random=82', 'main', 0, 'Black Ceramic Mug - 12 oz'),
(41, 'https://picsum.photos/800/800?random=83', 'gallery', 1, 'Black Mug side view'),

(42, 'https://picsum.photos/800/800?random=84', 'main', 0, 'Black Ceramic Mug - 16 oz'),
(42, 'https://picsum.photos/800/800?random=85', 'gallery', 1, 'Black Mug - 16 oz with coffee'),

(43, 'https://picsum.photos/800/800?random=86', 'main', 0, 'Blue Ergonomic Mug - 16 oz'),
(43, 'https://picsum.photos/800/800?random=87', 'gallery', 1, 'Blue Mug ergonomic handle'),

(44, 'https://picsum.photos/800/800?random=88', 'main', 0, 'Blue Ergonomic Mug - 20 oz'),
(44, 'https://picsum.photos/800/800?random=89', 'gallery', 1, 'Blue Mug - 20 oz large'),

(45, 'https://picsum.photos/800/800?random=90', 'main', 0, 'Red Wooden Handle Mug - 16 oz'),
(45, 'https://picsum.photos/800/800?random=91', 'gallery', 1, 'Red Mug wooden handle detail'),

(46, 'https://picsum.photos/800/800?random=92', 'main', 0, 'Red Wooden Handle Mug - 20 oz'),
(46, 'https://picsum.photos/800/800?random=93', 'gallery', 1, 'Red Mug - 20 oz with tea'),

-- Cutting Board variants (47-52)
(47, 'https://picsum.photos/800/800?random=94', 'main', 0, 'Bamboo Cutting Board - Small'),
(47, 'https://picsum.photos/800/800?random=95', 'gallery', 1, 'Bamboo Board grain detail'),

(48, 'https://picsum.photos/800/800?random=96', 'main', 0, 'Bamboo Cutting Board - Medium'),
(48, 'https://picsum.photos/800/800?random=97', 'gallery', 1, 'Bamboo Board - Medium size'),

(49, 'https://picsum.photos/800/800?random=98', 'main', 0, 'Maple Cutting Board - Small'),
(49, 'https://picsum.photos/800/800?random=99', 'gallery', 1, 'Maple Board wood grain'),

(50, 'https://picsum.photos/800/800?random=100', 'main', 0, 'Maple Cutting Board - Medium'),
(50, 'https://picsum.photos/800/800?random=101', 'gallery', 1, 'Maple Board - Medium with utensils'),

(51, 'https://picsum.photos/800/800?random=102', 'main', 0, 'Walnut Cutting Board - Medium'),
(51, 'https://picsum.photos/800/800?random=103', 'gallery', 1, 'Walnut Board rich color'),

(52, 'https://picsum.photos/800/800?random=104', 'main', 0, 'Walnut Cutting Board - Large'),
(52, 'https://picsum.photos/800/800?random=105', 'gallery', 1, 'Walnut Board - Large premium');
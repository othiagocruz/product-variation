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
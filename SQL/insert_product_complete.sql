CREATE OR REPLACE FUNCTION insert_product_complete(product_data JSON)
RETURNS JSON
LANGUAGE PLPGSQL
AS $$
DECLARE
    new_product_id INTEGER;
    variant_item JSON;
    attr_key TEXT;
    attr_value TEXT;
    variant_id INTEGER;
    attr_id INTEGER;
    value_id INTEGER;
BEGIN
    -- Insert main product
    INSERT INTO products (name, description, base_price)
    VALUES (
        product_data->>'name',
        product_data->>'description', 
        (product_data->>'base_price')::NUMERIC
    )
    RETURNING id INTO new_product_id;

    -- Process each variant
    FOR variant_item IN SELECT * FROM json_array_elements(product_data->'variants')
    LOOP
        -- Insert variant
        INSERT INTO product_variants (product_id, sku, price, stock_quantity)
        VALUES (
            new_product_id,
            variant_item->>'sku',
            (variant_item->>'price')::NUMERIC,
            COALESCE((variant_item->>'stock_quantity')::INTEGER, 0)
        )
        RETURNING id INTO variant_id;

        -- Process each attribute in the variant
        FOR attr_key, attr_value IN 
            SELECT * FROM json_each_text(variant_item->'attributes')
        LOOP
            -- Ensure attribute exists
            SELECT id INTO attr_id FROM product_attributes WHERE name = attr_key;
            IF attr_id IS NULL THEN
                INSERT INTO product_attributes (name, display_name)
                VALUES (attr_key, initcap(attr_key))
                RETURNING id INTO attr_id;
            END IF;

            -- Ensure attribute value exists
            SELECT id INTO value_id 
            FROM attribute_values 
            WHERE attribute_id = attr_id AND value = attr_value;
            
            IF value_id IS NULL THEN
                INSERT INTO attribute_values (attribute_id, value)
                VALUES (attr_id, attr_value)
                RETURNING id INTO value_id;
            END IF;

            -- Link variant to attribute value
            INSERT INTO variant_attributes (variant_id, attribute_value_id)
            VALUES (variant_id, value_id);
        END LOOP;
    END LOOP;

    RETURN json_build_object(
        'success', true,
        'product_id', new_product_id,
        'message', 'Product created successfully with all variants'
    );
END;
$$;
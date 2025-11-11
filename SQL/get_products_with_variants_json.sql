CREATE OR REPLACE FUNCTION get_products_with_variants_json()
RETURNS JSON
LANGUAGE SQL
AS $$
    WITH product_variants_data AS (
        SELECT 
            pv.product_id,
            json_agg(
                json_build_object(
                    'variant_id', pv.id,
                    'sku', pv.sku,
                    'price', pv.price,
                    'stock_quantity', pv.stock_quantity,
                    'stock_status', 
                        CASE 
                            WHEN pv.stock_quantity = 0 THEN 'Out of Stock'
                            WHEN pv.stock_quantity < 10 THEN 'Low Stock'
                            ELSE 'In Stock'
                        END,
                    'attributes', (
                        SELECT json_agg(
                            json_build_object(
                                'attribute_name', pa.name,
                                'attribute_value', av.value
                            )
                        )
                        FROM variant_attributes va
                        JOIN attribute_values av ON va.attribute_value_id = av.id
                        JOIN product_attributes pa ON av.attribute_id = pa.id
                        WHERE va.variant_id = pv.id
                    )
                )
            ) as variants
        FROM product_variants pv
        WHERE pv.is_active = TRUE
        GROUP BY pv.product_id
    ),
    product_aggregates AS (
        SELECT 
            p.id,
            p.name,
            p.description,
            COUNT(pv.id) as variant_count,
            MIN(pv.price) as min_price,
            MAX(pv.price) as max_price
        FROM products p
        JOIN product_variants pv ON p.id = pv.product_id AND pv.is_active = TRUE
        GROUP BY p.id, p.name, p.description
    )
    SELECT json_agg(
        json_build_object(
            'product_id', pa.id,
            'product_name', pa.name,
            'description', pa.description,
            'variant_count', pa.variant_count,
            'min_price', pa.min_price,
            'max_price', pa.max_price,
            'variants', COALESCE(pvd.variants, '[]'::json)
        )
        ORDER BY pa.name
    )
    FROM product_aggregates pa
    LEFT JOIN product_variants_data pvd ON pa.id = pvd.product_id;
$$;
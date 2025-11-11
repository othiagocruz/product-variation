## Product variations schema

**API endpoints:**

- Retrieve products:
  `https://tslpttwiuktvrtzcndfp.supabase.co/functions/v1/products-with-variants`
- Create new product:
  `https://tslpttwiuktvrtzcndfp.supabase.co/functions/v1/create-product`

**Product payload example:**

```json
{
  "name": "Granola bars",
  "description": "Natural vegan granola bars",
  "base_price": 5.0,
  "variants": [
    {
      "sku": "GRANOLA-BARS-SKU-1",
      "price": 5.5,
      "stock_quantity": 25,
      "attributes": {
        "flavor": "peanuts",
        "size": "2oz"
      }
    },
    {
      "sku": "GRANOLA-BARS-SKU-2",
      "price": 4.5,
      "stock_quantity": 10,
      "attributes": {
        "flavor": "raisin",
        "size": "2oz"
      }
    }
  ]
}
```

This will create the product, variants and its attributes if they do not exist.

**Request example:**

```bash
curl -L -X POST 'https://tslpttwiuktvrtzcndfp.supabase.co/functions/v1/create-product' \
  -H 'Authorization: Bearer SUPABASE_ANON_KEY' \
  -H 'Content-Type: application/json' \
  --data '{"name":"Product"}'
```

```bash
curl -L -X GET 'https://tslpttwiuktvrtzcndfp.supabase.co/functions/v1/products-with-variants' \
  -H 'Authorization: Bearer SUPABASE_ANON_KEY' \
  -H 'Content-Type: application/json'
```

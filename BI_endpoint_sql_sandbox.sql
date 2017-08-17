GET /api/v1/items/most_revenue ?quantity=x
returns the top x items ranked by total revenue generated

SELECT items.name, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue
FROM items
INNER JOIN invoice_items ON items.id = invoice_items.item_id
INNER JOIN invoices ON invoices.id = invoice_items.invoice_id
WHERE invoices.status = 'shipped'
GROUP BY items.name
ORDER BY revenue DESC
LIMIT 10

---------------------------------------------------------------------------

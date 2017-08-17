GET /api/v1/items/most_revenue ?quantity=x
returns the top x items ranked by total revenue generated

SELECT items.name, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue
FROM items
INNER JOIN invoice_items ON items.id = invoice_items.item_id
INNER JOIN invoices ON invoices.id = invoice_items.invoice_id
WHERE invoices.status = 'shipped'
GROUP BY items.id
ORDER BY revenue DESC
LIMIT 10

---------------------------------------------------------------------------
GET /api/v1/items/most_items?quantity=x
returns the top x item ranked by total number sold

SELECT items.name, sum(invoice_items.quantity) AS top_sold
FROM items
INNER JOIN invoice_items ON items.id = invoice_items.item_id
INNER JOIN invoices ON invoices.id = invoice_items.invoice_id
WHERE invoices.status = 'shipped'
GROUP BY items.id
ORDER BY top_sold DESC
LIMIT 10


---------------------------------------------------------------------------
GET /api/v1/items/:id/best_day
returns the date with the most sales for the given item using the invoice date.

If there are multiple days with equal number of sales, return the most recent day.

SELECT invoices.*
FROM invoices
INNER JOIN invoice_items ON invoices.id = invoice_items.invoice_id
INNER JOIN items ON items.id = invoice_items.item_id
WHERE items.id = #{id}
GROUP BY invoices.id
ORDER BY top_sold DESC
LIMIT 10

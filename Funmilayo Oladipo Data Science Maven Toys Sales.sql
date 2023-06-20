/*QUE 1 Which product categories drive the biggest profits? Is this the same across store
locations? */

WITH cte AS (
SELECT
p.product_id,
p.product_name AS products,
p.product_category AS categories,
p.product_cost,
p.product_price,
(product_price -product_cost) AS product_profit,
s.sales_id,
s.store_id,
s.unit,
(product_price -product_cost) *(s.sales_id) AS units_sold_profits,
ss.store_location AS location,
ss.store_city AS city,
ss.store_name AS store_name
FROM
products AS p
 JOIN
sales AS s
ON
p.product_id = s.product_id
JOIN
stores as ss
ON
ss.store_id = s.store_id
)

SELECT
cte.categories,
 cte.location,
 SUM (units_sold_profits) AS category_profit
FROM
cte
GROUP BY
cte.categories,
 cte.location
ORDER BY  category_profit DESC;


--The product category that drives the biggest profit is the TOY , and most of the profits are within DOWNTOWN--


--QUE 2: How much money is tied up in inventory at the toy stores? How long will it last?--
WITH ct AS (
Select
i.store_id AS storeid,
i.product_id,
i."stock_On_Hand",
p.product_name,
p.product_cost,
s.store_name AS storename,
(i."stock_On_Hand") * (p.product_cost) AS amount_tied
FROM
products as p
INNER JOIN
inventory AS i
ON
i.product_id = p.product_id
JOIN
stores AS s
ON
i.store_id = s.store_id
)

SELECT
ct.storeid,
ct.storename,
SUM (ct.amount_tied) AS total_amount_tied
FROM
ct
GROUP BY 
storeid,
storename;




--QUE 3 :Are sales being lost with out-of-stock products at certain locations?--

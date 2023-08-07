USE sales;
SELECT COUNT(*) FROM transactions;
SELECT COUNT(*) FROM customers;

SELECT * FROM transactions
WHERE currency = 'USD';

SELECT SUM(t.sales_amount)
FROM transactions t
INNER JOIN date d ON t.order_date = d.date
WHERE d.year = 2020 AND market_code = 'Mark001';


SELECT
	c.custmer_name AS customer_name,
	c.customer_type,
	t.order_date,
	t.sales_qty,
    t.currency,
	CASE WHEN t.currency = 'USD' THEN (t.sales_amount*82.54) ELSE (t.sales_amount*1) END AS sales_amount,
	p.product_type,
	m.markets_name,
	m.zone,
	CASE WHEN d.year = NULL OR d.year = '' THEN YEAR(d.date) ELSE d.year END AS year,
	CASE WHEN d.month_name = NULL OR d.month_name = '' THEN MONTHNAME(d.date) ELSE d.month_name END AS month_name,
	d.date,
	d.cy_date
FROM customers c
    JOIN transactions t ON c.customer_code = t.customer_code
    JOIN products p ON t.product_code = p.product_code
    JOIN markets m ON t.market_code = m.markets_code
    JOIN date d ON t.order_date = d.date
WHERE t.sales_amount > 0 AND m.zone != '';
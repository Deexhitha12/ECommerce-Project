SELECT * FROM `e-commerce`.olist_orders_dataset;

-- 1. Weekday Vs Weekend (order_purchase_timestamp) Payment Statistics

SELECT 
   DateType,
    p.payment_type,
    COUNT(o.order_id) AS order_count,
    round(SUM(p.payment_value)) AS total_payment
FROM 
    olist_orders_dataset o
JOIN 
    olist_order_payments_dataset p ON o.order_id = p.order_id
GROUP BY 
   DateType, p.payment_type;

-- 2. Number of Orders with review score 5 and payment type as credit card.

SELECT 
count(o.order_id) as order_count
FROM 
   olist_orders_dataset o
JOIN 
    olist_order_reviews_dataset r ON o.order_id = r.order_id
JOIN 
    olist_order_payments_dataset p ON o.order_id = p.order_id
WHERE 
  review_score = 5
    AND p.payment_type = 'credit_card';
 
-- 3. Average number of days taken for order_delivered_customer_date for pet_shop

    SELECT
 round(avg(i.shipping_limit_date ))AS avg_delivery_days
FROM 
olist_order_items_dataset i
join 
 olist_products_dataset p ON i.product_id= p.product_id
WHERE 
p.product_category_name = 'pet_shop';


-- 4. Average price and payment values from customers of sao paulo city
SELECT 
    round(AVG(i.price)) AS average_price,
    round(AVG(p.payment_value))AS average_payment_value
FROM 
    olist_sellers_dataset s
JOIN 
    olist_order_items_dataset i ON s.seller_id = i.seller_id
JOIN 
    olist_order_payments_dataset p ON i.order_id = p.order_id
WHERE 
    s.seller_city = 'sao paulo';
    
-- 5.Relationship between shipping days (order_delivered_customer_date - order_purchase_timestamp) Vs review scores.

SELECT 
   round(avg(o.shippingdays)) as shipping_days,
   r.review_score 
    FROM 
    olist_orders_dataset o
    join 
   olist_order_reviews_dataset r on o.order_id = r.order_id
   group by r.review_score;



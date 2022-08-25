WITH yesterday as (
SELECT c.created_date, c.id, c.merchant_id, 
c.payment_method_id, c.charged_amount, c.captured, 
c.failure_code, c.card_id, p.description, m.merchant_name, 
d.Category, card.card_country
FROM charges_cleaned c
LEFT JOIN payment_method p
ON c.payment_method_id = p.id
LEFT JOIN merchants_cleaned m
ON c.merchant_id = m.merchant_id
LEFT JOIN disputes_cleaned d
ON c.id = d.charge_id
LEFT JOIN cards_cleaned card
ON c.card_id = card.card_id
WHERE c.created_date = '2022-07-14'
),
yesterday_fail as (
SELECT c.created_date, c.id, c.merchant_id, 
c.payment_method_id, c.charged_amount, c.captured, 
c.failure_code, c.card_id, p.description, m.merchant_name, m.merchant_category, 
d.Category, card.card_country
FROM charges_cleaned c
LEFT JOIN payment_method p
ON c.payment_method_id = p.id
LEFT JOIN merchants_cleaned m
ON c.merchant_id = m.merchant_id
LEFT JOIN disputes_cleaned d
ON c.id = d.charge_id
LEFT JOIN cards_cleaned card
ON c.card_id = card.card_id
WHERE c.created_date = '2022-07-14' AND captured = 'False'
)
SELECT merchant_name, merchant_category, COUNT(*)*100/(SELECT COUNT(*) FROM yesterday) as '% Failure'
FROM yesterday_fail
GROUP BY merchant_name
ORDER BY 3 DESC;






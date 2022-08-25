WITH ytd as (
SELECT merchant_name, created_date, charged_amount
FROM charges_cleaned c
LEFT JOIN payment_method p
ON c.payment_method_id = p.id
LEFT JOIN merchants_cleaned m
ON c.merchant_id = m.merchant_id
LEFT JOIN disputes_cleaned d
ON c.id = d.charge_id
LEFT JOIN cards_cleaned card
ON c.card_id = card.card_id
WHERE merchant_name NOT IN (SELECT merchant_name
FROM charges_cleaned c
LEFT JOIN payment_method p
ON c.payment_method_id = p.id
LEFT JOIN merchants_cleaned m
ON c.merchant_id = m.merchant_id
LEFT JOIN disputes_cleaned d
ON c.id = d.charge_id
LEFT JOIN cards_cleaned card
ON c.card_id = card.card_id
WHERE created_date >= '2022-04-15')
AND created_date >= '2022-01-01' AND captured = 'True'
ORDER BY created_date DESC
)
SELECT merchant_name, created_date, SUM(charged_amount) as 'PV(YTD)'
FROM ytd
GROUP BY merchant_name;
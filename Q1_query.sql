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
ON c.card_id = card.card_id;
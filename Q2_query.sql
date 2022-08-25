SELECT strftime("%Y",c.created_date) as Year, p.description as Method, SUM(c.charged_amount) as PV
FROM charges_cleaned c
LEFT JOIN payment_method p
ON c.payment_method_id = p.id
LEFT JOIN merchants_cleaned m
ON c.merchant_id = m.merchant_id
LEFT JOIN disputes_cleaned d
ON c.id = d.charge_id
LEFT JOIN cards_cleaned card
ON c.card_id = card.card_id
GROUP BY Year, method;
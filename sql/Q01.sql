#------------------QUERY 1----------------#
SELECT 
    YEAR(e.start_time) AS festival_year,
    SUM(CASE WHEN t.purchase_method = 'cash' THEN t.cost ELSE 0 END) AS cash,
    SUM(CASE WHEN t.purchase_method = 'debit_card' THEN t.cost ELSE 0 END) AS debit_card,
    SUM(CASE WHEN t.purchase_method = 'credit_card' THEN t.cost ELSE 0 END) AS credit_card,
    SUM(CASE WHEN t.purchase_method = 'bank_account' THEN t.cost ELSE 0 END) AS bank_account,
    SUM(CASE WHEN t.purchase_method = 'non_cash' THEN t.cost ELSE 0 END) AS non_cash,
    SUM(t.cost) AS total_earnings
FROM ticket t 
JOIN event e ON t.event_id = e.event_id
GROUP BY festival_year
ORDER BY festival_year;
#-------------------QUERY 5----------------#
SELECT 
a.artist_id,
a.artist_name,
a.pseudonym,
TIMESTAMPDIFF(YEAR, a.birth_date, p.start_time) AS age,
COUNT(DISTINCT YEAR(p.start_time)) AS total_festival_participations
FROM artist a
JOIN performance_artist pa ON a.artist_id = pa.artist_id
JOIN performance p ON pa.performance_id = p.performance_id
WHERE TIMESTAMPDIFF(YEAR, a.birth_date, NOW()) < 30
GROUP BY a.artist_id, a.artist_name, a.pseudonym
ORDER BY total_festival_participations DESC, age;

#-------------------QUERY 13----------------#
SELECT 
a.artist_id,
a.artist_name,
COUNT(DISTINCT l.continent) AS num_continents
FROM artist a
JOIN performance_artist pa ON a.artist_id = pa.artist_id
JOIN performance p ON pa.performance_id = p.performance_id
JOIN event e ON p.event_id = e.event_id
JOIN festival f ON e.festival_id = f.festival_id
JOIN location l ON f.location_id = l.location_id
GROUP BY a.artist_id, a.artist_name
HAVING num_continents>=3
ORDER BY num_continents DESC;
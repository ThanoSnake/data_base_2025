#-------------------QUERY 11----------------#

WITH tot_apps_of_artists AS (
SELECT 
a.artist_id,
a.artist_name,
COUNT(DISTINCT f.festival_id) AS total_artist_appearances
FROM artist a 
JOIN performance_artist pa ON a.artist_id = pa.artist_id
JOIN performance p ON pa.performance_id = p.performance_id
JOIN event e ON p.event_id = e.event_id
JOIN festival f ON e.festival_id = f.festival_id
GROUP BY a.artist_id, a.artist_name
)
  
SELECT * 
FROM tot_apps_of_artists 
WHERE total_artist_appearances - (SELECT MAX(total_artist_appearances) FROM tot_apps_of_artists ) <= -5 
ORDER BY total_artist_appearances DESC;
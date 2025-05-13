#-------------------QUERY 14----------------#
WITH gen_year_num AS(
SELECT 
ag.genre,
YEAR(p.start_time) AS year,
COUNT(DISTINCT p.performance_id) AS num_genre_annually
FROM artist_genre ag
JOIN performance_artist pa ON ag.artist_id = pa.artist_id
JOIN performance p ON pa.performance_id = p.performance_id
GROUP BY genre,YEAR(p.start_time)
HAVING COUNT(DISTINCT p.performance_id) >= 3
)
SELECT 
gyn1.genre,
gyn1.year AS year1,
gyn2.year AS year2,
gyn1.num_genre_annually
FROM gen_year_num gyn1
JOIN gen_year_num gyn2 
    ON gyn1.genre = gyn2.genre AND gyn1.year = gyn2.year + 1
WHERE gyn1.num_genre_annually = gyn2.num_genre_annually;

#-------------------QUERY 10----------------#
WITH genre_pairs AS (
    SELECT DISTINCT
        ag1.artist_id,
        LEAST(ag1.genre, ag2.genre) AS genre1,
        GREATEST(ag1.genre, ag2.genre) AS genre2
    FROM artist_genre ag1 
    JOIN artist_genre ag2 
        ON ag1.artist_id = ag2.artist_id
    WHERE ag1.genre < ag2.genre
),
pair_festivals AS (
    SELECT DISTINCT
        f.festival_id,
        gp.genre1,
        gp.genre2
    FROM genre_pairs gp
    JOIN performance_artist pa ON gp.artist_id = pa.artist_id
    JOIN performance p ON pa.performance_id = p.performance_id
    JOIN event e ON p.event_id = e.event_id
    JOIN festival f ON e.festival_id = f.festival_id
)
SELECT 
    genre1,
    genre2,
    COUNT(DISTINCT festival_id) AS festival_count
FROM pair_festivals
GROUP BY genre1, genre2
ORDER BY festival_count DESC
LIMIT 3;
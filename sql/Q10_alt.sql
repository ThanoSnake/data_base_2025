#-------------------QUERY 10 PER FESTIVAL SOLUTION 2----------------#
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
    SELECT
        f.festival_id,
        f.festival_name,
        gp.genre1,
        gp.genre2,
        COUNT(DISTINCT gp.artist_id) AS artist_count
    FROM genre_pairs gp
    JOIN performance_artist pa ON gp.artist_id = pa.artist_id
    JOIN performance p ON pa.performance_id = p.performance_id
    JOIN event e ON p.event_id = e.event_id
    JOIN festival f ON e.festival_id = f.festival_id
    GROUP BY f.festival_id, f.festival_name, gp.genre1, gp.genre2
),
ranked_pairs AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY festival_id
            ORDER BY artist_count DESC
        ) AS rank
    FROM pair_festivals
)
SELECT
    festival_id,
    festival_name,
    genre1,
    genre2,
    artist_count AS genre_tuple_count
FROM ranked_pairs
WHERE rank <= 3
ORDER BY festival_id, rank;
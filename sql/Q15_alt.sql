#---QUERY 15/TOP5 reviews για καθε καλλιτεχνη ξεχωριστα. Αν ενας visitor πολλαπλα reviews για τον ιδιο καλλιτεχνη τοτε AVG των reviews---#
WITH visitor_artist_avg AS (
    SELECT 
        a.artist_id,
        a.artist_name,
        v.visitor_id,
        v.visitor_name,
        AVG(r.artist_performance) AS avg_artist_score
    FROM review r
    JOIN visitor v ON r.visitor_id = v.visitor_id
    JOIN performance_artist pa ON r.performance_id = pa.performance_id
    JOIN artist a ON pa.artist_id = a.artist_id
    GROUP BY a.artist_id, a.artist_name, v.visitor_id, v.visitor_name
),
ranked_reviews AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY artist_id 
            ORDER BY avg_artist_score DESC
        ) AS rn
    FROM visitor_artist_avg
)
SELECT 
artist_id,
artist_name,
visitor_id,
visitor_name,
avg_artist_score
FROM ranked_reviews
WHERE rn <= 5
ORDER BY artist_id, avg_artist_score DESC;
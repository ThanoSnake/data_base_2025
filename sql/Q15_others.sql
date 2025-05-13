#--QUERY 15/top5 reviews συνολικα. Αν ενας visitor πολλαπλα reviews για τον ιδιο καλλιτεχνη τοτε καθε review ξεχωριστα---#
SELECT
v.visitor_id,
v.visitor_name,
a.artist_id,
a.artist_name,
r.artist_performance 
FROM visitor v
JOIN review r ON v.visitor_id = r.visitor_id
JOIN performance_artist pa ON r.performance_id =  pa.performance_id
JOIN artist a ON pa.artist_id = a.artist_id
ORDER BY r.artist_performance DESC 
LIMIT 5;


#----QUERY 15/top5 reviews συνολικα. Αν ενας visitor πολλαπλα reviews για τον ιδιο καλλιτεχνη τοτε AVG των reviews ως προς συνολο βαθμολογιας-#
SELECT 
    v.visitor_id,
    v.visitor_name,
    a.artist_id,
    a.artist_name,
    AVG(
        r.artist_performance + 
        r.sound_lighting + 
        r.stage_presence + 
        r.organization + 
        r.overall_impression
    ) AS average_score
FROM visitor v
JOIN review r ON v.visitor_id = r.visitor_id
JOIN performance_artist pa ON r.performance_id = pa.performance_id
JOIN artist a ON pa.artist_id = a.artist_id
GROUP BY v.visitor_id, v.visitor_name, a.artist_id, a.artist_name
ORDER BY average_score DESC
LIMIT 5;

#--QUERY 15/top5 reviews συνολικα. Αν ενας visitor πολλαπλα reviews για τον ιδιο καλλιτεχνη τοτε AVG των reviews----------------#
SELECT 
    v.visitor_id,
    v.visitor_name,
    a.artist_id,
    a.artist_name,
    AVG(
        r.artist_performance
    ) AS average_score
FROM visitor v
JOIN review r ON v.visitor_id = r.visitor_id
JOIN performance_artist pa ON r.performance_id = pa.performance_id
JOIN artist a ON pa.artist_id = a.artist_id
GROUP BY v.visitor_id, v.visitor_name, a.artist_id, a.artist_name
ORDER BY average_score DESC
LIMIT 5;

#----QUERY 15/top5 reviews για συγκεκριμενο καλλιτεχνη. Αν ενας visitor πολλαπλα reviews για τον ιδιο καλλιτεχνη τοτε AVG των reviews ως προς συνολο βαθμολογιας----#
DELIMITER //
DROP PROCEDURE IF EXISTS top5_reviews_for_artist;
CREATE PROCEDURE top5_reviews_for_artist (
    IN in_artist_id INT
)
BEGIN
    SELECT 
        v.visitor_id,
        v.visitor_name,
        a.artist_id,
        a.artist_name,
        AVG(
        r.artist_performance + 
        r.sound_lighting + 
        r.stage_presence + 
        r.organization + 
        r.overall_impression
    ) AS average_score
    FROM visitor v
    JOIN review r ON v.visitor_id = r.visitor_id
    JOIN performance_artist pa ON r.performance_id = pa.performance_id
    JOIN artist a ON pa.artist_id = a.artist_id
    WHERE a.artist_id = in_artist_id
    GROUP BY v.visitor_id, v.visitor_name, a.artist_id, a.artist_name
    ORDER BY average_score DESC
    LIMIT 5;
END //
DELIMITER ;


#---QUERY 15/TOP5 reviews για καθε καλλιτεχνη ξεχωριστα. Αν ενας visitor πολλαπλα reviews για τον ιδιο καλλιτεχνη καθε review ξεχωριστα----#
SELECT *
FROM (
    SELECT 
        a.artist_id,
        a.artist_name,
        v.visitor_id,
        v.visitor_name,
        r.review_id,
        r.performance_id,
        r.artist_performance AS artist_score,
        ROW_NUMBER() OVER (
            PARTITION BY artist_id 
            ORDER BY artist_score DESC
        ) AS rn
    FROM review r
    JOIN visitor v ON r.visitor_id = v.visitor_id
    JOIN performance_artist pa ON r.performance_id = pa.performance_id
    JOIN artist a ON pa.artist_id = a.artist_id
) AS ranked_reviews
WHERE rn <= 5
ORDER BY artist_id, artist_score DESC;

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


#-------------------QUERY 2----------------#
DELIMITER //
DROP PROCEDURE IF EXISTS get_artists_by_genre_and_year_cte;
CREATE PROCEDURE get_artists_by_genre_and_year_cte (
    IN in_festival_year INT,
    IN in_genre VARCHAR(50)
)
BEGIN
    WITH artists_in_genre AS (
        SELECT 
            a.artist_id,
            a.artist_name,
            a.pseudonym,
            ag.genre,
            ag.subgenre
        FROM artist a
        JOIN artist_genre ag ON a.artist_id = ag.artist_id
        WHERE ag.genre = in_genre
    ),
    artists_participated AS (
        SELECT DISTINCT pa.artist_id
        FROM performance_artist pa
        JOIN performance p ON pa.performance_id = p.performance_id
        WHERE YEAR(p.start_time) = in_festival_year
    )
    SELECT 
        ag.artist_id,
        ag.artist_name,
        ag.pseudonym,
        ag.genre,
        ag.subgenre,
        CASE 
            WHEN ap.artist_id IS NOT NULL THEN 'YES'
            ELSE 'NO'
        END AS participated_in_year
    FROM artists_in_genre ag
    LEFT JOIN artists_participated ap ON ag.artist_id = ap.artist_id
    ORDER BY participated_in_year DESC, ag.artist_id;
END //
DELIMITER ;


#-------------------QUERY 3----------------#
WITH warmup_performances AS (
    SELECT
        pa.artist_id,
        a.artist_name,
        a.pseudonym,
        YEAR(p.start_time) AS festival_year,
        COUNT(*) AS warmup_count
    FROM artist a
    JOIN performance_artist pa ON a.artist_id = pa.artist_id
    JOIN performance p ON pa.performance_id = p.performance_id
    WHERE p.type_of_performance = 'warm up'
    GROUP BY a.artist_id, a.artist_name, a.pseudonym, YEAR(p.start_time)
),
warmup_filtered AS (
    SELECT *
    FROM warmup_performances
    WHERE warmup_count > 2
)
SELECT *
FROM warmup_filtered
ORDER BY festival_year, warmup_count DESC;


#-------------------QUERY 4----------------#

DELIMITER //
DROP PROCEDURE IF EXISTS avg_review_of_artist_1;
CREATE PROCEDURE avg_review_of_artist_1 (
    IN in_artist_name VARCHAR(100)   
)
BEGIN
EXPLAIN SELECT a.artist_id,
a.artist_name,
a.pseudonym,
AVG(r.artist_performance) AS avg_artist_performance_review,
AVG(r.overall_impression) AS avg_overall_impression_review
FROM review r
JOIN performance_artist pa ON r.performance_id = pa.performance_id
JOIN artist a ON pa.artist_id = a.artist_id
WHERE a.artist_name = in_artist_name;
END//
DELIMITER ;

#-----------QUERY 4/with FORCE INDEX-----------#
DELIMITER //
DROP PROCEDURE IF EXISTS avg_review_of_artist_2;
CREATE PROCEDURE avg_review_of_artist_2 (
    IN in_artist_name VARCHAR(100)    
)
BEGIN
EXPLAIN SELECT a.artist_id,
a.artist_name,
a.pseudonym,
AVG(r.artist_performance) AS avg_artist_performance_review,
AVG(r.overall_impression) AS avg_overall_impression_review
FROM review r
JOIN performance_artist pa ON r.performance_id = pa.performance_id
JOIN artist a FORCE INDEX (idx_artist_name) ON pa.artist_id = a.artist_id
WHERE a.artist_name = in_artist_name;
END//
DELIMITER ;





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
WHERE TIMESTAMPDIFF(YEAR, a.birth_date, p.start_time) < 30
GROUP BY a.artist_id, a.artist_name, a.pseudonym
ORDER BY total_festival_participations DESC, age;




#-------------------QUERY 6----------------#
DELIMITER //
DROP PROCEDURE IF EXISTS avg_review_of_events_of_a_visitor_1;
CREATE PROCEDURE avg_review_of_events_of_a_visitor_1 (
    IN in_visitor_name VARCHAR(100) 
)
BEGIN
    EXPLAIN SELECT 
    v.visitor_id,
    v.visitor_name,
    e.event_name,
    AVG(r.artist_performance) AS avg_artist_performance_review,
    AVG(r.sound_lighting) AS avg_sound_lighting_review,
    AVG(r.stage_presence) AS avg_stage_presence_review,
    AVG(r.organization) AS avg_overall_impression_review,
    AVG(r.overall_impression) AS avg_overall_impression_review,
    (AVG(r.artist_performance) + AVG(r.sound_lighting)  + AVG(r.stage_presence) + AVG(r.organization) + AVG(r.overall_impression))/5 AS general_avg 
    FROM visitor v
    JOIN review r ON v.visitor_id = r.visitor_id
    JOIN performance p ON r.performance_id = p.performance_id
    JOIN event e ON p.event_id = e.event_id
    WHERE visitor_name = in_visitor_name
    GROUP BY v.visitor_id, v.visitor_name, e.event_name;
END//
DELIMITER ;



DELIMITER //
DROP PROCEDURE IF EXISTS avg_review_of_events_of_a_visitor_2;
CREATE PROCEDURE avg_review_of_events_of_a_visitor_2 (
    IN in_visitor_name VARCHAR(100) 
)
BEGIN
    EXPLAIN SELECT 
    v.visitor_id,
    v.visitor_name,
    e.event_name,
    AVG(r.artist_performance) AS avg_artist_performance_review,
    AVG(r.sound_lighting) AS avg_sound_lighting_review,
    AVG(r.stage_presence) AS avg_stage_presence_review,
    AVG(r.organization) AS avg_overall_impression_review,
    AVG(r.overall_impression) AS avg_overall_impression_review,
    (AVG(r.artist_performance) + AVG(r.sound_lighting)  + AVG(r.stage_presence) + AVG(r.organization) + AVG(r.overall_impression))/5 AS general_avg 
    FROM visitor v FORCE INDEX (idx_visitor_name)
    JOIN review r ON v.visitor_id = r.visitor_id
    JOIN performance p ON r.performance_id = p.performance_id
    JOIN event e ON p.event_id = e.event_id
    WHERE visitor_name = in_visitor_name
    GROUP BY v.visitor_id, v.visitor_name, e.event_name;
END//
DELIMITER ;


#-------------------QUERY 7----------------#
WITH temp1 AS (
    SELECT staff_id,
        CASE WHEN experience_level = 'Specialist' THEN 1 
            WHEN experience_level = 'Beginner' THEN 2
            WHEN experience_level = 'Intermediate' THEN 3 
            WHEN experience_level = 'Experienced' THEN 4 
            WHEN experience_level = 'Very Experienced' THEN 5
        END AS experience_level_numerated
        FROM staff 
        WHERE job = 'technical'
),
temp2 AS(
    SELECT 
    f.festival_id,
    f.festival_name,
    AVG(CAST(t1.experience_level_numerated AS FLOAT)) AS tech_experience_level_score
    FROM temp1 t1
    JOIN staff_event se ON t1.staff_id = se.staff_id
    JOIN event e ON se.event_id = e.event_id
    JOIN festival f ON e.festival_id = f.festival_id
    GROUP BY f.festival_id, f.festival_name
)
SELECT *
FROM temp2
ORDER BY tech_experience_level_score
LIMIT 1;

#-------------------QUERY 8----------------#
DELIMITER //
DROP PROCEDURE IF EXISTS free_assistant_staff_for_date;
CREATE PROCEDURE free_assistant_staff_for_date (
    IN specific_date DATE
)
BEGIN
    WITH assistant_staff AS (
        SELECT * FROM staff WHERE job = 'assistant'
    ),

    occupied_assistant_staff AS(
        SELECT s.staff_id
        FROM staff s
        JOIN staff_event se ON s.staff_id = se.staff_id
        JOIN event e ON se.event_id = e.event_id
        WHERE DATE(e.start_time) = specific_date
    )

    SELECT * FROM assistant_staff WHERE staff_id 
    NOT IN (
        SELECT staff_id FROM occupied_assistant_staff
    );
END//
DELIMITER ;

    


#-------------------QUERY 8 ALTERNATIVE SOLUTION----------------WRONG AT THE MOMENT#
DELIMITER //
DROP PROCEDURE IF EXISTS free_assistant_staff_for_date;
CREATE PROCEDURE free_assistant_staff_for_date (
    IN specific_date DATE
)
BEGIN
    SELECT DISTINCT s.*
    FROM staff s
    LEFT JOIN staff_event se ON s.staff_id = se.staff_id
    LEFT JOIN event e ON se.event_id = e.event_id 
        AND DATE(e.start_time) = specific_date
    WHERE s.job = 'assistant'
      AND e.event_id IS NULL;
END //
DELIMITER ;

#-------------------QUERY 9----------------#

WITH visitors_min_appearances AS (
    SELECT 
        v.visitor_id,
        v.visitor_name,
        YEAR(e.start_time) AS year,
        COUNT(DISTINCT e.event_id) AS num_events
    FROM visitor v
    JOIN ticket t ON v.visitor_id = t.visitor_id
    JOIN event e ON t.event_id = e.event_id
    WHERE t.active = FALSE
    GROUP BY v.visitor_id, YEAR(e.start_time)
    HAVING num_events > 3
),
grouped_visitors AS (
    SELECT
        year,
        num_events,
        GROUP_CONCAT(v.visitor_name ORDER BY v.visitor_name) AS visitors
    FROM visitors_min_appearances v
    GROUP BY year, num_events
)
SELECT * FROM grouped_visitors
ORDER BY year, num_events;


#-------------------QUERY 9/alternative----------------#
WITH visitors_min_appearances AS (
SELECT 
    v.visitor_id,
    v.visitor_name,
    YEAR(e.start_time) AS year,
    COUNT(DISTINCT e.event_id) AS num_events
FROM visitor v
JOIN ticket t ON v.visitor_id = t.visitor_id
JOIN event e ON t.event_id = e.event_id
WHERE t.active = FALSE
GROUP BY v.visitor_id, YEAR(e.start_time)
HAVING num_events > 3
)
SELECT DISTINCT
vma1.visitor_id,
vma1.visitor_name,
vma1.year,
vma1.num_events
FROM visitors_min_appearances vma1
JOIN visitors_min_appearances vma2 ON vma1.year = vma2.year AND vma1.num_events = vma2.num_events AND vma1.visitor_id != vma2.visitor_id
ORDER BY year;
  

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


#-------------------QUERY 12/Αναλυτικη πληροφορια για το ποιο staff και σε ποια ημερα επιλεγεται----------------#
DELIMITER //
DROP PROCEDURE IF EXISTS staff_info;
CREATE PROCEDURE staff_info (
    IN in_festival_id INT
)
BEGIN
SELECT 
f.festival_id,
f.festival_name,
s.*,
DATE(e.start_time) AS festival_day
FROM staff s
JOIN staff_event se ON s.staff_id = se.staff_id
JOIN event e ON se.event_id = e.event_id
JOIN festival f ON e.festival_id = f.festival_id
WHERE f.festival_id = in_festival_id
ORDER BY festival_day, s.job, s.staff_id;

END//
DELIMITER ;

#-------------------QUERY 12/Δινει ποσοι χρειάζονται απο καθε κατηγορία για καθε μερα για συγκεκριμενο φεστιβαλ----------------#
DELIMITER //
DROP PROCEDURE IF EXISTS staff_info;
CREATE PROCEDURE staff_info (
    IN in_festival_id INT
)
BEGIN
    SELECT 
        f.festival_id,
        f.festival_name,
        DATE(e.start_time) AS festival_day,
        SUM(CASE WHEN s.job = 'technical' THEN 1 ELSE 0 END) AS techincal_staff, 
        SUM(CASE WHEN s.job = 'security' THEN 1 ELSE 0 END) AS security_staff,  
        SUM(CASE WHEN s.job = 'assistant' THEN 1 ELSE 0 END) AS assistant_staff   
    FROM staff s
    JOIN staff_event se ON s.staff_id = se.staff_id
    JOIN event e ON se.event_id = e.event_id
    JOIN festival f ON e.festival_id = f.festival_id
    WHERE f.festival_id = in_festival_id
    GROUP BY f.festival_id, f.festival_name, festival_day;
END //
DELIMITER ;

#-------------------QUERY 12/Δινει ποσοι χρειάζονται απο καθε κατηγορία για καθε μερα για ολα τα φεστιβαλ----------------#
 SELECT 
    f.festival_id,
    f.festival_name,
     DATE(e.start_time) AS festival_day,
    SUM(CASE WHEN s.job = 'technical' THEN 1 ELSE 0 END) AS techincal_staff, 
    SUM(CASE WHEN s.job = 'security' THEN 1 ELSE 0 END) AS security_staff,  
    SUM(CASE WHEN s.job = 'assistant' THEN 1 ELSE 0 END) AS assistant_staff   
FROM staff s
JOIN staff_event se ON s.staff_id = se.staff_id
JOIN event e ON se.event_id = e.event_id
JOIN festival f ON e.festival_id = f.festival_id
WHERE f.festival_id = in_festival_id
GROUP BY f.festival_id, f.festival_name, festival_day;



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




#--QUERY 15/top5 reviews συνολικα. Αν ενας visitor πολλαπλα reviews για τον ιδιο καλλιτεχνη τοτε καθε review ξεχωριστα (ως προς συνολικη βαθμολογιση)---#
SELECT
v.visitor_id,
v.visitor_name,
a.artist_id,
a.artist_name,
r.artist_performance + r.sound_lighting + r.stage_presence + r.organization + r.overall_impression AS overall_score
FROM visitor v
JOIN review r ON v.visitor_id = r.visitor_id
JOIN performance_artist pa ON r.performance_id = pa.performance_id
JOIN artist a ON pa.artist_id = a.artist_id
ORDER BY overall_score DESC 
LIMIT 5;

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






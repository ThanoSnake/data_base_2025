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
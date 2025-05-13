#-------------------QUERY 4----------------'Elias Romero'#

DELIMITER //
DROP PROCEDURE IF EXISTS avg_review_of_artist_1;
CREATE PROCEDURE avg_review_of_artist_1 (
    IN in_artist_name VARCHAR(100)   
)
BEGIN
SELECT a.artist_id,
a.artist_name,
a.pseudonym,
AVG(r.artist_performance) AS avg_artist_performance_review,
AVG(r.overall_impression) AS avg_overall_impression_review
FROM review r
JOIN performance_artist pa ON r.performance_id = pa.performance_id
JOIN artist a IGNORE INDEX (idx_artist_name) ON pa.artist_id = a.artist_id
WHERE a.artist_name = in_artist_name;
END//
DELIMITER ;

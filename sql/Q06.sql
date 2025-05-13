#-------------------QUERY 6----------------#
DELIMITER //
DROP PROCEDURE IF EXISTS avg_review_of_events_of_a_visitor_1;
CREATE PROCEDURE avg_review_of_events_of_a_visitor_1 (
    IN in_visitor_name VARCHAR(100) 
)
BEGIN
    SELECT 
    v.visitor_id,
    v.visitor_name,
    e.event_name,
    AVG(r.artist_performance) AS avg_artist_performance_review,
    AVG(r.sound_lighting) AS avg_sound_lighting_review,
    AVG(r.stage_presence) AS avg_stage_presence_review,
    AVG(r.organization) AS avg_overall_impression_review,
    AVG(r.overall_impression) AS avg_overall_impression_review,
    (AVG(r.artist_performance) + AVG(r.sound_lighting)  + AVG(r.stage_presence) + AVG(r.organization) + AVG(r.overall_impression))/5 AS general_avg 
    FROM visitor v IGNORE INDEX (idx_visitor_name)
    JOIN review r ON v.visitor_id = r.visitor_id
    JOIN performance p ON r.performance_id = p.performance_id
    JOIN event e ON p.event_id = e.event_id
    WHERE visitor_name = in_visitor_name
    GROUP BY v.visitor_id, v.visitor_name, e.event_name;
END//
DELIMITER ;
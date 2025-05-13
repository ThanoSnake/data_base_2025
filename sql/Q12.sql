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
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
        JOIN event e FORCE INDEX (idx_event_start_time) ON se.event_id = e.event_id
        WHERE DATE(e.start_time) = specific_date
    )

    SELECT * FROM assistant_staff WHERE staff_id 
    NOT IN (
        SELECT staff_id FROM occupied_assistant_staff
    );
END//
DELIMITER ;
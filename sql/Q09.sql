#-------------------QUERY 9----------------#

WITH visitors_min_appearances AS (
    SELECT 
        v.visitor_id,
        v.visitor_name,
        YEAR(e.start_time) AS year,
        COUNT(DISTINCT e.event_id) AS num_events
    FROM visitor v
    JOIN ticket t FORCE INDEX (unique_ticket_per_visitor) ON v.visitor_id = t.visitor_id
    JOIN event e ON t.event_id = e.event_id
    WHERE t.active = FALSE
    GROUP BY v.visitor_id, visitor_name, YEAR(e.start_time)
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

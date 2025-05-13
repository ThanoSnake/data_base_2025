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
GROUP BY f.festival_id, f.festival_name, festival_day;

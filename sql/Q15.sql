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

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
    JOIN performance p FORCE INDEX (idx_type_of_performance) ON pa.performance_id = p.performance_id
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

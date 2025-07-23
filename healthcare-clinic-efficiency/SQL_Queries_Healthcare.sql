
-- 1. Average Wait Time by Provider
SELECT
    p.provider_id,
    pr.provider_name,
    ROUND(AVG(EXTRACT(EPOCH FROM (v.check_in_time - a.appointment_time)) / 60), 2) AS avg_wait_time_minutes
FROM
    appointments a
JOIN visits v ON a.appointment_id = v.appointment_id
JOIN providers pr ON a.provider_id = pr.provider_id
JOIN patients p ON a.patient_id = p.patient_id
WHERE
    v.check_in_time IS NOT NULL
GROUP BY
    p.provider_id, pr.provider_name
ORDER BY
    avg_wait_time_minutes DESC;

-- 2. Monthly No-Shows vs. Completed Visits
SELECT
    DATE_TRUNC('month', a.appointment_time) AS month,
    COUNT(CASE WHEN v.visit_id IS NOT NULL THEN 1 END) AS completed_visits,
    COUNT(CASE WHEN v.visit_id IS NULL THEN 1 END) AS no_shows
FROM
    appointments a
LEFT JOIN visits v ON a.appointment_id = v.appointment_id
GROUP BY
    month
ORDER BY
    month;

-- 3. Overbooked Providers Based on Visit Duration
WITH avg_visit_durations AS (
    SELECT
        provider_id,
        ROUND(AVG(EXTRACT(EPOCH FROM (v.check_out_time - v.check_in_time)) / 60), 2) AS avg_visit_duration_min
    FROM
        visits v
    GROUP BY
        provider_id
),
daily_appointments AS (
    SELECT
        provider_id,
        DATE(appointment_time) AS appt_day,
        COUNT(*) AS appointments_per_day
    FROM
        appointments
    GROUP BY
        provider_id, appt_day
)
SELECT
    a.provider_id,
    pr.provider_name,
    ROUND(AVG(d.appointments_per_day), 2) AS avg_daily_appointments,
    v.avg_visit_duration_min
FROM
    daily_appointments d
JOIN avg_visit_durations v ON d.provider_id = v.provider_id
JOIN providers pr ON d.provider_id = pr.provider_id
GROUP BY
    a.provider_id, pr.provider_name, v.avg_visit_duration_min
ORDER BY
    avg_daily_appointments DESC;

-- 4. No-Show Patterns Based on Age Group
SELECT
    CASE
        WHEN EXTRACT(YEAR FROM CURRENT_DATE) - p.birth_year < 18 THEN 'Under 18'
        WHEN EXTRACT(YEAR FROM CURRENT_DATE) - p.birth_year BETWEEN 18 AND 34 THEN '18-34'
        WHEN EXTRACT(YEAR FROM CURRENT_DATE) - p.birth_year BETWEEN 35 AND 54 THEN '35-54'
        ELSE '55+'
    END AS age_group,
    COUNT(CASE WHEN v.visit_id IS NULL THEN 1 END) AS no_shows,
    COUNT(*) AS total_appointments,
    ROUND(100.0 * COUNT(CASE WHEN v.visit_id IS NULL THEN 1 END) / COUNT(*), 2) AS no_show_rate_percent
FROM
    appointments a
JOIN patients p ON a.patient_id = p.patient_id
LEFT JOIN visits v ON a.appointment_id = v.appointment_id
GROUP BY
    age_group
ORDER BY
    no_show_rate_percent DESC;

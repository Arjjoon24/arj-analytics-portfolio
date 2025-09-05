-- =============================================================================
-- Blue Jays Performance Analytics
-- Author: Arjun Puri
-- Live page: https://arjjoon24.github.io/arj-analytics-portfolio/blue-jays-performance-analytics/
-- Repo: https://github.com/Arjjoon24/arj-analytics-portfolio
-- End-to-end SQL queries powering analysis, visuals, and insights.
-- =============================================================================

-- ============================================================================
-- 1) Average runs per game (daily + monthly)
-- ============================================================================
-- Daily runs per game
SELECT
  game_date,
  runs_scored AS runs_per_game
FROM games
WHERE team = 'Toronto Blue Jays'
ORDER BY game_date;

-- Monthly runs per game
SELECT
  DATE_TRUNC('month', game_date) AS month,
  ROUND(AVG(runs_scored)::numeric, 2) AS runs_per_game
FROM games
WHERE team = 'Toronto Blue Jays'
GROUP BY 1
ORDER BY 1;

-- ============================================================================
-- 2) Bullpen usage & earned runs (plus K/9 and ER/9)
-- ============================================================================
SELECT
  pitcher_name,
  COUNT(*) AS appearances,
  SUM(innings_pitched) AS ip,
  SUM(strikeouts) AS k,
  SUM(earned_runs) AS er,
  ROUND((SUM(strikeouts)::numeric / NULLIF(SUM(innings_pitched),0)) * 9, 2) AS K_per_9,
  ROUND((SUM(earned_runs)::numeric / NULLIF(SUM(innings_pitched),0)) * 9, 2) AS ER_per_9
FROM pitching_stats
WHERE team = 'Toronto Blue Jays'
  AND role = 'Relief'
GROUP BY pitcher_name
HAVING SUM(innings_pitched) > 5
ORDER BY K_per_9 DESC;

-- Optional late-inning focus
SELECT
  pitcher_name,
  COUNT(*) AS late_appr,
  SUM(innings_pitched) AS late_ip,
  ROUND((SUM(strikeouts)::numeric / NULLIF(SUM(innings_pitched),0)) * 9, 2) AS late_K_per_9,
  ROUND((SUM(earned_runs)::numeric / NULLIF(SUM(innings_pitched),0)) * 9, 2) AS late_ER_per_9
FROM pitching_stats
WHERE team = 'Toronto Blue Jays'
  AND role = 'Relief'
  AND inning BETWEEN 7 AND 9
GROUP BY pitcher_name
HAVING SUM(innings_pitched) > 3
ORDER BY late_K_per_9 DESC;

-- ============================================================================
-- 3) Win expectancy impact by player (WPA) – placeholder
-- ============================================================================
SELECT 
  player_name,
  ROUND(SUM(win_exp_change), 3) AS total_wpa
FROM batting_stats
WHERE team = 'Toronto Blue Jays'
GROUP BY player_name
ORDER BY total_wpa DESC
LIMIT 10;

-- ============================================================================
-- 4) Batting Average – Top Hitters
-- ============================================================================
SELECT
  player_name,
  ROUND(SUM(hits)::numeric / NULLIF(SUM(at_bats),0), 3) AS batting_avg
FROM batting_stats
WHERE team = 'Toronto Blue Jays'
GROUP BY player_name
HAVING SUM(at_bats) >= 100
ORDER BY batting_avg DESC
LIMIT 10;

-- ============================================================================
-- 5) Home Run Leaders
-- ============================================================================
SELECT
  player_name,
  SUM(home_runs) AS home_runs
FROM batting_stats
WHERE team = 'Toronto Blue Jays'
GROUP BY player_name
HAVING SUM(plate_appearances) > 50
ORDER BY home_runs DESC
LIMIT 10;

-- ============================================================================
-- 6) Pitcher Strikeouts – Rotation & Bullpen
-- ============================================================================
SELECT
  CASE WHEN role = 'Starter' THEN 'Starter' ELSE 'Relief' END AS role_group,
  pitcher_name,
  SUM(strikeouts) AS strikeouts
FROM pitching_stats
WHERE team = 'Toronto Blue Jays'
GROUP BY role_group, pitcher_name
ORDER BY role_group, strikeouts DESC;

-- Top strikeout pitchers overall
SELECT
  pitcher_name,
  SUM(strikeouts) AS strikeouts
FROM pitching_stats
WHERE team = 'Toronto Blue Jays'
GROUP BY pitcher_name
ORDER BY strikeouts DESC
LIMIT 10;

-- ============================================================================
-- 7) Runs by Month (plus HR comparison)
-- ============================================================================
SELECT
  DATE_TRUNC('month', game_date) AS month,
  ROUND(AVG(runs_scored)::numeric, 2) AS runs_per_game
FROM games
WHERE team = 'Toronto Blue Jays'
GROUP BY 1
ORDER BY 1;

-- Monthly team home runs
SELECT
  DATE_TRUNC('month', game_date) AS month,
  SUM(home_runs) AS team_hr
FROM batting_stats
WHERE team = 'Toronto Blue Jays'
GROUP BY 1
ORDER BY 1;

-- ============================================================================
-- 8) Attendance Trend
-- ============================================================================
SELECT
  DATE_TRUNC('month', game_date) AS month,
  SUM(attendance) AS month_attendance
FROM attendance
WHERE team = 'Toronto Blue Jays'
GROUP BY 1
ORDER BY 1;

-- Attendance vs runs per game
WITH runs_m AS (
  SELECT DATE_TRUNC('month', game_date) AS month,
         ROUND(AVG(runs_scored)::numeric, 2) AS team_rpg
  FROM games
  WHERE team = 'Toronto Blue Jays'
  GROUP BY 1
),
att_m AS (
  SELECT DATE_TRUNC('month', game_date) AS month,
         SUM(attendance) AS month_attendance
  FROM attendance
  WHERE team = 'Toronto Blue Jays'
  GROUP BY 1
)
SELECT r.month, r.team_rpg, a.month_attendance
FROM runs_m r
LEFT JOIN att_m a USING (month)
ORDER BY r.month;

-- ============================================================================
-- 9) AL East Division Snapshot
-- ============================================================================
SELECT
  team,
  DATE_TRUNC('month', game_date) AS month,
  ROUND(AVG(runs_scored)::numeric, 2) AS runs_per_game
FROM games
WHERE division = 'AL East'
GROUP BY team, month
ORDER BY team, month;

-- ============================================================================
-- 10) Contact + Team Runs Linkage
-- ============================================================================
WITH runs_m AS (
  SELECT DATE_TRUNC('month', game_date) AS month,
         ROUND(AVG(runs_scored)::numeric, 2) AS team_rpg
  FROM games
  WHERE team = 'Toronto Blue Jays'
  GROUP BY 1
),
player_month AS (
  SELECT
    player_name,
    DATE_TRUNC('month', game_date) AS month,
    SUM(hits) AS hits_m,
    SUM(at_bats) AS ab_m
  FROM batting_stats
  WHERE team = 'Toronto Blue Jays'
  GROUP BY player_name, DATE_TRUNC('month', game_date)
),
avg_m AS (
  SELECT
    month,
    ROUND(AVG((hits_m::numeric / NULLIF(ab_m,0)))::numeric, 3) AS top_contact_avg
  FROM player_month
  WHERE ab_m >= 40
  GROUP BY month
)
SELECT r.month, r.team_rpg, a.top_contact_avg
FROM runs_m r
LEFT JOIN avg_m a USING (month)
ORDER BY r.month;

-- =============================================================================
-- END
-- =============================================================================
-- HOW TO USE:
-- • Run queries in PostgreSQL (tested with Postgres syntax).
-- • Replace table names (games, batting_stats, pitching_stats, attendance)
--   with your own schema or mock dataset names.
-- • Use these outputs to recreate the visuals in /assets and analysis in index.html.
-- =============================================================================

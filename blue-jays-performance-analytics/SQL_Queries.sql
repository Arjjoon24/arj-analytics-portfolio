-- Blue Jays Performance Analytics
-- Example queries for player and game-level analysis

-- 1. Average runs per game
SELECT 
    game_date,
    SUM(runs_scored) AS total_runs
FROM games
WHERE team = 'Toronto Blue Jays'
GROUP BY game_date
ORDER BY game_date;

-- 2. Bullpen usage and earned runs
SELECT 
    pitcher_name,
    COUNT(*) AS appearances,
    SUM(earned_runs) AS total_runs_allowed,
    ROUND(SUM(earned_runs) * 1.0 / COUNT(*), 2) AS avg_runs_per_appearance
FROM pitching_stats
WHERE team = 'Toronto Blue Jays'
  AND role = 'Relief'
GROUP BY pitcher_name
ORDER BY avg_runs_per_appearance ASC;

-- 3. Win expectancy impact by player (placeholder example)
-- Assuming "win_exp_change" is recorded per plate appearance
SELECT 
    player_name,
    ROUND(SUM(win_exp_change), 3) AS total_wpa
FROM batting_stats
WHERE team = 'Toronto Blue Jays'
GROUP BY player_name
ORDER BY total_wpa DESC
LIMIT 10;

-- ---------REPORTS -------
-- Player with maximum appearances in International matches
SELECT 
    fps.player_id,
    p.player_name,
    SUM(fps.appearances) AS Total_Appearances
FROM Fact_Player_Statistics fps
JOIN dim_player p ON fps.player_id = p.player_id
JOIN dim_matchtype m ON fps.matchtype_id = m.matchtype_id
WHERE m.match_name = 'International'
GROUP BY fps.player_id, p.player_name
ORDER BY Total_Appearances DESC
LIMIT 1;

-- Top 10 goal scorers of 2010
SELECT 
    fps.player_id,
    p.player_name,
    SUM(fps.goals_scored) AS Total_Goals
FROM fact_player_statistics fps
JOIN dim_player p ON fps.player_id = p.player_id
JOIN dim_time t ON fps.time_id = t.time_id
WHERE t.`Year` = 2010
GROUP BY fps.player_id, p.player_name
ORDER BY Total_Goals DESC
LIMIT 10;

-- Top 5 players who got red card
SELECT 
    fps.player_id,
    p.player_name,
    SUM(fps.red_card) AS Total_Red_Cards
FROM fact_player_statistics fps
JOIN dim_player p ON fps.player_id = p.player_id
GROUP BY fps.player_id, p.player_name
ORDER BY Total_Red_Cards DESC
LIMIT 5;

-- Top 5 successful clubs
SELECT 
    c.club_name,
    SUM(fts.wins) AS Total_Wins
FROM fact_team_statistics fts
JOIN dim_club c ON fts.club_id = c.club_id
GROUP BY c.club_name
ORDER BY Total_Wins DESC
LIMIT 5;
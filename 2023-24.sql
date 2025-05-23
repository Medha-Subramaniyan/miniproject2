--**player24 = per game data 
--**player23 = total data over the season 
--**teams = historcal team data from 2000-2024

--Find players who played in the 23-24 and 24-25 season
 SELECT pname,player23.pts AS "2023 points", player24.pts as "2024 PPG", player24.tm AS "2024 Team"  FROM player23
 INNER JOIN player24 ON player23.pname = player24.player;
 
 --Find players who increased their scoring average from 2023 to 2024. 
 SELECT player23.pname, player24.pts AS "ppg_2024", player23.ppg_2023, 
 ROUND((player24.pts::DOUBLE PRECISION - player23.ppg_2023)::NUMERIC,2) AS PPGDIFF FROM player23
 JOIN player24 on player23.pname = player24.player
 WHERE  ROUND((player24.pts::DOUBLE PRECISION - player23.ppg_2023)::NUMERIC,2) > 0; 
 
 --Match player stats with team records 
SELECT DISTINCT player23.pname, teams.wins AS "2023-24 Wins", teams.losses AS "2023-24 Losses", player23.team, player23.ppg_2023 AS "2023_PPG", player24.pts AS "2024_PPG" FROM player23
JOIN player24 ON player23.pname = player24.player
JOIN teams ON player23.team = teams.team_abbr
WHERE teams.season = '2023-24';

--Offseason Dropouts 
SELECT player23.pname, player23.team AS "23 team", player24.tm AS "24 team", player23.ppg_2023
FROM player23 
LEFT JOIN player24 ON player23.pname = player24.player
WHERE player24.tm IS NULL ; 

--Players with reduced roles (drop of 5+ PPG from 24 to 23)
SELECT DISTINCT player23.pname, player23.team, ROUND((player24.pts::DOUBLE PRECISION- player23.ppg_2023)::NUMERIC,0) AS pt_diff, player23.ppg_2023, player24.pts AS "2024 PPG"
FROM player23
LEFT JOIN player24 ON player23.pname = player24.player
WHERE (player24.pts - player23.ppg_2023) >= 5;

--2024 Rookies..RJ
SELECT player24.player,player23.ppg_2023, player24.tm, player24.pts, player24.mp AS "Minutes Per Game" FROM player24
RIGHT JOIN player23 
ON player24.player = player23.pname;

-- Rookie vs Veteran production 


--Master Roster Tracker

-- Transition Analysis 

--Mulyi year aggregated view 

--draft simulator 

--fantasy matchups 

--cross year teammate scenarios 

--intra team comparison

--most least efficient pair 

--matching players w/ similar stats 
  

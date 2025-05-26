-- top 10 players (by PPG) who play more than 40 games and average more than 3 assists.
SELECT player_name, assists / games_played AS "APG" FROM players
WHERE games_played > 40 AND (assists / games_played) > 3; 

--Provide a list of all players (name, position) and the city and conference of their current team
SELECT p.player_name, p.position, t.team_name, t.conference FROM players p
INNER JOIN teams t ON t.team_id = p.team_id; 

--Show all teams and include players who have not played any games this season (games_played = 0). 
--Still list the team even if they had no such players.
SELECT t.team_name, p.player_name FROM teams t
LEFT JOIN players p ON p.team_id = t.team_id 
WHERE p.games_played = 0; 

--***For each team, find the pair of players who play the same position and both have played over 50 games. 
--Show their names, team, and position."
SELECT DISTINCT p.player_name, t.team_name, p.position FROM players p 
JOIN players pl ON p.team_id = pl.team_id
JOIN teams t ON t.team_id = p.team_id 
WHERE pl.position = p.position AND pl.team_id = p.team_id AND p.games_played >50
ORDER BY t.team_name; 

--****"For each team, calculate the average number of points per player and total assists. 
--Sort teams by total assists descending."
SELECT t.team_name, AVG(p.points) AS "PPP",SUM(p.assists) AS "total assists" FROM players p 
LEFT JOIN teams t ON t.team_id = p.team_id
GROUP BY t.team_name, p.points, p.assists
ORDER BY t.team_name DESC; 


--"Which games generated over $1 million in revenue? List date, home/away teams, and revenue."
SELECT g.game_date, a.total_revenue, t.team_name AS "home team", ti.team_name AS "away team" FROM attendance a
JOIN games g ON a.game_id = g.game_id
JOIN teams t on t.team_id = g.home_team_id 
JOIN teams ti on ti.team_id = g.away_team_id
WHERE a.total_revenue > 1000000
ORDER BY a.total_revenue DESC; 

--Which players have an assist-to-turnover ratio below 1.0? 
--List their name, team, and calculated ratio rounded to 2 decimal;; places."
SELECT p.player_name, t.team_name, ROUND((p.assists::DOUBLE PRECISION / p.turnovers)::NUMERIC,2) AS "AST:TOV" from players p 
JOIN teams t ON p.team_id = t.team_id 
WHERE p.assists !=0 
AND p.turnovers != 0 
AND ROUND((p.assists::DOUBLE PRECISION / p.turnovers)::NUMERIC,2) < 1
ORDER BY "AST:TOV" DESC ; 

--"Group all players by conference and position.
--Show the average points and average games played. 
--Only include position/conference combos where the average points > 800."
SELECT  p.player_name, p.position, t.conference, ROUND(AVG(p.games_played), 2) AS "avg games played", ROUND(AVG(points),2)AS "avg points"  from players p  
JOIN teams t ON p.team_id = t.team_id 
GROUP BY t.conference, p.position, p.player_name
HAVING AVG(points)> 800; 


--"Are there any players with the same assist-to-turnover ratio and games played on the same team? Show these ‘duplicates’."
SELECT p.player_name AS "player 1", pl.player_name AS "player 2", 
ROUND((p.assists::DOUBLE PRECISION / p.turnovers)::NUMERIC,2) AS "ratio"
from players p 
JOIN players pl
ON ROUND((p.assists::DOUBLE PRECISION / p.turnovers)::NUMERIC,2) = ROUND((pl.assists::DOUBLE PRECISION / pl.turnovers)::NUMERIC,2)
WHERE p.team_id = pl.team_id 
AND p.player_id != pl.player_id
AND p.assists !=0 
AND p.turnovers != 0 
AND pl.assists !=0 
AND pl.turnovers !=0 


AND pl.turnovers != 0; 
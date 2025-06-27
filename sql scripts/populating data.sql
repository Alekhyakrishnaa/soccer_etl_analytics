-- -----POPULATING DATA INTO DIMENSION TABLES-----

Insert into dim_league(league_name)
select distinct league_name
from sockey_src2;

Insert into dim_country(country_name, coach)
select distinct `Country name`, Coach
from sockey_src2;

Insert into dim_matchtype(match_name)
select distinct `Match`
from soccer_src1;

Insert into dim_club(league_id,club_name,manager,`owner`)
select distinct l.league_id, s.club_name, s.manager, s.`owner`
from sockey_src2 as s join dim_league as l on l.league_name = s.League_Name;

Insert into dim_time(`year`,`quarter`,`month`)
select distinct fb_year, `quarter`, fb_month
from dim_date_table;

Insert into dim_player(player_name, position, jersey_number, dob, nationality)
select distinct s.`Player Name`, s.Position, s.Jersey_no, STR_TO_DATE(s.`D. O. B.`, '%d-%b-%y'), s.Nationality
from soccer_src1 as s;

-- -----POPULATING DATA INTO FACT TABLES-----

Insert into fact_player_statistics
(time_id, matchtype_id, player_id, club_id, country_id, appearances, goals_scored, goals_assist, total_shots, shots_on_target, fouls_made,
fouls_suffered, yellow_card, red_card, goals_saved, goals_conceded, total_penalty, successful_penalty, salary)
select distinct t.time_id, m.matchtype_id, p.player_id, c.club_id, co.country_id, s.appearances, s.`goals scored`, s.`goals assist`, s.`total shots`,
s.`shots on target`, s.`fouls made`, s.`fouls suffered`, s.`yellow card`, s.`red card`, s.`goals saved`, s.`goals conceded(stopped)`, 
s.`total penalty`, s.`successful penalty`, CAST(NULLIF(TRIM(s.salary), '') AS DECIMAL(15,2)) AS salary 
from soccer_src1 as s 
left join dim_time as t on t.`year` = s.`Year`
left join dim_matchtype as m on m.match_name = s.`Match`
left join dim_player as p on p.player_name = s.`Player Name`
left join dim_club as c on c.club_name = s.`Club Name`
left join dim_country as co on co.country_name = s.`country Name`
WHERE TRIM(s.salary) REGEXP '^[0-9]+(\\.[0-9]{1,2})?$';

insert into fact_team_statistics (time_id, matchtype_id, league_id, club_id, country_id, appearances, wins, lost, drawn, cleansheets, net_worth)
select distinct t.time_id, m.matchtype_id, l.league_id, c.club_id, co.country_id, s.Appearances, s.Wins, s.Losts, s.Drawn,
s.`Clean sheets`, CAST(REPLACE(REPLACE(s.`Net Worth`, '$', ''), ',', '') AS DECIMAL(15,2))
from sockey_src2 s
join dim_league l ON l.league_name = s.League_Name
JOIN dim_club c ON c.club_name = s.Club_Name
JOIN dim_country co ON co.country_name = s.`Country Name`
JOIN dim_matchtype m ON m.match_name = s.Match_Name
JOIN dim_time t ON t.`Year` = s.`Year`;

-- ----------------------------------------------------------------------------------------- --- 






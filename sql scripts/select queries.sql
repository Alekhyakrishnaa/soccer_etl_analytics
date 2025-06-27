Create database socceranalysis;
Use socceranalysis;

Select * from soccer_src1;
select * from sockey_src2;
select * from dim_date_table;

-- -------------------------------------------------- --

select * from dim_league;
select * from dim_club;
select * from dim_country;
select * from dim_matchtype;
select * from dim_player;
select * from dim_time;
select * from fact_player_statistics;
select * from fact_team_statistics;


-- --------------------------------------------------- --
-- ALTERING SALARY 
Update soccer_src1
set salary = replace (salary, '$', '');

Update soccer_src1
set salary = replace (salary, ',','');

-- ---------------------------------------------------- --
-- FOR ERROR CODE: 2013 . LOST CONNECTION TO SERVER DURING QUERY
SET net_read_timeout = 600;
SET net_write_timeout = 600;
SET wait_timeout = 600;
SET interactive_timeout = 600;
 
 -- ---------salary or networth decimal value not match error explanation of regexp----------------
 
 -- | Part               | Meaning                                                                        |
-- | ------------------ | ------------------------------------------------------------------------------ |
-- | `^`                | Start of string (ensures no leading characters)                                |
-- | `[0-9]+`           | One or more digits (e.g., `100`, `54321`)                                      |
-- | `(\\.[0-9]{1,2})?` | Optional decimal part: a dot `.` followed by 1 or 2 digits (e.g., `.5`, `.50`) |
-- | `$`                | End of string (ensures no trailing characters)                                 |

-- ---------------------------------------------------------------------------------------------- --

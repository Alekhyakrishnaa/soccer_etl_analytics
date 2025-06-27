
-- ----------- DIMENSION TABLES CREATION ------------
Create table dim_league(
 league_id int auto_increment primary key not null,
 league_name varchar(200) not null
 );

Create table dim_country(
 country_id int auto_increment primary key not null,
 country_name varchar(200) not null,
 coach varchar(200)
 );
 
 Create table dim_matchtype(
  matchtype_id int auto_increment primary key not null,
  match_name varchar(200)
  );
  
Create table dim_club(
 club_id int auto_increment primary key not null,
 league_id int,
 club_name varchar(200) not null,
 manager varchar(200),
 `owner` varchar(200),
 foreign key (league_id) references dim_league(league_id)
 );
 
 Create table dim_time(
  time_id int auto_increment primary key not null,
  `year` int,
  `quarter` int,
  `month` int
  );
  
  Create table dim_player(
   player_id int auto_increment primary key not null,
   player_name varchar(200) not null,
   position varchar(50),
   jersey_number int,
   dob date,
   nationality varchar(50)
   );
   
  -- -----------FACT TABLES CREATION---------
 Create table fact_player_statistics(
  fact_id int auto_increment primary key not null,
  time_id int,
  matchtype_id int,
  player_id int,
  club_id int,
  country_id int,
  appearances int,
  goals_scored int,
  goals_assist int,
  total_shots int,
  shots_on_target int,
  fouls_made int,
  fouls_suffered int,
  yellow_card int,
  red_card int,
  goals_saved int,
  goals_conceded int,
  total_penalty int,
  successful_penalty int,
  salary decimal(15,2),
  foreign key (time_id) references dim_time(time_id), 
  foreign key (matchtype_id) references dim_matchtype(matchtype_id),
  foreign key (player_id) references dim_player(player_id),
  foreign key (club_id) references dim_club(club_id),
  foreign key (country_id) references dim_country(country_id)
);
  
Create table fact_team_statistics(
 fact_id int auto_increment primary key not null,
 time_id int,
 matchtype_id int,
 league_id int,
 club_id int,
 country_id int,
 appearances int,
 wins int,
 lost int,
 drawn int,
 cleansheets int,
 net_worth decimal,
 foreign key (time_id) references dim_time(time_id), 
 foreign key (matchtype_id) references dim_matchtype(matchtype_id),
 foreign key (league_id) references dim_league(league_id),
 foreign key (club_id) references dim_club(club_id),
 foreign key (country_id) references dim_country(country_id)
);
 
 -- -----------------------------------------------------------------
 
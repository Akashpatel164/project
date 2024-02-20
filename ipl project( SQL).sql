create database ipl;
use ipl;

select * from deliveries;
select * from matches;


-- 1) what are the top 5 players with the most player of the match?
select  player_of_match,count(player_of_match) as "count_awards" from matches  group by player_of_match order by count_awards desc limit 5; 

-- 2) how many matches were won by each team in each season?
select season, winner as team,count(winner) as win_matches  from matches group by season,team;

-- 3) what is the average strike rate of batsmen in the ipl dataset?
  select avg(strike_rate) as average_strike_rate from 
      (select batsman, (sum(total_runs)/count(ball))*100 as strike_rate from deliveries group by batsman) as batsman_stats ;
 
 -- for each batsman strike rate
 select batsman, (sum(total_runs)/count(ball))*100 as strike_rate from deliveries group by batsman;

-- 4) what is the number of matches won by each team batting first versus batting secound?
select batting_first, count(*) as matches_won from
 (select case when win_by_runs > 0 then team1 else team2
 end as batting_first 
 from matches
 where winner != "Tie") as batting_first_teams group by batting_first;
				 
-- 5) which batsman has the highest strike rate (min 200 runs scored)?
select batsman, (sum(batsman_runs)*100/count(*)) as strike_rate from deliveries 
   group by batsman having sum(batsman_runs)>=200 order by strike_rate desc limit 1;
   
-- 6) how many times has each batsman been dismissed by the bowler 'Malinga'?
 select batsman,count(*) as total_dismissals  from deliveries 
    where player_dismissed is not null and bowler="SL Malinga" group by batsman;  
 
-- 7) what is the average percentage of boundaries (4 & 6 combined) hit by each batsman?
 select batsman,
             avg(case when batsman_runs =4 or batsman_runs=6 then 1 else 0 end)*100 as avg_boundaries
             from deliveries group by batsman;
             
-- 8) what is the average number of boundaries hit by each team in each season?
select season,batting_team,avg(fours+sixes) as avg_boundaries 
 from (select season,match_id,batting_team,
        sum(case when batsman_runs=4 then 1 else 0 end) as fours,
        sum(case when batsman_runs=6 then 1 else 0 end) as sixes
        from deliveries,matches where deliveries.match_id=matches.id
        group by season,match_id,batting_team) as team_boundaries
   group by season,batting_team;
   
 -- 9) what is the hightest partnership(runs) for each team in each season?
 select season,batting_team,max(total_runs) as highest_partnership
   from ( select season,batting_team,partnership,sum(total_runs) as total_runs
     from( select season,match_id,batting_team,sum(batsman_runs) as partnership,sum(batsman_runs)+sum(extra_runs) as total_runs
          from deliveries,matches where deliveries.match_id=matches.id group by season,match_id,batting_team) as team_scores
    group  by season,batting_team,partnership) as highest_partnership
 group by season,batting_team;   
 
 -- 10) how many extras(wides & no-balls) were bowled by each team in each match?
 select m.id as match_no,d.bowling_team,sum(d.extra_runs) as extras
  from matches as m join deliveries as d  on m.id=d.match_id 
   where extra_runs>0 group by m.id,d.bowling_team;

select  match_id,bowling_team,sum(extra_runs) as extras from deliveries 
   where extra_runs>0 group by match_id,bowling_team;
   
  -- 11) how many matches resulted in a win for each team in each city?
SELECT team, city, COUNT(*) as num_wins
FROM
    (SELECT team1 as team, city
     FROM matches
     WHERE result = 'normal'
     UNION ALL
     SELECT team2 as team, city
     FROM matches
     WHERE result = 'normal') as wins
GROUP BY team, city;

-- 12) how many time did each team win the toss in each season?
 select season,toss_winner,count(*) as win_toss from matches group by season,toss_winner;
 
 -- 13)how many matches did each player win the "player of the match" award?
 select player_of_match,count(*) as win_award from matches group by player_of_match order by win_award desc;
 
 -- 14) what is the average number of run scored in each over of the innings in each match?
 select m.id,d.inning,d.over,avg(d.total_runs) as avg_run_per_over 
  from matches as m join deliveries as d on d.match_id=m.id
   group by m.id,d.inning,d.over;
 
-- 15) which team has the highest total score in a single match?
select batting_team,sum(total_runs) as team_runs from deliveries group by match_id,batting_team order by team_runs desc limit 1 ;

-- 16) which batsman has scored the most runs in a single match?
select match_id,batsman,sum(batsman_runs) as score from deliveries group by match_id,batsman order by score desc limit 1 ;


  

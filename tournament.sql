-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

CREATE DATABASE tournament;

CREATE TABLE player ( player_id serial, name char(50), PRIMARY KEY (player_id));
CREATE TABLE match ( match_id serial, winner int NOT NULL REFERENCES player(player_id), loser int NOT NULL REFERENCES player(player_id), PRIMARY KEY (match_id));
CREATE VIEW standings AS SELECT player.player_id, player.name, (SELECT COUNT(match_id) FROM match WHERE winner = player.player_id OR loser = player.player_id) AS matches, (SELECT count(match_id) FROM match WHERE winner = player.player_id) AS wins FROM player LEFT JOIN match ON player.player_id = match.winner AND player.player_id = match.loser GROUP BY player.player_id ORDER BY wins DESC;


create view standings as
select player.player_id, player.name, (Select count(match_id) from match where winner = player.player_id OR loser = player.player_id) as matches, (Select count(match_id) FROM match where winner = player.player_id) as wins from player left join match on player.player_id = match.winner and player.player_id = match.loser group by player.player_id ORDER BY wins desc;
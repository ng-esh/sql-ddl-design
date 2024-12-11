CREATE TABLE Teams (
    team_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(100)
);

CREATE TABLE Players (
    player_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    team_id INT REFERENCES Teams(team_id)
);

CREATE TABLE Matches (
    match_id SERIAL PRIMARY KEY,
    team1_id INT REFERENCES Teams(team_id),
    team2_id INT REFERENCES Teams(team_id),
    match_date DATE NOT NULL,
    season_year INT NOT NULL
);

CREATE TABLE Referees (
    referee_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE MatchReferees (
    match_id INT REFERENCES Matches(match_id),
    referee_id INT REFERENCES Referees(referee_id),
    PRIMARY KEY (match_id, referee_id)
);

CREATE TABLE Goals (
    goal_id SERIAL PRIMARY KEY,
    match_id INT REFERENCES Matches(match_id),
    player_id INT REFERENCES Players(player_id),
    goal_time TIME NOT NULL
);


INSERT INTO Teams (name, city) VALUES
('Red Hawks', 'New York'), ('Blue Sharks', 'Los Angeles');

INSERT INTO Players (name, team_id) VALUES
('Tom Brady', 1), ('Lionel Messi', 2);

INSERT INTO Matches (team1_id, team2_id, match_date, season_year) VALUES
(1, 2, '2024-12-10', 2024);

INSERT INTO Referees (name) VALUES
('Mike Dean');

INSERT INTO MatchReferees (match_id, referee_id) VALUES
(1, 1);

INSERT INTO Goals (match_id, player_id, goal_time) VALUES
(1, 2, '00:15:30');

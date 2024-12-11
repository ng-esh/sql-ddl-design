-- from the terminal run:
-- psql < music.sql

DROP DATABASE IF EXISTS music;

CREATE DATABASE music;

\c music


--OLD SCHEMA DESIGN:
-- CREATE TABLE songs
-- (
--   id SERIAL PRIMARY KEY,
--   title TEXT NOT NULL,
--   duration_in_seconds INTEGER NOT NULL,
--   release_date DATE NOT NULL,
--   artists TEXT[] NOT NULL,
--   album TEXT NOT NULL,
--   producers TEXT[] NOT NULL
-- );

-- INSERT INTO songs
--   (title, duration_in_seconds, release_date, artists, album, producers)
-- VALUES
--   ('MMMBop', 238, '04-15-1997', '{"Hanson"}', 'Middle of Nowhere', '{"Dust Brothers", "Stephen Lironi"}'),
--   ('Bohemian Rhapsody', 355, '10-31-1975', '{"Queen"}', 'A Night at the Opera', '{"Roy Thomas Baker"}'),
--   ('One Sweet Day', 282, '11-14-1995', '{"Mariah Cary", "Boyz II Men"}', 'Daydream', '{"Walter Afanasieff"}'),
--   ('Shallow', 216, '09-27-2018', '{"Lady Gaga", "Bradley Cooper"}', 'A Star Is Born', '{"Benjamin Rice"}'),
--   ('How You Remind Me', 223, '08-21-2001', '{"Nickelback"}', 'Silver Side Up', '{"Rick Parashar"}'),
--   ('New York State of Mind', 276, '10-20-2009', '{"Jay Z", "Alicia Keys"}', 'The Blueprint 3', '{"Al Shux"}'),
--   ('Dark Horse', 215, '12-17-2013', '{"Katy Perry", "Juicy J"}', 'Prism', '{"Max Martin", "Cirkut"}'),
--   ('Moves Like Jagger', 201, '06-21-2011', '{"Maroon 5", "Christina Aguilera"}', 'Hands All Over', '{"Shellback", "Benny Blanco"}'),
--   ('Complicated', 244, '05-14-2002', '{"Avril Lavigne"}', 'Let Go', '{"The Matrix"}'),
--   ('Say My Name', 240, '11-07-1999', '{"Destiny''s Child"}', 'The Writing''s on the Wall', '{"Darkchild"}');

--UPDATED SCHEMA DESIGN
CREATE TABLE Artists (
    artist_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE
);

CREATE TABLE Producers (
    producer_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE
);

CREATE TABLE Albums (
    album_id SERIAL PRIMARY KEY,
    title TEXT NOT NULL UNIQUE,
    release_date DATE NOT NULL
);

CREATE TABLE Songs (
    song_id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    duration_in_seconds INT NOT NULL,
    album_id INT REFERENCES Albums(album_id)
);

CREATE TABLE SongArtists (
    song_id INT REFERENCES Songs(song_id),
    artist_id INT REFERENCES Artists(artist_id),
    PRIMARY KEY (song_id, artist_id)
);

CREATE TABLE SongProducers (
    song_id INT REFERENCES Songs(song_id),
    producer_id INT REFERENCES Producers(producer_id),
    PRIMARY KEY (song_id, producer_id)
);


INSERT INTO Artists (name) VALUES
('Hanson'), ('Queen'), ('Mariah Carey'), ('Boyz II Men'), ('Lady Gaga'), 
('Bradley Cooper'), ('Nickelback'), ('Jay Z'), ('Alicia Keys');

INSERT INTO Producers (name) VALUES
('Dust Brothers'), ('Stephen Lironi'), ('Roy Thomas Baker'), ('Walter Afanasieff'), 
('Benjamin Rice'), ('Rick Parashar'), ('Al Shux'), ('Shellback'), ('Benny Blanco');

INSERT INTO Albums (title, release_date) VALUES
('Middle of Nowhere', '1997-04-15'),
('A Night at the Opera', '1975-10-31'),
('Daydream', '1995-11-14');

INSERT INTO Songs (title, duration_in_seconds, album_id) VALUES
('MMMBop', 238, 1),
('Bohemian Rhapsody', 355, 2),
('One Sweet Day', 282, 3);

INSERT INTO SongArtists (song_id, artist_id) VALUES
(1, 1), (2, 2), (3, 3), (3, 4);

INSERT INTO SongProducers (song_id, producer_id) VALUES
(1, 1), (2, 3), (3, 4);
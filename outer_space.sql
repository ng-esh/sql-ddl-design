-- from the terminal run:
-- psql < outer_space.sql

DROP DATABASE IF EXISTS outer_space;

CREATE DATABASE outer_space;

\c outer_space

-- OLD SCHEMA DESIGN:
-- CREATE TABLE planets
-- (
--   id SERIAL PRIMARY KEY,
--   name TEXT NOT NULL,
--   orbital_period_in_years FLOAT NOT NULL,
--   orbits_around TEXT NOT NULL,
--   galaxy TEXT NOT NULL,
--   moons TEXT[]
-- );

-- INSERT INTO planets
--   (name, orbital_period_in_years, orbits_around, galaxy, moons)
-- VALUES
--   ('Earth', 1.00, 'The Sun', 'Milky Way', '{"The Moon"}'),
--   ('Mars', 1.88, 'The Sun', 'Milky Way', '{"Phobos", "Deimos"}'),
--   ('Venus', 0.62, 'The Sun', 'Milky Way', '{}'),
--   ('Neptune', 164.8, 'The Sun', 'Milky Way', '{"Naiad", "Thalassa", "Despina", "Galatea", "Larissa", "S/2004 N 1", "Proteus", "Triton", "Nereid", "Halimede", "Sao", "Laomedeia", "Psamathe", "Neso"}'),
--   ('Proxima Centauri b', 0.03, 'Proxima Centauri', 'Milky Way', '{}'),
--   ('Gliese 876 b', 0.23, 'Gliese 876', 'Milky Way', '{}');


-- UPDATED SCHEMA DESIGN:
CREATE TABLE Galaxies (
    galaxy_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE
);

CREATE TABLE CelestialBodies (
    body_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    type TEXT NOT NULL, -- E.g., 'Planet', 'Star', 'Moon'
    galaxy_id INT REFERENCES Galaxies(galaxy_id)
);

CREATE TABLE Orbits (
    orbiting_body_id INT REFERENCES CelestialBodies(body_id),
    central_body_id INT REFERENCES CelestialBodies(body_id),
    orbital_period_in_years FLOAT,
    PRIMARY KEY (orbiting_body_id, central_body_id)
);

CREATE TABLE Moons (
    moon_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    planet_id INT REFERENCES CelestialBodies(body_id)
);



INSERT INTO Galaxies (name) VALUES
('Milky Way');

INSERT INTO CelestialBodies (name, type, galaxy_id) VALUES
('The Sun', 'Star', 1),
('Earth', 'Planet', 1),
('Mars', 'Planet', 1),
('Venus', 'Planet', 1),
('Neptune', 'Planet', 1),
('Proxima Centauri b', 'Planet', 1),
('Gliese 876 b', 'Planet', 1);

INSERT INTO Orbits (orbiting_body_id, central_body_id, orbital_period_in_years) VALUES
(2, 1, 1.00), 
(3, 1, 1.88), 
(4, 1, 0.62), 
(5, 1, 164.8);

INSERT INTO Moons (name, planet_id) VALUES
('The Moon', 2),
('Phobos', 3),
('Deimos', 3),
('Naiad', 5),
('Triton', 5);

-- from the terminal run:
-- psql < air_traffic.sql

DROP DATABASE IF EXISTS air_traffic;

CREATE DATABASE air_traffic;

\c air_traffic

-- OLD SCHEMA DESIGN:
-- CREATE TABLE tickets
-- (
--   id SERIAL PRIMARY KEY,
--   first_name TEXT NOT NULL,
--   last_name TEXT NOT NULL,
--   seat TEXT NOT NULL,
--   departure TIMESTAMP NOT NULL,
--   arrival TIMESTAMP NOT NULL,
--   airline TEXT NOT NULL,
--   from_city TEXT NOT NULL,
--   from_country TEXT NOT NULL,
--   to_city TEXT NOT NULL,
--   to_country TEXT NOT NULL
-- );

-- INSERT INTO tickets
--   (first_name, last_name, seat, departure, arrival, airline, from_city, from_country, to_city, to_country)
-- VALUES
--   ('Jennifer', 'Finch', '33B', '2018-04-08 09:00:00', '2018-04-08 12:00:00', 'United', 'Washington DC', 'United States', 'Seattle', 'United States'),
--   ('Thadeus', 'Gathercoal', '8A', '2018-12-19 12:45:00', '2018-12-19 16:15:00', 'British Airways', 'Tokyo', 'Japan', 'London', 'United Kingdom'),
--   ('Sonja', 'Pauley', '12F', '2018-01-02 07:00:00', '2018-01-02 08:03:00', 'Delta', 'Los Angeles', 'United States', 'Las Vegas', 'United States'),
--   ('Jennifer', 'Finch', '20A', '2018-04-15 16:50:00', '2018-04-15 21:00:00', 'Delta', 'Seattle', 'United States', 'Mexico City', 'Mexico'),
--   ('Waneta', 'Skeleton', '23D', '2018-08-01 18:30:00', '2018-08-01 21:50:00', 'TUI Fly Belgium', 'Paris', 'France', 'Casablanca', 'Morocco'),
--   ('Thadeus', 'Gathercoal', '18C', '2018-10-31 01:15:00', '2018-10-31 12:55:00', 'Air China', 'Dubai', 'UAE', 'Beijing', 'China'),
--   ('Berkie', 'Wycliff', '9E', '2019-02-06 06:00:00', '2019-02-06 07:47:00', 'United', 'New York', 'United States', 'Charlotte', 'United States'),
--   ('Alvin', 'Leathes', '1A', '2018-12-22 14:42:00', '2018-12-22 15:56:00', 'American Airlines', 'Cedar Rapids', 'United States', 'Chicago', 'United States'),
--   ('Berkie', 'Wycliff', '32B', '2019-02-06 16:28:00', '2019-02-06 19:18:00', 'American Airlines', 'Charlotte', 'United States', 'New Orleans', 'United States'),
--   ('Cory', 'Squibbes', '10D', '2019-01-20 19:30:00', '2019-01-20 22:45:00', 'Avianca Brasil', 'Sao Paolo', 'Brazil', 'Santiago', 'Chile');

--UPDATED SCHEMA DESIGN:
CREATE TABLE Locations (
    location_id SERIAL PRIMARY KEY,
    city TEXT NOT NULL,
    country TEXT NOT NULL,
    UNIQUE (city, country)
);

CREATE TABLE Flights (
    flight_id SERIAL PRIMARY KEY,
    airline TEXT NOT NULL,
    departure TIMESTAMP NOT NULL,
    arrival TIMESTAMP NOT NULL,
    from_location INT REFERENCES Locations(location_id),
    to_location INT REFERENCES Locations(location_id)
);

CREATE TABLE Tickets (
    ticket_id SERIAL PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    seat TEXT NOT NULL,
    flight_id INT REFERENCES Flights(flight_id)
);



INSERT INTO Locations (city, country) VALUES
('Washington DC', 'United States'),
('Seattle', 'United States'),
('Tokyo', 'Japan'),
('London', 'United Kingdom'),
('Los Angeles', 'United States'),
('Las Vegas', 'United States'),
('Paris', 'France'),
('Casablanca', 'Morocco');

INSERT INTO Flights (airline, departure, arrival, from_location, to_location) VALUES
('United', '2018-04-08 09:00:00', '2018-04-08 12:00:00', 1, 2),
('British Airways', '2018-12-19 12:45:00', '2018-12-19 16:15:00', 3, 4),
('Delta', '2018-01-02 07:00:00', '2018-01-02 08:03:00', 5, 6),
('TUI Fly Belgium', '2018-08-01 18:30:00', '2018-08-01 21:50:00', 7, 8);

INSERT INTO Tickets (first_name, last_name, seat, flight_id) VALUES
('Jennifer', 'Finch', '33B', 1),
('Thadeus', 'Gathercoal', '8A', 2),
('Sonja', 'Pauley', '12F', 3),
('Waneta', 'Skeleton', '23D', 4);
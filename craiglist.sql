CREATE TABLE Users (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    preferred_region_id INT REFERENCES Regions(region_id)
);

CREATE TABLE Regions (
    region_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE Posts (
    post_id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    content TEXT,
    user_id INT REFERENCES Users(user_id),
    region_id INT REFERENCES Regions(region_id),
    location VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Categories (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE PostCategories (
    post_id INT REFERENCES Posts(post_id),
    category_id INT REFERENCES Categories(category_id),
    PRIMARY KEY (post_id, category_id)
);


INSERT INTO Regions (name) VALUES
('San Francisco'), ('Seattle'), ('Atlanta');

INSERT INTO Users (name, email, preferred_region_id) VALUES
('Alice Johnson', 'alice@example.com', 1);

INSERT INTO Posts (title, content, user_id, region_id, location) VALUES
('Used Couch for Sale', 'Selling a slightly used couch.', 1, 1, '123 Main St');

INSERT INTO Categories (name) VALUES
('Furniture'), ('For Sale');

INSERT INTO PostCategories (post_id, category_id) VALUES
(1, 1), (1, 2);

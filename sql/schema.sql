-- Schema and sample data for Movie Cast Lookup
CREATE DATABASE IF NOT EXISTS movies_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE movies_db;

CREATE TABLE IF NOT EXISTS movies (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  year SMALLINT DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS actors (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS roles (
  id INT AUTO_INCREMENT PRIMARY KEY,
  movie_id INT NOT NULL,
  actor_id INT NOT NULL,
  role_name VARCHAR(255) NOT NULL,
  FOREIGN KEY (movie_id) REFERENCES movies(id) ON DELETE CASCADE,
  FOREIGN KEY (actor_id) REFERENCES actors(id) ON DELETE CASCADE
);

-- Sample data
INSERT INTO movies (title, year) VALUES ('The Matrix', 1999) ON DUPLICATE KEY UPDATE title=VALUES(title);
INSERT INTO actors (name) VALUES ('Keanu Reeves'), ('Laurence Fishburne'), ('Carrie-Anne Moss');

-- Map roles (assumes the inserted movie has id 1 and actors are 1..3)
INSERT INTO roles (movie_id, actor_id, role_name) VALUES (1,1,'Neo'), (1,2,'Morpheus'), (1,3,'Trinity');

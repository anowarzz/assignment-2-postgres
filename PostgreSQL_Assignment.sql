-- Active: 1747462889273@@127.0.0.1@5432@conservation_db@public

CREATE TABLE rangers (
ranger_id SERIAL PRIMARY KEY,
name VARCHAR(100),
region VARCHAR(100)
) ;


CREATE TABLE species (
species_id SERIAL PRIMARY KEY,
common_name VARCHAR(200),
scientific_name VARCHAR(250),
discovery_date DATE,
conservation_status VARCHAR(50)
);

CREATE TABLE sightings (
sighting_id SERIAL PRIMARY KEY,
ranger_id INTEGER REFERENCES rangers(ranger_id),
species_id INTEGER REFERENCES species(species_id),
sighting_time TIMESTAMP,
location VARCHAR (150),
notes TEXT
) ;

-- Inserting data on ranger table
INSERT INTO rangers (name, region) 
 VALUES
('Alice Green', 'Northern Hills'),
('Bob White', 'River Delta'),
('Carol King', 'Mountain Range');

-- Inserting data on species table
INSERT INTO species (common_name, scientific_name, discovery_date, conservation_status)
 VALUES
('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
('Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
('Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');

-- Inserting data on sightings table
INSERT INTO sightings (species_id, ranger_id, location, sighting_time, notes) VALUES
(1, 1, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image captured'),
(2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
(3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
(1, 2, 'Snowfall Pass', '2024-05-18 18:30:00', NULL);



-- 1️⃣ Register a new ranger with provided data with name = 'Derek Fox' and region = 'Coastal Plains'
INSERT INTO rangers (name, region) VALUES ('Derek Fox', 'Coastal Plains');


-- 2️⃣ Count unique species ever sighted.
SELECT count(DISTINCT species_id) as unique_species_count FROM sightings;


-- 3️⃣ Find all sightings where the location includes "Pass".
SELECT * FROM sightings 
WHERE location LIKE '%Pass%';

-- 4️⃣ List each ranger's name and their total number of sightings.
SELECT r.name , count(s.sighting_id) AS total_sightings FROM rangers r
INNER JOIN sightings s USING(ranger_id)
 GROUP BY r.ranger_id 
 ORDER BY r.name


-- 5️⃣ List species that have never been sighted.
SELECT common_name FROM species
LEFT JOIN sightings USING(species_id)
WHERE sightings.species_id IS NULL ;




-- 6️⃣ Show the most recent 2 sightings.
SELECT common_name, sighting_time, name FROM rangers
INNER JOIN sightings USING(ranger_id) INNER JOIN species USING(species_id) ORDER BY sighting_time DESC LIMIT 2; 


-- 7️⃣ Update all species discovered before year 1800 to have status 'Historic'.
UPDATE species
SET conservation_status = 'Historic' 
WHERE extract(YEAR FROM discovery_date) < 1800 ;


-- 8️⃣ Label each sighting's time of day as 'Morning', 'Afternoon', or 'Evening'.
SELECT sighting_id,
CASE 
    WHEN extract(hour FROM sighting_time) BETWEEN 0 AND 11 THEN 'Morning'  
    WHEN extract(hour FROM sighting_time) BETWEEN 12 AND 16 THEN 'Afternoon'  
    ELSE  'Evening'
END AS time_of_day
 FROM sightings;



-- 9️⃣ Delete rangers who have never sighted any species


SELECT * from rangers
-- Active: 1747462889273@@127.0.0.1@5432@conservation_db@public

CREATE TABLE rangers (
ranger_id SERIAL PRIMARY KEY,
name VARCHAR(100),
region VARCHAR(100)
) ;


DROP DATABASE IF EXISTS net_tv;
CREATE DATABASE IF NOT EXISTS net_tv;
USE net_tv;

DROP TABLE IF EXISTS channels,
                     programs,
                     seasons,
                     episodes, 
                     genres, 
                     program_slots,
                     program_genres,
                     views_records;


CREATE TABLE channels (
    id     INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    name   VARCHAR(100)       NOT NULL,
    UNIQUE KEY (name)
);

CREATE TABLE programs (
    id     INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    title   VARCHAR(100)      NOT NULL,
    description VARCHAR(100),
    has_seasons BOOLEAN       NOT NULL,
    UNIQUE  KEY (title)
);

CREATE TABLE seasons (
   id           INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
   program_id   INT                NOT NULL,
   FOREIGN KEY (program_id)  REFERENCES programs (id)    ON DELETE CASCADE,
   INDEX (program_id)
); 

CREATE TABLE episodes (
   id           INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
   title        VARCHAR(100)   NOT NULL,
   description  VARCHAR(100)   NOT NULL,
   length       INT            NOT NULL,
   release_date DATETIME       NOT NULL,
   season_id    INT,  
   FOREIGN KEY (season_id)  REFERENCES seasons (id)    ON DELETE CASCADE,
   INDEX (season_id)
); 

CREATE TABLE genres (
    id   INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    UNIQUE KEY (name)
);

CREATE TABLE program_slots (
    id            INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    channel_id    INT NOT NULL,
    program_id    INT NOT NULL,
    program_start DATETIME NOT NULL,
    program_end   DATETIME NOT NULL,
    FOREIGN KEY (channel_id) REFERENCES channels (id),
    FOREIGN KEY (program_id) REFERENCES programs (id),
    INDEX (channel_id, program_id)
) 
; 

CREATE TABLE program_genres (
    program_id INT NOT NULL,
    genre_id   INT NOT NULL,
    FOREIGN KEY (program_id) REFERENCES programs (id),
    FOREIGN KEY (genre_id)   REFERENCES genres (id),
    INDEX (program_id, genre_id)
) 
; 

CREATE TABLE view_records (
    id                INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    episode_id        INT NOT NULL,
    views             INT NOT NULL,
    FOREIGN KEY (episode_id) REFERENCES episodes(id),
    INDEX (episode_id, views)
) 
; 

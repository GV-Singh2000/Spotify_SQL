-- In this SQL file, write (and comment!) the typical SQL queries users will run on your database
-- Inserting sample data into artists table
INSERT INTO "artists" ("artist_id", "artist_name") VALUES
    (1, 'Ed Sheeran'),
    (2, 'Taylor Swift'),
    (3, 'Beyonce');

-- Inserting sample data into genres table
INSERT INTO "genres" ("genre_id", "genre_name") VALUES
    (1, 'Pop'),
    (2, 'Rock'),
    (3, 'R&B');

-- Inserting sample data into albums table
INSERT INTO "albums" ("album_id", "album_name", "release_date", "artist_id") VALUES
    (1, '÷', '2017-03-03', 1),
    (2, '1989', '2014-10-27', 2),
    (3, 'Lemonade', '2016-04-23', 3);

-- Inserting sample data into songs table
INSERT INTO "songs" ("song_id", "song_name", "album_id", "genre_id", "release_date") VALUES
    (1, 'Shape of You', 1, 1, '2017-01-06'),
    (2, 'Blank Space', 2, 1, '2014-11-10'),
    (3, 'Formation', 3, 3, '2016-02-06');

-- Inserting sample data into playlists table
INSERT INTO "playlists" ("playlist_id", "playlist_name") VALUES
    (1, 'Party Mix'),
    (2, 'Chill Vibes');

-- Inserting sample data into playlist_songs table
INSERT INTO "playlist_songs" ("playlist_id", "song_id") VALUES
    (1, 1),
    (1, 2),
    (2, 3);

-- SELECT query to retrieve all artists
SELECT * FROM "artists";

-- UPDATE query to change the genre of a song
UPDATE "songs" SET "genre_id" = 2 WHERE "song_id" = 1;

-- DELETE query to remove a song from a playlist
DELETE FROM "playlist_songs" WHERE "playlist_id" = 1 AND "song_id" = 2;

-- SELECT query to view playlist details with song counts by genre and year
SELECT * FROM "playlist_genre_year_counts";

-- DROP VIEW command to remove the created view
DROP VIEW IF EXISTS "playlist_genre_year_counts";

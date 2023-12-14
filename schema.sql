-- In this SQL file, write (and comment!) the schema of your database, including the CREATE TABLE, CREATE INDEX, CREATE VIEW, etc. statements that compose it

-- Table to store information about artists
CREATE TABLE IF NOT EXISTS "artists" (
    "artist_id" INTEGER PRIMARY KEY,
    "artist_name" TEXT NOT NULL
);

-- Table to store information about genres
CREATE TABLE IF NOT EXISTS "genres" (
    "genre_id" INTEGER PRIMARY KEY,
    "genre_name" TEXT NOT NULL
);

-- Table to store information about albums
CREATE TABLE IF NOT EXISTS "albums" (
    "album_id" INTEGER PRIMARY KEY,
    "album_name" TEXT NOT NULL,
    "release_date" DATE,
    "artist_id" INTEGER,
    FOREIGN KEY ("artist_id") REFERENCES "artists"("artist_id")
);

-- Table to store information about songs
CREATE TABLE IF NOT EXISTS "songs" (
    "song_id" INTEGER PRIMARY KEY,
    "song_name" TEXT NOT NULL,
    "album_id" INTEGER,
    "genre_id" INTEGER,
    "release_date" DATE,
    FOREIGN KEY ("album_id") REFERENCES "albums"("album_id"),
    FOREIGN KEY ("genre_id") REFERENCES "genres"("genre_id")
);

-- Table to store information about playlists
CREATE TABLE IF NOT EXISTS "playlists" (
    "playlist_id" INTEGER PRIMARY KEY,
    "playlist_name" TEXT NOT NULL
);

-- Table to associate songs with playlists (many-to-many relationship)
CREATE TABLE IF NOT EXISTS "playlist_songs" (
    "playlist_id" INTEGER,
    "song_id" INTEGER,
    PRIMARY KEY ("playlist_id", "song_id"),
    FOREIGN KEY ("playlist_id") REFERENCES "playlists"("playlist_id"),
    FOREIGN KEY ("song_id") REFERENCES "songs"("song_id")
);

-- View to get the total number of songs in a playlist of a particular genre and year
CREATE VIEW "playlist_genre_year_counts" AS
SELECT
    p."playlist_id",
    p."playlist_name",
    g."genre_id",
    g."genre_name",
    strftime('%Y', s."release_date") AS "release_year",
    COUNT(ps."song_id") AS "song_count"
FROM "playlists" p
JOIN "playlist_songs" ps ON p."playlist_id" = ps."playlist_id"
JOIN "songs" s ON ps."song_id" = s."song_id"
JOIN "genres" g ON s."genre_id" = g."genre_id"
GROUP BY p."playlist_id", g."genre_id", "release_year";

-- Indexes for better performance
CREATE INDEX IF NOT EXISTS "idx_playlist_name" ON "playlists"("playlist_name");
CREATE INDEX IF NOT EXISTS "idx_genre_name" ON "genres"("genre_name");
CREATE INDEX IF NOT EXISTS "idx_release_date" ON "songs"("release_date");
CREATE INDEX IF NOT EXISTS "idx_playlist_songs" ON "playlist_songs"("playlist_id", "song_id");

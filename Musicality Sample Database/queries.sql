-- get all songs in a playlist including album name and artist name
SELECT song.title, artist.name AS artist_name, album.name AS album_name, song.length
FROM song
NATURAL JOIN artist_for
INNER JOIN artist ON artist_for.artist_id = artist.artist_id
NATURAL JOIN album_song
INNER JOIN album ON album_song.album_id = album.album_id
WHERE song.song_id IN (SELECT playlist_song.song_id FROM playlist_song WHERE playlist_song.playlist_id = 1);

-- get name and length of all playlists, as well as the name of user who owns playlist
SELECT playlist.name, user.name, (SELECT SEC_TO_TIME(SUM(TIME_TO_SEC(song.length)))) AS playlist_length
FROM playlist_song
INNER JOIN playlist
ON playlist_song.playlist_id = playlist.playlist_id
INNER JOIN song
ON playlist_song.song_id = song.song_id
INNER JOIN user
ON playlist.user_id = user.user_id
GROUP BY playlist.playlist_id
ORDER BY playlist_length DESC;

-- Get play list id, name, and user who created playlist that contains a song from a particular artist
SELECT playlist.playlist_id, playlist.name, user.name
FROM playlist_song
INNER JOIN playlist
ON playlist_song.playlist_id = playlist.playlist_id
INNER JOIN artist_for
ON playlist_song.song_id = artist_for.song_id
INNER JOIN artist
ON artist_for.artist_id = artist.artist_id
INNER JOIN user
ON playlist.user_id = user.user_id
WHERE artist.name = "Drake";

-- get list of playlists sorted by likes
SELECT post.playlist_id, COUNT(likes.post_id) AS Num_Likes
FROM likes
INNER JOIN post
ON likes.post_id = post.post_id
GROUP BY post.playlist_id
ORDER BY Num_Likes DESC;

-- Get song that are in the most playlist, including artist and albumn name
SELECT song.song_id, song.title, artist.name AS Artist_Name, album.name AS Album_Name, COUNT(DISTINCT playlist_id) AS Num_Playlists
FROM playlist_song
NATURAL JOIN song
NATURAL JOIN artist_for
INNER JOIN artist
ON artist_for.artist_id = artist.artist_id
NATURAL JOIN album_song
INNER JOIN album
ON album_song.album_id = album.album_id
GROUP BY (song.song_id)
ORDER BY Num_Playlists DESC;

-- Get artists that are in the most playlists
SELECT artist.artist_id, artist.name AS Artist_Name, COUNT(DISTINCT playlist_id) as Num_Playlists
FROM playlist_song
NATURAL JOIN artist_for
INNER JOIN artist
ON artist_for.artist_id = artist.artist_id
GROUP BY (artist.artist_id)
ORDER BY Num_Playlists DESC;

-- get albums in most playlists
SELECT album.album_id, album.name AS Album_Name, artist.name AS Artist_Name, COUNT(DISTINCT playlist_id) AS Num_Playlists
FROM playlist_song
NATURAL JOIN artist_for
INNER JOIN artist
ON artist_for.artist_id = artist.artist_id
NATURAL JOIN album_song
INNER JOIN album
ON album_song.album_id = album.album_id
GROUP BY (album.album_id)
ORDER BY Num_Playlists DESC;

-- Get all song, genres pairs from songs that exceed a certain length
SELECT song.song_id, song.title, artist.name AS Artist_Name, album.name AS Album_Name, song.genre, song.length
FROM song
NATURAL JOIN artist_for
INNER JOIN artist
ON artist_for.artist_id = artist.artist_id
NATURAL JOIN album_song
INNER JOIN album
ON album_song.album_id = album.album_id
WHERE song.length > '0:2:00';

-- get all songs that have multiple artists
SELECT song.song_id, song.title, COUNT(DISTINCT artist_id) AS Num_Artists
FROM artist_for
NATURAL JOIN song
GROUP BY (song_id)
HAVING Num_Artists > 1;

-- get list of artists sorted by number of albums they have
SELECT artist_id, name, COUNT(DISTINCT album_id) AS Num_Albums
FROM artist_for
NATURAL JOIN artist
NATURAL JOIN album_song
GROUP BY (artist_id)
ORDER BY Num_Albums DESC;

-- get the 5 genres wit hthe most songs along with number of songs in that genre
SELECT genre, COUNT(song_id) AS Num_Songs
FROM song
GROUP BY genre
ORDER BY Num_Songs DESC LIMIT 5;

-- get all comments for a particular post
SELECT name, comment.*
FROM comment
NATURAL JOIN user
WHERE post_id = 9;

-- get all comments from a particular user
SELECT name, comment.*
FROM comment
NATURAL JOIN user
WHERE user_id = 1;

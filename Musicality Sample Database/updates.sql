-- change all genres in songs from "Alt. Rock" to "Alternative Rock"
UPDATE song
SET genre = "Alternative Rock"
WHERE song.genre = "Alt. Rock";

-- update a user's city and state to New Orleans, LA
UPDATE user
SET city = "New Orleans", state = "LA"
WHERE user.user_id = 3;

-- update playlist description, name
UPDATE playlist
SET description = "I figured out how to create a new playlist!", name = "My new playlist"
WHERE playlist.playlist_id = 11;

-- update comment text
UPDATE comment
SET text = CONCAT(text, " EDIT: Thanks for the gold, kind stranger!")
WHERE comment.comment_id = 5;

-- update user bio
UPDATE user
SET bio = "Check out my playlists...or else!"
WHERE user.user_id = 1;

-- update Comfortably Numb to be in album "The Wall"
UPDATE album_song
SET song_id = (SELECT song_id FROM song WHERE title = "Comfortably Numb")
WHERE album_id = (SELECT album_id FROM album WHERE name = "The Wall"); 

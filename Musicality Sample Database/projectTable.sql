CREATE TABLE user(
    user_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(30) NOT NULL,
    city VARCHAR(20) NOT NULL,
    state CHAR(2) NOT NULL,
    signup_date DATE NOT NULL,
    dob DATE NOT NULL,
    bio VARCHAR(250),
    PRIMARY KEY (user_id)
);

CREATE TABLE playlist(
    playlist_id INT NOT NULL AUTO_INCREMENT,
    user_id INT REFERENCES user(user_id),
    name VARCHAR(30) NOT NULL,
    description VARCHAR(250),
	creation_date DATE,
    PRIMARY KEY (playlist_id)
);

CREATE TABLE post(
    post_id INT NOT NULL AUTO_INCREMENT,
    user_id INT REFERENCES user(user_id),
    playlist_id INT REFERENCES playlist(playlist_id),
    date DATE NOT NULL,
    PRIMARY KEY (post_id)
);

CREATE TABLE comment(
    comment_id INT NOT NULL AUTO_INCREMENT,
    post_id INT REFERENCES post(post_id),
    user_id INT REFERENCES user(user_id),
    text VARCHAR(250) NOT NULL,
    date DATE NOT NULL,
    PRIMARY KEY (comment_id)
);

CREATE TABLE artist(
    artist_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(30) NOT NULL,
    PRIMARY KEY (artist_id)
);

CREATE TABLE song(
    song_id INT AUTO_INCREMENT NOT NULL,
    title VARCHAR(50) NOT NULL,
    year YEAR NOT NULL,
    genre VARCHAR(20) NOT NULL,
    length TIME NOT NULL,
    PRIMARY KEY (song_id)
);

CREATE TABLE album(
    album_id INT AUTO_INCREMENT NOT NULL,
    name VARCHAR(60) NOT NULL,
    date DATE NOT NULL,
    PRIMARY KEY (album_id)
);

CREATE TABLE follows(
user_id INT,
follows_u_id INT,
date DATE NOT NULL,
FOREIGN KEY (user_id) REFERENCES user(user_id),
FOREIGN KEY (follows_u_id) REFERENCES user(user_id),
PRIMARY KEY (user_id,follows_u_id)
);

CREATE TABLE likes(
    user_id INT,
    post_id INT,
    date DATE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES user(user_id),
    FOREIGN KEY (post_id) REFERENCES post(post_id),
    PRIMARY KEY (user_id, post_id)
);

CREATE TABLE artist_for(
    song_id INT,
    artist_id INT,
    FOREIGN KEY (song_id) REFERENCES song(song_id),
    FOREIGN KEY (artist_id) REFERENCES artist(artist_id),
    PRIMARY KEY (song_id, artist_id)
);

CREATE TABLE playlist_song(
    playlist_id INT,
    song_id INT,
    FOREIGN KEY (playlist_id) REFERENCES playlist(playlist_id),
    FOREIGN KEY (song_id) REFERENCES song(song_id),
    PRIMARY KEY (playlist_id, song_id)
);

CREATE TABLE album_song(
    album_id INT,
    song_id INT,
    FOREIGN KEY (album_id) REFERENCES album(album_id),
    FOREIGN KEY (song_id) REFERENCES song(song_id),
    PRIMARY KEY (album_id, song_id)
);

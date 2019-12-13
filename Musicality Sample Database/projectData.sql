-- INSERT SONGS

insert into song values (NULL,'Hotline Bling', '2016', 'Hip-Hop/Rap', '0:4:27');
insert into song values (NULL,'Only Girl (In the World)', '2010', 'Pop', '0:3:55');
insert into song values (NULL,'Ride of the Valkyries', '1979', 'soundtrack', '0:5:31');
insert into song values (NULL,'Say Something', '2018', 'Pop', '0:4:38');
insert into song values (NULL,'Barbie Girl', '1997', 'Pop', '0:3:17');
insert into song values (NULL,'Never Gonna Give You Up', '1987', 'Pop', '0:3:32');
insert into song values (NULL,'Think of Me', '2004', 'soundtrack', '0:3:39');
insert into song values (NULL,'Last to Know', '2009', 'Alt. Rock', '0:3:27');
insert into song values (NULL,'Walk This Way', '1975', 'Rock', '0:3:40');
insert into song values (NULL,'Hey Jude', '1968', 'Rock', '0:3:58');
insert into song values (NULL,'Pour Some Sugar on Me', '1987', 'Classic Rock', '0:4:27');
insert into song values (NULL,'Shake It Off', '2014', 'Pop', '0:3:39');
insert into song values (NULL,'Bad Blood', '2014', 'Pop', '0:3:31');
insert into song values (NULL,'Comfortably Numb', '1979', 'Progressive Rock', '0:6:23');
insert into song values (NULL,'Paranoid Android', '1997', 'Alt. Rock', '0:6:27');
insert into song values (NULL,'1985', '2004', 'Alt. Rock', '0:3:13');
insert into song values (NULL,'Baby Shark', '2016', 'Childrens', '0:1:46');
insert into song values (NULL,'Girl All the Bad Guys Want', '2002', 'Alt. Rock', '0:3:33');
insert into song values (NULL,'High School Never Ends', '2006', 'Alt. Rock', '0:3:29');
insert into song values (NULL,'We Will Rock You', '1977', 'Classic Rock', '0:2:02');
insert into song values (NULL,'Bohemian Rhapsody', '1975', 'Classic Rock', '0:5:55');
insert into song values (NULL,'Bicycle Race', '1978', 'Classic Rock', '0:3:01');
insert into song values (NULL,'Fat Bottom Girls', '1978', 'Classic Rock', '0:4:16');
insert into song values (NULL,'What`s My Name', '2010', 'Pop', '0:4:24');

-- INSERT USERS

Insert into user values (NULL, "Daniel","Baton Rouge", "LA", STR_TO_DATE("21,5,2013","%d,%m,%Y"), STR_TO_DATE("3,5,1998","%d,%m,%Y"), "Salutations my fellow music lovers");
Insert into user values (NULL, "Josh", "Encino", "CA", STR_TO_DATE("16,7,2015","%d,%m,%Y"), STR_TO_DATE("1,2,1995","%d,%m,%Y"), "Drake, where’s The Doors?");
Insert into user values (NULL, "Joe", "Boston", "MA", STR_TO_DATE("16,7,2018","%d,%m,%Y"), STR_TO_DATE("9,9,1968","%d,%m,%Y"), "Music was way much better in my day.");
Insert into user values (NULL, "Carl", "Sacramento", "CA", STR_TO_DATE("17,10,2017","%d,%m,%Y"), STR_TO_DATE("8,11,1999","%d,%m,%Y"), "Jeffery Epstein didn’t kill himself");
Insert into user values (NULL, "James", "Phoenix", "AZ", STR_TO_DATE("13,10,2013","%d,%m,%Y"), STR_TO_DATE("4,5,2000","%d,%m,%Y"), "Like my playlists please");
Insert into user values (NULL, "Spencer", "Baton Rouge", "LA", STR_TO_DATE("17,10,2017","%d,%m,%Y"), STR_TO_DATE("7,4,1995","%d,%m,%Y"), "You better call 3872323 right now");
Insert into user values (NULL, "Jeb", "Jackson", "MS", STR_TO_DATE("12,9,2019","%d,%m,%Y"), STR_TO_DATE("3,1,1950","%d,%m,%Y"), "My name is Jeb but you can call me Jebra");
Insert into user values (NULL, "Ricky", "New York", "NY", STR_TO_DATE("7,7,2017","%d,%m,%Y"), STR_TO_DATE("1,2,1980","%d,%m,%Y"), "I'm not a pessimist. I'm an optometrist.");
Insert into user values (NULL, "Ed", "Peach Creek", "ME", STR_TO_DATE("8,4,2017","%d,%m,%Y"), STR_TO_DATE("4,6,1995","%d,%m,%Y"), "Work that body work that body don’t you go hurt nobody.");
Insert into user values (NULL, "Frank", "Philadelphia", "PA", STR_TO_DATE("11,4,2017","%d,%m,%Y"), STR_TO_DATE("15,4,1953","%d,%m,%Y"), "Can I offer you some Gregg Allman in this trying time?");
Insert into user values (NULL, "Emma", "Denver", "CO", STR_TO_DATE("8,4,2017","%d,%m,%Y"), STR_TO_DATE("4,6,1995","%d,%m,%Y"), "S[he] Be[lie]ve[d]");
Insert into user values (NULL, "John Fortnite Kennedy", "Brookline", "MA", STR_TO_DATE("8,1,2019","%d,%m,%Y"), STR_TO_DATE("6,5,1942","%d,%m,%Y"), "The ignorance of one voter in a playlist sharing service impairs the security of all");

-- INSERT POST

Insert into post values (NULL,1,1, STR_TO_DATE('8,1,2019','%m,%d,%Y'));
Insert into post values (NULL,1,2, STR_TO_DATE('8,5,2019','%m,%d,%Y'));
Insert into post values (NULL,2,3, STR_TO_DATE('8,11,2019','%m,%d,%Y'));
Insert into post values (NULL,3,4, STR_TO_DATE('9,11,2019','%m,%d,%Y'));
Insert into post values (NULL,4,5, STR_TO_DATE('9,8,2019','%m,%d,%Y'));
Insert into post values (NULL,4,6, STR_TO_DATE('9,19,2019','%m,%d,%Y'));
Insert into post values (NULL,4,7, STR_TO_DATE('9,30,2019','%m,%d,%Y'));
Insert into post values (NULL,5,8, STR_TO_DATE('6,30,2019','%m,%d,%Y'));
Insert into post values (NULL,6,9, STR_TO_DATE('6,19,2019','%m,%d,%Y'));
Insert into post values (NULL,7,10, STR_TO_DATE('5,20,2019','%m,%d,%Y'));
Insert into post values (NULL,8,11, STR_TO_DATE('4,20,2019','%m,%d,%Y'));
Insert into post values (NULL,9,12, STR_TO_DATE('4,17,2019','%m,%d,%Y'));
Insert into post values (NULL,10,13, STR_TO_DATE('4,14,2019','%m,%d,%Y'));
Insert into post values (NULL,11,14, STR_TO_DATE('4,4,2019','%m,%d,%Y'));
Insert into post values (NULL,12,15, STR_TO_DATE('4,1,2019','%m,%d,%Y'));

-- INSERT COMMENTS

Insert into comment values (NULL, 1, 2, "Anyone else listening to this from Australia?", CURDATE());
Insert into comment values (NULL, 1, 1, "Thanks for listening!", STR_TO_DATE("7,11,2019","%d,%m,%Y"));
Insert into comment values (NULL, 1, 2, "I didn’t say it was good, idiot.", STR_TO_DATE('8,11,2019','%d,%m,%Y'));
Insert into comment values (NULL, 2, 4, "Nice playlist!", STR_TO_DATE('6,11,2019','%d,%m,%Y'));
Insert into comment values (NULL, 2, 5, "I like the songs in this playlist.", STR_TO_DATE('7,11,2019','%d,%m,%Y'));
Insert into comment values(NULL, 3, 5, "This playlist SUCKS!", STR_TO_DATE('9,11,2019','%d,%m,%Y'));
Insert into comment values(NULL, 4, 6, "I listen to this playlist at the gym.", STR_TO_DATE('10,11,2019','%d,%m,%Y'));
Insert into comment values(NULL, 4, 1, "This playlist brought back a previous heart condition I had.", STR_TO_DATE('15,11,2019','%d,%m,%Y'));
Insert into comment values(NULL, 5, 3, "My child loves this playlist!", STR_TO_DATE('1,9,2019','%d,%m,%Y'));
Insert into comment values(NULL, 5, 4, "Yeah, because only children can find enjoyment out of these songs.", STR_TO_DATE('2,9,2019','%d,%m,%Y'));
Insert into comment values(NULL, 6, 3, "Yeah it’s okay, I guess.", STR_TO_DATE('3,9,2019','%d,%m,%Y'));
Insert into comment values(NULL, 6, 10, "This playlist is the definition of adequate.", STR_TO_DATE('4,9,2019','%d,%m,%Y'));
Insert into comment values(NULL, 7, 12, "First!", STR_TO_DATE('5,9,2019','%d,%m,%Y'));
Insert into comment values(NULL, 7, 2, "Did you really think commenting that was a good use of your time?", STR_TO_DATE('6,9,2019','%d,%m,%Y'));
Insert into comment values(NULL, 8, 3, "Very good playlist, nice job!", STR_TO_DATE('7,9,2019','%d,%m,%Y'));
Insert into comment values(NULL, 8, 4, "A good playlist.", STR_TO_DATE('8,9,2019','%d,%m,%Y'));
Insert into comment values(NULL, 9, 1, "This is such a fun playist!", STR_TO_DATE('9,9,2019','%d,%m,%Y'));
Insert into comment values(NULL, 9, 2, "I think you meant playlist.",  STR_TO_DATE('10,9,2019','%d,%m,%Y'));
Insert into comment values(NULL, 9, 1, "Yeah, no kidding.", STR_TO_DATE('11,9,2019','%d,%m,%Y'));
Insert into comment values(NULL, 9, 8, "Be sensitive, I`m grieving.", STR_TO_DATE('11,9,2019','%d,%m,%Y'));
Insert into comment values(NULL, 10, 8, "Listening to this on my ride to work!", STR_TO_DATE('12,9,2019','%d,%m,%Y'));
Insert into comment values(NULL, 10, 5, "Hope you typed that out at a red light then.", STR_TO_DATE('13,9,2019','%d,%m,%Y'));
Insert into comment values(NULL, 10, 8, "Nope!", STR_TO_DATE('14,9,2019','%d,%m,%Y'));
Insert into comment values(NULL, 10, 6, "r/madlads", STR_TO_DATE('15,9,2019','%d,%m,%Y'));
Insert into comment values(NULL, 10, 5, "r/ihavereddit", STR_TO_DATE('16,9,2019','%d,%m,%Y'));
Insert into comment values(NULL, 11, 9, "My husbands love listening to this!", STR_TO_DATE('17,9,2019','%d,%m,%Y'));
Insert into comment values(NULL, 12, 10, "Good job on this!", STR_TO_DATE('18,9,2019','%d,%m,%Y'));
Insert into comment values(NULL, 12, 11, "Nice.", STR_TO_DATE('19,9,2019','%d,%m,%Y'));
Insert into comment values(NULL, 13, 5, "Sounds like what was played at my dad's funeral", STR_TO_DATE('20,9,2019','%d,%m,%Y'));
Insert into comment values(NULL, 14, 6, "Anyone else never want to listen to this playlist again?", STR_TO_DATE('21,9,2019','%d,%m,%Y'));
Insert into comment values(NULL, 9, 11, "Oh no! Not your wonderful goldfish!", STR_TO_DATE('12,9,2019','%d,%m,%Y'));
Insert into comment values(NULL, 9, 8, "Yeah... Goldy Goldenfin was special.  I miss him.", STR_TO_DATE('12,9,2019','%d,%m,%Y'));
Insert into comment values(NULL, 9, 11, "I am soooooooo sorry for your loss.", STR_TO_DATE('13,9,2019','%d,%m,%Y'));
Insert into comment values(NULL, 15, 3, "I didn`t like it.", STR_TO_DATE('22,9,2019','%d,%m,%Y'));

-- INSERT ARTIST

Insert into artist values (NULL, 'Drake');
Insert into artist values (NULL, 'Taylor Swift');
Insert into artist values (NULL, 'Rihanna');
Insert into artist values (NULL, 'Richard Wagner');
Insert into artist values (NULL, 'A Great Big World');
Insert into artist values (NULL, 'Aqua');
Insert into artist values (NULL, 'Rick Astley');
Insert into artist values (NULL, 'Patrick Wilson');
Insert into artist values (NULL, 'Three Days Grace');
Insert into artist values (NULL, 'Aerosmith');
Insert into artist values (NULL, 'The Beatles');
Insert into artist values (NULL, 'Def Leppard');
Insert into artist values (NULL, 'Bruno Mars');
Insert into artist values (NULL, 'Justin Timberlake');
Insert into artist values (NULL, 'Chris Stapleton');
Insert into artist values (NULL, 'Emmy Rossum');
Insert into artist values (NULL, 'Pink Floyd');
Insert into artist values (Null, 'Radiohead');
Insert into artist values (Null, 'Bowling For Soup');
Insert into artist values (Null, 'Pinkfong');
Insert into artist values (Null, 'Queen');
Insert into artist values (Null, 'Andrew Lloyd Webber');

-- INSERT PLAYLIST

Insert into playlist values (NULL, 1, 'My playlist', "This is a playlist of my favorite songs, hope you enjoy!", STR_TO_DATE('1,7,2019','%d,%m,%Y'));
Insert into playlist values (NULL, 2, 'Playlist for the ages', "Only listen to this playlist if you are prepared to have your socks blown off", STR_TO_DATE('2,7,2019','%d,%m,%Y'));
Insert into playlist values (NULL, 3, 'Best of rock', "A playlist for true rock & roll lovers", STR_TO_DATE('3,7,2019','%d,%m,%Y'));
Insert into playlist values (NULL, 4, 'Worst of Becky', "This is a playlist of all the songs that annoy my ex-girlfriend Becky. Screw you Becky.", STR_TO_DATE('4,7,2019','%d,%m,%Y'));
Insert into playlist values (NULL, 5, 'Inspiration', "A playlist of songs that inspire you to work.", STR_TO_DATE('5,7,2019','%d,%m,%Y'));
Insert into playlist values (NULL, 6, 'Hell', "That playlist your hear at the gates of hell.", STR_TO_DATE('6,7,2019','%d,%m,%Y'));
Insert into playlist values (NULL, 7, 'Best of pop', "A playlist that contains only the best songs that pop has to offer.", STR_TO_DATE('7,7,2019','%d,%m,%Y'));
Insert into playlist values (NULL, 8, 'Gold', "Songs I like to play for my pet goldfish.", STR_TO_DATE('8,7,2019','%d,%m,%Y'));
Insert into playlist values (NULL, 8, 'Golden memories', "Songs I like to play in remembrance of my pet goldfish", STR_TO_DATE('13,7,2019','%d,%m,%Y'));
Insert into playlist values (NULL, 9, 'Golden', "Dedicated to my professor", STR_TO_DATE('14,7,2019','%d,%m,%Y'));
Insert into playlist values (NULL, 10, 'How do you cre', "How do you create a playlist", STR_TO_DATE('15,7,2019','%d,%m,%Y'));
Insert into playlist values (NULL, 11, 'My favorite songs', "How do you create a playlist", STR_TO_DATE('16,7,2019','%d,%m,%Y'));

-- INSERT ALBUM

Insert into album values (NULL, 'Views', STR_TO_DATE('29,4,2016','%d,%m,%Y'));
Insert into album values (NULL, '1989', STR_TO_DATE('27,10,2014','%d,%m,%Y'));
Insert into album values (NULL, 'Loud', STR_TO_DATE('12,11,2010','%d,%m,%Y'));
Insert into album values (NULL, 'The Ride of the Valkyries', STR_TO_DATE('23,11,1988','%d,%m,%Y'));
Insert into album values (NULL, 'Aquarium', STR_TO_DATE('26,3,1997','%d,%m,%Y'));
Insert into album values (NULL, 'Whenever You Need Somebody', STR_TO_DATE('16,11,1987','%d,%m,%Y'));
Insert into album values (NULL, 'The Phantom of the Opera', STR_TO_DATE('23,11,2004','%d,%m,%Y'));
Insert into album values (NULL, 'Life Starts Now', STR_TO_DATE('22,9,2009','%d,%m,%Y'));
Insert into album values (NULL, 'Toys in the Attic', STR_TO_DATE('8,4,1975','%d,%m,%Y'));
Insert into album values (NULL, 'Hey Jude', STR_TO_DATE('11,5,1975','%d,%m,%Y'));
Insert into album values (NULL, 'Hysteria', STR_TO_DATE('8,9,1987','%d,%m,%Y'));
Insert into album values (NULL, 'The Wall', STR_TO_DATE('30,11,1979','%d,%m,%Y'));
Insert into album values (NULL, 'OK Computer', STR_TO_DATE('21,5,1997','%d,%m,%Y'));
Insert into album values (Null, 'Comfortably Numb', STR_TO_DATE('23,6,1980', '%d,%m,%Y'));
Insert into album values (Null, 'A Hangover You Don`t Deserve', STR_TO_DATE('14,9,2004', '%d,%m,%Y'));
Insert into album values (Null, 'The Great Burrito Extortion Case', STR_TO_DATE('7,11,2006', '%d,%m,%Y'));
Insert into album values (Null, 'Drunk Enough to Dance', STR_TO_DATE('20,8,2002', '%d,%m,%Y'));
Insert into album values (Null, 'Pinkfong Animal Songs', STR_TO_DATE('27,7,2017', '%d,%m,%Y'));
Insert into album values (Null, 'Jazz', STR_TO_DATE('10,11,1978', '%d,%m,%Y'));
Insert into album values (Null, 'A Night at the Opera', STR_TO_DATE('21,11,1975', '%d,%m,%Y'));
Insert into album values (Null, 'News of the World', STR_TO_DATE('28,10,1977', '%d,%m,%Y'));
Insert into album values (Null, 'The Platinum Collection (Greatest Hits I, II, & III)', STR_TO_DATE('13,11,2000', '%d,%m,%Y'));

-- INSERT FOLLOWS

Insert into follows values (1, 1, STR_TO_DATE("2,4,2019","%d,%m,%Y"));
Insert into follows values (1, 2, STR_TO_DATE("3,4,2019","%d,%m,%Y"));
Insert into follows values (1, 3, STR_TO_DATE("4,4,2019","%d,%m,%Y"));
Insert into follows values (2, 1, STR_TO_DATE("5,4,2019","%d,%m,%Y"));
Insert into follows values (3, 3, STR_TO_DATE("6,4,2019","%d,%m,%Y"));
Insert into follows values (3, 4, STR_TO_DATE("7,4,2019","%d,%m,%Y"));
Insert into follows values (4, 3, STR_TO_DATE("8,4,2019","%d,%m,%Y"));
Insert into follows values (5, 4, STR_TO_DATE("9,4,2019","%d,%m,%Y"));
Insert into follows values (5, 6, STR_TO_DATE("10,4,2019","%d,%m,%Y"));
Insert into follows values (5, 7, STR_TO_DATE("11,4,2019","%d,%m,%Y"));
Insert into follows values (5, 8, STR_TO_DATE("12,4,2019","%d,%m,%Y"));
Insert into follows values (6, 8, STR_TO_DATE("13,4,2019","%d,%m,%Y"));
Insert into follows values (7, 9, STR_TO_DATE("14,4,2019","%d,%m,%Y"));
Insert into follows values (8, 10, STR_TO_DATE("15,4,2019","%d,%m,%Y"));
Insert into follows values (8, 11, STR_TO_DATE("16,4,2019","%d,%m,%Y"));
Insert into follows values (9, 12, STR_TO_DATE("19,5,2019","%d,%m,%Y"));
Insert into follows values (10, 12, STR_TO_DATE("20,5,2019","%d,%m,%Y"));
Insert into follows values (10, 1, STR_TO_DATE("21,5,2019","%d,%m,%Y"));
Insert into follows values (10, 2, STR_TO_DATE("22,5,2019","%d,%m,%Y"));
Insert into follows values (10, 3, STR_TO_DATE("13,5,2019","%d,%m,%Y"));
Insert into follows values (11, 12, STR_TO_DATE("29,5,2019","%d,%m,%Y"));

-- INSERT LIKES

Insert into likes values (2, 4, STR_TO_DATE("12,5,2019","%d,%m,%Y"));
Insert into likes values (5, 15, STR_TO_DATE("9,10,2019","%d,%m,%Y"));
Insert into likes values (10, 7, STR_TO_DATE("24, 8, 2019","%d,%m,%Y"));
Insert into likes values (4, 12, STR_TO_DATE("7,9,2019","%d,%m,%Y"));
Insert into likes values (1, 3, STR_TO_DATE("12,4,2019","%d,%m,%Y"));
Insert into likes values (8, 8, STR_TO_DATE("1,8,2019","%d,%m,%Y"));
Insert into likes values (5, 10, STR_TO_DATE("29,5,2019","%d,%m,%Y"));
Insert into likes values (3, 7, STR_TO_DATE("9,11,2019","%d,%m,%Y"));
Insert into likes values (1, 13, STR_TO_DATE("15,7,2019","%d,%m,%Y"));
Insert into likes values (2, 12, STR_TO_DATE("28,2,2019","%d,%m,%Y"));
Insert into likes values (3, 6, STR_TO_DATE("27,5,2019","%d,%m,%Y"));
Insert into likes values (4, 13, STR_TO_DATE("16,3,2019","%d,%m,%Y"));
Insert into likes values (7, 5, STR_TO_DATE("30,6,2019","%d,%m,%Y"));
Insert into likes values (10, 3, STR_TO_DATE("2,6,2019","%d,%m,%Y"));
Insert into likes values (12, 10, STR_TO_DATE("20,10,2019","%d,%m,%Y"));

-- INSERT artist_for

Insert into artist_for values (1, 1);
Insert into artist_for values (2, 3);
Insert into artist_for values (3, 4);
Insert into artist_for values (4, 5);
Insert into artist_for values (5, 6);
Insert into artist_for values (6, 7);
Insert into artist_for values (7, 8);
Insert into artist_for values (8, 9);
Insert into artist_for values (9, 10);
Insert into artist_for values (10, 11);
Insert into artist_for values (11,12);
Insert into artist_for values (12, 2);
Insert into artist_for values (13, 2);
Insert into artist_for values (14, 17);
Insert into artist_for values (15, 18);
Insert into artist_for values (16, 19);
Insert into artist_for values (17, 20);
Insert into artist_for values (18, 19);
Insert into artist_for values (19, 19);
Insert into artist_for values (7, 16);
Insert into artist_for values (20, 21);
Insert into artist_for values (21, 21);
Insert into artist_for values (22, 21);
Insert into artist_for values (23, 21);
Insert into artist_for values (24, 3);
Insert into artist_for values (24, 1);
Insert into artist_for values (7, 22);

-- INSERT playlist_song

Insert into playlist_song values (1, 1);
Insert into playlist_song values (1, 2);
Insert into playlist_song values (1, 3);
Insert into playlist_song values (2, 1);
Insert into playlist_song values (2, 2);
Insert into playlist_song values (2, 4);
Insert into playlist_song values (3, 3);
Insert into playlist_song values (3, 4);
Insert into playlist_song values (3, 5);
Insert into playlist_song values (4, 6);
Insert into playlist_song values (4, 7);
Insert into playlist_song values (4, 8);
Insert into playlist_song values (5, 5);
Insert into playlist_song values (5, 10);
Insert into playlist_song values (5, 7);
Insert into playlist_song values (6, 3);
Insert into playlist_song values (6, 1);
Insert into playlist_song values (7, 2);
Insert into playlist_song values (7, 5);
Insert into playlist_song values (7, 8);
Insert into playlist_song values (8, 5);
Insert into playlist_song values (8, 9);
Insert into playlist_song values (8, 10);
Insert into playlist_song values (9, 5);
Insert into playlist_song values (9, 10);
Insert into playlist_song values (9, 11);
Insert into playlist_song values (10, 1);
Insert into playlist_song values (10, 4);
Insert into playlist_song values (10, 7);
Insert into playlist_song values (6, 17);
Insert into playlist_song values (6, 17);
Insert into playlist_song values (6, 17);
Insert into playlist_song values (6, 17);
Insert into playlist_song values (9, 20);
Insert into playlist_song values (9, 21);
Insert into playlist_song values (9, 22);
Insert into playlist_song values (9, 23);

-- INSERT album_song

Insert into album_song values (1, 1);
Insert into album_song values (2, 12);
Insert into album_song values (2, 13);
Insert into album_song values (3, 2);
Insert into album_song values (4, 3);
Insert into album_song values (5, 5);
Insert into album_song values (6, 6);
Insert into album_song values (7, 7);
Insert into album_song values (8, 8);
Insert into album_song values (9, 9);
Insert into album_song values (10, 10);
Insert into album_song values (11, 11);
Insert into album_song values (12, 15);
Insert into album_song values (13, 15);
Insert into album_song values (15, 16);
Insert into album_song values (17, 18);
Insert into album_song values (16, 19);
Insert into album_song values (18, 17);
Insert into album_song values (21, 20);
Insert into album_song values (22, 20);
Insert into album_song values (20, 21);
Insert into album_song values (22, 21);
Insert into album_song values (19, 22);
Insert into album_song values (22, 22);
Insert into album_song values (19, 23);
Insert into album_song values (22, 23);
Insert into album_song values (3,24);

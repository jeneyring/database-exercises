USE albums_db;

SELECT *
FROM albums;

#How many rows are in albums table?
--   32

#How many unique artist names are in the albums table?
SELECT DISTINCT artist 
FROM albums; 
-- 23 unique artists

#What is the primary key for the albums table?
DESCRIBE albums;
-- "id"

#What is the oldest release date for any album in the albums table? 
#What is the most recent release date?  
SELECT min(release_date)
FROM albums;
-- oldest is 1967
SELECT max(release_date)
FROM albums;
-- most recent is 2011

#The name of all albums by Pink Floyd 
SELECT name
FROM albums WHERE artist = 'Pink Floyd';
-- The Dark Side of the Moon | The Wall

#The year Sgt. Pepper's Lonely Hearts Club Band was released
SELECT release_date
FROM albums 
WHERE name = "Sgt. Pepper's Lonely Hearts Club Band";
-- answer: 1967
 
 #The genre for the album Nevermind
 SELECT genre
 FROM albums
 WHERE name = "Nevermind";
 -- answer: Grunge, Alternative rock
 
 #Which albums were released in the 1990s?
 SELECT name 
 FROM albums 
 WHERE release_date > 1989;
 -- answer: 'The Bodyguard,'Jagged Little Pill','Come On Over','Falling into You','21','Let\'s Talk About Love','1','Dangerous','The Immaculate Collection','Titanic: Music from the Motion Picture','Metallica','Nevermind','Supernatural'

 #Which albums had less than 20 million certified sales?
 SELECT name 
 FROM albums
 WHERE sales < 20.0;
 -- answer: # 'Grease: The Original Soundtrack from the Motion Picture'
'Bad'
'Sgt. Pepper\'s Lonely Hearts Club Band'
'Dirty Dancing'
'Let\'s Talk About Love'
'Dangerous'
'The Immaculate Collection'
'Abbey Road'
'Born in the U.S.A.'
'Brothers in Arms'
'Titanic: Music from the Motion Picture'
'Nevermind'
'The Wall'

#All the albums with a genre of "Rock". 
#Why do these query results not include albums 
## with a genre of "Hard rock" or "Progressive rock"?

 

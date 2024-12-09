
create database Cse_4B_390

select * from Artists
select * from Albums
select * from Songs

--part A

--1
select Distinct Genre from Songs 

--2
select top 2 Album_title from Albums 
where Release_year<2010

--3
insert into Songs values (1245, 'Zaroor', 2.55, 'Feel good', 1005)

--4
update Songs
set Genre='Happy'
where Genre='Zaroor'

--5
delete from Artists
where Artist_name='Ed Sheeran'

--6
Alter table Songs
add  Rating decimal(3,2)

--7
select * from songs where Song_title like 'S%'

--8
select * from songs where Song_title like '%Everybody%'

--9
Select UPPER(Artist_name) from Artists

--10
select sqrt(duration) from songs where Song_title='Good luck'

--11
select GETDATE()

--12 
SELECT ARTIST_NAME, COUNT(DISTINCT ALBUMS.ALBUM_ID) 
FROM ARTISTS
JOIN ALBUMS ON ARTISTS.ARTIST_ID = ALBUMS.ARTIST_ID 
GROUP BY ARTIST_NAME;

--13
SELECT ALBUM_ID FROM SONGS GROUP BY ALBUM_ID HAVING COUNT(SONG_ID) > 5;

--14
SELECT Song_title FROM Songs
WHERE Album_id=(SELECT Album_id FROM Albums where Album_title='Album1')

--15
SELECT ALBUM_TITLE FROM ALBUMS
WHERE ARTIST_ID=(SELECT ARTIST_ID FROM ARTISTS WHERE ARTIST_NAME='Aparshakti Khurana')

--16 
SELECT SONG_TITLE,ALBUMS.ALBUM_TITLE FROM SONGS JOIN ALBUMS ON SONGS.ALBUM_ID=ALBUMS.ALBUM_ID

--17 
SELECT SONG_TITLE FROM SONGS 
WHERE ALBUM_ID IN (SELECT ALBUM_ID FROM ALBUMS WHERE Release_year=2020)

--18 
CREATE VIEW Fav_Songs
AS 
SELECT * FROM SONGS WHERE SONG_ID BETWEEN 101 AND 105

--19 
UPDATE Fav_Songs
SET Song_title='Jannat'
where song_id=101

--20 
SELECT Artist_name FROM Artists
WHERE Artist_ID in (SELECT Artist_ID FROM ALBUMS WHERE Release_year=2020)

--21 
SELECT Songs.SONG_TITLE 
FROM Songs 
JOIN Albums ON Songs.Album_id = Albums.Album_id 
JOIN Artists ON Artists.Artist_id = Albums.Artist_id 
WHERE Artists.Artist_name = 'Shreya Ghoshal' 
ORDER BY Songs.DURATION;

--PART-B
--22 
SELECT S.SONG_TITLE
FROM Songs S
JOIN Albums A ON S.Album_id = A.Album_id
JOIN Artists AR ON A.Artist_id = AR.Artist_id
WHERE AR.Artist_id IN (
    SELECT Artist_id
    FROM Albums
    GROUP BY Artist_id
    HAVING COUNT(DISTINCT Album_id) > 1
);

--23 
SELECT ALBUM_TITLE,COUNT(SONGS.SONG_ID) FROM ALBUMS JOIN SONGS ON ALBUMS.ALBUM_ID=SONGS.ALBUM_ID
GROUP BY ALBUM_TITLE

--24 
SELECT SONG_TITLE,ALBUMS.release_year FROM SONGS JOIN ALBUMS ON SONGS.ALBUM_ID=ALBUMS.ALBUM_ID
ORDER BY ALBUMS.RELEASE_YEAR

--25 
SELECT GENRE,COUNT(DISTINCT SONG_TITLE) FROM SONGS GROUP BY GENRE HAVING COUNT(DISTINCT SONG_TITLE)>2

--26 
SELECT ARTISTS.ARTIST_NAME
FROM ARTISTS
JOIN ALBUMS ON ARTISTS.ARTIST_ID = ALBUMS.ARTIST_ID
JOIN SONGS ON ALBUMS.ALBUM_ID = SONGS.ALBUM_ID
GROUP BY ARTISTS.ARTIST_NAME, ALBUMS.ALBUM_ID
HAVING COUNT(SONGS.SONG_ID) > 3;

--PART-C
--27 
SELECT ALBUM_TITLE FROM ALBUMS WHERE Release_year=(SELECT Release_year FROM ALBUMS WHERE Album_title='Album4')

--28 
SELECT S1.GENRE, S1.SONG_TITLE, S1.DURATION
FROM SONGS S1
JOIN (
    SELECT GENRE, MAX(DURATION) AS MAX_DURATION
    FROM SONGS
    GROUP BY GENRE
) S2
ON S1.GENRE = S2.GENRE AND S1.DURATION = S2.MAX_DURATION;

--29
SELECT SONG_TITLE FROM SONGS JOIN ALBUMS ON SONGS.Album_id=ALBUMS.ALBUM_ID WHERE ALBUMS.ALBUM_TITLE LIKE '%Album%'

--30 
SELECT ARTISTS.ARTIST_NAME,SUM(SONGS.DURATION) FROM ARTISTS JOIN ALBUMS ON ARTISTS.Artist_id=ALBUMS.Artist_id JOIN SONGS ON ALBUMS.Album_id=SONGS.Album_id GROUP BY ARTISTS.Artist_name HAVING SUM(SONGS.DURATION)>15


















-- เลือกชื่อ Artist
SELECT name
FROM artists;

--ค้นหาศิลปินที่ชื่อขึ้นด้วยตัว A
SELECT name
FROM artists
WHERE name Like 'a%';

-- แสดงชื่อเพลงและความยาวของเพลง โดยเรียงจากยาวที่สุด
SELECT 	name,Milliseconds
FROM tracks
order by Milliseconds DESC;

-- หาจำนวน albums ทั้งหมด
SELECT count (*) AS AlbumsCount
FROM albums ;

-- ดึงรายชื่อเพลงที่มีความยาวมากกว่า 5 นาที
SELECT name,Milliseconds
FROM tracks
WHERE Milliseconds > 5*60*1000;

-- ดู 10 เพลงที่มีราคาแพงที่สุด
SELECT Name,UnitPrice
FROM tracks
ORDER by UnitPrice DESC
LIMIT 10 ;

-- จำนวนแพลงในแต่ละ albums
SELECT AlbumId,count(*) As TrackCount
FROM tracks
GROUP by AlbumId ;

-- ดึงชื่อ albums พร้อมชื่อศิลปิน
SELECT al.Title ,at.name
from albums al
join artists at on al.ArtistId = at.ArtistId ; 

--ดูรายชื่อเพลงพร้อมประเภทแนวแพลง
SELECT t.Name as Track ,g.name as Genre
FROM tracks t
join genres g on t.GenreId = g.GenreId ; 

-- หาชื่อศิลปินที่มีจำนวนอัลบั้มมากที่สุด
SELECT at.name,count(al.AlbumId) as AlbumCount
FROM artists at
join albums al on at.ArtistId = al.ArtistId 
GROUP by at.name
ORDER by Albumcount DESC
LIMIT 1;

-- ดูจำนวนแพลงในแต่ละสไตล์
SELECT g.name as Genre,count(t.name) as TrackCount
FROM genres g
JOIN tracks t on g.GenreId = t.GenreId
GROUP by genre ; 

-- จำนวนเพลงในแต่ละเพลลิส
SELECT playlists.Name ,count(playlist_track.TrackId) as TrackCount
FROM playlists 
JOIN playlist_track on playlists.PlaylistId = playlist_track.PlaylistId
GROUP by playlists.name ;

--หายอดขายรวมของลูกค้าแต่ละคน
SELECT c.FirstName ||''|| c.LastName as CustomerName, sum (i.total) as TotalSpend
FROM customers c
JOIN invoices i on c.CustomerId = i.CustomerId 
GROUP by c.CustomerId;

--ดูรายการขายพร้อมชื่อประเทศลูกค้า
SELECT i.InvoiceId,c.FirstName,c.LastName,i.total,c.Country
FROM invoices i 
JOIN customers c on i.CustomerId = c.CustomerId 
;

-- หาชื่อเพลงที่แพงที่สุดพร้อมชื่อศิลปิน
SELECT t.name as TrackName,ar.name as ArtistName,t.UnitPrice as Price
FROM tracks t 
JOIN albums al on t.AlbumId = al.AlbumId
JOIN artists ar on al.ArtistId = ar.ArtistId 
WHERE Price =
 (SELECT max(unitprice) FROM tracks );
 
 -- ดูลูกค้าที่มียอดซื้อสูงสุด 3 อันดับแรก
 SELECT c.FirstName ||' '|| c.LastName as Customer_Name,
	sum(i.total) as Total_Spend
FROM customers c
JOIN invoices i on c.CustomerId = i.CustomerId 
GROUP by Customer_Name
ORDER by Total_Spend DESC
LIMIT 3 ;

-- หาแพลงที่อยู่ในหลายๆ PlaylistId
SELECT t.name,count(DISTINCT p.PlaylistId) as PlaylistCount
FROM tracks t
JOIN playlist_track p on t.TrackId = p.TrackId
GROUP by t.TrackId
HAVING PlaylistCount > 1 ;

--เพิ่ม Column แสดงระดับราคาของเพลง
SELECT name,
		UnitPrice,
		CASE
			WHEN UnitPrice <= 0.99 THEN 'low'
			WHEN UnitPrice BETWEEN 1 and 1.98 THEN 'Medium'
			ELSE 'High'
		End as PriceCategory
From tracks;

-- แสดง albums ที่ไม่มีเพลงเลย
SELECT a.Title 
FROM albums a
LEFT JOIN tracks t on a.AlbumId = t.AlbumId 
WHERE t.TrackId is NULL;

--หาศิลปินที่มีเพลงยาวเฉลี่ยมากที่สุด
SELECT ar.name,round(avg(t.milliseconds)/60000,2) as AvgLengh
FROM artists ar
JOIN albums al on ar.ArtistId = al.ArtistId
JOIN tracks t on al.AlbumId = t.AlbumId
GROUP by ar.name
ORDER by AvgLengh DESC
limit 1;
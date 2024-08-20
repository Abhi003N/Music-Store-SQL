--what is the senior most employee based on job title?
select Concat(MIN(first_name),' ',MIN(last_name)) as Full_name,title
from employee
group by title,birthdate
order by birthdate DESC

--which Countries have the most invoices?
select Count(*) as Invoice_count,billing_country 
from invoice
group by billing_country
order by Invoice_count DESC

--what are top 3 values of total invoice?
select TOP 3 * from invoice
order by total DESC

--which city has the highest sum of invoice total. Return both city name and sum of all invoice totals.
select sum(total)as invoice_total,billing_city from invoice
group by billing_city
order by invoice_total DESC

--which customer has spent the most money?
select top 1 CONCAT(min(c.first_name),' ',min(c.last_name)) as Full_name,sum(i.total) as total 
from customer c 
full join invoice i on c.customer_id = i.customer_id 
group by i.customer_id
order by  total DESC

--Write a query to return email,firstname, lastname, and genre of all rock Music listeners. Return your list ordered alphabetically by email startinf with A.
select Distinct c.email,c.first_name,c.last_name from customer c
join invoice i on c.customer_id = i.customer_id
join invoice_line l on i.invoice_id = l.invoice_id
where track_id in (select t.track_id from track t 
join genre g on t.genre_id = g.genre_id
where g.name like 'RoCK')
order by c.email

--write a query that returns the Artist name and total track count of the top 10 rock bands.
select top 10 a.artist_id,min(a.name) as artist_name,count(a.artist_id) as number_of_songs
from track t
join album au on t.album_id=au.album_id
join artist a on au.artist_id = a.artist_id
join genre g on t.genre_id = g.genre_id
where g.name like 'rock'
group by a.artist_id
order by number_of_songs DESC

--write a query that returns name and milliseconds of songs length longer than avg. song length.order song by length
select name,milliseconds from track
where milliseconds > (select AVG(milliseconds) from track)
order by milliseconds DESC 

--find how much amount spent by each customer on artist.
select c.customer_id,CONCAT(MIN(c.first_name),' ',MIN(c.last_name)) as customer_name,MIN(a.name) as artist_name,i.total from customer c
join invoice i on c.customer_id = i.customer_id
join invoice_line l on i.invoice_id=l.invoice_id
join track t on l.track_id=t.track_id
join album au on t.album_id=au.album_id
join artist a on au.artist_id=a.artist_id
group by c.customer_id,i.total

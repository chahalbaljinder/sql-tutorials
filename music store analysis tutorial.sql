--Q1: who is the senior most employee based on job title?

select *
from employee 
order by levels desc
limit 1

--Q2: Which country have the most invoices ?

select count(*) as c,billing_country
from invoice 
group by billing_country 
order by c desc 

--Q3: What are top 3 values of invoices ?

select total from invoice
order by total desc
limit 3

--Q4: which city has the best customers? We would like to throw a promotional 
--music festival in the city we made most money. Write a query that returns one 
--city that has the highest sum of invoices totals.
--Return both the city name and sum of all invoices totals.

select sum(total) as invoices_total, billing_city
from invoice
group by billing_city 
order by invoices_total desc
limit 1

--Q5:who is the best customer? The customer who spent the most money will be 
--declared the best customer. Write a query that returns the person who has 
--spent the most money.

select customer.customer_id , customer.first_name , customer.last_name , sum(total) as invoice_total 
from customer 
join invoice on customer.customer_id = invoice.customer_id 
group by customer.customer_id 
order by invoice_total desc
limit 1

--Q6: write a query to return the email , first name , last name and genre of all rock music listners 
--Return your list ordered alphabetically by email starting with A.

select distinct email , first_name , last_name 
from customer 
join invoice on customer.customer_id = invoice.customer_id 
join invoice_line on invoice.invoice_id=invoice_line.invoice_id
where track_id in (
	select track_id from track 
	join genre on track.genre_id = genre.genre_id
	where genre.name like 'Rock') 
order by email


--Q7:lets invite the artist who have written the most rock music in our dataset.
--write a query that returns the artist name & total track counts of the top 
-- 10 rock bands.

select artist.artist_id , artist.name , count(artist.artist_id) as number_of_songs
from track 
join album on album.album_id =track.album_id 
join artist on artist.artist_id =album.artist_id 
join genre on genre.genre_id = track.genre_id
where genre.name like 'Rock'
group by artist.artist_id
order by number_of_songs desc

--Q8: Return all the track names that have a song length longer than the avg. song length.
--Return the name and milliseconds for the each track.
--order by the song length with the longest song listed first.

select name , milliseconds 
from track 
where track.milliseconds > 
	(select avg(track.milliseconds) 
	as avg_millisecond from track)

order by milliseconds desc






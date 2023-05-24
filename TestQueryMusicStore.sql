use MusicStore

												--No of rows count , let's start the project work!!
SELECT * FROM dbo.album;                        --350 rows
SELECT * FROM dbo.artist;						--277 rows
SELECT * FROM dbo.customer;						--60 rows
SELECT * FROM dbo.employee;						--9 rows
SELECT * FROM dbo.genre;						--25 rows
SELECT * FROM dbo.invoice;						--617 rows
SELECT * FROM dbo.invoice_line;					--4757 rows
SELECT * FROM dbo.media_type;					--5 rows
SELECT * FROM dbo.playlist;						--19 rows
SELECT * FROM dbo.track;						--3500 rows
SELECT * FROM dbo.playlist_track;				--4752 rows

/*	Question Set 1 - Easy */

/* Q1: Who is the senior most employee based on job title? */
SELECT * FROM dbo.employee where title = 'Senior General Manager';	
SELECT top 1 * FROM dbo.employee order by Levels desc;	

/* Q2: Which countries have the most Invoices? */
SELECT  top 1 count(invoice_id)   total_invoice_count, billing_country  FROM dbo.invoice group by billing_country
order by total_invoice_count  desc; 

/* Q3: What are top 3 values of total invoice? */
SELECT  top 1 count(invoice_id)   total_invoice_count, customer_id  FROM dbo.invoice group by customer_id
order by total_invoice_count  desc; 	

--What are the top 3 values of total invoices? 
SELECT top 3 total FROM dbo.invoice;

/* Q4: Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money. 
Write a query that returns one city that has the highest sum of invoice totals. 
Return both the city name & sum of all invoice totals */
SELECT  top 1 billing_city, sum(total) as total_sum FROM dbo.invoice group by billing_city order by total_sum desc ;

/* Q5: Who is the best customer? The customer who has spent the most money will be declared the best customer. 
Write a query that returns the person who has spent the most money.*/
SELECT  top 1 sum(total)   total_sum, customer_id  FROM dbo.invoice group by customer_id
order by total_sum  desc; 

SELECT  top 1 sum(invoice.total) total_sum, invoice.customer_id, customer.first_name  
FROM dbo.invoice join customer
on invoice.customer_id = customer.customer_id
group by invoice.customer_id,customer.first_name  
order by total_sum  desc; 

/* Question Set 2 - Moderate */

/* Q1: Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
Return your list ordered alphabetically by email starting with A. */

select distinct c.first_name,c.last_name, c.email from customer c join invoice i on c.customer_id = i.customer_id
join invoice_line il on i.invoice_id = il.invoice_id
join track t on il.track_id = t.track_id 
join genre g on t.genre_id = g.genre_id 
where g.name ='Rock'
order by c.email asc;


/* Q2: Let's invite the artists who have written the most rock music in our dataset. 
Write a query that returns the Artist name and total track count of the top 10 rock bands. */

select  top 10 art.name, count(t.track_id) total_track_count from genre g join track t on g.genre_id =  t.genre_id
join album a on  t.album_id = a.album_id
join artist art on a.artist_id = art.artist_id
where g.name = 'Rock'
group by art.name
order by total_track_count desc;


/* Q3: Return all the track names that have a song length longer than the average song length. 
Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first. */

select name, milliseconds  from  dbo.track where milliseconds>( 
SELECT avg(milliseconds)  avg_length FROM dbo.track)
order by milliseconds desc;


/* Question Set 3 - Advance */

/* Q1: Find how much amount spent by each customer on artists? Write a query to return customer name, artist name and total spent */

with most_selling_artist as (
select TOP 1 artist.artist_id,artist.[name],
sum((invoice_line.unit_price * invoice_line.quantity)) as total_amount_spent
from invoice_line  
join track on invoice_line.track_id = track.track_id
join album on track.album_id = album.album_id
join artist on album.artist_id = artist.artist_id 
group by artist.artist_id,artist.[name]

)
select customer.customer_id, customer.first_name, customer.last_name, msa.[name],
sum((invoice_line.unit_price * invoice_line.quantity)) as best_selling_amount
from customer 
join invoice on customer.customer_id = invoice.customer_id 
join invoice_line on  invoice.invoice_id =  invoice_line.invoice_id 
join track on invoice_line.track_id = track.track_id
join album on track.album_id = album.album_id
join artist art on album.artist_id = art.artist_id 
join most_selling_artist msa on art.artist_id = msa.artist_id
group by customer.customer_id, customer.first_name, customer.last_name, msa.[name]
order by best_selling_amount desc


/* Q2: We want to find out the most popular music Genre for each country. We determine the most popular genre as the genre 
with the highest amount of purchases. Write a query that returns each country along with the top Genre. For countries where 
the maximum number of purchases is shared return all Genres. */

with  most_popular_genre as (
select count(il.quantity)as purchases, c.country,g.name ,g.genre_id,
ROW_NUMBER() over(partition by c.country order by count(il.quantity)) as row_num
from invoice_line il join invoice i on i.invoice_id= il.invoice_id
join customer c on c.customer_id= i.customer_id 
join track t on t.track_id = il.track_id
join genre g on g.genre_id = t.genre_id
group by c.country,g.name ,g.genre_id
)
select *from most_popular_genre where row_num<=1;


/* Q3: Write a query that determines the customer that has spent the most on music for each country. 
Write a query that returns the country along with the top customer and how much they spent. 
For countries where the top amount spent is shared, provide all customers who spent this amount. */

WITH MOST_SPENT_CUSTOMER AS(
select c.customer_id, c.first_name, c.last_name, i.billing_country, sum(total) as total_spent,
ROW_NUMBER() over(partition by billing_country order by sum(total) desc) as row_num
from customer c join invoice i on c.customer_id= i.customer_id
group by c.customer_id, c.first_name, c.last_name, i.billing_country
)
select * from MOST_SPENT_CUSTOMER where row_num<=1;

USE sakila;

-- 1. Write a query to display for each store its store ID, city, and country.
-- store is connected to city over adress and country is connected to city

SELECT s.store_id, c.city, co.country
FROM store s
JOIN address a
USING (address_id)
JOIN city c
USING (city_id)
JOIN country co
USING (country_id);

-- 2. Write a query to display how much business, in dollars, each store brought in.
-- combine store, customer and payment
-- 

SELECT sto.store_id, SUM(p.amount) AS total_amount
FROM sakila.payment p
LEFT JOIN rental r
USING (rental_id)
JOIN sakila.staff sta
ON r.staff_id = sta.staff_id
JOIN sakila.store sto
ON sta.store_id = sto.store_id
GROUP BY sto.store_id;


-- 3. Which film categories are longest?
-- combine category, film category and film
-- i interpreted as on average the longest
SELECT avg(f.length) AS avg_duration, c.name AS category
FROM category c
JOIN film_category fc
USING(category_id)
JOIN film f
USING(film_id)
GROUP BY c.name
ORDER BY avg_duration DESC;

-- 4. Display the most frequently rented movies in descending order.
-- combine film, inventory and rental

SELECT count(r.rental_id) AS rental_sum, f.title, f.film_id 
FROM film f
JOIN inventory i
USING(film_id)
JOIN rental r
USING(inventory_id)
GROUP BY f.film_id
ORDER BY rental_sum DESC;

-- 5. List the top five genres in gross revenue in descending order.
-- 

SELECT ca.name, sum(p.amount) AS gross_revenue
FROM category ca
JOIN film_category fc
USING(category_id)
JOIN inventory inv
USING(film_id)
JOIN rental r
USING(inventory_id)
JOIN payment p
USING(rental_id)
GROUP BY ca.name
ORDER BY gross_revenue DESC
LIMIT 5;


-- 6. Is "Academy Dinosaur" available for rent from Store 1?
-- it doesnt ask if its currently available because then one needs to check if its rented out
-- I checked if its generally available
-- combine film, inventory and store
SELECT f.title, s.store_id, count(store_id) AS number_of_films
FROM film f
JOIN inventory i
USING(film_id)
JOIN store s
USING(store_id)
WHERE s.store_id = '1' AND f.title='academy dinosaur';
-- this shows that 4 copies are generally available

SELECT store_id, f.title, COUNT(store_id) AS Num_film
FROM store
JOIN sakila.inventory i
USING (store_id)
JOIN sakila.film f
USING(film_id)
WHERE store_id = 1
GROUP BY f.title, store_id
HAVING f.title = 'Academy Dinosaur';


SELECT f.title, s.store_id, r.return_date
FROM film f
JOIN inventory i
USING(film_id)
JOIN store s
USING(store_id)
JOIN rental r
USING(inventory_id)
WHERE s.store_id = '1' AND f.title='academy dinosaur' AND r.return_date IS NULL;
-- here it shows that there are all rented out because the renturn date is null
-- i assume that only if there is areturn date its also back, but thats tricky

-- 7. Get all pairs of actors that worked together.

SELECT fa1.actor_id, fa2.actor_id, fa1.film_id
FROM film_actor fa1
JOIN film_actor fa2
ON (fa1.actor_id <> fa2.actor_id) AND (fa1.film_id = fa2.film_id)
WHERE fa1.actor_id > fa2.actor_id;


-- 8+9 are somehow Bonus: can answer after monday =)

-- 8. Get all pairs of customers that have rented the same film more than 3 times


-- 9. For each film, list actor that has acted in most films



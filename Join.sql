1. **Join Practice:**
```sql
SELECT c.first_name, c.last_name, c.email, a.city
FROM customer c
JOIN address a ON c.address_id = a.address_id;
```
2. **Subquery Practice (Single Row):**
```sql
SELECT title, description, release_year
FROM film
WHERE length = (SELECT MAX(length) FROM film);
```

3. **Join Practice (Multiple Joins):**
```sql
SELECT c.first_name, c.last_name, r.rental_date, f.title
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id
LEFT JOIN inventory i ON r.inventory_id = i.inventory_id
LEFT JOIN film f ON i.film_id = f.film_id;
```
4. **Subquery Practice (Multiple Rows):**
```sql
SELECT f.title, COUNT(actor_id) AS actor_count
FROM film f
LEFT JOIN film_actor fa ON f.film_id = fa.film_id
GROUP BY f.title;
```

5. **Join Practice (Using Aliases):**
```sql
SELECT c.first_name, c.last_name, c.email, r.rental_date, f.title, r.return_date
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id;
```
6. **Subquery Practice (Conditional):**
```sql
SELECT title
FROM film
WHERE film_id IN (
SELECT film_id
FROM inventory
WHERE store_id IN (
SELECT store_id
FROM customer
WHERE email LIKE '%.net'
)
);
```

7. **Join Practice (Aggregation):**
```sql

SELECT c.first_name, c.last_name, COUNT(r.rental_id) AS total_rentals
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id
ORDER BY total_rentals DESC;
```

8. **Subquery Practice (Aggregation):**
```sql
SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
SELECT customer_id
FROM rental
GROUP BY customer_id
HAVING COUNT(rental_id) > (
SELECT AVG(rental_count)
FROM (
SELECT COUNT(rental_id) AS rental_count
FROM rental
GROUP BY customer_id
) AS avg_rentals
)
);
```
9. **Join Practice (Self Join):**
```sql
SELECT c1.first_name, c1.last_name, c1.email, c2.first_name AS other_first_name,
c2.last_name AS other_last_name
FROM customer c1
JOIN address a1 ON c1.address_id = a1.address_id
JOIN address a2 ON a1.city = a2.city AND a1.address_id != a2.address_id
JOIN customer c2 ON a2.address_id = c2.address_id;
```
10. **Subquery Practice (Correlated Subquery):**
```sql
SELECT title, rental_rate
FROM film f
WHERE rental_rate > (
SELECT AVG(rental_rate)
FROM film
WHERE category_id = f.category_id

);
```
11. **Subquery Practice (Nested Subquery):**
```sql
SELECT title, description, length
FROM film
WHERE rental_rate > (
SELECT AVG(rental_rate)
FROM film
WHERE release_year = film.release_year
);
```
12. **Subquery Practice (IN Operator):**
```sql
SELECT first_name, last_name, email
FROM customer
WHERE customer_id IN (
SELECT DISTINCT c.customer_id
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film_category fc ON i.film_id = fc.film_id
JOIN category cat ON fc.category_id = cat.category_id
WHERE cat.name = 'Documentary'
);
```
13. **Subquery Practice (Scalar Subquery):**
```sql
SELECT title, rental_rate,
rental_rate - (SELECT AVG(rental_rate) FROM film) AS rate_difference
FROM film;
```
14. **Subquery Practice (Existence Check):**
```sql
SELECT title
FROM film
WHERE film_id NOT IN (

SELECT DISTINCT film_id
FROM inventory
WHERE film_id IS NOT NULL
);
```
15. **Subquery Practice (Correlated Subquery - Multiple Conditions):**
```sql
SELECT title
FROM film f
WHERE rental_rate > (
SELECT AVG(rental_rate)
FROM film
WHERE release_year = f.release_year
)
AND film_id IN (
SELECT fc.film_id
FROM film_category fc
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Sci-Fi'
);
```

16. **Subquery Practice (Conditional Aggregation):**
```sql
SELECT customer_id, COUNT(rental_id) AS film_count
FROM rental
GROUP BY customer_id
HAVING COUNT(rental_id) >= 5;
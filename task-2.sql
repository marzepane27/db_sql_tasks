Запит на вибірку даних: Отримання списку фільмів та їх категорій
SELECT 
    film.title AS "Назва фільму", 
    film.length AS "Тривалість (хвилини)", 
    category.name AS "Категорія"
FROM 
    film
JOIN 
    film_category ON film.film_id = film_category.film_id
JOIN 
    category ON film_category.category_id = category.category_id;

Фільми, орендовані певним клієнтом
SELECT 
    customer.firstname AS "Ім'я клієнта", 
    customer.last_name AS "Прізвище клієнта", 
    film.title AS "Назва фільму", 
    rental.rental_date AS "Дата оренди"
FROM 
    rental
JOIN 
    inventory ON rental.inventory_id = inventory.inventory_id
JOIN 
    film ON inventory.film_id = film.film_id
JOIN 
    customer ON rental.customer_id = customer.customer_id
WHERE 
    customer.customer_id = <Кодклієнта>;

Популярність фільмів: Топ-5 найпопулярніших фільмів
SELECT 
    film.title AS "Назва фільму", 
    COUNT(rental.rental_id) AS "Кількість оренд"
FROM 
    rental
JOIN 
    inventory ON rental.inventory_id = inventory.inventory_id
JOIN 
    film ON inventory.film_id = film.film_id
GROUP BY 
    film.title
ORDER BY 
    COUNT(rental.rental_id) DESC
LIMIT 5;

Додавання нового клієнта
INSERT INTO customer (first_name, last_name, address_id, store_id, active, create_date)
VALUES (
    'Alice', 
    'Cooper', 
    (SELECT address_id FROM address WHERE address = '123 Main St' AND city_id = (SELECT city_id FROM city WHERE city = 'San Francisco')), 
    1, 
    1, 
    NOW()
);

Оновлення адреси клієнта
UPDATE address
SET address = '456 Elm St'
WHERE address_id = (
    SELECT address_id 
    FROM customer
    JOIN address ON customer.address_id = address.address_id
    WHERE customer.first_name = 'Alice' AND customer.last_name = 'Cooper'
);

Видалення клієнта
DELETE FROM customer
WHERE first_name = 'Alice' AND last_name = 'Cooper';



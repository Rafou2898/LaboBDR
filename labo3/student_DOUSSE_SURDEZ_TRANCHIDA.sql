SET search_path = pagila;

-- BEGIN Exercice 01
SELECT customer_id,
       last_name,
       email
FROM customer AS C
WHERE C.first_name = 'PHYLLIS'
  AND store_id = 1
ORDER BY C.customer_id DESC;
-- END Exercice 01


-- BEGIN Exercice 02
SELECT title,
       release_year
FROM film as F
WHERE f.rating = 'R'
  AND f.length < 60
  AND replacement_cost = 12.99
ORDER BY title ASC;
-- END Exercice 02


-- BEGIN Exercice 03
SELECT address,
       city,
       country
FROM address
         JOIN city on address.city_id = city.city_id
         JOIN country c on city.country_id = c.country_id
WHERE country = 'France'
   OR c.country_id >= 63 AND c.country_id <= 67
ORDER BY country ASC,
         city ASC,
         postal_code ASC;
-- END Exercice 03

-- BEGIN Exercice 04
SELECT *
FROM customer


-- END Exercice 04


-- BEGIN Exercice 05
-- END Exercice 05


-- BEGIN Exercice 06
-- END Exercice 06


-- BEGIN Exercice 07a
-- END Exercice 07a

-- BEGIN Exercice 07b
-- END Exercice 07b


-- BEGIN Exercice 08a
-- END Exercice 08a

-- BEGIN Exercice 08b
-- END Exercice 08b

-- BEGIN Exercice 08c
-- END Exercice 08c


-- BEGIN Exercice 09 (Bonus)
-- END Exercice 09 (Bonus)


-- BEGIN Exercice 10
-- END Exercice 10


-- BEGIN Exercice 11
-- END Exercice 11


-- BEGIN Exercice 12
-- END Exercice 12


-- BEGIN Exercice 13a
-- END Exercice 13a

-- BEGIN Exercice 13b
-- END Exercice 13b


-- BEGIN Exercice 14
-- END Exercice 14


-- BEGIN Exercice 15
-- END Exercice 15


-- BEGIN Exercice 16a
-- END Exercice 16a

-- BEGIN Exercice 16b
-- END Exercice 16b

-- BEGIN Exercice 16c
-- END Exercice 16c


-- BEGIN Exercice 17
-- END Exercice 17


-- BEGIN Exercice 18
-- END Exercice 18

-- BEGIN Exercice 18d
-- END Exercice 18d

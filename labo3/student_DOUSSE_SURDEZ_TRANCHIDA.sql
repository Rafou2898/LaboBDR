SET search_path = pagila;


-- BEGIN Exercice 01
SELECT customer_id as id_client,
       last_name   as nom,
       email       as e_mail
FROM customer AS C
WHERE C.first_name = 'PHYLLIS'
  AND store_id = 1
ORDER BY C.customer_id DESC;
-- END Exercice 01


-- BEGIN Exercice 02
SELECT title        as titre,
       release_year as annee_de_sortie
FROM film as F
WHERE f.rating = 'R'
  AND f.length < 60
  AND replacement_cost = 12.99
ORDER BY title ASC;
-- END Exercice 02


-- BEGIN Exercice 03
SELECT address as adresse,
       city    as ville,
       country as pays
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
-- Listez tous les clients actifs (customer_id, prenom, nom) habitant la ville 171, et rattachés au
-- magasin numéro 1. Triez-les par ordre alphabétique des prénoms.
SELECT customer_id as id_client, first_name as prenom, last_name as nom
FROM customer
         JOIN address on customer.address_id = address.address_id
    AND city_id = 171
WHERE active = TRUE
  AND store_id = 1
ORDER BY first_name ASC;

-- END Exercice 04

-- BEGIN Exercice 05
-- Donnez le nom et le prénom (prenom_1, nom_1, prenom_2, nom_2) des clients qui ont loué au
-- moins une fois le même film (par exemple, si ALAN et BEN ont loué le film MATRIX, mais pas TRACY,
-- seuls ALAN et BEN doivent être listés).
SELECT c1.first_name AS prenom1,
       c1.last_name  AS nom1,
       c2.first_name AS prenom2,
       c2.last_name  AS nom2

FROM customer AS c1
         JOIN rental r1 on c1.customer_id = r1.customer_id
         JOIN inventory i1 on r1.inventory_id = i1.inventory_id
         JOIN inventory i2 on i2.film_id = i1.film_id
         JOIN rental r2 on i2.inventory_id = r2.inventory_id
         JOIN customer c2 on r2.customer_id = c2.customer_id
WHERE c1.customer_id < c2.customer_id;

-- END Exercice 05

--Donnez le nom et le prénom des acteurs (nom, prenom) ayant joué dans un film d’horreur, dont le
--prénom commence par K, ou dont le nom de famille commence par D sans utiliser le mot clé JOIN.
-- BEGIN Exercice 06
-- END Exercice 06

SELECT first_name as prenom, last_name as nom
FROM actor
WHERE first_name LIKE 'K%'
   OR last_name LIKE 'D%'
    AND actor_id =
        ANY (SELECT actor_id
             FROM film_actor
             WHERE film_id = ANY (SELECT film_id
                                  FROM film_category
                                  WHERE category_id = ANY (SELECT category_id
                                                           FROM category
                                                           WHERE name = 'Horror')));



-- Première façon : Utiliser NOT EXISTS
SELECT
    f.film_id,
    f.title,
    f.rental_rate/rental_duration as rental_rate_per_day
FROM film f
WHERE f.rental_rate/rental_duration <= 1.00
    AND NOT EXISTS (
        SELECT 1
        FROM rental r
        JOIN inventory i ON r.inventory_id = i.inventory_id
        WHERE i.film_id = f.film_id
    );

-- BEGIN Exercice 07b
    -- Deuxième façon : Utiliser LEFT JOIN et vérifier si il n'y a pas de correspondance (NULL)
SELECT
    f.film_id,
    f.title,
    f.rental_rate/rental_duration as rental_rate_per_day
FROM film f
LEFT JOIN  inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
WHERE f.rental_rate/rental_duration <= 1.00 AND r.rental_id IS NULL;

-- END Exercice 07b

-- Donnez la liste des clients (id, nom, prenom) espagnols qui n’ont pas encore rendu tous les films
-- qu’ils ont empruntés, en les ordonnant par nom. Donnez 3 versions de cette requête :
-- (a) En utilisant EXISTS (pas de GROUP BY, ni de IN ou NOT IN).
-- (b) En utilisant IN (pas de GROUP BY, ni de EXISTS ou NOT EXISTS).
-- (c) En utilisant aucun des mot-clés précédent (c’est à dire pas de GROUP BY, IN, NOT IN, EXISTS, NOT EXISTS).

-- BEGIN Exercice 08a
-- Reponse différente que la correction de l'assistant mais si on fait le select que sur l'interrieur de la requete,
-- on remarque que ils sont bien tous en Espagne et qu'ils ont bien des films non rendu... donc normalement ça devrait
-- être bon
SELECT customer.customer_id as id_client,
       customer.last_name   as nom,
       customer.first_name  as prenom
FROM customer
WHERE EXISTS (SELECT *
              FROM address
                       JOIN city ON address.city_id = city.city_id
                       JOIN country ON city.country_id = country.country_id
                       JOIN rental ON customer.customer_id = rental.customer_id
              WHERE country.country = 'Spain'
                AND rental.return_date IS NULL
                AND address.address_id = customer.address_id)
ORDER BY customer.last_name ASC;
-- END Exercice 08a

-- BEGIN Exercice 08b
SELECT customer.customer_id as id_client, customer.last_name as nom, customer.first_name as prenom
FROM customer
         JOIN address ON customer.address_id = address.address_id
         JOIN city ON address.city_id = city.city_id
         JOIN country ON city.country_id = country.country_id
WHERE country.country = 'Spain'
  AND customer.customer_id IN (SELECT rental.customer_id
                               FROM rental
                               WHERE rental.return_date IS NULL)
ORDER BY customer.last_name ASC;

-- END Exercice 08b

-- BEGIN Exercice 08c
SELECT customer.customer_id as id_client, customer.last_name as nom, customer.first_name as prenom
FROM customer
         JOIN address ON customer.address_id = address.address_id
         JOIN city ON address.city_id = city.city_id
         JOIN country ON city.country_id = country.country_id
WHERE country.country = 'Spain'
  AND customer.customer_id = ANY (SELECT rental.customer_id
                                  FROM rental
                                  WHERE rental.return_date IS NULL)
ORDER BY customer.last_name ASC;
-- END Exercice 08c

-- BEGIN Exercice 09 (Bonus)
    -- Sous-requête pour obtenir la liste des films de l'actrice EMILY DEE
WITH emily_dee_films AS (
    SELECT DISTINCT
        fa.film_id
    FROM actor a
    JOIN film_actor fa ON a.actor_id = fa.actor_id
    WHERE a.first_name = 'EMILY' AND a.last_name = 'DEE'
)

-- Requête principale pour obtenir les clients ayant loué tous les films d'EMILY DEE
SELECT
    c.customer_id,
    c.first_name AS prenom,
    c.last_name AS nom
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN emily_dee_films edf ON i.film_id = edf.film_id
GROUP BY
    c.customer_id, c.first_name, c.last_name
HAVING
    COUNT(DISTINCT edf.film_id) = (SELECT COUNT(*) FROM emily_dee_films);

-- END Exercice 09 (Bonus)

-- Donnez le titre des films et le nombre d’acteurs (titre, nb_acteurs) des films dramatiques en les
-- triant par le nombre d’acteur décroissant. Retenez uniquement les films avec moins de 5 acteurs
-- BEGIN Exercice 10

SELECT film.title as titre, COUNT(actor.actor_id) AS nombres_acteurs
FROM film_category
         JOIN category ON category.category_id = film_category.category_id
         JOIN film ON film.film_id = film_category.film_id
         JOIN film_actor ON film.film_id = film_actor.film_id
         JOIN actor ON film_actor.actor_id = actor.actor_id
WHERE category.name = 'Drama'
GROUP BY film.film_id, film.title
HAVING count(actor.actor_id) < 5
ORDER BY nombres_acteurs DESC;
-- END Exercice 10


-- BEGIN Exercice 11
SELECT
    c.category_id AS id,
    c.name AS nom,
    COUNT(fc.film_id) AS nb_films
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
GROUP BY
    c.category_id, c.name
HAVING
    COUNT(fc.film_id) > 65
ORDER BY
    nb_films DESC;
-- END Exercice 11

--Affichez le(s) film(s) (id, titre, duree) ayant la durée la moins longue. Si plusieurs films ont la
--même durée (la moins longue), il faut afficher l’ensemble de ces derniers.
-- BEGIN Exercice 12
SELECT film_id as id_film, title as titre, length as longueur
FROM film
WHERE length = (SELECT MIN(length)
                FROM film);
-- END Exercice 12


-- BEGIN Exercice 13a
-- Sous-requête pour obtenir les acteurs ayant joué dans plus de 40 films
WITH prolific_actors AS (
    SELECT
        fa.actor_id
    FROM film_actor fa
    GROUP BY
        fa.actor_id
    HAVING COUNT(DISTINCT fa.film_id) > 40
)

-- Requête principale pour obtenir les films
SELECT DISTINCT
    f.film_id AS id,
    f.title
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
WHERE fa.actor_id IN (SELECT actor_id FROM prolific_actors)
ORDER BY
    f.title;

-- END Exercice 13a


-- BEGIN Exercice 13b

-- Sous-requête pour obtenir les acteurs ayant joué dans plus de 40 films
WITH prolific_actors AS (
    SELECT
        fa.actor_id
    FROM
        film_actor fa
    GROUP BY
        fa.actor_id
    HAVING
        COUNT(DISTINCT fa.film_id) > 40
)

-- Requête principale pour obtenir les films
SELECT
    DISTINCT f.film_id AS id,
    f.title
FROM
    film f
JOIN
    film_actor fa ON f.film_id = fa.film_id
JOIN
    prolific_actors pa ON fa.actor_id = pa.actor_id
ORDER BY
    f.title;

-- END Exercice 13b

--Un fou furieux décide de regarder l’ensemble des films qui sont présents dans la base de données.
--Etablissez une requête qui donne le nombre de jours (nb_jours) qu’il devra y consacrer sachant
--qu’il dispose de 8 h par jour.
-- BEGIN Exercice 14
SELECT CEIL(SUM(film.length) / 60 / 8) as nombre_de_jours
FROM film;
-- END Exercice 14


-- BEGIN Exercice 15
    SELECT
    c.customer_id AS id,
    c.last_name || ', ' || c.first_name AS nom,
    c.email,
    co.country AS pays,
    COUNT(r.rental_id) AS nb_locations,
    SUM(p.amount) AS depense_totale,
    AVG(p.amount) AS depense_moyenne
FROM
    customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN payment p ON r.rental_id = p.rental_id
JOIN staff s ON p.staff_id = s.staff_id
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
GROUP BY
    c.customer_id, c.last_name, c.first_name, c.email, co.country;
SELECT *
FROM (
    -- Sous-requête pour obtenir tous les clients avec leur dépense moyenne
    SELECT
        c.customer_id AS id,
        c.last_name || ', ' || c.first_name AS nom,
        c.email,
        co.country AS pays,
        COUNT(r.rental_id) AS nb_locations,
        SUM(p.amount) AS depense_totale,
        AVG(p.amount) AS depense_moyenne
    FROM customer c
    JOIN rental r ON c.customer_id = r.customer_id
    JOIN payment p ON r.rental_id = p.rental_id
    JOIN staff s ON p.staff_id = s.staff_id
    JOIN address a ON c.address_id = a.address_id
    JOIN city ci ON a.city_id = ci.city_id
    JOIN country co ON ci.country_id = co.country_id
    GROUP BY
        c.customer_id, c.last_name, c.first_name, c.email, co.country
) AS customer_summary
WHERE
    pays IN ('Switzerland', 'France', 'Germany')
    AND depense_moyenne > 3.0
ORDER BY
    pays, nom;

-- END Exercice 15

-- Donnez les 3 requêtes suivantes ainsi que le résultat de la première et de la dernière :
-- (a) Comptez les paiements dont la valeur est inférieure ou égale à 9.
-- (b) Effacez ces mêmes paiements.
-- (c) Comptez à nouveau ces mêmes paiements pour vérifier que l’opération a bien eu lieu.
-- BEGIN Exercice 16a

SELECT COUNT(*) AS nombre_de_paiements
FROM payment
WHERE amount <= 9;
-- RESULTAT: 15'678
-- END Exercice 16a

-- BEGIN Exercice 16b
DELETE
FROM payment
WHERE amount <= 9;
-- END Exercice 16b

-- BEGIN Exercice 16c
SELECT *
FROM payment
WHERE amount <= 9;
-- RESULTAT: 0

-- COMMENT FAIRE POUR RAJOUTER LES ELEMENTS SUPPRIMER PARCE QUE QUAND JE RELANCE LE SCRIPTE CA MET PAS LES
-- RESULTATS DANS LA TABLE PAYMENT!!

-- END Exercice 16c


-- BEGIN Exercice 17
    -- (a) Majorer de 50 % les paiements de plus de 4$
-- (b) Mettre à jour la date de paiement avec la date courante du serveur

UPDATE payment
SET
    amount = amount * 1.5,
    payment_date = CURRENT_TIMESTAMP
WHERE
    amount > 4;

-- END Exercice 17

--Un nouveau client possèdant les informations suivantes souhaite louer des films :
--M. Guillaume Ransome
--Adresse : Rue du centre, 1260 Nyon
--Pays : Suisse / Switzerland
--Téléphone : 021/360.00.00
--E-mail : gr@bluewin.ch
--Ce client est rattaché au magasin 1.
--Insérez-le dans la base de données, avec toutes les informations requises pour lui permettre de louer des films.
--(a) Spécifiez les attributs (colonnes) lors de l’insertion.
--Indication : plusieurs requêtes sont nécessaires
--(b) Pour chaque nouveau tuple, la base de données doit générer l’id. Pourquoi ne pouvez-vous
--pas le faire ?
--(c) Pour chaque clé étrangère pour laquelle une valeur est requise, une requête doit donner cette
--valeur. On considère que l’ensemble des requêtes nécessaires sera fait dans une transaction,
--ainsi, seules vos modifications de la base de données seront effectives (pas de soucis de
--concurrence avec une éventuelle autre application).
--(d) Ecrivez une requête d’interrogation, qui montrera que l’ensemble des opérations s’est bien déroulé.
--Indication : Guillaume Ransome est un identifiant unique suffisant.

-- BEGIN Exercice 18a

INSERT INTO city (city, country_id, last_update)
VALUES ('Nyon', (SELECT country_id FROM country WHERE country = 'Switzerland'), NOW());

INSERT INTO address (address, address2, district, city_id, postal_code, phone, last_update)
VALUES ('Rue du centre', '', 'Vaud', (SELECT city_id FROM city WHERE city = 'Nyon'), '1260', '021/360.00.00', NOW());

INSERT INTO customer (store_id, first_name, last_name, email, address_id, active, create_date, last_update)
VALUES (1,
        'Guillaume',
        'Ransome',
        'gr@bluewin.ch',
        (SELECT address_id FROM address WHERE address = 'Rue du centre'),
        true,
        NOW(),
        NOW());
INSERT INTO customer (store_id, first_name, last_name, email, address_id, active, create_date, last_update)
VALUES (1,
        'Rafael',
        'Dousse',
        'gr@bluewin.ch',
        (SELECT address_id FROM address WHERE address = 'Rue du centre'),
        true,
        NOW(),
        NOW());

-- END Exercice 18a

-- BEGIN Exercice 18b
-- Ici, quand on inserte une nouvelle personne dans la base de donnée, une clé primaire est générée automatiquement
-- c'est à dire qu'elle est incrémenté à chaque fois qu'une nouvelle donnée est ajouté. On ne peut pas le faire nous
-- même dans des valeurs qui existe déjà, ce qui est normal vu que la clé doit être unique. Par contre, on peut rajouter
-- une donnée avec une id plus haute que celle qui existe déjà
-- END Exercice 18b

-- BEGIN Exercice 18c
-- JE SAIS PAS

-- END Exercice 18c

-- BEGIN Exercice 18d
-- Je sais pas si c'est ça qu'on veut?
SELECT *
FROM customer
WHERE first_name = 'Guillaume'
  AND last_name = 'Ransome';
-- END Exercice 18d


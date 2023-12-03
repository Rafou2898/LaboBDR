--BEGIN01
create or replace function before_insert_payment_func()
returns trigger as
    $$
    begin
        new.amount = new.amount * 1.08;

        new.payment_date = now();

        return new;
    end;
    $$ language plpgsql;

create trigger before_insert_payment
    before insert on payment
    for each row
    execute function before_insert_payment_func();

insert into payment values(32099, 533, 2, 615, 1.00, '2017-05-14 13:44:29.996577 +00:00');
select * from payment where payment_id = 32099;
--END01

--BEGIN02
create table staff_creation_log (
    username varchar(16),
    when_created timestamp with time zone
);

create or replace function after_insert_staff_func()
returns trigger as
    $$
    begin
        insert into staff_creation_log
        values(new.username, now());
        return new;
    end;
    $$ language plpgsql;

create trigger after_insert_staff
    after insert on staff
    for each row
    execute function after_insert_staff_func();

insert into staff values(3, 'Sara', 'Seven', 5, 'sara.seven@gmail.com', 1, false, 'Sara', 'abc', now());
select * from staff_creation_log;
--END02

--BEGIN03
create or replace function update_email_staff_func()
returns trigger as
    $$
    begin
        new.email = concat(new.first_name, '.', new.last_name, '@sakilastaff.com');
        return new;
    end;
    $$ language plpgsql;

create or replace trigger update_email_staff
    before insert or update on staff
    for each row
    execute function update_email_staff_func();


insert into staff values(4, 'Raf', 'Doudou', 6, 'sara.seven@gmail.com', 1, false, 'Raf', 'abc', now()) returning email;
update staff set active = true where last_name = 'Seven' returning email;
--END03

--BEGIN04
create view restricted_staff
as select last_name, first_name, phone, address
    from staff
    inner join address
    on staff.address_id = address.address_id;
select * from restricted_staff;

-- oui Franklin pourra changer la table de base étant donné qu'elle ne possède aucune des conditions limitantes
--END04

--BEGIN05
create view late_client
as select email, title, rental.last_update - rental.rental_date + rental_duration*INTERVAL '1 day' as number_of_days
from customer
inner join rental
on customer.customer_id = rental.customer_id
inner join inventory
on rental.inventory_id = inventory.inventory_id
inner join film
on inventory.film_id = film.film_id
where rental.return_date ISNULL
and rental.last_update - rental.rental_date + rental_duration*INTERVAL '1 day' >= INTERVAL '1 s';
select * from late_client;
drop view late_client;
--END05

--BEGIN06
create view more_than_three_days_late
as select email, title, number_of_days
from late_client
where number_of_days > INTERVAL '3 days';
select * from more_than_three_days_late;
--END06

--BEGIN07
create or replace view number_locations_per_client
as select customer.customer_id, first_name, last_name, count(rental_id) as nb_locations
from customer
inner join rental
on customer.customer_id = rental.customer_id
group by customer.customer_id;
select * from number_locations_per_client
order by nb_locations desc
limit 20;
--END07

--BEGIN08
create or replace view number_locations_per_day
as select date_trunc('day', rental_date) as rental_day,
          count(rental_id) as total_rental
from rental
group by rental_day;
select * from number_locations_per_day;

select total_rental
from number_locations_per_day
where rental_day = '2005-08-01';
--END08

--BEGIN09
create or replace function nb_films_by_store(store_id_var integer)
returns integer
language plpgsql
as
$$
    declare film_count integer;
    begin
    select count(distinct film_id)
    into film_count
    from inventory
    where store_id = store_id_var;

    return film_count;
    end;
    $$;

select
    nb_films_by_store(1) as store_1_nb_film,
    nb_films_by_store(2) as store_2_nb_film

select
    store_id,
    count(distinct film_id) as nb_film
from inventory
where store_id = 1 or store_id = 2
group by store_id;
--END09

--BEGIN10
create or replace procedure update_film_last_update()
language plpgsql
as
    $$
    begin
        update film
        set last_update = now();
    end;

    $$
-- 2017-09-10 17:46:03.905795 +00:00 was the latest timestamp before the call to the procedure
select
    last_update
from film
group by last_update;

call update_film_last_update();
--END10

--BEGIN11
with recursive actor_distance as (

    select actor_id,
    last_name,
    first_name,
    0 as distance
    from actor
    where first_name = 'ED'
    and last_name = 'GUINESS'

    union all

    select x.actor_id,
    x.last_name,
    x.first_name,
    ad.distance + 1
    from actor x
    inner join film_actor
    on x.actor_id = film_actor.actor_id
    inner join film
    on film_actor.film_id = film.film_id and film.length < 50
    inner join actor_distance as ad
    on film.film_id in (
    select
    film_id
    from film_actor
    where actor_id = ad.actor_id
    )
    where ad.distance < 3
    )
select distinct actor_id from actor_distance where distance > 0
order by actor_id asc;
--END11

--BEGIN12
select payment_id,
       customer_id,
       payment_date,
       amount,
       sum(amount) over (partition by customer_id order by payment_date) as cumulative_amount
from payment
order by customer_id, payment_date;
--END12

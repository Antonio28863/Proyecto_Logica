

--2. Muestra los nombres de todas las películas con una clasificación por edades de ‘R’.

select f.title
from film f 
where f.rating = 'R' ;

--3. Encuentra los nombres de los actores que tengan un “actor_id” entre 30 y 40.

select a.first_name 
from actor a 
where a.actor_id 
between 30 and 40 ;

--4. Obtén las películas cuyo idioma coincide con el idioma original.

select f.title 
from film f 
where f.original_language_id is not null
and f.language_id = f.original_language_id ;

--5. Ordena las películas por duración de forma ascendente.

select *
from film f 
order by f.length asc ;

--6. Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su apellido.

select a.first_name, a.last_name 
from actor a 
where a.last_name ilike '%Allen%' ;

--7. Encuentra la cantidad total de películas en cada clasificación de la tabla “film” y muestra la clasificación junto con el recuento.

select f.rating, count (f.rating ) as "Total Películas"
from film f 
group by f.rating ;

--8. Encuentra el título de todas las películas que son ‘PG-13’ o tienen una duración mayor a 3 horas en la tabla film.

select f.title
from film f 
where f.rating = 'PG-13' or f.length > 180 ;

--9. Encuentra la variabilidad de lo que costaría reemplazar las películas.

select 
    MAX(f.replacement_cost) as "Coste Máximo",
    MIN(f.replacement_cost) as "Coste Mínimo",
    round (stddev (f.replacement_cost ), 2) as "Desviación Estandar",
    round (variance (f.replacement_cost), 2) as "Varianza"
from film f ;

--10. Encuentra la mayor y menor duración de una película de nuestra BBDD

select 
    MAX(f.length ) as "Mayor duración",
    MIN(f.length) as "Menor duración"
from film f ;

--11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.

select *
from payment p 
inner join rental r 
on p.rental_id = r.rental_id
order by r.rental_date desc
limit 1
offset 2;

--12. Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC-17’ ni ‘G’ en cuanto a su clasificación.

select f.title, f.rating 
from film f 
where f.rating not in ('NC-17', 'G') ;

--13. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.

select 
    f.rating,
    round (avg (f.length)) as "Duración Media"  
from film f 
group by f.rating ;

--14. Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.

select f.title
from film f 
where f.length > 180 ;

--15. ¿Cuánto dinero ha generado en total la empresa?

select round (sum (p.amount),2)  as "Dinero Generado"
from payment p ;

--16. Muestra los 10 clientes con mayor valor de id.

select *
from customer c 
order by c.customer_id desc
limit 10;

--17. Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igby’.

select a.first_name, a.last_name 
from actor a 
inner join film_actor fa 
on a.actor_id = fa.actor_id
inner join film f 
on fa.film_id = f.film_id
where f.title = 'EGG IGBY';

--18. Selecciona todos los nombres de las películas únicos.

select distinct f.title 
from film f ;

--19. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “film”.

select f.title 
from film f 
inner join film_category fc 
on f.film_id = fc.film_id
inner join category c 
on fc.category_id = c.category_id
where f.length > 180
and c."name" = 'Comedy';

--20. Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio de duración.

select 
     c."name", 
     round (avg(f.length )) as "Promedio de duración"
from film f 
inner join film_category fc 
on f.film_id = fc.film_id
inner join category c 
on fc.category_id = c.category_id
group by c.name
having (avg(f.length )) > 110 ;

--21. ¿Cuál es la media de duración del alquiler de las películas?

select (avg(r.return_date - r.rental_date )) as "Duración media alquiler"
from rental r ;

--22. Crea una columna con el nombre y apellidos de todos los actores y actrices.

select concat(a.first_name, ' ', a.last_name) as "Nombre Completo"
from actor a ;

--23. Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.

select 
    date (r.rental_date),
    count(*) as "Alquileres"
from rental r 
group by date (r.rental_date)
order by "Alquileres" desc ;

--24. Encuentra las películas con una duración superior al promedio.

select f.title
from film f 
where f.length > 
      (select AVG(f.length )
       from film f); 

--25. Averigua el número de alquileres registrados por mes.

select 
    to_char(r.rental_date, 'MM-YYYY') as "Mes de Alquiler",
    count(*) as "Alquileres"
from rental r 
group by "Mes de Alquiler"
order by "Alquileres" desc;

--26. Encuentra el promedio, la desviación estándar y varianza del total pagado.

select 
    round(AVG(p.amount),2) as "Promedio",
    round(stddev(p.amount),2) as "Desviacón estandar", 
    round(variance(p.amount),2) as "Varianza"
from payment p ;

--27. ¿Qué películas se alquilan por encima del precio medio?

select f.title
from film f 
where f.rental_rate >
     (select avg (f.rental_rate )
      from film f);
 
--28. Muestra el id de los actores que hayan participado en más de 40 películas.
      
select fa.actor_id
from film_actor fa 
group by actor_id 
having count(fa.actor_id)> 40 ;

--29. Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.

select
    f.title,
    count(i.film_id ) as "Cantidad disponible"
from film f 
left join inventory i 
on f.film_id = i.film_id
group by f.film_id  ;

--30. Obtener los actores y el número de películas en las que ha actuado.

select 
    a.first_name, 
    a.last_name, 
    count(fa.actor_id) as "Películas en las que ha actuado"
from actor a 
inner join film_actor fa 
on a.actor_id = fa.actor_id
group by fa.actor_id, a.first_name, a.last_name ;

--31. Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.

select f.title, a.first_name, a.last_name 
from film f 
left join film_actor fa 
on f.film_id = fa.film_id
left join actor a 
on fa.actor_id = a.actor_id
order by f.title ;

--32. Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película.

select a.first_name, a.last_name, f.title 
from actor a 
left join film_actor fa 
on a.actor_id = fa.actor_id
left join film f 
on fa.film_id = f.film_id
order by a.first_name ;

--33. Obtener todas las películas que tenemos y todos los registros de alquiler.

select f.title, r.* 
from film f 
full join inventory i 
on f.film_id = i.film_id
full join rental r 
on i.inventory_id = r.inventory_id 
order by f.title;


--34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.

select 
     p.customer_id,
      sum (p.amount) as "Gastado"
from payment p 
group by p.customer_id 
order by sum (p.amount) desc 
limit 5 ;

--35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.

select a.first_name, a.last_name 
from actor a 
where a.first_name ilike 'Johnny' ;

--36. Renombra la columna “first_name” como Nombre y “last_name” como Apellido.

select
   a.first_name as "Nombre",
   a.last_name as "Apellido"
from actor a ;

--37. Encuentra el ID del actor más bajo y más alto en la tabla actor.

select 
    MIN(a.actor_id) as "ID más bajo",
    MAX(a.actor_id) as "ID más alto"
from actor a ;

--38. Cuenta cuántos actores hay en la tabla “actor”.

select count(*) as "Nº de actores"
from actor a ;

--39. Selecciona todos los actores y ordénalos por apellido en orden ascendente.

select *
from actor a 
order by a.last_name asc;

--40. Selecciona las primeras 5 películas de la tabla “film”.

select *
from film f 
limit 5;

--41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido?

select 
    count (*) as "Nº actores con el mismo nombre", 
    a.first_name 
from actor a 
group by a.first_name 
order by "Nº actores con el mismo nombre" desc;

--42. Encuentra todos los alquileres y los nombres de los clientes que los realizaron.

select r.rental_id, c.first_name, c.last_name 
from rental r 
inner join customer c 
on r.customer_id = c.customer_id ;

--43. Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.

select c.customer_id, c.first_name, c.last_name, r.*
from customer c 
left join rental r 
on c.customer_id = r.customer_id ;

--44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.

select* 
from film f 
cross join category c ;
-- No aporta ningun valor ya que une todas las peliculas con todas las categorias pero cada película solo puede tener una categoria.

--45. Encuentra los actores que han participado en películas de la categoría 'Action'.

select distinct a.first_name, a.last_name 
from actor a 
inner join film_actor fa 
on a.actor_id = fa.actor_id
inner join film_category fc 
on fa.film_id = fc.film_id 
inner join category c 
on fc.category_id = c.category_id
where c."name" = 'Action';

--46. Encuentra todos los actores que no han participado en películas.

select a.actor_id, a.first_name, a.last_name 
from actor a 
left join film_actor fa
on a.actor_id = fa.actor_id
where fa.film_id is null;

--47. Selecciona el nombre de los actores y la cantidad de películas en las que han participado.

select 
    a.first_name,
    a.last_name,
    count(fa.actor_id) as "Películas en las que ha actuado"
from actor a 
inner join film_actor fa 
on a.actor_id = fa.actor_id
group by fa.actor_id, a.first_name, a.last_name ;

--48. Crea una vista llamada “actor_num_peliculas” que muestre los nombres de los actores y el número de películas en las que han participado.

create view actor_num_peliculas as 
    select 
        a.first_name,
        a.last_name,
        count(fa.actor_id) as "Películas en las que ha actuado"
    from actor a 
    inner join film_actor fa 
    on a.actor_id = fa.actor_id
    group by fa.actor_id, a.first_name, a.last_name ;

--49. Calcula el número total de alquileres realizados por cada cliente.

select 
    r.customer_id,
    count(*) as "Nº de Alquileres"
from rental r 
group by r.customer_id ;

--50. Calcula la duración total de las películas en la categoría 'Action'.

select sum(f.length ) as "Duración total películas de Acción"
from film f 
inner join film_category fc 
on f.film_id = fc.film_id
inner join category c 
on fc.category_id = c.category_id
where c.name = 'Action';

--51. Crea una tabla temporal llamada “cliente_rentas_temporal” para almacenar el total de alquileres por cliente.

create temp table clientes_rentas_temporal as (
     select 
     r.customer_id,
     count(*) as "Nº de Alquileres"
     from rental r 
     group by r.customer_id);

--52. Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las películas que han sido alquiladas al menos 10 veces.

create temp table peliculas_alquiladas as(
       select f.title, count(r.rental_id)
       from film f
       inner join inventory i 
       on f.film_id = i.film_id
       inner join rental r 
       on i.inventory_id = r.inventory_id
       group by f.film_id 
       having count (r.rental_id ) >10) ;

/*53. Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sanders’ y que aún no se han devuelto. Ordena
      los resultados alfabéticamente por título de película.*/

select f.title 
from customer c 
inner join rental r 
on c.customer_id = r.customer_id
inner join inventory i
on r.inventory_id = i.inventory_id
inner join film f 
on i.film_id = f.film_id
where c.first_name ilike 'Tammy' 
and c.last_name ilike 'Sanders' 
and r.return_date is null 
order by f.title ;


/*54. Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría ‘Sci-Fi’. Ordena los resultados
      alfabéticamente por apellido.*/

select distinct a.first_name, a.last_name 
from actor a 
inner join film_actor fa 
on a.actor_id = fa.actor_id
inner join film_category fc 
on fa.film_id = fc.film_id
inner join category c 
on fc.category_id = c.category_id
where c.name = 'Sci-Fi'
order by a.last_name ;

/*55 Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película ‘Spartacus
     Cheaper’ se alquilara por primera vez. Ordena los resultados alfabéticamente por apellido.*/
    
select distinct a.first_name, a.last_name 
from actor a 
inner join film_actor fa 
on a.actor_id = fa.actor_id
inner join film f 
on fa.film_id = f.film_id
inner join inventory i 
on f.film_id = i.film_id
inner join rental r 
on i.inventory_id = r.inventory_id
where r.rental_date >
   (select min (r2.rental_date )
    from rental r2 
    inner join inventory i2
    on r2.inventory_id = i2.inventory_id 
    inner join film f2
    on i2.film_id = f2.film_id 
    where f2.title = 'Spartacus Cheaper')
order by a.last_name ;

--56. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Music’.

select a.first_name, a.last_name
from actor a 
where a.actor_id not in (
    select fa.actor_id
    from film_actor fa 
    inner join film_category fc
    on fa.film_id = fc.film_id 
    inner join category c 
    on fc.category_id = c.category_id
    where c.name = 'Music') ;

--57. Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.
    
select f.title
from film f 
inner join inventory i 
on f.film_id = i.film_id
inner join rental r 
on i.inventory_id = r.inventory_id
where (r.return_date - r.rental_date) > INTERVAL '8 days' ;

--58. Encuentra el título de todas las películas que son de la misma categoría que ‘Animation’.

select f.title
from film f 
inner join film_category fc 
on f.film_id = fc.film_id
inner join category c 
on fc.category_id = c.category_id
where c.name = 'Animation' ;

/*59. Encuentra los nombres de las películas que tienen la misma duración que la película con el título ‘Dancing Fever’. Ordena los resultados
  alfabéticamente por título de película.*/

select f.title 
from film f 
where f.length = ( select f.length
                   from film f 
                   where f.title ilike 'Dancing Fever')
order by f.title ;

--60. Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. Ordena los resultados alfabéticamente por apellido.

select c.first_name, c.last_name
from customer c 
inner join rental r 
on c.customer_id = r.customer_id
inner join inventory i 
on r.inventory_id = i.inventory_id
group by c.customer_id, c.first_name, c.last_name 
having count (distinct i.film_id ) >= 7
order by c.last_name ;

--61. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.

select 
    c.name, 
    count(r.rental_id ) as "Nº de Alquileres"
from rental r 
inner join inventory i
on r.inventory_id = i.inventory_id
inner join film_category fc 
on i.film_id = fc.film_id 
inner join category c 
on fc.category_id = c.category_id
group by c.name ;

--62. Encuentra el número de películas por categoría estrenadas en 2006.

select 
     c.name,
     count(*)
from category c 
inner join film_category fc 
on c.category_id = fc.category_id
inner join film f 
on fc.film_id = f.film_id
where f.release_year = '2006'
group by c.name ;

--63. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.

select s.staff_id, s.first_name, s.last_name, s2.store_id 
from staff s 
cross join store s2 ;

/*64. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de
  películas alquiladas.*/

select 
    c.customer_id, 
    c.first_name, 
    c.last_name,
    count(r.rental_id ) as "Cantidad de películas alquiladas"
from customer c 
left join rental r 
on c.customer_id = r.customer_id
group by c.customer_id, c.first_name, c.last_name 






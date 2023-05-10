--función sin parametro de entrada para devolver el precio máximo
CREATE OR REPLACE FUNCTION public.precio_max(
	)
    RETURNS numeric
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare maximo numeric;
begin
	select max(unit_price) into maximo from public.products;
	return maximo;
end
$BODY$;

ALTER FUNCTION public.precio_max()
    OWNER TO postgres;
--Parametro de entrada obtener el numero de ordenes por empleado
CREATE OR REPLACE FUNCTION public.obtener_ordenes(
	id_employee integer)
    RETURNS numeric
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare num integer;
begin
	select count(*) into num from public.orders where employee_id=id_employee;
	return num;
end
$BODY$;

ALTER FUNCTION public.obtener_ordenes(integer)
    OWNER TO postgres;
--Obtener la venta de un empleado con un determinado producto
CREATE OR REPLACE FUNCTION public.venta(
	)
    RETURNS TABLE(product smallint, name character varying, unit_precio real, units_stock smallint) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
begin
	return query
	select product_id,product_name,unit_price,units_in_stock
	from public.products
	where product_name like 'N%';
end
$BODY$;
--obtener las ordener por año
CREATE OR REPLACE FUNCTION public.anio(
	)
    RETURNS TABLE(anio numeric, ordenes bigint) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
begin
	return query
	select extract(year from order_date), count(order_id)
	from public.orders
	group by extract(year from order_date);
end
$BODY$;
--lo mismo que el anterior pero pasando el año
CREATE OR REPLACE FUNCTION public.anio_params(
	anio integer)
    RETURNS TABLE(year numeric, num_orders bigint) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
begin
	return query
	select extract(year from order_date) as year, count(order_id)
	from public.orders
	where extract(year from order_date) = anio
	group by year;
end 
$BODY$;
--promedio del precio según categoría 
CREATE OR REPLACE FUNCTION public.promedio_suma(
	categoria_id integer)
    RETURNS TABLE(promedio double precision, num_orders bigint) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
begin
	return query
	select avg(unit_price), sum(units_in_stock)
	from public.products
	where category_id = categoria_id
	group by category_id;
end 
$BODY$;

select * from promedio_suma(1);
-- Sentencia Select 
--Obtener todos los registros y todos los campos de la tabla de productos
select * from public.products;
-- Obtener una consulta con Productid, productname, supplierid, categoryId, UnistsinStock, UnitPrice
select product_id,product_name,supplier_id,category_id,units_in_stock,unit_price from public.products;
--Crear una consulta para obtener el IdOrden, IdCustomer, Fecha de la orden de la tabla de ordenes.
select order_id,customer_id,order_date from public.orders;
--Crear una consulta para obtener el OrderId, EmployeeId, Fecha de la orden.

--Columnas calculadas 
--Obtener una consulta con Productid, productname y valor del inventario, valor inventrio (UnitsinStock * UnitPrice)
select product_id,product_name,units_in_stock*unit_price as "valor_inventario" from public.products;
-- Cuanto vale el punto de reorden 
select reorder_level from public.products;
-- Mostrar una consulta con Productid, productname y precio, el nombre del producto debe estar en mayuscula 
select product_id,upper(product_name),unit_price from public.products;
-- Mostrar una consulta con Productid, productname y precio, el nombre del producto debe contener unicamente 10 caracteres */
select product_id,product_name,unit_price from public.products where length(product_name)=10;
--Obtener una consulta que muestre la longitud del nombre del producto
select length(product_name) from public.products;
--Obtener una consulta de la tabla de productos que muestre el nombre en minúscula
select lower(product_name) from public.products;
-- Mostrar una consulta con Productid, productname y precio, el nombre del producto debe contener unicamente 10 caracteres y se deben mostrar en mayúscula */
select product_id,upper(product_name),unit_price from public.products where length(product_name)=10;

--Filtros
--Obtener de la tabla de Customers las columnas CustomerId, CompanyName, Pais Obtener los clientes cuyo pais sea Spain
select customer_id,company_name,country from public.customers where country='Spain';
--Obtener de la tabla de Customers las columnas CustomerId, CompanyName, Pais, Obtener los clientes cuyo pais comience con la letra U
select customer_id,company_name,country from public.customers where country like'U%';
--Obtener de la tabla de Customers las columnas CustomerId, CompanyName, Pais, Obtener los clientes cuyo pais comience con la letra U,S,A
select customer_id,company_name,country from public.customers where country like'U%' OR country like'S%' OR country like'A%';
--Obtener de la tabla de Productos las columnas productid, ProductName, UnitPrice cuyos precios esten entre 50 y 150
select product_id,product_name,unit_price from public.products where unit_price between 50 and 150;
--Obtener de la tabla de Productos las columnas productid, ProductName, UnitPrice, UnitsInStock cuyas existencias esten entre 50 y 100
select product_id,product_name,unit_price,units_in_stock from public.products where units_in_stock  between 50 and 100;
--Obtener las columnas OrderId, CustomerId, employeeid de la tabla de ordenes cuyos empleados sean 1, 4, 9
select order_id,customer_id,employee_id from public.orders where employee_id=1 or employee_id=4 or employee_id=9;
-- ORDENAR EL RESULTADO DE LA QUERY POR ALGUNA COLUMNA Obtener la información de la tabla de Products, Ordenarlos por Nombre del Producto de forma ascendente
select * from public.products order by product_name asc;
-- Obtener la información de la tabla de Products, Ordenarlos por Categoria de forma ascendente y por precio unitario de forma descendente
select * from public.products order by category_id asc, unit_price desc;
select * from public.products order by unit_price desc;
-- Obtener la información de la tabla de Clientes, Customerid, CompanyName, city, country ordenar por pais, ciudad de forma ascendente
select customer_id,company_name,city,country from public.customers order by country, city asc;
-- Obtener los productos productid, productname, categoryid, supplierid ordenar por categoryid y supplier únicamente mostrar aquellos cuyo precio esté entre 25 y 200
select product_id,product_name,category_id,supplier_id from public.products where unit_price between 25 and 200 order by category_id,supplier_id;

--Funciones agregación

--Cuantos productos hay en la tabla de productos
select sum(product_id) from public.products;
--de la tabla de productos Sumar las cantidades en existencia 
select sum(units_in_stock) from public.products;
--Promedio de los precios de la tabla de productos
select avg(unit_price) from public.products;

--Ordenar
--Obtener los datos de productos ordenados descendentemente por precio unitario de la categoría 1
select * from public.products where category_id=1 order by unit_price desc;
--Obtener los datos de los clientes(Customers) ordenados descendentemente por nombre(CompanyName) que se encuentren en la ciudad(city) de barcelona, Lisboa
select * from public.customers where city in ('Barcelona','Lisboa') order by company_name desc;
--Obtener los datos de las ordenes, ordenados descendentemente por la fecha de la orden cuyo cliente(CustomerId) sea ALFKI
select * from public.orders where customer_id='ALFKI' order by order_date desc;
--Obtener los datos del detalle de ordenes, ordenados ascendentemente por precio cuyo producto sea 1, 5 o 20
select * from public.order_details where product_id in(1,5,20) order by unit_price asc;
--Obtener los datos de las ordenes ordenados ascendentemente por la fecha de la orden cuyo empleado sea 2 o 4
select * from public.orders where employee_id in(2,4) order by order_date asc;
--Obtener los productos cuyo precio están entre 30 y 60 ordenado por nombre
select * from public.products where unit_price between 30 and 60 order by product_name;

--funciones de agrupacion
--OBTENER EL MAXIMO, MINIMO Y PROMEDIO DE PRECIO UNITARIO DE LA TABLA DE PRODUCTOS UTILIZANDO ALIAS
select max(unit_price) as "MAXIMO", min(unit_price) as "MINIMO", avg(unit_price) as "PROMEDIO" from public.products;

--Agrupacion
--Numero de productos por categoria
select category_id, count(*) as "Productos" from public.products group by category_id;
--Obtener el precio promedio por proveedor de la tabla de productos
select supplier_id,avg(unit_price) from public.products group by supplier_id;
--Obtener la suma de inventario (UnitsInStock) por SupplierID De la tabla de productos (Products)
select supplier_id,sum(units_in_stock) from public.products group by supplier_id;
--Contar las ordenes por cliente de la tabla de orders
select customer_id,sum(order_id) from public.orders group by customer_id;
--Contar las ordenes por empleado de la tabla de ordenes unicamente del empleado 1,3,5,6
select employee_id,sum(order_id) from public.orders where employee_id in (1,3,5,6) group by employee_id;
--Obtener la suma del envío (freight) por cliente
select customer_id, sum(freight) from public.orders group by customer_id;
--De la tabla de ordenes únicamente de los registros cuya ShipCity sea Madrid, Sevilla, Barcelona, Lisboa, LondonOrdenado por el campo de suma del envío
select *,sum(freight) from public.orders where ship_city in ('Madrid','Sevilla','Barcelona','Lisboa','London') group by order_id order by freight;
--obtener el precio promedio de los productos por categoria sin contar con los productos descontinuados (Discontinued)
select category_id,avg(unit_price) from public.products where discontinued=0 group by category_id;
--Obtener la cantidad de productos por categoria,  aquellos cuyo precio se encuentre entre 10 y 60 que tengan más de 12 productos
select category_id,count(product_id) from public.products where product_id between 10 and 60 group by category_id having count(*)>12;
--OBTENER LA SUMA DE LAS UNIDADES EN EXISTENCIA (UnitsInStock) POR CATEGORIA, Y TOMANDO EN CUENTA UNICAMENTE LOS PRODUCTOS CUYO PROVEEDOR (SupplierID) SEA IGUAL A 17, 19, 16.
--cuya categoria tenga menos de 100 unidades ordenado por unidades
select category_id,sum(units_in_stock) as Total  from public.products where supplier_id in(17,19,16) and category_id in(select category_id from public.products group by category_id having sum(units_in_stock) < 100)group by category_id order by Total;










--distinct

-- Se quiere saber a qué paises se les vende usar la tabla de clientes
select distinct country from  public.customers;
-- Se quiere saber a qué ciudades se les vende usar la tabla de clientes
select distinct city from public.customers;
-- Se quiere saber a qué ciudades se les ha enviado una orden
select distinct ship_city from public.orders;
--Se quiere saber a qué ciudades se les vende en el pais USA usar la tabla de clientes
select distinct city from public.customers where country='USA';

--Agrupacion
-- Se quiere saber a qué paises se les vende usar la tabla de clientes nota hacerla usando group by
select city from public.customers group by city;
--Cuantos clientes hay por pais
select country,count(customer_id) from public.customers group by country;
--Cuantos clientes hay por ciudad en el pais USA
select city,count(customer_id) from public.customers where country='USA' group by city;
--Cuantos productos hay por proveedor de la categoria 1
select supplier_id,count(product_id) from public.products group by supplier_id;

--Filtro con having
-- Cuales son los proveedores que nos surten más de 1 producto, mostrar el proveedor mostrar la cantidad de productos
select supplier_id,count(product_id) from public.products group by supplier_id having count(*)>1;
-- Cuales son los proveedores que nos surten más de 1 producto, mostrar el proveedor mostrar la cantidad de productos, pero únicamente de la categoria 1
select supplier_id,count(product_id) from public.products where category_id=1 group by supplier_id having count(*)>1;
--CONTAR LAS ORDENES POR EMPLEADO DE LOS PAISES USA, CANADA, SPAIN (ShipCountry) MOSTRAR UNICAMENTE LOS EMPLEADOS CUYO CONTADOR DE ORDENES SEA MAYOR A 20
select employee_id,count(order_id) from public.orders where ship_country in ('USA','Canada','Spain') group by employee_id having count(*)>20;
--OBTENER EL PRECIO PROMEDIO DE LOS PRODUCTOS POR PROVEEDOR UNICAMENTE DE AQUELLOS CUYO PROMEDIO SEA MAYOR A 20
select supplier_id,avg(units_in_stock) from public.products group by supplier_id having avg(units_in_stock)>20;
--OBTENER LA SUMA DE LAS UNIDADES EN EXISTENCIA (UnitsInStock) POR CATEGORIA, Y TOMANDO EN CUENTA UNICAMENTE LOS PRODUCTOS CUYO PROVEEDOR (SupplierID) SEA IGUAL A 17, 19, 16 DICIONALMENTE CUYA SUMA POR CATEGORIA SEA MAYOR A 300--
select category_id,sum(units_in_stock) from public.products where supplier_id in(17,19,16) group by category_id having sum(units_in_stock)>300;
--CONTAR LAS ORDENES POR EMPLEADO DE LOS PAISES (ShipCountry) SA, CANADA, SPAIN cuYO CONTADOR SEA MAYOR A 25
select employee_id,count(order_id) from public.orders where ship_country in ('SA','Canada','Spain') group by employee_id having count(*)>25;
----OBTENER LAS VENTAS (Quantity * UnitPrice) AGRUPADAS POR PRODUCTO (Orders details) Y CUYA SUMA DE VENTAS SEA MAYOR A 50.000
select product_id,sum(quantity * unit_price) as ventas from public.order_details group by product_id having sum(quantity * unit_price)>50000;

--Mas de una tabla 

--OBTENER EL NUMERO DE ORDEN, EL ID EMPLEADO, NOMBRE Y APELLIDO DE LAS TABLAS DE ORDENES Y EMPLEADOS
select orders.order_id,orders.employee_id,employees.first_name,employees.last_name from employees inner join orders on employees.employee_id = orders.employee_id;
--OBTENER EL PRODUCTID, PRODUCTNAME, SUPPLIERID, COMPANYNAME DE LAS TABLAS DE PRODUCTOS Y PROVEEDORES (SUPPLIERS)
select produ.product_id,produ.product_name,produ.supplier_id,prov.company_name from public.products as produ inner join public.suppliers as prov on produ.supplier_id = prov.supplier_id;
--OBTENER LOS DATOS DEL DETALLE DE ORDENES CON EL NOMBRE DEL PRODUCTO DE LAS TABLAS DE DETALLE DE ORDENES Y DE PRODUCTOS
select o.*,pr.product_name from public.order_details as o inner join public.products as pr on o.product_id=pr.product_id;
--OBTENER DE LAS ORDENES EL ID, SHIPPERID, NOMBRE DE LA COMPAÑÍA DE ENVIO (SHIPPERS)
select order_id,shipper_id,company_name from shippers as s inner join public.orders as o on s.shipper_id=o.ship_via;
--Obtener el número de orden, país de envío (shipCountry) y el nombre del empleado de la tabla ordenes y empleados Queremos que salga el Nombre y Apellido del Empleado en una sola columna.
select o.order_id,o.ship_country,concat(e.first_name,' ',e.last_name) as Nombre from public.orders as o inner join public.employees as e on o.employee_id=e.employee_id;
--Combinando la mayoría de conceptos

--CONTAR EL NUMERO DE ORDENES POR EMPLEADO OBTENIENDO EL ID EMPLEADO Y EL NOMBRE COMPLETO DE LAS TABLAS DE ORDENES Y DE EMPLEADOS join y group by / columna calculada
select o.employee_id,concat(e.first_name,' ',e.last_name) as Nombre,count(o.order_id) from public.orders as o inner join public.employees as e on o.employee_id=e.employee_id group by o.employee_id,e.first_name,e.last_name;
--OBTENER LA SUMA DE LA CANTIDAD VENDIDA Y EL PRECIO PROMEDIO POR NOMBRE DE PRODUCTO DE LA TABLA DE ORDERS DETAILS Y PRODUCTS
select pr.product_name,sum(o.unit_price),avg(o.unit_price) from public.products as pr inner join public.order_details as o on pr.product_id=o.product_id group by pr.product_name;
--OBTENER LAS VENTAS (UNITPRICE * QUANTITY) POR CLIENTE DE LAS TABLAS ORDER DETAILS, ORDERS
select o.customer_id,sum(od.unit_price * od.quantity) as sales from public.orders as o inner join public.order_details od on o.order_id=od.order_id group by o.customer_id;
--OBTENER LAS VENTAS (UNITPRICE * QUANTITY) POR EMPLEADO MOSTRANDO EL APELLIDO (LASTNAME)DE LAS TABLAS EMPLEADOS, ORDENES, DETALLE DE ORDENES
select e.last_name as Nombre,sum(od.unit_price * od.quantity) as sales from public.employees as e inner join public.orders as o on e.employee_id=o.employee_id inner join public.order_details od on o.order_id=od.order_id group by Nombre;
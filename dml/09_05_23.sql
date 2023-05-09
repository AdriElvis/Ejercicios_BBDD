--Subconsultas

-- Obtener los productos cuyo precio unitario sea mayor al precio promedio de la tabla de productos
select * from public.products where unit_price > (select avg(unit_price) from public.products);
-- Obtener los productos cuya cantidad en stock sea menor al promedio de cantidad en stock de toda la tabla de productos.
select * from public.products where units_in_stock < (select avg(units_in_stock) from public.products);
-- Obtener los productos cuya cantidad en Inventario (UnitsInStock) sea menor a la cantidad mínima del detalle de ordenes (Order Details)
select * from public.products where units_in_stock < all(select quantity from public.order_details);
--OBTENER LOS PRODUCTOS CUYA CATEGORIA SEA IGUAL A LAS CATEGORIAS DE LOS PRODUCTOS CON PROVEEDOR 1.
select * from public.products where category_id in (select category_id from public.products where supplier_id=1);

-- Subconsultas correlacionadas 

--Obtener el número de empleado y el apellido para aquellos empleados que tengan menos de 100 ordenes.

SELECT employee_id, last_name
FROM employees
WHERE (
  SELECT COUNT(*)
  FROM orders
  WHERE employee_id = employees.employee_id
) < 100;
--Obtener la clave de cliente y el nombre de la empresa para aquellos clientes que tengan más de 20 ordenes
SELECT customer_id, company_name
FROM customers c
WHERE (
  SELECT COUNT(*) 
  FROM orders o 
  WHERE o.customer_id = c.customer_id
) > 20;
--Obtener el productoid, el nombre del producto, el proveedor de la tabla de productos para aquellos productos que se hayan vendido menos de 100 unidades (Consultarlo en la tabla de Orders details).
SELECT product_id, product_name, supplier_id
FROM products p
WHERE EXISTS (
  SELECT 1
  FROM order_details od
  WHERE od.product_id = p.product_id
  GROUP BY od.product_id
  HAVING SUM(quantity) < 100
);

--Obtener los datos del empleado IDEmpleado y nombre completo De aquellos que tengan mas de 100 ordenes
SELECT employee_id, CONCAT(first_name, ' ', last_name) AS nombre_completo
FROM employees
WHERE employee_id IN (
  SELECT employee_id
  FROM orders
  WHERE orders.employee_id = employees.employee_id
  GROUP BY employee_id
  HAVING COUNT(*) > 100
);
--Obtener los datos de Producto ProductId, ProductName, UnitsinStock, UnitPrice (Tabla Products) de los productos que la sumatoria de la cantidad (Quantity) de orders details sea mayor a 450
SELECT product_id, product_name, units_in_stock, unit_price
FROM products
WHERE product_id IN (
  SELECT product_id
  FROM order_details
  WHERE order_details.product_id = products.product_id
  GROUP BY product_id
  HAVING SUM(quantity) > 450
);
--Obtener la clave de cliente y el nombre de la empresa para aquellos clientes que tengan más de 20 ordenes.
SELECT customer_id, company_name
FROM customers
WHERE customer_id IN (
  SELECT customer_id
  FROM orders
  WHERE customers.customer_id = orders.customer_id
  GROUP BY customer_id
  HAVING COUNT(*) > 20
);

--insert

--Insertar un registro en la tabla de Categorias, únicamente se quiere insertar la información del CategoryName y la descripción los Papelería y papelería escolar
insert into public.categories values(9,'Papelería','papelería escolar');
--Dar de alta un producto con Productname, SupplierId, CategoryId, UnitPrice, UnitsInStock Como esta tabla tiene dos clave foraneas hay que ver los datos a dar de alta
insert into public.products (product_id,product_name,supplier_id,category_id,unit_price,units_in_stock,discontinued) values(78,'miproducto',8,9,18,12,0);
--Dar de alta un empleado con LastName, FistName, Title, BrithDate
insert into public.employees (employee_id,last_name,first_name,title,birth_date) values(10,'Sánchez','Adrián','Sales Manager','1996-12-08');
--Dar de alta una orden, CustomerId, Employeeid, Orderdate, ShipVia Como esta tabla tiene dos clave foraneas hay que ver los datos a dar de alta
insert into public.orders (order_id,customer_id,employee_id,order_date,ship_via) values (11078,'LILAS',5,'1996-08-10',2);
--Dar de alta un Order details, con todos los datos
insert into public.order_details values(11078,20,10.4,15,0.25);

--update

-- Cambiar el CategoryName a Verduras de la categoria 10
update public.categories
set category_name = 'Verduras'
where category_id = 10;
-- Actualizar los precios de la tabla de Productos para incrementarlos un 10%
update public.products
set unit_price = unit_price*1.1;
--ACTUALIZAR EL PRODUCTNAME DEL PRODUCTO 80 A ZANAHORIA ECOLOGICA
update public.products
set product_name = 'Zanahoria ecológica'
where product_id = 80;
--ACTUALIZAR EL FIRSTNAME DEL EMPLOYEE 10 A ROSARIO 
update public.employees
set first_name = 'Rosario'
where employee_id = 10;
--ACTUALIZAR EL ORDERS DETAILS DE LA 11079 PARA QUE SU CANTIDAD SEA 10
update public.employees
set first_name = 'Rosario'
where employee_id = 10;

--Delete

--diferencia entre delete y truncate
--BORRAR EL EMPLEADO 10
delete from public.employees
where employee_id = 10;


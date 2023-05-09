-- EJERCICIOS
/*

1 - Escriba un bloque de codigo PL/pgSQL que reciba una nota como parametro
    y notifique en la consola de mensaje las letras A,B,C,D,E o F segun el valor de la nota
*/
DO $$
	declare nota integer:= 5;
	begin
	CASE nota
		WHEN 0 THEN
			raise notice 'F';
		WHEN 1 THEN
			raise notice 'F';
		WHEN 2 THEN
			raise notice 'F';
		WHEN 3 THEN
			raise notice 'F';
		WHEN 4 THEN
			raise notice 'F';
		WHEN 5 THEN
			raise notice 'E';
		WHEN 6 THEN
			raise notice 'D';
		WHEN 7 THEN
			raise notice 'C';
		WHEN 8 THEN
			raise notice 'B';
		WHEN 9 THEN

		WHEN 10 THEN
			raise notice 'A';
		ELSE
			raise notice 'Nota errónea';
	END CASE;
END $$ language 'plpgsql'
/*
2 - Escriba un bloque de codigo PL/pgSQL que reciba un numero como parametro
    y muestre la tabla de multiplicar de ese numero.
*/
DO $$
	declare num integer:= 6;
	declare cont integer:=0;
	declare resultado integer:=0;
	begin
		FOR cont IN 0..10 LOOP
			resultado := num*cont;
			raise notice '% X % = %',num,cont,resultado;
		END LOOP;
END $$ language 'plpgsql'

/*
3 - Escriba una funcion PL/pgSQL que convierta de dolares a moneda nacional.
    La funcion debe recibir dos parametros, cantidad de dolares y tasa de cambio.
    Al final debe retornar el monto convertido a moneda nacional.
*/
DO $$
	DECLARE
	  dolares INTEGER := 1;
	  tasa NUMERIC := 0.91;
	  nacional numeric := dolares * tasa;
	BEGIN
  	RAISE NOTICE '%', nacional;
END $$ LANGUAGE plpgsql;
/*

4 - Escriba una funcion PL/pgSQL que reciba como parametro el monto de un prestamo,
    su duracion en meses y la tasa de interes, retornando el monto de la cuota a pagar.
    Aplicar el metodo de amortizacion frances.
*/
DO $$
	DECLARE
		monto_prestamo numeric := 10000;
		meses integer := 24;
		tasa_interes numeric := 5;
		cuota_mensual numeric;
	BEGIN
	cuota_mensual := monto_prestamo/(1-(1/(1+tasa_interes))^meses)/tasa_interes;
    RAISE NOTICE 'La cuota mensual a pagar es: %', cuota_mensual;
END $$ LANGUAGE plpgsql;
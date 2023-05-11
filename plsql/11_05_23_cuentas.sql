-- create table cuentas (cuenta serial primary key, saldo numeric);
-- insert into cuentas (saldo) values (8000.0);
-- create table movimientos (id_movimiento serial primary key,cuenta integer references cuentas(cuenta), descripcion varchar(20), cantidad integer);

-- create trigger tg_pista
-- before insert
-- on movimientos
-- execute procedure actualizar_cuenta();

create trigger tg_insertar_movimiento
before update
on cuentas
execute procedure insertar_movimiento();

-- create or replace function actualizar_cuenta()
-- returns trigger
-- as $$
-- begin
-- 	if new.descripcion='retirada' then
-- 		update cuentas set saldo = saldo - new.cantidad where cuenta = new.cuenta;
-- 	elsif new.descripcion='ingreso' then
-- 		update cuentas set saldo = saldo + new.cantidad where cuenta = new.cuenta;
-- 	end if;
-- return new;
-- end;
-- $$ language 'plpgsql';

create or replace function insertar_movimiento()
returns trigger
as $$
begin
	if new.saldo > old.saldo then
		insert into movimientos(cuenta,descripcion,cantidad) values(new.cuenta,'ingreso',new.saldo - old.saldo);
	elsif new.saldo < old.saldo then
		insert into movimientos(cuenta,descripcion,cantidad) values(new.cuenta,'retirada',old.saldo - new.saldo);
	end if;
return new;
end;
$$ language 'plpgsql';

create or replace procedure ingreso(in c_destino integer, descripcion varchar(20), in cantidad numeric)
as $$
begin
	if exists(select cuenta from public.cuentas where cuenta=c_destino) then
		if cantidad >0 then	
			if descripcion='retirada' then
				if(select saldo from public.cuentas where cuenta=c_destino)>cantidad then
					update cuentas set saldo = saldo - cantidad where cuenta = c_destino;
				else
					raise exception 'La cuenta no dispone de suficiente saldo';
					rollback;
				end if;
			elsif descripcion='ingreso' then
				update cuentas set saldo = saldo + cantidad where cuenta = c_destino;
			else
				raise exception 'Descripción incorrecta, escriba ingreso o retirada';
				rollback;
			end if;
		else
			raise exception 'La cantidad tiene que ser mayor a 0';
			rollback;
		end if;
	else
		raise exception 'La cuenta no existe';
		rollback;
	end if;
end $$ language 'plpgsql'

call ingreso(1,'retirada',300);
select * from cuentas;
select * from movimientos;
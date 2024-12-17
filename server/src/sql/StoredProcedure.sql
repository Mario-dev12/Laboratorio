/*----------------------------------------------------------------------------------------------------------------------
--------------------------------------------- DESPUES TERCERO CORRE ESTO -------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------ */

CREATE OR REPLACE FUNCTION sp_find_all_alliance(
	)
    RETURNS json[]
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare 
	v_json_resp json[];
begin
	select array(
        select jsonb_build_object(
			'idAlliance', a.idAlliance,
			'quantity', a.quantity,
            'idReactive', a.idReactive,
			'idProvider', a.idProvider,
			'createdDate', a.createdDate,
            'modifiedDate', a.modifiedDate
		)
		from alliance a
        ) ::json[] into v_json_resp;
		return v_json_resp;
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_find_all_exam(
	)
    RETURNS json[]
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare 
	v_json_resp json[];
begin
	select array(
        select jsonb_build_object(
			'idExam', a.idExam,
			'name', a.name,
            'cost_bs', a.cost_bs,
			'cost_usd', a.cost_usd,
			'status', a.status,
			'idUser', a.idUser,
			'createdDate', a.createdDate,
            'modifiedDate', a.modifiedDate
		)
		from exam a
        ) ::json[] into v_json_resp;
		return v_json_resp;
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_find_all_payment_method(
	)
    RETURNS json[]
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare 
	v_json_resp json[];
begin
	select array(
        select jsonb_build_object(
			'idPayment_method', a.idPayment_method,
			'name', a.name,
            'amount', a.amount,
			'bank', a.bank,
			'type', a.type,
			'idExam', a.idExam,
			'createdDate', a.createdDate,
            'modifiedDate', a.modifiedDate
		)
		from payment_method a
        ) ::json[] into v_json_resp;
		return v_json_resp;
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_find_all_provider(
	)
    RETURNS json[]
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare 
	v_json_resp json[];
begin
	select array(
        select jsonb_build_object(
			'idProvider', a.idProvider,
			'name', a.name,
			'createdDate', a.createdDate,
            'modifiedDate', a.modifiedDate
		)
		from provider a
        ) ::json[] into v_json_resp;
		return v_json_resp;
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_find_all_reactive(
	)
    RETURNS json[]
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare 
	v_json_resp json[];
begin
	select array(
        select jsonb_build_object(
			'idReactive', a.idReactive,
			'name', a.name,
			'quantity', a.quantity,
			'idExam', a.idExam,
			'createdDate', a.createdDate,
            'modifiedDate', a.modifiedDate
		)
		from reactive a
        ) ::json[] into v_json_resp;
		return v_json_resp;
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_find_all_unit(
	)
    RETURNS json[]
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare 
	v_json_resp json[];
begin
	select array(
        select jsonb_build_object(
			'idUnit', a.idUnit,
			'name', a.name,
			'idExam', a.idExam,
			'createdDate', a.createdDate,
            'modifiedDate', a.modifiedDate
		)
		from unit a
        ) ::json[] into v_json_resp;
		return v_json_resp;
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_find_all_users(
	)
    RETURNS json[]
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare 
	v_json_resp json[];
begin
	select array(
        select jsonb_build_object(
			'idUser', a.idUser,
			'ci', a.ci,
			'passport', a.passport,
			'firstName', a.firstName,
			'lastName', a.lastName,
			'genre', a.genre,
			'age', a.age,
			'address', a.address,
			'createdDate', a.createdDate,
            'modifiedDate', a.modifiedDate
		)
		from users a
        ) ::json[] into v_json_resp;
		return v_json_resp;
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_find_user_by_id(
	p_id character varying)
    RETURNS json[]
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare 
	v_json_resp json[];
begin
	select array(
        select jsonb_build_object(
			'idUser', a.idUser,
			'ci', a.ci,
			'passport', a.passport,
			'firstName', a.firstName,
			'lastName', a.lastName,
			'genre', a.genre,
			'age', a.age,
			'address', a.address,
			'createdDate', a.createdDate,
            'modifiedDate', a.modifiedDate
		)
		from users a 
		WHERE a.ci = p_id or a.passport = p_id
        ) ::json[] into v_json_resp;
		return v_json_resp;
end;
$BODY$;



CREATE OR REPLACE FUNCTION sp_delete_alliance(
	p_id integer)
    RETURNS character varying
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
begin
	delete from alliance
	where idAlliance = p_id;
	return 'Se ha borrado la alianza correctamente';
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_delete_exam(
	p_id integer)
    RETURNS character varying
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
begin
	delete from exam
	where idExam = p_id;
	return 'Se ha borrado el examen correctamente';
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_delete_payment_method(
	p_id integer)
    RETURNS character varying
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
begin
	delete from payment_method
	where idPayment_method = p_id;
	return 'Se ha borrado el método de pago correctamente';
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_delete_provider(
	p_id integer)
    RETURNS character varying
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
begin
	delete from provider
	where idProvider = p_id;
	return 'Se ha borrado el proveedor correctamente';
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_delete_reactive(
	p_id integer)
    RETURNS character varying
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
begin
	delete from reactive
	where idReactive = p_id;
	return 'Se ha borrado el reactivo correctamente';
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_delete_unit(
	p_id integer)
    RETURNS character varying
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
begin
	delete from unit
	where idUnit = p_id;
	return 'Se ha borrado la unidad correctamente';
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_delete_users(
	p_id integer)
    RETURNS character varying
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
begin
	delete from users
	where idUser = p_id;
	return 'Se ha borrado el usuario correctamente';
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_create_alliance(
	p_quantity integer,
    p_idReactive integer,
    p_idProvider integer)
    RETURNS varchar
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
	v_id                                    integer;
begin
	select idalliance into v_id FROM alliance 
	WHERE idprovider = p_idProvider
	AND idreactive = p_idReactive;
	if (v_id is NOT NULL) then
		return 'La alianza ya fue ingresado anteriormente.';
	else
		Insert into alliance(quantity, idReactive, idProvider) 
		VALUES (p_quantity, p_idReactive, p_idProvider);
		return 'Inserción exitosa';
	end if;
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_create_reactive(
	p_name character varying,
    p_quantity integer,
    p_idExam integer)
    RETURNS varchar
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
	v_id                                    integer;
begin
	select idreactive into v_id FROM reactive 
	WHERE name = p_name
	AND idexam = p_idExam;
	if (v_id is NOT NULL) then
		return 'El reactivo ya fue ingresado anteriormente.';
	else
		Insert into reactive(name, quantity, idExam) 
		VALUES (p_name, p_quantity, p_idExam);
		return 'Inserción exitosa';
	end if;
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_create_payment_method(
	p_name character varying,
    p_amount character varying,
	p_bank character varying,
    p_type character varying,
    p_idExam integer)
    RETURNS varchar
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
	v_id                                    integer;
begin
	select idpayment_method into v_id FROM payment_method 
	WHERE name = p_name
	AND idexam = p_idExam;
	if (v_id is NOT NULL) then
		return 'El método de pago ya fue ingresado anteriormente.';
	else
		Insert into payment_method(name, amount, bank, type, idExam) 
		VALUES (p_name, p_amount, p_bank, p_type, p_idExam);
		return 'Inserción exitosa';
	end if;
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_create_unit(
	p_name character varying,
    p_idExam integer)
    RETURNS varchar
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
	v_id                                    integer;
begin
	select idunit into v_id FROM unit 
	WHERE name = p_name
	AND idexam = p_idExam;
	if (v_id is NOT NULL) then
		return 'La unidad ya fue ingresado anteriormente.';
	else
		Insert into unit(name, idExam) 
		VALUES (p_name, p_idExam);
		return 'Inserción exitosa';
	end if;
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_create_exam(
	p_name character varying,
	p_cost_bs character varying,
	p_cost_usd character varying,
	p_status character varying,
    p_idUser integer)
    RETURNS varchar
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
	v_id                                    integer;
begin
		Insert into exam(name, cost_bs, cost_usd, status, iduser) 
		VALUES (p_name, p_cost_bs, p_cost_usd, p_status, p_idUser);
		return 'Inserción exitosa';
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_create_users(
	p_ci character varying,
	p_passport character varying,
	p_firstName character varying,
	p_lastName character varying,
	p_genre character varying,
	p_age integer,
	p_address character varying)
    RETURNS varchar
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
	v_id                                    integer;
begin
		Insert into users(ci, passport, firstName, lastName, genre, age, address) 
		VALUES (p_ci, p_passport​, p_firstName, p_lastName, p_genre, p_age, p_address);
		return 'Inserción exitosa';
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_create_provider(
	p_name character varying)
    RETURNS varchar
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
	v_id                                    integer;
begin
	select idprovider into v_id FROM provider 
	WHERE name = p_name;
	if (v_id is NOT NULL) then
		return 'La unidad ya fue ingresado anteriormente.';
	else
		Insert into provider(name) 
		VALUES (p_name);
		return 'Inserción exitosa';
	end if;
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_update_alliance(
	p_id integer,
	p_quantity integer,
	p_idReactive integer,
	p_idProvider integer)
    RETURNS json
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
	v_quantity                              integer;
	v_idReactive                             integer;
	v_idProvider                             integer;
	v_createdDate                       TIMESTAMP;
	v_modifiedDate                      TIMESTAMP;
	v_id                                    integer;
begin
	update alliance
	set quantity = p_quantity, idReactive = p_idReactive, idProvider = p_idProvider, modifiedDate = now()
	where idalliance = p_id;
	select u.quantity into v_quantity from alliance u where idalliance = p_id;
	select u.idReactive into v_idReactive from alliance u where idalliance = p_id;
	select u.idProvider into v_idProvider from alliance u where idalliance = p_id;
	select u.createdDate into v_createdDate from alliance u where idalliance = p_id;
	select u.modifiedDate into v_modifiedDate from alliance u where idalliance = p_id;
	return json_build_object(
		'idAlliance', p_id,
		'quantity', v_quantity,
		'idReactive', v_idReactive,
		'idProvider', v_idProvider,
		'createdDate', v_createdDate,
		'modifiedDate', v_modifiedDate
	);
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_update_reactive(
	p_id integer,
	p_name character varying,
	p_quantity integer,
	p_idExam integer)
    RETURNS json
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
	v_name                              character varying;
	v_quantity                             integer;
	v_idExam                             integer;
	v_createdDate                       TIMESTAMP;
	v_modifiedDate                      TIMESTAMP;
	v_id                                    integer;
begin
	update reactive
	set name = p_name, quantity = p_quantity, idExam = p_idExam, modifiedDate = now()
	where idreactive = p_id;
	select u.name into v_name from reactive u where idreactive = p_id;
	select u.quantity into v_quantity from reactive u where idreactive = p_id;
	select u.idExam into v_idExam from reactive u where idreactive = p_id;
	select u.createdDate into v_createdDate from reactive u where idreactive = p_id;
	select u.modifiedDate into v_modifiedDate from reactive u where idreactive = p_id;
	return json_build_object(
		'idReactive', p_id,
		'name', v_name,
		'quantity', v_quantity,
		'idExam', v_idExam,
		'createdDate', v_createdDate,
		'modifiedDate', v_modifiedDate
	);
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_update_payment_method(
	p_id integer,
	p_name character varying,
	p_amount character varying,
	p_bank character varying,
	p_type character varying,
	p_idExam integer)
    RETURNS json
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
	v_name                              character varying;
	v_amount                             character varying;
	v_bank                              character varying;
	v_type                             character varying;
	v_idExam                             integer;
	v_createdDate                       TIMESTAMP;
	v_modifiedDate                      TIMESTAMP;
	v_id                                    integer;
begin
	update payment_method
	set name = p_name, amount = p_amount, bank = p_bank, type = p_type, idExam = p_idExam, modifiedDate = now()
	where idpayment_method = p_id;
	select u.name into v_name from payment_method u where idpayment_method = p_id;
	select u.amount into v_amount from payment_method u where idpayment_method = p_id;
	select u.bank into v_bank from payment_method u where idpayment_method = p_id;
	select u.type into v_type from payment_method u where idpayment_method = p_id;
	select u.idExam into v_idExam from payment_method u where idpayment_method = p_id;
	select u.createdDate into v_createdDate from payment_method u where idpayment_method = p_id;
	select u.modifiedDate into v_modifiedDate from payment_method u where idpayment_method = p_id;
	return json_build_object(
		'idPayment_method', p_id,
		'name', v_name,
		'amount', v_amount,
		'bank', v_bank,
		'type', v_type,
		'idExam', v_idExam,
		'createdDate', v_createdDate,
		'modifiedDate', v_modifiedDate
	);
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_update_unit(
	p_id integer,
	p_name character varying,
	p_idExam integer)
    RETURNS json
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
	v_name                              character varying;
	v_idExam                             integer;
	v_createdDate                       TIMESTAMP;
	v_modifiedDate                      TIMESTAMP;
	v_id                                    integer;
begin
	update unit
	set name = p_name, idExam = p_idExam, modifiedDate = now()
	where idunit = p_id;
	select u.name into v_name from unit u where idunit = p_id;
	select u.idExam into v_idExam from unit u where idunit = p_id;
	select u.createdDate into v_createdDate from unit u where idunit = p_id;
	select u.modifiedDate into v_modifiedDate from unit u where idunit = p_id;
	return json_build_object(
		'idUnit', p_id,
		'name', v_name,
		'idExam', v_idExam,
		'createdDate', v_createdDate,
		'modifiedDate', v_modifiedDate
	);
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_update_exam(
	p_id integer,
	p_name character varying,
	p_cost_bs character varying,
	p_cost_usd character varying,
	p_status character varying,
	p_idUser integer)
    RETURNS json
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
	v_name                              character varying;
	v_cost_bs                              character varying;
	v_cost_usd                              character varying;
	v_status                              character varying;
	v_idUser                             integer;
	v_createdDate                       TIMESTAMP;
	v_modifiedDate                      TIMESTAMP;
	v_id                                    integer;
begin
	update exam
	set name = p_name, cost_bs = p_cost_bs, cost_usd = p_cost_usd, status = p_status, idUser = p_idUser, modifiedDate = now()
	where idexam = p_id;
	select u.name into v_name from exam u where idexam = p_id;
	select u.cost_bs into v_cost_bs from exam u where idexam = p_id;
	select u.cost_usd into v_cost_usd from exam u where idexam = p_id;
	select u.status into v_status from exam u where idexam = p_id;
	select u.idUser into v_idUser from exam u where idexam = p_id;
	select u.createdDate into v_createdDate from exam u where idexam = p_id;
	select u.modifiedDate into v_modifiedDate from exam u where idexam = p_id;
	return json_build_object(
		'idExam', p_id,
		'name', v_name,
		'cost_bs', v_cost_bs,
		'cost_usd', v_cost_usd,
		'status', v_status,
		'idUser', v_idUser,
		'createdDate', v_createdDate,
		'modifiedDate', v_modifiedDate
	);
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_update_users(
	p_id integer,
	p_ci character varying,
	p_passport character varying,
	p_firstName character varying,
	p_lastName character varying,
	p_genre character varying,
	p_age integer,
	p_address character varying)
    RETURNS json
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
	v_ci                              character varying;
	v_passport                              character varying;
	v_firstName                              character varying;
	v_lastName                              character varying;
	v_genre                              character varying;
	v_age                              integer;
	v_address                              character varying;
	v_createdDate                       TIMESTAMP;
	v_modifiedDate                      TIMESTAMP;
	v_id                                    integer;
begin
	update users
	set ci = p_ci, passport = p_passport, firstName = p_firstName, lastName = p_lastName, genre = p_genre, age = p_age, address = p_address, modifiedDate = now()
	where idusers = p_id;
	select u.ci into v_ci from users u where idusers = p_id;
	select u.passport into v_passport from users u where idusers = p_id;
	select u.firstName into v_firstName from users u where idusers = p_id;
	select u.lastName into v_lastName from users u where idusers = p_id;
	select u.genre into v_genre from users u where idusers = p_id;
	select u.age into v_age from users u where idusers = p_id;
	select u.address into v_address from users u where idusers = p_id;
	select u.createdDate into v_createdDate from users u where idusers = p_id;
	select u.modifiedDate into v_modifiedDate from users u where idusers = p_id;
	return json_build_object(
		'idUser', p_id,
		'ci', v_ci,
		'passport', v_passport,
		'firstName', v_firstName,
		'lastName', v_lastName,
		'genre', v_genre,
		'age', v_age,
		'address', v_address,
		'createdDate', v_createdDate,
		'modifiedDate', v_modifiedDate
	);
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_update_provider(
	p_id integer,
	p_name character varying)
    RETURNS json
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
	v_name                              character varying;
	v_createdDate                       TIMESTAMP;
	v_modifiedDate                      TIMESTAMP;
	v_id                                    integer;
begin
	update provider
	set name = p_name, modifiedDate = now()
	where idprovider = p_id;
	select u.name into v_name from provider u where idprovider = p_id;
	select u.createdDate into v_createdDate from provider u where idprovider = p_id;
	select u.modifiedDate into v_modifiedDate from provider u where idprovider = p_id;
	return json_build_object(
		'idProvider', p_id,
		'name', v_name,
		'createdDate', v_createdDate,
		'modifiedDate', v_modifiedDate
	);
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_find_user_by_name(
	p_name character varying)
    RETURNS json[]
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare 
	v_json_resp json[];
begin
	select array(
        select jsonb_build_object(
			'idUser', a.idUser,
			'ci', a.ci,
			'passport', a.passport,
			'firstName', a.firstName,
			'lastName', a.lastName,
			'genre', a.genre,
			'age', a.age,
			'address', a.address,
			'createdDate', a.createdDate,
            'modifiedDate', a.modifiedDate
		)
		from users a 
		WHERE a.firstName = p_name
        ) ::json[] into v_json_resp;
		return v_json_resp;
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_find_payment_method_by_name(
	p_name character varying
	)
    RETURNS json[]
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare 
	v_json_resp json[];
begin
	select array(
        select jsonb_build_object(
			'idPayment_method', a.idPayment_method,
			'name', a.name,
            'amount', a.amount,
			'bank', a.bank,
			'type', a.type,
			'idExam', a.idExam,
			'createdDate', a.createdDate,
            'modifiedDate', a.modifiedDate
		)
		from payment_method a
		where a.name = p_name
        ) ::json[] into v_json_resp;
		return v_json_resp;
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_find_provider_by_name(
	p_name character varying)
    RETURNS json[]
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare 
	v_json_resp json[];
begin
	select array(
        select jsonb_build_object(
			'idProvider', a.idProvider,
			'name', a.name,
			'createdDate', a.createdDate,
            'modifiedDate', a.modifiedDate
		)
		from provider a
		where a.name = p_name
        ) ::json[] into v_json_resp;
		return v_json_resp;
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_find_reactive_by_name(
	p_name character varying
	)
    RETURNS json[]
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare 
	v_json_resp json[];
begin
	select array(
        select jsonb_build_object(
			'idReactive', a.idReactive,
			'name', a.name,
			'quantity', a.quantity,
			'idExam', a.idExam,
			'createdDate', a.createdDate,
            'modifiedDate', a.modifiedDate
		)
		from reactive a
		where a.name = p_name
        ) ::json[] into v_json_resp;
		return v_json_resp;
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_find_unit_by_name(
	p_name character varying
	)
    RETURNS json[]
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare 
	v_json_resp json[];
begin
	select array(
        select jsonb_build_object(
			'idUnit', a.idUnit,
			'name', a.name,
			'idExam', a.idExam,
			'createdDate', a.createdDate,
            'modifiedDate', a.modifiedDate
		)
		from unit a
		where a.name = p_name
        ) ::json[] into v_json_resp;
		return v_json_resp;
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_find_exam_by_name(
	p_name character varying
	)
    RETURNS json[]
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare 
	v_json_resp json[];
begin
	select array(
        select jsonb_build_object(
			'idExam', a.idExam,
			'name', a.name,
            'cost_bs', a.cost_bs,
			'cost_usd', a.cost_usd,
			'status', a.status,
			'idUser', a.idUser,
			'createdDate', a.createdDate,
            'modifiedDate', a.modifiedDate
		)
		from exam a
		where a.name = p_name
        ) ::json[] into v_json_resp;
		return v_json_resp;
end;
$BODY$;
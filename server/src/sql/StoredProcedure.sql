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

CREATE OR REPLACE FUNCTION sp_find_all_profile(
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
			'idProfile', a.idProfile,
			'name', a.name,
            'cost_bs', a.cost_bs,
			'cost_usd', a.cost_usd,
			'createdDate', a.createdDate,
            'modifiedDate', a.modifiedDate
		)
		from profile a
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
			'idUser', a.idUser,
            'total_cost_bs', a.total_cost_bs,
			'total_cost_usd', a.total_cost_usd,
			'createdDate', a.createdDate,
            'modifiedDate', a.modifiedDate
		)
		from exam a
        ) ::json[] into v_json_resp;
		return v_json_resp;
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_find_all_order(
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
			'idOrder', a.idOrder,
			'idExam', a.idExam,
			'idProfile', a.idProfile,
			'status', a.status,
			'createdDate', a.createdDate,
            'modifiedDate', a.modifiedDate
		)
		from orders a
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
			'createdDate', a.createdDate,
            'modifiedDate', a.modifiedDate
		)
		from payment_method a
        ) ::json[] into v_json_resp;
		return v_json_resp;
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_find_all_payment(
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
			'idPayment', a.idPayment,
			'idPayment_method', a.idPayment_method,
			'idExam', a.idExam,
			'amount_bs', a.amount_bs,
            'amount_usd', a.amount_usd,
			'bank', a.bank,
			'phone', a.phone,
			'type', a.type,
			'createdDate', a.createdDate,
            'modifiedDate', a.modifiedDate
		)
		from payment_method a
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
			'idProfile', a.idProfile,
			'createdDate', a.createdDate,
            'modifiedDate', a.modifiedDate
		)
		from unit a
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
			'total', a.total,
			'createdDate', a.createdDate,
            'modifiedDate', a.modifiedDate
		)
		from reactive a
        ) ::json[] into v_json_resp;
		return v_json_resp;
end;
$BODY$;

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
			'cost_bs', a.cost_bs,
			'cost_usd', a.cost_usd,
			'pay_done', a.pay_done,
			'pay_amount', a.pay_amount,
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

CREATE OR REPLACE FUNCTION sp_delete_profile(
	p_id integer)
    RETURNS character varying
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
begin
	delete from profile
	where idProfile = p_id;
	return 'Se ha borrado el perfil correctamente';
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

CREATE OR REPLACE FUNCTION sp_delete_order(
	p_id integer)
    RETURNS character varying
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
begin
	delete from orders
	where idOrder = p_id;
	return 'Se ha borrado la orden correctamente';
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_delete_payment(
	p_id integer)
    RETURNS character varying
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
begin
	delete from payment
	where idPayment = p_id;
	return 'Se ha borrado el pago correctamente';
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
	p_cost_bs character varying,
	p_cost_usd character varying,
	p_pay_done boolean,
	p_pay_amount character varying,
	p_idreactive integer,
	p_idprovider integer)
    RETURNS json
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
	v_id                                    integer;
	v_total                                    integer;
	v_returning_id                                 integer;
begin
	select idalliance into v_id FROM alliance 
	WHERE idprovider = p_idProvider
	AND idreactive = p_idReactive;
	if (v_id is NOT NULL) then
		return 'La alianza ya fue ingresado anteriormente.';
	else
		select u.total into v_total from reactive u where idreactive = p_idReactive;
		update reactive
		set total = v_total + p_quantity, modifiedDate = now()
		where idreactive = p_idReactive;
		Insert into alliance(quantity, cost_bs, cost_usd, pay_done, pay_amount, idReactive, idProvider) 
		VALUES (p_quantity, p_cost_bs, p_cost_usd, p_pay_done, p_pay_amount, p_idReactive, p_idProvider)
		RETURNING idalliance INTO v_returning_id;
		return json_build_object('message', 'Inserción exitosa.', 
								 'id', v_returning_id);
	end if;
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_create_reactive(
	p_name character varying,
	p_total integer)
    RETURNS json
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
	v_id                                    integer;
	v_returning_id                                 integer;
begin
	select idreactive into v_id FROM reactive 
	WHERE name = p_name;
	if (v_id is NOT NULL) then
		return 'El reactivo ya fue ingresado anteriormente.';
	else
		Insert into reactive(name, total) 
		VALUES (p_name, p_total)
		RETURNING idreactive INTO v_returning_id;
		return json_build_object('message', 'Inserción exitosa.', 
								 'id', v_returning_id);
	end if;
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_create_payment(
	p_idPayment_method integer,
    p_idExam integer,
	p_amount_bs character varying,
	p_amount_usd character varying,
	p_bank character varying,
	p_phone character varying,
    p_type character varying)
    RETURNS json
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
	v_id                                    integer;
	v_returning_id                                 integer;
begin
		Insert into payment(idPayment_method, idExam, amount_bs, amount_usd, bank, phone, type) 
		VALUES (p_idPayment_method, p_idExam, p_amount_bs, p_amount_usd, p_bank, p_phone, p_type)
		RETURNING idPayment INTO v_returning_id;
		return json_build_object('message', 'Inserción exitosa.', 
								 'id', v_returning_id);
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_create_payment_method(
	p_name character varying)
    RETURNS json
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
	v_id                                    integer;
	v_returning_id                                 integer;
begin
	select idpayment_method into v_id FROM payment_method 
	WHERE name = p_name;
	if (v_id is NOT NULL) then
		return 'El método de pago ya fue ingresado anteriormente.';
	else
		Insert into payment_method(name) 
		VALUES (p_name)
		RETURNING idPayment_method INTO v_returning_id;
		return json_build_object('message', 'Inserción exitosa.', 
								 'id', v_returning_id);
	end if;
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_create_unit(
	p_name character varying,
	p_idProfile integer)
    RETURNS json
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
	v_id                                    integer;
	v_returning_id                                 integer;
begin
	select idunit into v_id FROM unit 
	WHERE name = p_name
	AND idProfile = p_idProfile;
	if (v_id is NOT NULL) then
		return 'La unidad ya fue ingresado anteriormente.';
	else
		Insert into unit(name, idProfile) 
		VALUES (p_name, idProfile)
		RETURNING idunit INTO v_returning_id;
		return json_build_object('message', 'Inserción exitosa.', 
								 'id', v_returning_id);
	end if;
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_create_users(
	p_ci character varying,
	p_passport character varying,
	p_firstname character varying,
	p_lastname character varying,
	p_genre character varying,
	p_age integer,
	p_address character varying)
    RETURNS json
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
	v_id                                    integer;
	v_returning_id                                 integer;
begin
		Insert into users(ci, passport, firstName, lastName, genre, age, address) 
		VALUES (p_ci, p_passport, p_firstName, p_lastName, p_genre, p_age, p_address)
		RETURNING iduser INTO v_returning_id;
		return json_build_object('message', 'Inserción exitosa.', 
								 'id', v_returning_id);
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_create_profile(
	p_name character varying,
	p_cost_bs character varying,
	p_cost_usd character varying)
    RETURNS json
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
	v_id                                    integer;
	v_returning_id                                 integer;
begin
		Insert into profile(name, cost_bs, cost_usd) 
		VALUES (p_name, p_cost_bs, p_cost_usd)
		RETURNING idProfile INTO v_returning_id;
		return json_build_object('message', 'Inserción exitosa.', 
								 'id', v_returning_id);
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_create_exam(
	p_iduser integer,
	p_total_cost_bs character varying,
	p_total_cost_usd character varying)
    RETURNS json
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
	v_id                                    integer;
	v_returning_id                                 integer;
begin
		Insert into exam(idUser, total_cost_bs, total_cost_usd) 
		VALUES (p_idUser, p_total_cost_bs, p_total_cost_usd)
		RETURNING idExam INTO v_returning_id;
		return json_build_object('message', 'Inserción exitosa.', 
								 'id', v_returning_id);
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_create_order(
	p_idexam integer,
	p_idprofile integer,
	p_status character varying)
    RETURNS json
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
	v_id                                    integer;
	v_returning_id                                 integer;
begin
		Insert into orders(idExam, idProfile, status) 
		VALUES (p_idexam, p_idprofile, p_status)
		RETURNING idOrder INTO v_returning_id;
		return json_build_object('message', 'Inserción exitosa.', 
								 'id', v_returning_id);
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_create_provider(
	p_name character varying)
    RETURNS json
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
	v_id                                    integer;
	v_returning_id                                 integer;
begin
	select idprovider into v_id FROM provider 
	WHERE name = p_name;
	if (v_id is NOT NULL) then
		return 'La unidad ya fue ingresado anteriormente.';
	else
		Insert into provider(name) 
		VALUES (p_name)
		RETURNING idprovider INTO v_returning_id;
		return json_build_object('message', 'Inserción exitosa.', 
								 'id', v_returning_id);
	end if;
end;
$BODY$;


CREATE OR REPLACE FUNCTION sp_update_alliance(
	p_id integer,
	p_quantity integer,
	p_cost_bs character varying, 
	p_cost_usd character varying, 
	p_pay_done boolean, 
	p_pay_amount character varying,
	p_idReactive integer,
	p_idProvider integer)
    RETURNS json
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
	v_quantity                              integer;
	v_cost_bs                            character varying;
	v_cost_usd                           character varying; 
	v_pay_done                           boolean;
	v_pay_amount                         character varying;
	v_idReactive                             integer;
	v_idProvider                             integer;
	v_createdDate                       TIMESTAMP;
	v_modifiedDate                      TIMESTAMP;
	v_id                                    integer;
	v_total                                    integer;
begin
	select u.total into v_total from reactive u where idreactive = p_idReactive;
	update reactive
	set total = v_total + p_quantity, modifiedDate = now()
	where idreactive = p_idReactive;
	update alliance
	set quantity = p_quantity, cost_bs = p_cost_bs, cost_usd = p_cost_usd, pay_done = p_pay_done, pay_amount = p_pay_amount, idReactive = p_idReactive, idProvider = p_idProvider, modifiedDate = now()
	where idalliance = p_id;
	select u.quantity into v_quantity from alliance u where idalliance = p_id;
	select u.cost_bs into v_cost_bs from alliance u where idalliance = p_id;
	select u.cost_usd into v_cost_usd from alliance u where idalliance = p_id;
	select u.pay_done into v_pay_done from alliance u where idalliance = p_id;
	select u.pay_amount into v_pay_amount from alliance u where idalliance = p_id;
	select u.idReactive into v_idReactive from alliance u where idalliance = p_id;
	select u.idProvider into v_idProvider from alliance u where idalliance = p_id;
	select u.createdDate into v_createdDate from alliance u where idalliance = p_id;
	select u.modifiedDate into v_modifiedDate from alliance u where idalliance = p_id;
	return json_build_object(
		'idAlliance', p_id,
		'quantity', v_quantity,
		'cost_bs', v_cost_bs,
		'cost_usd', v_cost_usd,
		'pay_done', v_pay_done,
		'pay_amount', v_pay_amount,
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
	p_total integer)
    RETURNS json
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
	v_name                              character varying;
	v_total                                    integer;
	v_createdDate                       TIMESTAMP;
	v_modifiedDate                      TIMESTAMP;
	v_id                                    integer;
begin
	update reactive
	set name = p_name, total = p_total, modifiedDate = now()
	where idreactive = p_id;
	select u.name into v_name from reactive u where idreactive = p_id;
	select u.total into v_total from reactive u where idreactive = p_id;
	select u.createdDate into v_createdDate from reactive u where idreactive = p_id;
	select u.modifiedDate into v_modifiedDate from reactive u where idreactive = p_id;
	return json_build_object(
		'idReactive', p_id,
		'name', v_name,
		'total', v_total,
		'createdDate', v_createdDate,
		'modifiedDate', v_modifiedDate
	);
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_update_payment(
	p_id integer,
	p_idPayment_method integer,
	p_idExam integer,
	p_amount_bs character varying,
	p_amount_usd character varying,
	p_bank character varying,
	p_phone character varying,
	p_type character varying)
    RETURNS json
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
	v_idPayment_method                             integer;
	v_idExam                             integer;
	v_amount_bs                              character varying;
	v_amount_usd                            character varying;
	v_bank                              character varying;
	v_phone                              character varying;
	v_type                             character varying;
	v_createdDate                       TIMESTAMP;
	v_modifiedDate                      TIMESTAMP;
	v_id                                    integer;
begin
	update payment
	set idPayment_method = p_idPayment_method, idExam = p_idExam, 
	amount_bs = p_amount_bs, amount_usd = p_amount_usd, 
	bank = p_bank, phone = p_phone, type = p_type, modifiedDate = now()
	where idpayment = p_id;
	select u.idPayment_method into v_idPayment_method from payment u where idpayment = p_id;
	select u.idExam into v_idExam from payment u where idpayment = p_id;
	select u.amount_bs into v_amount_bs from payment u where idpayment = p_id;
	select u.amount_usd into v_amount_usd from payment u where idpayment = p_id;
	select u.bank into v_bank from payment u where idpayment = p_id;
	select u.phone into v_phone from payment u where idpayment = p_id;
	select u.type into v_type from payment u where idpayment = p_id;
	select u.createdDate into v_createdDate from payment u where idpayment = p_id;
	select u.modifiedDate into v_modifiedDate from payment u where idpayment = p_id;
	return json_build_object(
		'idPayment', p_id,
		'idPayment_method', v_idPayment_method,
		'idExam', v_idExam,
		'amount_bs', v_amount_bs,
		'amount_usd', v_amount_usd,
		'bank', v_bank,
		'phone', v_phone,
		'type', v_type,
		'createdDate', v_createdDate,
		'modifiedDate', v_modifiedDate
	);
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_update_payment_method(
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
	update payment_method
	set name = p_name, modifiedDate = now()
	where idpayment_method = p_id;
	select u.name into v_name from payment_method u where idpayment_method = p_id;
	select u.createdDate into v_createdDate from payment_method u where idpayment_method = p_id;
	select u.modifiedDate into v_modifiedDate from payment_method u where idpayment_method = p_id;
	return json_build_object(
		'idPayment_method', p_id,
		'name', v_name,
		'createdDate', v_createdDate,
		'modifiedDate', v_modifiedDate
	);
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_update_unit(
	p_id integer,
	p_name character varying,
	p_idProfile integer)
    RETURNS json
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
	v_name                              character varying;
	v_idProfile                             integer;
	v_createdDate                       TIMESTAMP;
	v_modifiedDate                      TIMESTAMP;
	v_id                                    integer;
begin
	update unit
	set name = p_name, idProfile = p_idProfile, modifiedDate = now()
	where idunit = p_id;
	select u.name into v_name from unit u where idunit = p_id;
	select u.idProfile into v_idProfile from unit u where idunit = p_id;
	select u.createdDate into v_createdDate from unit u where idunit = p_id;
	select u.modifiedDate into v_modifiedDate from unit u where idunit = p_id;
	return json_build_object(
		'idUnit', p_id,
		'name', v_name,
		'idProfile', v_idProfile,
		'createdDate', v_createdDate,
		'modifiedDate', v_modifiedDate
	);
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_update_profile(
	p_id integer,
	p_name character varying,
	p_cost_bs character varying,
	p_cost_usd character varying)
    RETURNS json
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
	v_name                              character varying;
	v_cost_bs                              character varying;
	v_cost_usd                              character varying;
	v_createdDate                       TIMESTAMP;
	v_modifiedDate                      TIMESTAMP;
	v_id                                    integer;
begin
	update profile
	set name = p_name, cost_bs = p_cost_bs, cost_usd = p_cost_usd, modifiedDate = now()
	where idProfile = p_id;
	select u.name into v_name from profile u where idProfile = p_id;
	select u.cost_bs into v_cost_bs from profile u where idProfile = p_id;
	select u.cost_usd into v_cost_usd from profile u where idProfile = p_id;
	select u.createdDate into v_createdDate from profile u where idProfile = p_id;
	select u.modifiedDate into v_modifiedDate from profile u where idProfile = p_id;
	return json_build_object(
		'idProfile', p_id,
		'name', v_name,
		'cost_bs', v_cost_bs,
		'cost_usd', v_cost_usd,
		'createdDate', v_createdDate,
		'modifiedDate', v_modifiedDate
	);
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_update_exam(
	p_id integer,
	p_idUser integer,
	p_total_cost_bs character varying,
	p_total_cost_usd character varying)
    RETURNS json
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
	v_idUser                             integer;
	v_idProfile                             integer;
	v_total_cost_bs                              character varying;
	v_total_cost_usd                              character varying;
	v_createdDate                       TIMESTAMP;
	v_modifiedDate                      TIMESTAMP;
	v_id                                    integer;
begin
	update exam
	set idUser = p_idUser, total_cost_bs = p_total_cost_bs, total_cost_usd = p_total_cost_usd, modifiedDate = now()
	where idexam = p_id;
	select u.idUser into v_idUser from exam u where idexam = p_id;
	select u.total_cost_bs into v_total_cost_bs from exam u where idexam = p_id;
	select u.total_cost_usd into v_total_cost_usd from exam u where idexam = p_id;
	select u.createdDate into v_createdDate from exam u where idexam = p_id;
	select u.modifiedDate into v_modifiedDate from exam u where idexam = p_id;
	return json_build_object(
		'idExam', p_id,
		'idUser', v_idUser,
		'total_cost_bs', v_total_cost_bs,
		'total_cost_usd', v_total_cost_usd,
		'createdDate', v_createdDate,
		'modifiedDate', v_modifiedDate
	);
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_update_order(
	p_id integer,
	p_idexam integer,
	p_idprofile integer,
	p_status character varying)
    RETURNS json
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
	v_idExam                             integer;
	v_idProfile                             integer;
	v_status                            character varying;
	v_createdDate                       TIMESTAMP;
	v_modifiedDate                      TIMESTAMP;
	v_id                                    integer;
begin
	update orders
	set idExam = p_idexam, idProfile = p_idProfile, status = p_status, modifiedDate = now()
	where idorder = p_id;
	select u.idExam into v_idExam from orders u where idorder = p_id;
	select u.idProfile into v_idProfile from orders u where idorder = p_id;
	select u.status into v_status from orders u where idorder = p_id;
	select u.createdDate into v_createdDate from orders u where idorder = p_id;
	select u.modifiedDate into v_modifiedDate from orders u where idorder = p_id;
	return json_build_object(
		'idOrder', p_id,
		'idExam', v_idExam,
		'idProfile', v_idProfile,
		'status', v_status,
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
			'total', a.total,
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
			'idProfile', a.idProfile,
			'createdDate', a.createdDate,
            'modifiedDate', a.modifiedDate
		)
		from unit a
		where a.name = p_name
        ) ::json[] into v_json_resp;
		return v_json_resp;
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_find_profile_by_name(
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
			'idProfile', a.idProfile,
			'name', a.name,
            'cost_bs', a.cost_bs,
			'cost_usd', a.cost_usd,
			'createdDate', a.createdDate,
            'modifiedDate', a.modifiedDate
		)
		from profile a
		where a.name = p_name
        ) ::json[] into v_json_resp;
		return v_json_resp;
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_find_all_reactive_by_providers(
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
			'total', a.total,
			'createdDate', l.createdDate,
            'modifiedDate', l.modifiedDate,
			'providerName', d.name,
			'providerQuantity', l.quantity,
			'cost_bs', l.cost_bs,
			'cost_usd', l.cost_usd,
			'pay_done', l.pay_done,
			'pay_amount', l.pay_amount,
			'idProvider', d.idProvider,
			'idAlliance', l.idAlliance
		)
		from reactive a, provider d, alliance l
		where l.idReactive = a.idReactive
		and l.idProvider = d.idProvider
        ) ::json[] into v_json_resp;
		return v_json_resp;
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_find_all_bills(  
    p_all boolean,  
    p_startDate character varying,  
    p_endDate character varying   
)  
RETURNS json[]  
LANGUAGE 'plpgsql'  
COST 100  
VOLATILE PARALLEL UNSAFE  
AS $BODY$  
DECLARE   
    v_json_resp json[];  
BEGIN  
    IF p_all THEN  
        SELECT array(   
            SELECT jsonb_build_object(  
                'idAlliance', a.idalliance,  
                'quantity', a.quantity,  
                'cost_bs', a.cost_bs,  
                'cost_usd', a.cost_usd,  
                'pay_done', a.pay_done,  
                'pay_amount', a.pay_amount,  
                'createdDate', a.createddate,  
                'idProvider', p.idprovider,  
                'providerName', p.name,  
                'idReactive', r.idreactive,  
                'reactiveName', r.name  
            )  
            FROM alliance a  
            JOIN provider p ON a.idprovider = p.idprovider  
            JOIN reactive r ON a.idreactive = r.idreactive  
        )::json[] INTO v_json_resp;  
    ELSE  
        SELECT array(   
            SELECT jsonb_build_object(  
                'idAlliance', a.idalliance,  
                'quantity', a.quantity,  
                'cost_bs', a.cost_bs,  
                'cost_usd', a.cost_usd,  
                'pay_done', a.pay_done,  
                'pay_amount', a.pay_amount,  
                'createdDate', a.createddate,  
                'idProvider', p.idprovider,  
                'providerName', p.name,  
                'idReactive', r.idreactive,  
                'reactiveName', r.name  
            )  
            FROM alliance a  
            JOIN provider p ON a.idprovider = p.idprovider  
            JOIN reactive r ON a.idreactive = r.idreactive  
            WHERE   
                (p_startDate IS NULL OR p_startDate = '' OR a.createddate >= p_startDate::timestamp with time zone) AND  
                (p_endDate IS NULL OR p_endDate = '' OR a.createddate <= p_endDate::timestamp with time zone)  
        )::json[] INTO v_json_resp;  
    END IF;  

    IF v_json_resp IS NULL THEN  
        RETURN '{}'::json[];  
    END IF;  

    RETURN v_json_resp;  
END;  
$BODY$;


CREATE OR REPLACE FUNCTION sp_find_all_income(  
    p_all boolean,  
    p_startdate character varying,  
    p_enddate character varying)  
RETURNS json[]  
LANGUAGE 'plpgsql'  
COST 100  
VOLATILE PARALLEL UNSAFE  
AS $BODY$  

DECLARE   
    v_json_resp json[];  
BEGIN  
    IF p_all THEN   
        SELECT array(  
            SELECT jsonb_build_object(  
                'idUser', s.idUser,  
                'ci', s.ci,  
                'passport', s.passport,  
                'firstName', s.firstName,  
                'lastName', s.lastName,  
                'genre', s.genre,  
                'age', s.age,  
                'exams', jsonb_agg(  
                    jsonb_build_object(  
                        'idProfile', o.idProfile,  
                        'examName', p.name,  
                        'cost_bs', p.cost_bs,  
                        'cost_usd', p.cost_usd,  
                        'createdDate', e.createdDate,  
                        'payments', (  
                            SELECT jsonb_agg(  
                                jsonb_build_object(  
                                    'idPaymentMethod', m.idPayment_method,  
                                    'PaymentMethodName', m.name,  
                                    'amount_bs', pa.amount_bs,  
                                    'amount_usd', pa.amount_usd,  
                                    'bank', pa.bank,  
                                    'phone', pa.phone,  
                                    'type', pa.type  
                                )  
                            )  
                            FROM payment pa  
                            LEFT JOIN payment_method m ON pa.idPayment_method = m.idPayment_method  
                            WHERE pa.idExam = e.idExam   
                        )  
                    )  
                ),  
                'totalCost_bs', SUM(CAST(replace(p.cost_bs, ',', '.') AS numeric)),  
                'totalCost_usd', SUM(CAST(replace(p.cost_usd, ',', '.') AS numeric)),  
                'payments', (  
                    SELECT jsonb_agg(  
                        jsonb_build_object(  
                            'idPaymentMethod', m.idPayment_method,  
                            'PaymentMethodName', m.name,  
                            'amount_bs', pa.amount_bs,  
                            'amount_usd', pa.amount_usd,  
                            'bank', pa.bank,  
                            'phone', pa.phone,  
                            'type', pa.type  
                        )  
                    )  
                    FROM payment pa  
                    LEFT JOIN payment_method m ON pa.idPayment_method = m.idPayment_method  
                    JOIN exam ex ON pa.idExam = ex.idExam   
                    WHERE ex.idUser = s.idUser  
                )  
            )  
            FROM orders o  
            JOIN exam e ON o.idExam = e.idExam  
            JOIN profile p ON o.idProfile = p.idProfile  
            JOIN users s ON e.idUser = s.idUser  
            GROUP BY s.idUser, s.ci, s.passport, s.firstName, s.lastName, s.genre, s.age  
        ) ::json[] INTO v_json_resp;  
      
    ELSE    
        SELECT array(  
            SELECT jsonb_build_object(  
                'idUser', s.idUser,  
                'ci', s.ci,  
                'passport', s.passport,  
                'firstName', s.firstName,  
                'lastName', s.lastName,  
                'genre', s.genre,  
                'age', s.age,  
                'exams', jsonb_agg(  
                    jsonb_build_object(  
                        'idProfile', o.idProfile,  
                        'examName', p.name,  
                        'cost_bs', p.cost_bs,  
                        'cost_usd', p.cost_usd,  
                        'createdDate', e.createdDate,  
                        'payments', (  
                            SELECT jsonb_agg(  
                                jsonb_build_object(  
                                    'idPaymentMethod', m.idPayment_method,  
                                    'PaymentMethodName', m.name,  
                                    'amount_bs', pa.amount_bs,  
                                    'amount_usd', pa.amount_usd,  
                                    'bank', pa.bank,  
                                    'phone', pa.phone,  
                                    'type', pa.type  
                                )  
                            )  
                            FROM payment pa  
                            LEFT JOIN payment_method m ON pa.idPayment_method = m.idPayment_method  
                            WHERE pa.idExam = e.idExam   
                        )  
                    )  
                ),  
                'totalCost_bs', SUM(CAST(replace(p.cost_bs, ',', '.') AS numeric)),  
                'totalCost_usd', SUM(CAST(replace(p.cost_usd, ',', '.') AS numeric))  
            )  
            FROM orders o  
            JOIN exam e ON o.idExam = e.idExam  
            JOIN profile p ON o.idProfile = p.idProfile  
            JOIN users s ON e.idUser = s.idUser  
            WHERE (p_startDate = '' OR e.createdDate >= p_startDate::timestamp with time zone)  
            AND (p_endDate = '' OR e.createdDate <= p_endDate::timestamp with time zone)  
            GROUP BY s.idUser, s.ci, s.passport, s.firstName, s.lastName, s.genre, s.age  
        ) ::json[] INTO v_json_resp;  
    END IF;  

    RETURN v_json_resp;  
END;  
$BODY$;  

CREATE OR REPLACE FUNCTION sp_find_all_profile_unrepeated(
	)
    RETURNS json[]
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare 
	v_json_resp json[];
begin
	SELECT array(  
        SELECT jsonb_build_object(  
            'idProfile', MIN(a.idProfile),
            'name', a.name,  
            'cost_bs', MIN(a.cost_bs),  
            'cost_usd', MIN(a.cost_usd),   
            'createdDate', MIN(a.createdDate),  
            'modifiedDate', MIN(a.modifiedDate)  
        )  
        FROM profile a  
        GROUP BY a.name
    ) INTO v_json_resp; 
		return v_json_resp;
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_find_all_order_day(
	)
    RETURNS json[]
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
  
DECLARE   
    v_json_resp json[];  
BEGIN  
    SELECT array(  
        SELECT jsonb_build_object(  
            'idOrder', o.idOrder,  
            'idExam', o.idexam, 
			'idProfile', p.idProfile, 
            'status', o.status,  
			'idUser', u.idUser,
			'address', u.address,
            'ci', u.ci,  
            'firstName', u.firstname,  
            'lastName', u.lastname,  
            'genre', u.genre,  
            'age', u.age,  
            'profileName', p.name,
			'total_cost_bs', e.total_cost_bs,
			'total_cost_usd', e.total_cost_usd,
            'createdDate', o.createddate,  
            'modifiedDate', o.modifieddate  
        )  
        FROM orders o  
        JOIN profile p ON o.idprofile = p.idprofile  
        JOIN exam e ON o.idexam = e.idexam  
        JOIN users u ON e.iduser = u.iduser  
        WHERE o.status IN ('Pendiente por pasar', 'Pendiente de enviar', 'Pendiente de imprimir')
    )::json[] INTO v_json_resp;  

    RETURN v_json_resp;  
END;  
$BODY$;

CREATE OR REPLACE FUNCTION sp_find_all_hist_order_day(
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
			'idOrder', o.idOrder,
			'idExam', o.idexam,
			'status', o.status,
			'ci', u.ci,
			'firstName', u.firstname,
			'lastName', u.lastname,
			'genre', u.genre,
			'age', u.age,
			'profileName', p.name,
			'createdDate', o.createddate,
            'modifiedDate', o.modifieddate
		)
		from orders o, profile p, exam e, users u
		where o.idprofile = p.idprofile
		and o.idexam = e.idexam
		and e.iduser = u.iduser
        ) ::json[] into v_json_resp;
		return v_json_resp;
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_find_order_by_examId(
	p_id integer
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
			'idOrder', o.idOrder,
			'idExam', o.idexam,
			'idProfile', o.idprofile,
			'name', p.name,
			'cost_bs', p.cost_bs,
            'cost_usd', p.cost_usd
		)
		from orders o, profile p
		where o.idExam = p_id
		and o.idprofile = p.idprofile
        ) ::json[] into v_json_resp;
		return v_json_resp;
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_find_payment_by_examid(
	p_id integer)
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
			'idPayment', p.idpayment,
			'idExam', e.idexam,
			'name', pm.name,
			'amount_bs', p.amount_bs,
			'amount_usd', p.amount_usd,
            'bank', p.bank,
			'phone', p.phone,
			'type', p.type,
			'total_cost_bs', e.total_cost_bs,
			'total_cost_usd', e.total_cost_usd
		)
		from payment p, exam e, payment_method pm
		where p.idexam = e.idexam
		and p.idpayment_method = pm.idpayment_method
		and p.idexam = p_id
        ) ::json[] into v_json_resp;
		return v_json_resp;
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_find_order_by_examidandprofileid(
	p_idExam integer,
	p_idProfile integer)
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
			'idOrder', o.idOrder,
			'idExam', o.idexam,
			'idProfile', o.idprofile,
			'status', o.status,
			'name', p.name,
			'cost_bs', p.cost_bs,
            'cost_usd', p.cost_usd
		)
		from orders o, profile p
		where o.idExam = p_idExam
		and o.idprofile = p.idprofile
		and o.idExam = p_idExam
		and o.idProfile = p_idProfile
        ) ::json[] into v_json_resp;
		return v_json_resp;
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_delete_order_by_examid_and_profileid(
	p_idExam integer,
	p_idProfile integer)
    RETURNS character varying
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
begin
	delete from orders
	where idExam = p_idExam
	and idProfile = p_idProfile;
	return 'Se ha borrado la orden correctamente';
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_find_payment_by_examid_and_paymentmethodid(
	p_idExam integer,
	p_idPaymentMethod integer)
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
			'idPayment', p.idpayment,
			'idExam', e.idexam,
			'name', pm.name,
			'amount_bs', p.amount_bs,
			'amount_usd', p.amount_usd,
            'bank', p.bank,
			'phone', p.phone,
			'type', p.type,
			'total_cost_bs', e.total_cost_bs,
			'total_cost_usd', e.total_cost_usd
		)
		from payment p, exam e, payment_method pm
		where p.idexam = e.idexam
		and p.idpayment_method = pm.idpayment_method
		and p.idexam = p_idExam
		and p.idPayment_method = p_idPaymentMethod
        ) ::json[] into v_json_resp;
		return v_json_resp;
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_create_tabla_resultados(
	p_nombre_perfil character varying)
    RETURNS json
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
  
DECLARE  
    v_nombre_tabla TEXT;  
    v_sql TEXT;  
BEGIN  
    v_nombre_tabla := 'resultados_' || lower(replace(p_nombre_perfil, ' ', '_'));  
    
    IF EXISTS (SELECT 1 FROM information_schema.tables   
               WHERE table_name = v_nombre_tabla) THEN  
        RETURN json_build_object('message', 'La tabla ya existe.', 'table_name', v_nombre_tabla);  
    ELSE   
        v_sql := format($sql$  
            CREATE TABLE %I (  
                idResultado SERIAL PRIMARY KEY,  
				idOrder INTEGER NOT NULL REFERENCES orders(idOrder) ON DELETE CASCADE,  
				idProfile INTEGER NOT NULL REFERENCES profile(idProfile) ON DELETE CASCADE,  
				idCampo INTEGER NOT NULL REFERENCES campo(idCampo) ON DELETE CASCADE,  
				resultado character varying(255) NOT NULL, 
                createdDate timestamp with time zone NOT NULL DEFAULT now(),  
                modifiedDate timestamp with time zone NOT NULL DEFAULT now()  
            );  
        $sql$, v_nombre_tabla);  
        
        EXECUTE v_sql;  

        RETURN json_build_object('message', 'Tabla creada exitosamente.', 'table_name', v_nombre_tabla);  
    END IF;  
END;  
$BODY$;

CREATE OR REPLACE FUNCTION sp_agregar_campos_if_not_exists(  
    p_campos jsonb[]  
) RETURNS json  
LANGUAGE 'plpgsql'  
COST 100  
VOLATILE PARALLEL UNSAFE  
AS $BODY$  

DECLARE  
    v_campos jsonb;  
    v_nombre TEXT;  
    v_unidad VARCHAR;  
    v_inserciones integer := 0;  
BEGIN  
    FOREACH v_campos IN ARRAY p_campos LOOP   

        v_nombre := v_campos->>'nombre';  
        v_unidad := v_campos->>'unidad';  

        IF NOT EXISTS (SELECT 1 FROM campo WHERE nombre = v_nombre) THEN   
            INSERT INTO campo(nombre, unidad) VALUES (v_nombre, v_unidad);  
            v_inserciones := v_inserciones + 1;  
        END IF;  
    END LOOP;  

    RETURN json_build_object(  
        'message', 'Operación completada.',  
        'nuevos_agregados', v_inserciones  
    );  
END;  
$BODY$;  


CREATE OR REPLACE FUNCTION sp_find_all_inputs(
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
			'idCampo', a.idCampo,
			'nombre', a.nombre,
            'unidad', a.unidad,
			'createdDate', a.createdDate,
            'modifiedDate', a.modifiedDate
		)
		from campo a
        ) ::json[] into v_json_resp;
		return v_json_resp;
end;
$BODY$;


CREATE OR REPLACE FUNCTION sp_find_all_inputs_unit()  
    RETURNS json[]  
    LANGUAGE 'plpgsql'  
    COST 100  
    VOLATILE PARALLEL UNSAFE  
AS $BODY$  
DECLARE   
    v_json_resp json[];  
BEGIN  
    SELECT array(  
        SELECT jsonb_build_object(  
            'idCampo', a.idCampo,  
            'unidad', a.unidad,  
            'createdDate', a.createdDate,  
            'modifiedDate', a.modifiedDate  
        )  
        FROM (  
            SELECT DISTINCT ON (unidad)   
                idCampo, unidad, createdDate, modifiedDate   
            FROM campo    
        ) AS a  
    )::json[] INTO v_json_resp;  

    RETURN v_json_resp;  
END;  
$BODY$;

sp_find_all_inputs_by_profileCREATE OR REPLACE FUNCTION sp_find_all_inputs_by_profile(p_idProfile INTEGER)  
RETURNS json[]   
LANGUAGE 'plpgsql'  
COST 100  
VOLATILE PARALLEL UNSAFE  
AS $BODY$  
DECLARE  
    v_json_resp json[];  
    v_nombre_tabla TEXT;  
    v_query TEXT;  
BEGIN   
    SELECT name INTO v_nombre_tabla  
    FROM profile  
    WHERE idProfile = p_idProfile;  
 
    IF v_nombre_tabla IS NULL THEN  
        RAISE EXCEPTION 'Perfil no encontrado';  
    END IF;  

    v_nombre_tabla := format('resultados_%s', lower(replace(v_nombre_tabla, ' ', '_')));  

    IF NOT EXISTS (  
        SELECT 1   
        FROM information_schema.tables   
        WHERE table_name = v_nombre_tabla  
    ) THEN  
        RAISE EXCEPTION 'La tabla % no existe', v_nombre_tabla;  
    END IF;  

    EXECUTE format('SELECT array_agg(jsonb_build_object(  
                        ''idCampo'', c.idCampo,  
                        ''nombre'', c.nombre,  
                        ''unidad'', c.unidad,    
                        ''createdDate'', r.createdDate,  
                        ''modifiedDate'', r.modifiedDate  
                     ))  
                     FROM %I r  
                     JOIN campo c ON r.idCampo = c.idCampo  
                     WHERE r.idProfile = %L', v_nombre_tabla, p_idProfile) INTO v_json_resp;  

    RETURN v_json_resp;  
END;  
$BODY$;
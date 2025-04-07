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
			'phone', a.phone,
			'email', a.email,
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

CREATE OR REPLACE FUNCTION sp_find_all_restriction(
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
			'idRestriction', a.idRestriction,
			'idProfile', a.idProfile,
            'restriction', a.restriction,
			'createdDate', a.createdDate,
            'modifiedDate', a.modifiedDate
		)
		from restriction a
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

CREATE OR REPLACE FUNCTION sp_find_all_perfil_division(
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
			'idDivision', a.idDivision,
			'idProfile', a.idProfile,
			'nombre', a.nombre,
			'orden', a.orden,
			'createdDate', a.createdDate,
            'modifiedDate', a.modifiedDate
		)
		from perfil_division a
        ) ::json[] into v_json_resp;
		return v_json_resp;
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_find_all_division_campo(
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
			'idDivisionCampo', a.idDivisionCampo,
			'idDivision', a.idDivision,
			'idCampo', a.idCampo,
			'createdDate', a.createdDate,
            'modifiedDate', a.modifiedDate
		)
		from division_campo a
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
			'phone', a.phone,
			'email', a.email,
			'createdDate', a.createdDate,
            'modifiedDate', a.modifiedDate
		)
		from users a 
		WHERE a.ci = p_id or a.passport = p_id
        ) ::json[] into v_json_resp;
		return v_json_resp;
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_find_restriction_by_profile(
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
			'idRestriction', a.idRestriction,
			'idProfile', a.idProfile,
			'restriction', a.restriction,
			'createdDate', a.createdDate,
            'modifiedDate', a.modifiedDate
		)
		from restriction a 
		WHERE a.idProfile = p_id
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

CREATE OR REPLACE FUNCTION sp_delete_restriction(
	p_id integer)
    RETURNS character varying
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
begin
	delete from restriction
	where idRestriction = p_id;
	return 'Se ha borrado la restricción correctamente';
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

CREATE OR REPLACE FUNCTION sp_delete_input(
	p_id integer)
    RETURNS character varying
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
begin
	delete from campo
	where idCampo = p_id;
	return 'Se ha borrado el campo correctamente';
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_delete_input_profile(
	p_id integer)
    RETURNS character varying
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
begin
	delete from campo_perfil
	where idCampo_perfil = p_id;
	return 'Se ha borrado el campo correctamente';
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_perfil_division(
	p_id integer)
    RETURNS character varying
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
begin
	delete from perfil_division
	where idDivision = p_id;
	return 'Se ha borrado la división correctamente';
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_division_campo(
	p_id integer)
    RETURNS character varying
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
begin
	delete from division_campo
	where idDivisionCampo = p_id;
	return 'Se ha borrado el campo correctamente';
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
	p_address character varying,
	p_phone character varying,
	p_email character varying)
    RETURNS json
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
	v_id                                    integer;
	v_returning_id                                 integer;
begin
		Insert into users(ci, passport, firstName, lastName, genre, age, address, phone, email) 
		VALUES (p_ci, p_passport, p_firstName, p_lastName, p_genre, p_age, p_address, p_phone, p_email)
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
	p_address character varying,
	p_phone character varying,
	p_email character varying)
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
	v_phone                              character varying;
	v_email                              character varying;
	v_createdDate                       TIMESTAMP;
	v_modifiedDate                      TIMESTAMP;
	v_id                                    integer;
begin
	update users
	set ci = p_ci, passport = p_passport, firstName = p_firstName, lastName = p_lastName, genre = p_genre, age = p_age, address = p_address, phone = p_phone, email = p_email, modifiedDate = now()
	where idusers = p_id;
	select u.ci into v_ci from users u where idusers = p_id;
	select u.passport into v_passport from users u where idusers = p_id;
	select u.firstName into v_firstName from users u where idusers = p_id;
	select u.lastName into v_lastName from users u where idusers = p_id;
	select u.genre into v_genre from users u where idusers = p_id;
	select u.age into v_age from users u where idusers = p_id;
	select u.address into v_address from users u where idusers = p_id;
	select u.phone into v_phone from users u where idusers = p_id;
	select u.email into v_email from users u where idusers = p_id;
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
		'phone', v_phone,
		'email', v_email,
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

CREATE OR REPLACE FUNCTION sp_update_restriction(
	p_id integer,
    p_idProfile integer,
	p_restriction character varying)
    RETURNS json
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
	v_restriction                              character varying;
	v_createdDate                       TIMESTAMP;
	v_modifiedDate                      TIMESTAMP;
    v_idProfile                                    integer;
	v_id                                    integer;
begin
	update restriction
	set restriction = p_restriction, idProfile = p_idProfile, modifiedDate = now()
	where idRestriction = p_id;
	select u.restriction into v_restriction from restriction u where idRestriction = p_id;
    select u.idProfile into v_idProfile from restriction u where idRestriction = p_id;
	select u.createdDate into v_createdDate from restriction u where idRestriction = p_id;
	select u.modifiedDate into v_modifiedDate from restriction u where idRestriction = p_id;
	return json_build_object(
		'idRestriction', p_id,
        'idProfile', v_idProfile,
		'restriction', v_restriction,
		'createdDate', v_createdDate,
		'modifiedDate', v_modifiedDate
	);
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_update_inputs(
	p_id integer,
	p_nombre character varying,
	p_unidad character varying,
	p_valor_referencial character varying,
	p_calculado character varying)
    RETURNS json
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
	v_nombre                              character varying;
	v_unidad                                    character varying;
	v_valor_referencial                                    character varying;
	v_calculado                                    character varying;
	v_createdDate                       TIMESTAMP;
	v_modifiedDate                      TIMESTAMP;
	v_id                                    integer;
begin
	update campo
	set nombre = p_nombre, unidad = p_unidad, valor_referencial = p_valor_referencial, calculado = p_calculado, modifiedDate = now()
	where idCampo = p_id;
	select u.nombre into v_nombre from campo u where idCampo = p_id;
	select u.unidad into v_unidad from campo u where idCampo = p_id;
	select u.valor_referencial into v_valor_referencial from campo u where idCampo = p_id;
	select u.calculado into v_calculado from campo u where idCampo = p_id;
	select u.createdDate into v_createdDate from campo u where idCampo = p_id;
	select u.modifiedDate into v_modifiedDate from campo u where idCampo = p_id;
	return json_build_object(
		'idCampo', p_id,
		'name', v_nombre,
		'unit', v_unidad,
		'valor_referencial', v_valor_referencial,
		'calculado', v_calculado, 
		'createdDate', v_createdDate,
		'modifiedDate', v_modifiedDate
	);
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_update_input_profile(
	p_id integer,
	p_idCampo integer,
	p_idProfile integer)
    RETURNS json
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
	v_idCampo                              integer;
	v_idProfile                                   integer;
	v_createdDate                       TIMESTAMP;
	v_modifiedDate                      TIMESTAMP;
	v_id                                    integer;
begin
	update campo_perfil
	set idCampo = p_idCampo, idProfile = p_idProfile, modifiedDate = now()
	where idCampo_perfil = p_id;
	select u.idCampo into v_idCampo from campo_perfil u where idCampo_perfil = p_id;
	select u.idProfile into v_idProfile from campo_perfil u where idCampo_perfil = p_id;
	select u.createdDate into v_createdDate from campo_perfil u where idCampo_perfil = p_id;
	select u.modifiedDate into v_modifiedDate from campo_perfil u where idCampo_perfil = p_id;
	return json_build_object(
		'idCampo_perfil', p_id,
		'idCampo', v_idCampo,
		'idProfile', v_idProfile,
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
			'phone', a.phone,
			'email', a.email,
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

CREATE OR REPLACE FUNCTION public.sp_find_all_order_day(
	p_today boolean,
	p_date text)
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
            'idUser', u.idUser,  
            'address', u.address,  
            'ci', u.ci,  
            'firstName', u.firstname,  
            'lastName', u.lastname,  
            'genre', u.genre,  
            'age', u.age,  
			'phone', u.phone,
			'email', u.email,
            'orders', jsonb_agg(  
                jsonb_build_object(  
                    'idOrder', o.idOrder,  
                    'idExam', o.idexam,   
                    'status', o.status,  
                    'total_cost_bs', e.total_cost_bs,  
                    'total_cost_usd', e.total_cost_usd,  
                    'createdDate', o.createddate,  
                    'modifiedDate', o.modifieddate,  
                    'profiles', (  
                        SELECT jsonb_agg(  
                            jsonb_build_object(  
                                'idProfile', p.idProfile,  
                                'profileName', p.name  
                            )  
                        )  
                        FROM profile p  
                        WHERE p.idProfile = o.idProfile   
                    )  
                )  
            )  
        )  
        FROM users u  
        JOIN exam e ON u.idUser = e.idUser  
        JOIN orders o ON o.idExam = e.idExam  
        WHERE o.status IN ('Pendiente por pasar', 'Pendiente de enviar', 'Pendiente de imprimir')  
        AND (  
            (p_today IS TRUE AND o.createdDate::date = CURRENT_DATE) OR  
            (p_today IS FALSE AND o.createdDate::date = to_date(p_date, 'DD-MM-YYYY'))  
        )  
        GROUP BY u.idUser  
    )::json[] INTO v_json_resp;  

    RETURN v_json_resp;  
END;  
$BODY$;

CREATE OR REPLACE FUNCTION sp_find_all_hist_order_day()  
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
            'idUser', u.idUser,  
            'address', u.address,  
            'ci', u.ci,  
            'firstName', u.firstname,  
            'lastName', u.lastname,  
            'genre', u.genre,  
            'age', u.age,  
            'phone', u.phone,  
            'email', u.email,  
            'createdDate', MIN(o.createdDate), 
            'modifiedDate', MAX(o.modifiedDate), 
            'orders', jsonb_agg(  
                jsonb_build_object(  
                    'idOrder', o.idOrder,  
                    'idExam', o.idexam,   
                    'status', o.status,  
                    'total_cost_bs', e.total_cost_bs,  
                    'total_cost_usd', e.total_cost_usd,  
                    'createdDate', o.createdDate,  
                    'modifiedDate', o.modifiedDate,  
                    'profiles', (  
                        SELECT jsonb_agg(  
                            jsonb_build_object(  
                                'idProfile', p.idProfile,  
                                'profileName', p.name  
                            )  
                        )  
                        FROM profile p  
                        WHERE p.idProfile = o.idProfile   
                    )  
                )  
            )  
        )  
        FROM users u  
        JOIN exam e ON u.idUser = e.idUser  
        JOIN orders o ON o.idExam = e.idExam  
        GROUP BY u.idUser  
    )::json[] INTO v_json_resp;  
    
    RETURN v_json_resp;  
END;  
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
				idOrder integer NOT NULL REFERENCES orders(idOrder) ON DELETE CASCADE,  
				idCampo_perfil integer NOT NULL REFERENCES campo_perfil(idCampo_perfil) ON DELETE CASCADE,  
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

CREATE OR REPLACE FUNCTION sp_create_restriction(  
    idProfile INTEGER,  
    restricciones VARCHAR[]  
)   
RETURNS INTEGER[] AS $$  
DECLARE  
    ids INTEGER[] := '{}';  
    r VARCHAR;   
    newIdRestriction INTEGER;  
BEGIN  
    FOREACH r IN ARRAY restricciones  
    LOOP  
        INSERT INTO restriction (idProfile, restriction)  
        VALUES (idProfile, r)  
        RETURNING idRestriction INTO newIdRestriction;  
      
        ids := array_append(ids, newIdRestriction);  
    END LOOP;  
    
    RETURN ids;  
END;  
$$ LANGUAGE plpgsql;  

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
	v_valor_referencial VARCHAR;  
	v_calculado VARCHAR; 
    v_inserciones integer := 0;  
    v_unidad_existente VARCHAR;  
BEGIN  
    FOREACH v_campos IN ARRAY p_campos LOOP   

        v_nombre := v_campos->>'nombre';  
        v_unidad := v_campos->>'unidad';
		v_valor_referencial := v_campos->>'valor_referencial';  
		v_calculado := v_campos->>'calculado';  
 
        IF NOT EXISTS (SELECT 1 FROM campo WHERE nombre = v_nombre) THEN  
        
            SELECT unidad INTO v_unidad_existente   
            FROM campo   
            WHERE unidad = v_unidad   
            LIMIT 1;  

            IF v_unidad_existente IS NULL THEN  
                v_unidad_existente := v_unidad; 
            END IF;  
 
            INSERT INTO campo(nombre, unidad, valor_referencial, calculado) VALUES (v_nombre, v_unidad_existente, v_valor_referencial, v_calculado);  
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
			'valor_referencial', a.valor_referencial,
			'calculado', a.calculado,
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
			'valor_referencial', a.valor_referencial, 
			'calculado', a.calculado, 
            'createdDate', a.createdDate,  
            'modifiedDate', a.modifiedDate  
        )  
        FROM (  
            SELECT DISTINCT ON (unidad)   
                idCampo, unidad, valor_referencial, calculado, createdDate, modifiedDate   
            FROM campo    
        ) AS a  
    )::json[] INTO v_json_resp;  

    RETURN v_json_resp;  
END;  
$BODY$;

CREATE OR REPLACE FUNCTION sp_find_all_inputs_by_profile(
	p_idProfile INTEGER
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
			'idCampo', c.idCampo,
			'idCampo_perfil', cp.idCampo_perfil,
			'nombre', c.nombre,
            'unidad', c.unidad,
			'valor_referencial', c.valor_referencial, 
			'calculado', c.calculado,
			'createdDate', cp.createdDate,
            'modifiedDate', cp.modifiedDate
		)
		from campo_perfil cp, profile p, campo c 
		where cp.idprofile = p.idprofile
		and cp.idcampo = c.idcampo
		and cp.idprofile = p_idProfile
        ) ::json[] into v_json_resp;
		return v_json_resp;
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_find_division_info_by_profile(  
    p_idProfile INTEGER  
)  
RETURNS json[]  
LANGUAGE 'plpgsql'  
COST 100  
VOLATILE PARALLEL UNSAFE  
AS $BODY$  
DECLARE   
    v_division_resp json[];  
BEGIN  
    SELECT array(  
        SELECT jsonb_build_object(  
            'nombre', pd.nombre,  
            'expandida', false,  
            'orden', pd.orden,  
            'campos', (  
                SELECT array_agg(jsonb_build_object(  
                    'idDivisionCampo', dc.idDivisionCampo,  
                    'idCampo', dc.idCampo,  
                    'createdDate', dc.createdDate,  
                    'modifiedDate', dc.modifiedDate  
                ))  
                FROM division_campo dc  
                WHERE dc.idDivision = pd.idDivision  
            )  
        )  
        FROM perfil_division pd  
        WHERE pd.idProfile = p_idProfile  
    )::json[] INTO v_division_resp;  

    RETURN v_division_resp;  
END;  
$BODY$;  

CREATE OR REPLACE FUNCTION sp_find_input_by_profile_and_input(
	p_idCampo INTEGER,
	p_idProfile INTEGER
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
			'idCampo_perfil', cp.idCampo_perfil,
			'idCampo', cp.idCampo,
            'idProfile', cp.idProfile,
			'createdDate', cp.createdDate,
            'modifiedDate', cp.modifiedDate
		)
		from campo_perfil cp
		where cp.idCampo = p_idCampo
		and cp.idProfile = p_idProfile
        ) ::json[] into v_json_resp;
		return v_json_resp;
end;
$BODY$;

CREATE OR REPLACE FUNCTION insertar_campo_perfil(perfil_id INT, campos JSONB)  
RETURNS VOID AS $$  
DECLARE  
    elemento JSONB;
    campo_id INT;  
BEGIN  
    FOR elemento IN SELECT * FROM jsonb_array_elements(campos)
    LOOP   
        SELECT idCampo INTO campo_id  
        FROM campo  
        WHERE nombre = elemento->>'nombre';
   
        IF campo_id IS NOT NULL THEN  
            INSERT INTO campo_perfil (idCampo, idProfile)  
            VALUES (campo_id, perfil_id);  
        ELSE  
            RAISE WARNING 'Campo no encontrado: %', elemento->>'nombre';  
        END IF;  
    END LOOP;  
END;   
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION obtener_perfil_json(nomb_perfil character varying)  
RETURNS JSON AS $$  
DECLARE  
    resultado JSON;  
BEGIN  
    IF nomb_perfil = 'Perfil 20' THEN  
        resultado := json_build_object(  
            'Hematología Completa', json_build_object(  
                'resultado', json_build_array(  
                    json_build_object('nombre', 'Hematies', 'unidad', (SELECT unidad FROM campo WHERE nombre = 'hematies')),  
                    json_build_object('nombre', 'Hemoglobina', 'unidad', (SELECT unidad FROM campo WHERE nombre = 'hemoglobina')),  
                    json_build_object('nombre', 'Hematocrito', 'unidad', (SELECT unidad FROM campo WHERE nombre = 'hematocrito'))  
                )  
            ),  
            'Química Sanguinea', json_build_object(  
                'resultado', json_build_array(  
                    json_build_object('nombre', 'glicemia', 'unidad', (SELECT unidad FROM campo WHERE nombre = 'glicemia')),  
                    json_build_object('nombre', 'colesterol_total', 'unidad', (SELECT unidad FROM campo WHERE nombre = 'colesterol_total')),  
                    json_build_object('nombre', 'colesterol_hdl', 'unidad', (SELECT unidad FROM campo WHERE nombre = 'colesterol_hdl')),  
                    json_build_object('nombre', 'colesterol_ldl', 'unidad', (SELECT unidad FROM campo WHERE nombre = 'colesterol_ldl')),  
                    json_build_object('nombre', 'trigliceridos', 'unidad', (SELECT unidad FROM campo WHERE nombre = 'trigliceridos')),  
                    json_build_object('nombre', 'lipidos_totales', 'unidad', (SELECT unidad FROM campo WHERE nombre = 'lipidos_totales')),  
                    json_build_object('nombre', 'proteina_c_resactiva', 'unidad', (SELECT unidad FROM campo WHERE nombre = 'proteina_c_resactiva')),  
                    json_build_object('nombre', 'creatina', 'unidad', (SELECT unidad FROM campo WHERE nombre = 'creatina')),  
                    json_build_object('nombre', 'transaminasa_oxalacetica', 'unidad', (SELECT unidad FROM campo WHERE nombre = 'transaminasa_oxalacetica')),  
                    json_build_object('nombre', 'transaminasa_piruvica', 'unidad', (SELECT unidad FROM campo WHERE nombre = 'transaminasa_piruvica')),  
                    json_build_object('nombre', 'calcio', 'unidad', (SELECT unidad FROM campo WHERE nombre = 'calcio')),  
                    json_build_object('nombre', 'fosforo', 'unidad', (SELECT unidad FROM campo WHERE nombre = 'fosforo')),  
                    json_build_object('nombre', 'bilirrubina_total', 'unidad', (SELECT unidad FROM campo WHERE nombre = 'bilirrubina_total')),  
                    json_build_object('nombre', 'bilirrubina_directa', 'unidad', (SELECT unidad FROM campo WHERE nombre = 'bilirrubina_directa')),  
                    json_build_object('nombre', 'bilirrubina_indirecta', 'unidad', (SELECT unidad FROM campo WHERE nombre = 'bilirrubina_indirecta')),  
                    json_build_object('nombre', 'albumina', 'unidad', (SELECT unidad FROM campo WHERE nombre = 'albumina')),  
                    json_build_object('nombre', 'globulina', 'unidad', (SELECT unidad FROM campo WHERE nombre = 'globulina'))  
                )  
            )  
        );  

    ELSIF nomb_perfil = 'Uroanalisis' THEN  
        resultado := json_build_object(  
            'Uroanalisis', json_build_object(  
                'resultado', json_build_array(  
                    json_build_object('nombre', 'color', 'unidad', (SELECT unidad FROM campo WHERE nombre = 'color')),  
                    json_build_object('nombre', 'aspecto', 'unidad', (SELECT unidad FROM campo WHERE nombre = 'aspecto')),  
                    json_build_object('nombre', 'ph', 'unidad', (SELECT unidad FROM campo WHERE nombre = 'ph')),  
                    json_build_object('nombre', 'densidad', 'unidad', (SELECT unidad FROM campo WHERE nombre = 'densidad'))  
                )  
            ),  
            'Análisis microscopico', json_build_object(  
                'resultado', json_build_array(  
                    json_build_object('nombre', 'leucocitos', 'unidad', (SELECT unidad FROM campo WHERE nombre = 'leucocitos')),  
                    json_build_object('nombre', 'cristales', 'unidad', (SELECT unidad FROM campo WHERE nombre = 'cristales'))  
                )  
            ),  
            'Análisis Químico', json_build_object(  
                'resultado', json_build_array(  
                    json_build_object('nombre', 'proteinas', 'unidad', (SELECT unidad FROM campo WHERE nombre = 'proteinas'))  
                )  
            )  
        );  
    
    ELSIF nomb_perfil = 'Perfil Tiroideo' THEN  
        resultado := json_build_object(  
            'Perfil tiroideo', json_build_object(  
                'resultado', json_build_array(  
                    json_build_object('nombre', 'TSH', 'unidad', (SELECT unidad FROM campo WHERE nombre = 'TSH')),  
                    json_build_object('nombre', 'T4', 'unidad', (SELECT unidad FROM campo WHERE nombre = 'T4')),  
                    json_build_object('nombre', 'T3', 'unidad', (SELECT unidad FROM campo WHERE nombre = 'T3')),  
                    json_build_object('nombre', 'Anti-TG', 'unidad', (SELECT unidad FROM campo WHERE nombre = 'Anti-TG')),  
                    json_build_object('nombre', 'Anti-TPO', 'unidad', (SELECT unidad FROM campo WHERE nombre = 'Anti-TPO'))  
                )  
            )  
        );  
    
    ELSE  
        RAISE EXCEPTION 'Perfil no reconocido: %', nomb_perfil;  
    END IF;  

    RETURN resultado;  
END;  
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION agregar_en_campo_perfil(p_idProfile integer, p_idCampos integer[])  
RETURNS void AS $$  
DECLARE  
    campo integer;  
BEGIN  
    FOREACH campo IN ARRAY p_idCampos  
    LOOP  
        INSERT INTO campo_perfil (idCampo, idProfile)  
        VALUES (campo, p_idProfile);  
    END LOOP;  
END;  
$$ LANGUAGE plpgsql;  

CREATE OR REPLACE FUNCTION agregar_en_division_campo(p_idProfile integer, p_nombre varchar, p_idCampos integer[])  
RETURNS void AS $$  
DECLARE  
    campo integer;  
	id integer;  
BEGIN  
	select idDivision into id   
	from perfil_division  
	where idProfile = p_idProfile  
	and nombre = p_nombre;   

    FOREACH campo IN ARRAY p_idCampos  
    LOOP  
        RAISE NOTICE 'Intentando insertar campo: %', campo;  

        IF NOT EXISTS (SELECT 1   
                       FROM division_campo   
                       WHERE idDivision = id AND idCampo = campo) THEN  
            INSERT INTO division_campo (idDivision, idCampo)  
            VALUES (id, campo);  
            RAISE NOTICE 'Campo insertado: %', campo;  
        ELSE  
            RAISE NOTICE 'El campo % ya existe y no se insertará.', campo;  
        END IF;  
    END LOOP;  
END;  
$$ LANGUAGE plpgsql;  

CREATE OR REPLACE FUNCTION eliminar_campo_perfil(p_idProfile integer, p_idCampos integer[])  
RETURNS void AS $$  
DECLARE  
    campo integer;  
BEGIN  
    FOREACH campo IN ARRAY p_idCampos  
    LOOP  
        DELETE FROM campo_perfil  
        WHERE idCampo = campo AND idProfile = p_idProfile;  
    END LOOP;  
END;  
$$ LANGUAGE plpgsql;  

CREATE OR REPLACE FUNCTION eliminar_division_campo(p_idProfile integer, p_nombre varchar, p_idCampos integer[])  
RETURNS void AS $$  
DECLARE  
    campo integer;
	id integer;  
BEGIN  
	select idDivision into id 
	from perfil_division
	where idProfile = p_idProfile
	and nombre = p_nombre; 

    FOREACH campo IN ARRAY p_idCampos  
    LOOP  
        DELETE FROM division_campo  
        WHERE idCampo = campo AND idDivision = id;  
    END LOOP;  
END;  
$$ LANGUAGE plpgsql; 

CREATE OR REPLACE FUNCTION eliminar_perfil_division(p_idProfile integer, p_nombre varchar)  
    RETURNS character varying
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE  
    id integer; 
begin
	select idDivision into id 
	from perfil_division
	where idProfile = p_idProfile
	and nombre = p_nombre; 

	delete from perfil_division
	where idDivision = id;
	return 'Se ha borrado la division correctamente';
end;
$BODY$; 

CREATE OR REPLACE FUNCTION sp_agregar_perfil_division(  
    p_campos jsonb[]  
) RETURNS json  
LANGUAGE 'plpgsql'  
COST 100  
VOLATILE PARALLEL UNSAFE  
AS $BODY$  

DECLARE  
    v_campos jsonb;  
    v_idProfile integer;  
    v_nombre VARCHAR;
	v_orden integer;  
    v_inserciones integer := 0;  
    v_unidad_existente VARCHAR;  
BEGIN  
    FOREACH v_campos IN ARRAY p_campos LOOP   

        v_idProfile := v_campos->>'idProfile';  
        v_nombre := v_campos->>'nombre';
		v_orden := v_campos->>'orden';  
 
        IF NOT EXISTS (SELECT 1 FROM perfil_division WHERE nombre = v_nombre and idProfile = v_idProfile) THEN   
 
            INSERT INTO perfil_division(idProfile, nombre, orden) VALUES (v_idProfile, v_nombre, v_orden);  
            v_inserciones := v_inserciones + 1;  
        END IF;  
    END LOOP;  

    RETURN json_build_object(  
        'message', 'Operación completada.',  
        'nuevos_agregados', v_inserciones  
    );  
END;  
$BODY$; 

CREATE OR REPLACE FUNCTION sp_insertar_resultados_en_perfil(p_data jsonb)  
RETURNS varchar AS $$  
DECLARE  
    v_profile_name text;  
    v_order_id integer;  
    v_field jsonb;  
    v_idCampo integer;  
    v_resultado text;  
    v_table_name text;  
    v_sql text;  
BEGIN  
    v_profile_name := p_data->>'profileName';  
    v_order_id := (p_data->>'orderId')::integer;  

    v_table_name := 'resultados_' || lower(replace(v_profile_name, ' ', '_'));  

    FOR v_field IN SELECT * FROM jsonb_array_elements(p_data->'fields') LOOP  
        SELECT idCampo INTO v_idCampo  
        FROM campo  
        WHERE nombre = v_field->>'fieldName';  

        IF v_idCampo IS NOT NULL THEN  
            v_resultado := v_field->>'inputValue';  
 
            v_sql := format('INSERT INTO %I (idOrder, idCampo_perfil, resultado) VALUES (%L, %L, %L)',   
                           v_table_name, v_order_id, v_idCampo, v_resultado);  

            EXECUTE v_sql;  
        END IF;  
    END LOOP;  

    RETURN 'Inserción exitosa';  
END;  
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION insertar_perfil_division_y_campos(  
    p_idProfile INTEGER,  
    p_divisiones JSONB  
) RETURNS VARCHAR AS $$  
DECLARE  
    v_idDivision INTEGER;  
    v_idCampo INTEGER;  
    elem RECORD;   
    campo_json JSONB;  
BEGIN    
    FOR elem IN SELECT * FROM jsonb_to_recordset(p_divisiones) AS x(nombre TEXT, orden INTEGER, campos JSONB)  
    LOOP  
        INSERT INTO perfil_division (idProfile, nombre, orden)  
        VALUES (p_idProfile, elem.nombre, elem.orden)  
        RETURNING idDivision INTO v_idDivision;  

        FOR campo_json IN SELECT * FROM jsonb_array_elements(elem.campos)  
        LOOP  
            SELECT c.idCampo INTO v_idCampo  
            FROM campo c  
            WHERE c.nombre = campo_json->>'nombre';
            
            INSERT INTO division_campo (idDivision, idCampo) 
            VALUES (v_idDivision, v_idCampo);  
        END LOOP;  
    END LOOP;  

    RETURN 'Inserción exitosa';  
END;  
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION sp_sincronizar_resultados(p_data jsonb)  
RETURNS VARCHAR AS $$  
DECLARE  
    v_profile_name TEXT;  
    v_order_id INTEGER;  
    v_field JSONB;  
    v_idCampo INTEGER;  
    v_resultado TEXT;  
    v_table_name TEXT;  
    v_sql TEXT;  
    v_count INTEGER;  
BEGIN  
    v_profile_name := p_data->>'profileName';  
    v_order_id := (p_data->>'orderId')::INTEGER;  
    v_table_name := 'resultados_' || lower(replace(v_profile_name, ' ', '_'));  
  
    v_sql := format('SELECT count(*) FROM %I WHERE idOrder = %L', v_table_name, v_order_id);  
    EXECUTE v_sql INTO v_count;  

    IF v_count > 0 THEN  
        v_sql := format('DELETE FROM %I WHERE idOrder = %L', v_table_name, v_order_id);  
        EXECUTE v_sql;  
    END IF;  

    FOR v_field IN SELECT * FROM jsonb_array_elements(p_data->'fields') LOOP  
        SELECT idCampo INTO v_idCampo  
        FROM campo  
        WHERE nombre = v_field->>'fieldName';  

        IF v_idCampo IS NOT NULL THEN  
            v_resultado := v_field->>'inputValue';  

            v_sql := format('INSERT INTO %I (idOrder, idCampo_perfil, resultado) VALUES (%L, %L, %L)',  
                           v_table_name, v_order_id, v_idCampo, v_resultado);  

            EXECUTE v_sql;  
        END IF;  
    END LOOP;  

    RETURN 'Sincronización exitosa';  
END;  
$$ LANGUAGE plpgsql;  

CREATE OR REPLACE FUNCTION obtener_perfil_json2(nomb_perfil character varying)  
RETURNS JSON AS $$  
DECLARE  
    resultado JSON;  
    division_cursor CURSOR FOR  
        SELECT idDivision, nombre, orden  
        FROM perfil_division  
        WHERE idProfile = (SELECT idProfile FROM profile WHERE name = nomb_perfil)  
        ORDER BY orden;  
    id_division INTEGER;  
    nombre_division TEXT;  
    orden_division INTEGER;  
    campos_json JSON[];  
    campo_cursor CURSOR FOR  
        SELECT c.nombre, c.unidad, c.valor_referencial, c.calculado  
        FROM division_campo dc  
        JOIN campo c ON dc.idCampo = c.idCampo  
        WHERE dc.idDivision = id_division;  
    nombre_campo TEXT;  
    unidad_campo TEXT;  
    valor_referencial_campo TEXT; 
	calculado_campo TEXT; 
    divisiones_array JSON[]; 
    division_json JSON;  
    final_json JSONB := '{}'::JSONB;
    division_element JSON;  
BEGIN   
    IF NOT EXISTS (SELECT 1 FROM profile WHERE name = nomb_perfil) THEN  
        RAISE EXCEPTION 'Perfil no reconocido: %', nomb_perfil;  
    END IF;  
  
    divisiones_array := ARRAY[]::JSON[];  
  
    OPEN division_cursor;  

    LOOP    
        FETCH division_cursor INTO id_division, nombre_division, orden_division;  
        EXIT WHEN NOT FOUND;  
  
        campos_json := ARRAY[]::JSON[];  
  
        OPEN campo_cursor;  

        LOOP   
            FETCH campo_cursor INTO nombre_campo, unidad_campo, valor_referencial_campo, calculado_campo;  
            EXIT WHEN NOT FOUND;  
 
            campos_json := array_append(campos_json, json_build_object('nombre', nombre_campo, 'unidad', unidad_campo, 'valor_referencial', valor_referencial_campo, 'calculado', calculado_campo));  
        END LOOP;  
 
        CLOSE campo_cursor;  
 
        division_json := json_build_object(nombre_division, json_build_object('resultado', json_build_array(VARIADIC campos_json)));  

        divisiones_array := array_append(divisiones_array, division_json);  

    END LOOP;  
 
    CLOSE division_cursor;  
  
    FOREACH division_element IN ARRAY divisiones_array  
    LOOP  
        final_json := final_json || division_element::JSONB;  
    END LOOP;  

    resultado := final_json::JSON;  

    RETURN resultado;  

EXCEPTION  
    WHEN OTHERS THEN  
        RAISE EXCEPTION 'Error al obtener el perfil: %', SQLERRM;  
END;  
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION sp_update_order_status(  
    p_idOrder INT,  
    p_status VARCHAR  
) RETURNS VOID AS $$  
BEGIN  
    UPDATE orders  
    SET status = p_status,  
        modifiedDate = now()  
    WHERE idOrder = p_idOrder;  

    IF NOT FOUND THEN  
        RAISE EXCEPTION 'Order with idOrder % does not exist', p_idOrder;  
    END IF;  
END;  
$$ LANGUAGE plpgsql;  

CREATE OR REPLACE FUNCTION obtener_perfil_con_resultados(
	nomb_perfil character varying,
	idorder integer)
    RETURNS json
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE  
    resultado JSON;  
    division_cursor CURSOR FOR  
        SELECT idDivision, nombre, orden  
        FROM perfil_division  
        WHERE idProfile = (SELECT idProfile FROM profile WHERE name = nomb_perfil)  
        ORDER BY orden;  
    id_division INTEGER;  
    nombre_division TEXT;  
    orden_division INTEGER;  
    campos_json JSON[];  
    nombre_campo TEXT;  
    unidad_campo TEXT;  
    valor_referencial_campo TEXT;   
    calculado_campo TEXT;   
    resultado_campo TEXT;
    divisiones_array JSON[];   
    division_json JSON;  
    final_json JSONB := '{}'::JSONB;  
    division_element JSON;  
    record RECORD;  
    nombre_tabla TEXT;  
	restricciones_json JSON;
BEGIN   
    -- Comprobamos si existe el perfil  
    IF NOT EXISTS (SELECT 1 FROM profile WHERE name = nomb_perfil) THEN  
        RAISE EXCEPTION 'Perfil no reconocido: %', nomb_perfil;  
    END IF;  

    divisiones_array := ARRAY[]::JSON[];  

    OPEN division_cursor;  

    LOOP    
        FETCH division_cursor INTO id_division, nombre_division, orden_division;  
        EXIT WHEN NOT FOUND;  

        campos_json := ARRAY[]::JSON[];  

        FOR record IN  
            SELECT c.idCampo, c.nombre, c.unidad, c.valor_referencial, c.calculado  
            FROM division_campo dc  
            JOIN campo c ON dc.idCampo = c.idCampo  
            WHERE dc.idDivision = id_division  
        LOOP  
            nombre_campo := record.nombre;  
            unidad_campo := record.unidad;  
            valor_referencial_campo := record.valor_referencial;   
            calculado_campo := record.calculado;  

            nombre_tabla := 'resultados_' || lower(replace(nomb_perfil, ' ', '_'));   

            EXECUTE format('SELECT r.resultado   
                            FROM %I r   
                            JOIN campo_perfil c ON r.idcampo_perfil = c.idcampo_perfil   
                            JOIN campo ca ON ca.idcampo = c.idcampo   
                            WHERE r.idOrder = $1 AND ca.nombre = $2', nombre_tabla)   
            INTO resultado_campo USING idOrder, nombre_campo;   
            
            -- Manejar el caso en que resultado_campo es nulo  
            IF resultado_campo IS NULL THEN  
                resultado_campo := NULL;  -- Mensaje en caso de no encontrar resultados  
            END IF;  
			
			SELECT json_agg(r.restriction) INTO restricciones_json  
			FROM restriction r  
			WHERE r.idProfile = (SELECT idProfile FROM profile WHERE name = nomb_perfil);

            campos_json := array_append(campos_json, json_build_object(  
                'nombre', nombre_campo,   
                'unidad', unidad_campo,   
                'valor_referencial', valor_referencial_campo,   
                'calculado', calculado_campo,  
                'valor', resultado_campo,
				'restricciones', COALESCE(restricciones_json, '[]')
            ));  
			  
        END LOOP;  

        division_json := json_build_object(nombre_division, json_build_object('resultado', json_build_array(VARIADIC campos_json)));  
        divisiones_array := array_append(divisiones_array, division_json);  
    END LOOP;  

    CLOSE division_cursor;  

    FOREACH division_element IN ARRAY divisiones_array  
    LOOP  
        final_json := final_json || division_element::JSONB;  
    END LOOP;  

    resultado := final_json::JSON;  

    RETURN resultado;  
   
EXCEPTION  
    WHEN OTHERS THEN  
        RAISE EXCEPTION 'Error al obtener el perfil: %', SQLERRM;  
END;  
$BODY$;

CREATE OR REPLACE FUNCTION sp_find_all_section_inputs_by_name(
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
			'idCampo', a.idCampo,
			'nombre', a.nombre,
            'unidad', a.unidad,
			'valor_referencial', a.valor_referencial,
			'calculado', a.calculado,
			'createdDate', a.createdDate,
            'modifiedDate', a.modifiedDate
		)
		from division_campo dc, perfil_division pd, campo a
		where dc.iddivision = pd.iddivision
		and a.idcampo = dc.idcampo
		and pd.nombre = p_name
        ) ::json[] into v_json_resp;
		return v_json_resp;
end;
$BODY$;
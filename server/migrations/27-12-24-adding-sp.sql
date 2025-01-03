CREATE OR REPLACE FUNCTION sp_find_all_income(
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
			'idExam', e.idexam,
			'examName', e.name,
			'cost_bs', e.cost_bs,
			'cost_usd', e.cost_usd,
            'createdDate', e.createddate,
			'idUser', s.iduser,
			'ci', s.ci,
			'passport', s.passport,
			'firstName', s.firstname,
			'lastName', s.lastname,
			'genre', s.genre,
			'age', s.age,
			'idPaymentMethod', m.idpayment_method,
			'PaymentMethodName', m.name,
			'amount', m.amount,
			'bank', m.bank,
			'type', m.type
		)
		FROM exam e, users s, payment_method m 
		WHERE e.iduser = s.iduser
		AND e.idexam = m.idexam
        ) ::json[] into v_json_resp;
		return v_json_resp;
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_find_all_bills(
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
		FROM alliance a, provider p, reactive r
		WHERE a.idreactive = r.idreactive
		AND a.idprovider = p.idprovider
        ) ::json[] into v_json_resp;
		return v_json_resp;
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

CREATE OR REPLACE FUNCTION sp_create_exam(
	p_name character varying,
	p_cost_bs character varying,
	p_cost_usd character varying,
	p_status character varying,
	p_iduser integer)
    RETURNS json
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
	v_id                                    integer;
	v_returning_id                                 integer;
begin
		Insert into exam(name, cost_bs, cost_usd, status, iduser) 
		VALUES (p_name, p_cost_bs, p_cost_usd, p_status, p_idUser)
		RETURNING idexam INTO v_returning_id;
		return json_build_object('message', 'Inserción exitosa.', 
								 'id', v_returning_id);
end;
$BODY$;

CREATE OR REPLACE FUNCTION sp_create_payment_method(
	p_name character varying,
	p_amount character varying,
	p_bank character varying,
	p_type character varying,
	p_idexam integer)
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
	WHERE name = p_name
	AND idexam = p_idExam;
	if (v_id is NOT NULL) then
		return 'El método de pago ya fue ingresado anteriormente.';
	else
		Insert into payment_method(name, amount, bank, type, idExam) 
		VALUES (p_name, p_amount, p_bank, p_type, p_idExam)
		RETURNING idpayment_method INTO v_returning_id;
		return json_build_object('message', 'Inserción exitosa.', 
								 'id', v_returning_id);
	end if;
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

CREATE OR REPLACE FUNCTION sp_create_unit(
	p_name character varying,
	p_idexam integer)
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
	AND idexam = p_idExam;
	if (v_id is NOT NULL) then
		return 'La unidad ya fue ingresado anteriormente.';
	else
		Insert into unit(name, idExam) 
		VALUES (p_name, p_idExam)
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
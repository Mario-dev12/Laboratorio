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
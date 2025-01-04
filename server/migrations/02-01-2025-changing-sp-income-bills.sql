CREATE OR REPLACE FUNCTION public.sp_find_all_bills(  
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

CREATE OR REPLACE FUNCTION public.sp_find_all_income(
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
			FROM exam e  
			JOIN users s ON e.iduser = s.iduser  
			JOIN payment_method m ON e.idexam = m.idexam  
		) ::json[] INTO v_json_resp;  
	  
	ELSE    
		SELECT array(  
			SELECT jsonb_build_object(  
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
			FROM exam e  
			JOIN users s ON e.iduser = s.iduser  
			JOIN payment_method m ON e.idexam = m.idexam  
			WHERE (p_startDate = '' OR e.createddate >= p_startDate::timestamp with time zone)  
			AND (p_endDate = '' OR e.createddate <= p_endDate::timestamp with time zone)  
		) ::json[] INTO v_json_resp;  
	END IF;  

	RETURN v_json_resp;  
END;  
$BODY$;
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
			'createdDate', a.createdDate,
            'modifiedDate', a.modifiedDate,
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

CREATE OR REPLACE FUNCTION public.sp_find_all_quantity_reactive(
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
			'name', a.name,
			'quantity', SUM(l.quantity)
		)
		from reactive a, alliance l
		WHERE a.idReactive = l.idReactive
		GROUP BY a.name
        ) ::json[] into v_json_resp;
		return v_json_resp;
end;
$BODY$;
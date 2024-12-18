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
			'quantity', a.quantity,
			'idExam', a.idExam,
			'createdDate', a.createdDate,
            'modifiedDate', a.modifiedDate,
			'provider_name', d.name
		)
		from reactive a, provider d, alliance l
		where l.idReactive = a.idReactive
		and l.idProvider = d.idProvider
        ) ::json[] into v_json_resp;
		return v_json_resp;
end;
$BODY$;
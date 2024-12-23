CREATE OR REPLACE FUNCTION public.sp_find_all_reactive()  
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
			'idReactive', a.idReactive,  
			'name', a.name,  
			'createdDate', a.createdDate,  
            'modifiedDate', a.modifiedDate,  
			'totalQuantity', COALESCE(SUM(l.quantity), 0)  
		)  
		FROM reactive a  
		LEFT JOIN alliance l ON l.idReactive = a.idReactive  
		GROUP BY a.idReactive, a.name, a.createdDate, a.modifiedDate  
		ORDER BY SUM(l.quantity) DESC  
	) ::json[] INTO v_json_resp;  
	  
	RETURN v_json_resp;  
END;  
$BODY$;  

CREATE OR REPLACE FUNCTION public.sp_create_reactive(
	p_name character varying)
    RETURNS character varying
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
	v_id                                    integer;
begin
	select idreactive into v_id FROM reactive 
	WHERE name = p_name;
	if (v_id is NOT NULL) then
		return 'El reactivo ya fue ingresado anteriormente.';
	else
		Insert into reactive(name) 
		VALUES (p_name);
		return 'Inserción exitosa';
	end if;
end;
$BODY$;
CREATE OR REPLACE FUNCTION "prueba"."ft_cargo_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		PRUEBA
 FUNCION: 		prueba.ft_cargo_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'prueba.tcargo'
 AUTOR: 		 (admin)
 FECHA:	        16-08-2013 18:28:25
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:		
***************************************************************************/

DECLARE

	v_nro_requerimiento    	integer;
	v_parametros           	record;
	v_id_requerimiento     	integer;
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
	v_id_cargo	integer;
			    
BEGIN

    v_nombre_funcion = 'prueba.ft_cargo_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PRU_CAR_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		16-08-2013 18:28:25
	***********************************/

	if(p_transaccion='PRU_CAR_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into prueba.tcargo(
			estado_reg,
			estado,
			nombre,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			'activo',
			v_parametros.estado,
			v_parametros.nombre,
			now(),
			p_id_usuario,
			null,
			null
							
			)RETURNING id_cargo into v_id_cargo;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Cargo almacenado(a) con exito (id_cargo'||v_id_cargo||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_cargo',v_id_cargo::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PRU_CAR_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		16-08-2013 18:28:25
	***********************************/

	elsif(p_transaccion='PRU_CAR_MOD')then

		begin
			--Sentencia de la modificacion
			update prueba.tcargo set
			estado = v_parametros.estado,
			nombre = v_parametros.nombre,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_cargo=v_parametros.id_cargo;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Cargo modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_cargo',v_parametros.id_cargo::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PRU_CAR_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		16-08-2013 18:28:25
	***********************************/

	elsif(p_transaccion='PRU_CAR_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from prueba.tcargo
            where id_cargo=v_parametros.id_cargo;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Cargo eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_cargo',v_parametros.id_cargo::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
         
	else
     
    	raise exception 'Transaccion inexistente: %',p_transaccion;

	end if;

EXCEPTION
				
	WHEN OTHERS THEN
		v_resp='';
		v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
		v_resp = pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
		v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
		raise exception '%',v_resp;
				        
END;
$BODY$
LANGUAGE 'plpgsql' VOLATILE
COST 100;
ALTER FUNCTION "prueba"."ft_cargo_ime"(integer, integer, character varying, character varying) OWNER TO postgres;

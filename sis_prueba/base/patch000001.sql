/********************************************I-SCP-EAC-PRUEBA-0-16/08/2013********************************************/

CREATE TABLE prueba.templeado_cargo ( 
	id_empleado_cargo serial NOT NULL,
	id_empleado integer,
	id_cargo integer,
	estado varchar(50),
	fecha_inicio timestamp,
	fecha_fin timestamp
)
;

CREATE TABLE prueba.tcargo ( 
	id_cargo serial NOT NULL,
	nombre varchar(100),
	estado varchar(50)
)
;

CREATE TABLE prueba.templeado ( 
	id_empleado serial NOT NULL,
	nombre varchar(100),
	apellido_paterno varchar(100),
	apellido_materno varchar(100),
	fecha_nacimiento timestamp
)
;


ALTER TABLE prueba.templeado_cargo ADD CONSTRAINT PK_templeado_cargo__id_empleado_cargo 
	PRIMARY KEY (id_empleado_cargo)
;


ALTER TABLE prueba.tcargo ADD CONSTRAINT PK_tcargo__id_cargo 
	PRIMARY KEY (id_cargo)
;


ALTER TABLE prueba.templeado ADD CONSTRAINT PK_templeado__id_empleado 
	PRIMARY KEY (id_empleado)
;




ALTER TABLE prueba.templeado_cargo ADD CONSTRAINT FK_templeado_cargo__id_cargo 
	FOREIGN KEY (id_cargo) REFERENCES prueba.tcargo (id_cargo)
;

ALTER TABLE prueba.templeado_cargo ADD CONSTRAINT FK_templeado_cargo__id_empleado 
	FOREIGN KEY (id_empleado) REFERENCES prueba.templeado (id_empleado)
;


/********************************************F-SCP-EAC-PRUEBA-0-16/08/2013********************************************/

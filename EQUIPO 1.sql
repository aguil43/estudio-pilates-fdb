CREATE DATABASE equipo1;
USE equipo1;

-- TABLAS ENTIDADES FERES
CREATE TABLE persona(
	id 			INTEGER PRIMARY KEY NOT NULL UNIQUE AUTO_INCREMENT,
    prNom 		VARCHAR(25) NOT NULL,
    sgNom 		VARCHAR(25),
    apPat 		VARCHAR(25) NOT NULL,
    apMat 		VARCHAR(25),
    fechaNac 	DATE NOT NULL
);

CREATE TABLE membresia(
	id 				INTEGER PRIMARY KEY NOT NULL UNIQUE AUTO_INCREMENT,
    tipo 			VARCHAR(30) NOT NULL,
    costoMensual 	DOUBLE NOT NULL
);

CREATE TABLE sucursal(
	id 				INTEGER PRIMARY KEY NOT NULL UNIQUE,
    nombreSucursal 	VARCHAR(40) NOT NULL,
    calle			VARCHAR(30) NOT NULL,
    num				VARCHAR(7) NOT NULL,
    col				VARCHAR(30) NOT NULL,
    cd				VARCHAR(30) NOT NULL,
    cp				VARCHAR(5) NOT NULL,
    CONSTRAINT chk_sucursal_cp_1 CHECK(cp regexp '^[0-9]{5}$')
);

CREATE TABLE maquina(
	id			INTEGER PRIMARY KEY NOT NULL UNIQUE AUTO_INCREMENT,
    marca		VARCHAR(25) NOT NULL,
    modelo		VARCHAR(30) NOT NULL,
    idSucursal	INTEGER NOT NULL,
    numSala		INTEGER NOT NULL
);

CREATE TABLE clase(
	id				INTEGER PRIMARY KEY NOT NULL UNIQUE,
    nombreClase		VARCHAR(30) NOT NULL,
    horario			VARCHAR(15) NOT NULL,
    idInstructor	INTEGER NOT NULL,
    CONSTRAINT chk_clase_horario_1 CHECK(horario regexp '^([01][0-9]|2[0-3]):[0-5][0-9]-([01][0-9]|2[0-3]):[0-5][0-9]$')
);

CREATE TABLE certificacion(
	id		INTEGER PRIMARY KEY NOT NULL UNIQUE,
    nombre	VARCHAR(30) NOT NULL
);

-- TABLAS ENTIDADES HERENCIAS
CREATE TABLE cliente(
	id					INTEGER PRIMARY KEY NOT NULL UNIQUE,
    fechaRegistro		DATE NOT NULL,
    idMembresia			INTEGER NULL,
    duracion			INTEGER NULL,
    fechaAdquisicion 	DATE NULL,
    idReferente			INTEGER NULL,
    FOREIGN KEY (id) REFERENCES persona(id),
    FOREIGN KEY (idMembresia) REFERENCES membresia(id),
    FOREIGN KEY (idReferente) REFERENCES cliente(id)
);

CREATE TABLE empleado(
	id				INTEGER NOT NULL PRIMARY KEY UNIQUE,
    fechaContrato	DATE NOT NULL,
    idSupervisor	INTEGER NOT NULL,
    FOREIGN KEY (id) REFERENCES persona(id),
    FOREIGN KEY (idSupervisor) REFERENCES empleado(id)
);

CREATE TABLE instructor(
	id				INTEGER NOT NULL PRIMARY KEY UNIQUE,
    telefono		VARCHAR(14) NOT NULL UNIQUE,
    correo			VARCHAR(55) NOT NULL UNIQUE,
    horario			VARCHAR(11) NOT NULL,
    FOREIGN KEY (id) REFERENCES empleado(id),
    CONSTRAINT chk_instructor_telefono_1 CHECK(telefono regexp '^\\+[0-9]{13}$'),
    CONSTRAINT chk_instructor_correo_1 CHECK(correo regexp '^[0-9a-zA-Z._%+-]+@[0-9a-zA-Z.-]+\\.[a-zA-Z]{2,}$'),
	CONSTRAINT chk_instructor_horario_1 CHECK(horario regexp '^([01][0-9]|2[0-3]):[0-5][0-9]-([01][0-9]|2[0-3]):[0-5][0-9]$')
);

CREATE TABLE recepcionista(
	id 				INTEGER NOT NULL PRIMARY KEY UNIQUE,
    turno			VARCHAR(1) NOT NULL, -- AGREGAR CHECK M-V MATUTINO VESPERTINO
    correo			VARCHAR(55) NOT NULL,
    idSucursal		INTEGER NOT NULL,
    FOREIGN KEY (id) REFERENCES empleado(id),
    FOREIGN KEY (idSucursal) REFERENCES sucursal(id),
    CONSTRAINT chk_recepcionista_turno_1 CHECK(turno in ('M', 'V')),
    CONSTRAINT chk_recepcionista_correo_1 CHECK(correo regexp '^[0-9a-zA-Z._%+-]+@[0-9a-zA-Z.-]+\\.[a-zA-Z]{2,}$')
);

-- TABLAS DE ENTIDADES DEBILES
CREATE TABLE historial_medico(
	idCliente		INTEGER NOT NULL,
    id				INTEGER NOT NULL,
    descripcion		VARCHAR(150) NULL,
    fechaUltimaAct	DATE NULL,
    prNom			VARCHAR(25) NOT NULL,
    sgNom			VARCHAR(25) NULL,
    apPat			VARCHAR(30) NOT NULL,
    apMat			VARCHAR(30) NULL,
    PRIMARY KEY (idCliente, id),
    FOREIGN KEY (idCliente) REFERENCES cliente(id)
);

CREATE TABLE visita(
	idCliente		INTEGER NOT NULL,
    id				INTEGER NOT NULL,
    fechaVisita		DATE NOT NULL,
    duracion		DOUBLE NOT NULL,
    PRIMARY KEY (idCliente, id),
    FOREIGN KEY (idCliente) REFERENCES cliente(id)
);

CREATE TABLE sala(
	idSucursal		INTEGER NOT NULL,
    num				INTEGER NOT NULL,
    estado			VARCHAR(20),
    ultimoUso		DATE NULL,
    PRIMARY KEY (idSucursal, num),
    FOREIGN KEY (idSucursal) REFERENCES sucursal(id)
);

CREATE TABLE reservacion(
	idCliente			INTEGER NOT NULL,
    id					INTEGER NOT NULL,
    fechaReserva		DATE NOT NULL,
    horaInicio			VARCHAR(5) NOT NULL,
    horaFin				VARCHAR(5) NOT NULL,
	idSucursal			INTEGER NOT NULL,
    numSala				INTEGER NOT NULL,
    idClienteGenerador 	INTEGER NOT NULL,
    idGenerador			INTEGER NULL,
    PRIMARY KEY (idCliente, id),
    FOREIGN KEY (idCliente) REFERENCES cliente(id),
    FOREIGN KEY (idSucursal, numSala) REFERENCES sala(idSucursal, num),
    FOREIGN KEY (idClienteGenerador, idGenerador) REFERENCES reservacion(idCliente, id),
    CONSTRAINT chk_rsv_hora_1 CHECK(horaInicio regexp '^([01][0-9]|2[0-3]):[0-5][0-9]$'),
    CONSTRAINT chk_rsv_hora_2 CHECK(horaFin regexp '^([01][0-9]|2[0-3]):[0-5][0-9]$')
);

CREATE TABLE mantenimiento(
	idMaquina 			INTEGER NOT NULL,
    folio				INTEGER NOT NULL,
    fechaMantenimiento	DATE NOT NULL,
    horaInicio			VARCHAR(5) NOT NULL,
	horaFin				VARCHAR(5) NULL,
    PRIMARY KEY (idMaquina, folio),
    FOREIGN KEY (idMaquina) REFERENCES maquina(id),
    CONSTRAINT chk_mtto_hora_1 CHECK(horaInicio regexp '^([01][0-9]|2[0-3]):[0-5][0-9]$'),
    CONSTRAINT chk_mtto_hora_2 CHECK(horaFin regexp '^([01][0-9]|2[0-3]):[0-5][0-9]$')
);

CREATE TABLE playlist(
	idSucursal			INTEGER NOT NULL,
    id					INTEGER NOT NULL,
    nombre				VARCHAR(25) NOT NULL,
    cantidadCanciones	INTEGER NOT NULL,
    fechaReproduccion	DATE NOT NULL,
    PRIMARY KEY (idSucursal, id),
    FOREIGN KEY (idSucursal) REFERENCES sucursal(id)
);

CREATE TABLE sesion(
	idClase			INTEGER NOT NULL,
    id				INTEGER NOT NULL,
    fecha 			DATE NOT NULL,
	numAsistentes	INTEGER NOT NULL,
    PRIMARY KEY (idClase, id),
    FOREIGN KEY (idClase) REFERENCES clase(id),
    CONSTRAINT chk_sesion_asistentes_1 CHECK(numAsistentes > 0)
);

-- TABLAS ATRIBUTOS MULTIVALUADOS
CREATE TABLE cliente_telefono(
	idCliente		INTEGER NOT NULL,
    telefono		VARCHAR(14) NOT NULL,
    PRIMARY KEY (idCliente, telefono),
    FOREIGN KEY (idCliente) REFERENCES cliente(id),
    CONSTRAINT chk_cliente_telefono_1 CHECK(telefono regexp '^\\+[0-9]{13}$')
);

CREATE TABLE clase_clasificacion(
	idClase 		INTEGER NOT NULL,
    clasificacion	VARCHAR(20) NOT NULL,
    PRIMARY KEY (idClase, clasificacion),
    FOREIGN KEY (idClase) REFERENCES clase(id)
);

CREATE TABLE certificacion_clasificacion(
	idCertificacion		INTEGER NOT NULL,
	clasificacion		VARCHAR(20) NOT NULL,
    PRIMARY KEY (idCertificacion, clasificacion),
    FOREIGN KEY (idCertificacion) REFERENCES certificacion(id)
);

CREATE TABLE historial_hospital(
	idCliente		INTEGER NOT NULL,
    idHistorial		INTEGER NOT NULL,
    hospital		VARCHAR(30) NOT NULL,
    PRIMARY KEY (idCliente, idHistorial, hospital),
    FOREIGN KEY (idCliente, idHistorial) REFERENCES historial_medico(idCliente, id)
);

-- TABLAS DE RELACIONES N:M
CREATE TABLE cliente_sesion(
	idCliente	INTEGER NOT NULL,
    idClase 	INTEGER NOT NULL,
    idSesion	INTEGER NOT NULL,
    PRIMARY KEY (idCliente, idClase, idSesion),
    FOREIGN KEY (idCliente) REFERENCES cliente(id),
    FOREIGN KEY (idClase, idSesion) REFERENCES sesion(idClase, id)
);

CREATE TABLE INSTRUCTOR_CERTIFICACION(
	idInstructor		INTEGER NOT NULL,
    idCertificacion		INTEGER NOT NULL,
    validez				INTEGER NOT NULL,
    fechaCertificacion	DATE NOT NULL,
    PRIMARY KEY (idInstructor, idCertificacion),
    FOREIGN KEY (idInstructor) REFERENCES instructor(id),
    FOREIGN KEY (idCertificacion) REFERENCES certificacion(id),
    CONSTRAINT chk_ins_cert_validez_1 CHECK(validez > 0)
);

ALTER TABLE maquina
ADD CONSTRAINT fk_maquina_sala
FOREIGN KEY (idSucursal, numSala) REFERENCES sala(idSucursal, num); 

ALTER TABLE clase
ADD CONSTRAINT fk_clase_instructor
FOREIGN KEY (idInstructor) REFERENCES instructor(id);
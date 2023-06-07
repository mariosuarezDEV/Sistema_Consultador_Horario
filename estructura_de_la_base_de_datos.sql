create table autoridad
(
    matricula         int UNIQUE PRIMARY KEY NOT NULL,
    primerNombre      varchar(50)            NOT NULL,
    segundoNombre     varchar(50),
    apellidoPat       varchar(50)            not null,
    apellidoMat       varchar(50)            not null,
    clave             varchar(64)            NOT NULL,
    correoElectronico varchar(150)           NOT NULL
);

CREATE TABLE region
(
    idRegion            int UNIQUE PRIMARY KEY NOT NULL,
    nombre              varchar(50)            NOT NULL,
    matricula_autoridad int                    NOT NULL,
    foreign key (matricula_autoridad) references autoridad (matricula)
);

CREATE TABLE areaAcademica
(
    idAreaAcad          int UNIQUE PRIMARY KEY NOT NULL,
    nombre              varchar(150)           NOT NULL,
    region_id           int                    NOT NULL,
    matricula_autoridad int                    NOT NULL,
    foreign key (region_id) references region (idRegion),
    foreign key (matricula_autoridad) references autoridad (matricula)
);

CREATE TABLE facultad
(
    idFacultad          int UNIQUE PRIMARY KEY NOT NULL,
    nombre              varchar(150)           NOT NULL,
    dirCalle            varchar(150)           NOT NULL,
    dirColinia          varchar(150)           NOT NULL,
    dirCP               varchar(150)           NOT NULL,
    matricula_autoridad int                    NOT NULL,
    idAreaAcad          int                    NOT NULL
);

CREATE TABLE edificio
(
    idEdicio    int UNIQUE PRIMARY KEY NOT NULL,
    nombre      varchar(150)           NOT NULL,
    facultad_id int                    NOT NULL,
    foreign key (facultad_id) references facultad (idFacultad)
);

CREATE TABLE aula
(
    idAula      int UNIQUE PRIMARY KEY NOT NULL,
    nombre      varchar(50)            not null,
    edificio_id int                    NOT NULL,
    foreign key (edificio_id) references edificio (idEdicio)
);

CREATE TABLE programaEducativo
(
    idProgramaEducativo int UNIQUE PRIMARY KEY NOT NULL,
    nombre              varchar(150)           NOT NULL,
    facultad_id         int                    NOT NULL,
    foreign key (facultad_id) references facultad (idFacultad)
);

CREATE TABLE ee
(
    idEE                 int UNIQUE PRIMARY KEY NOT NULL,
    nombre               varchar(150)           NOT NULL,
    creditos             int                    NOT NULL,
    programaEduactivo_id int                    NOT NULL,
    foreign key (programaEduactivo_id) references programaEducativo (idProgramaEducativo)
);

CREATE TABLE alumno
(
    matricula            int UNIQUE PRIMARY KEY NOT NULL,
    primerNombre         varchar(50)            NOT NULL,
    segundoNombre        varchar(50),
    apellidoPat          varchar(50)            NOT NULL,
    apellidoMat          varchar(50)            NOT NULL,
    email                varchar(150)           NOT NULL,
    clave                varchar(64)            NOT NULL,
    programaEduactivo_id int                    NOT NULL,
    foreign key (programaEduactivo_id) references programaEducativo (idProgramaEducativo)
);

CREATE TABLE academico
(
    matricula     int UNIQUE PRIMARY KEY NOT NULL,
    primerNombre  varchar(50)            NOT NULL,
    segundoNombre varchar(50),
    apellidoPat   varchar(50)            NOT NULL,
    apellidoMat   varchar(50)            NOT NULL,
    correo        varchar(150)           NOT NULL
);

CREATE TABLE seccion
(
    NRC                 int UNIQUE PRIMARY KEY NOT NULL,
    periodoInicio       date                   NOT NULL,
    periodoFin          date                   NOT NULL,
    ee_id               int                    NOT NULL,
    matricula_academico int                    NOT NULL,
    foreign key (matricula_academico) references academico (matricula)
);

CREATE TABLE cursa
(
    idCursa          int UNIQUE PRIMARY KEY NOT NULL,
    matricula_alumno int                    NOT NULL,
    numNRC           int                    NOT NULL,
    foreign key (matricula_alumno) references alumno (matricula),
    foreign key (numNRC) references seccion (NRC)
);

CREATE TABLE imparte
(
    idImparte           int UNIQUE PRIMARY KEY                                                      NOT NULL,
    numNRC              int                                                                         NOT NULL,
    aula_id             int                                                                         NOT NULL,
    estado              bool                                                                        NOT NULL,
    matricula_academico int,
    dia                 enum ('Lunes','Martes','Miercoles','Jueves','Viernes', 'Sabado', 'Domingo') NOT NULL,
    horaInicio          time                                                                        NOT NULL,
    horaFin             time                                                                        NOT NULL,
    foreign key (numNRC) references seccion (NRC),
    foreign key (aula_id) references aula (idAula),
    foreign key (matricula_academico) references academico (matricula),
    CONSTRAINT horario_unico_aula UNIQUE (aula_id, dia, horaInicio, horaFin)
);

### EMPEZAR A METER DATOS ####

#ESTRUCTURA DE LA INFORMACION
#Autoridad

INSERT INTO autoridad
VALUES (1, 'Martin', 'Gerardo', 'Aguilar', 'Sanchez',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 'martinaguilar@uv.mx');


#Region

INSERT INTO region
VALUES (1, 'Xalapa', 1);


#Area academica
##Xalapa
#area economico administrativo
INSERT INTO areaAcademica
VALUES (1, 'Economico Administrativa', 1, 1);
#area artes
INSERT INTO areaAcademica
VALUES (2, 'Artes', 1, 1);
#area Ciencias Biológicas y Agropecuarias
INSERT INTO areaAcademica
VALUES (3, 'Ciencias Biológicas y Agropecuarias', 1, 1);
#area Ciencias de la Salud
INSERT INTO areaAcademica
VALUES (4, 'Ciencias de la Salud', 1, 1);
#area Humanidades
INSERT INTO areaAcademica
VALUES (5, 'Humanidades', 1, 1);
#area Técnica
INSERT INTO areaAcademica
VALUES (6, 'Técnica', 1, 1);

select *
from areaAcademica;

#Facultades economico administrativo

INSERT INTO facultad
VALUES (1, 'Estadistica e Informatica', 'Av. Xalapa', 'Obrero Campesina', 91020, 1, 1);
INSERT INTO facultad
VALUES (2, 'Economia', 'Av. Xalapa', 'Obrero Campesina', 91020, 1, 1);
INSERT INTO facultad
VALUES (3, 'Ciencias Administrativas y Sociales', 'Arco Sur Paseo', 'Campo Nuevo', 91097, 1, 1);

#facultades artes
describe facultad;
INSERT INTO facultad
VALUES (4, 'Artes Plásticas', 'Belisario Domínguez', 'Zona Centro', 91000, 1, 2);
INSERT INTO facultad
VALUES (5, 'Danza', 'Belisario Domínguez', 'Zona Centro', 91000, 1, 2);
INSERT INTO facultad
VALUES (6, 'Música', 'Belisario Domínguez', 'Zona Centro', 91000, 1, 2);
INSERT INTO facultad
VALUES (7, 'Teatro', 'Belisario Domínguez', 'Zona Centro', 91000, 1, 2);

#facultades Ciencias Biológicas y Agropecuarias
INSERT INTO facultad
VALUES (8, 'Ciencias Agrícolas', 'Lomas del Estadio', 'Zona Centro', 91000, 1, 3);
INSERT INTO facultad
VALUES (9, 'Biología', 'Belisario Domínguez', 'Zona Centro', 91000, 1, 3);

#facultades Ciencias de la Salud
INSERT INTO facultad
VALUES (10, 'Bioanálisis', 'Médicos y Odontólogos', 'nidad del Bosque', 91010, 1, 4);
INSERT INTO facultad
VALUES (11, 'Enfermería', 'Médicos y Odontólogos', 'nidad del Bosque', 91010, 1, 4);
INSERT INTO facultad
VALUES (12, 'Medicina', 'Médicos y Odontólogos', 'Unidad del Bosque', 91010, 1, 4);
INSERT INTO facultad
VALUES (13, 'Nutrición', 'Médicos y Odontólogos', 'Unidad del Bosque', 91010, 1, 4);
INSERT INTO facultad
VALUES (14, 'Odontología', 'Médicos esquina Odontólogos', 'Zona Centro', 91010, 1, 4);
INSERT INTO facultad
VALUES (15, 'Psicología', 'Manantial de San Cristóbal', 'Xalapa 2000', 91097, 1, 4);

#facultades humanidades
INSERT INTO facultad
VALUES (16, 'Derecho', 'Circuito Gonzalo Aguirre Beltrán', 'Zona UV', 91000, 1, 5);
INSERT INTO facultad
VALUES (17, 'Sociología', 'Teodoro Avendaño', 'Xalapa', 91020, 1, 5);
INSERT INTO facultad
VALUES (18, 'Antropología', 'José Azueta', 'Xalapa', 91000, 1, 5);
INSERT INTO facultad
VALUES (19, 'Filosofía', 'Francisco Moreno', 'Francisco Ferrer Guardia', 91020, 1, 5);
INSERT INTO facultad
VALUES (20, 'Historia', 'Diego Leño', 'Zona Centro', 91010, 1, 5);
INSERT INTO facultad
VALUES (21, 'Idiomas', 'Teodoro Avendaño', 'Xalapa 2000', 91020, 1, 5);
INSERT INTO facultad
VALUES (22, 'Letras Españolas', 'Ezequiel Alatriste', ' Francisco Ferrer Guardia', 91026, 1, 5);
INSERT INTO facultad
VALUES (23, 'Pedagogía', 'Arco Sur', 'Nuevo Xalapa', 91224, 1, 5);

#facultades Técnica
INSERT INTO facultad
VALUES (24, 'Arquitectura', 'Arco Sur', 'Nuevo Xalapa', 91224, 1, 6);
INSERT INTO facultad
VALUES (25, 'Física', 'Arco Sur', 'Nuevo Xalapa', 91224, 1, 6);
INSERT INTO facultad
VALUES (26, 'Instrumentación Electrónica', 'Arco Sur', 'Nuevo Xalapa', 91224, 1, 6);
INSERT INTO facultad
VALUES (27, 'Matemáticas', 'Arco Sur', 'Nuevo Xalapa', 91224, 1, 6);
INSERT INTO facultad
VALUES (28, 'Ingeniería Civil', 'Arco Sur', 'Nuevo Xalapa', 91224, 1, 6);
INSERT INTO facultad
VALUES (29, 'Ingeniería Mecánica y Eléctrica', 'Arco Sur', 'Nuevo Xalapa', 91224, 1, 6);
INSERT INTO facultad
VALUES (30, 'Ciencias Químicasa', 'Arco Sur', 'Nuevo Xalapa', 91224, 1, 6);
INSERT INTO facultad
VALUES (31, 'Química Farmacéutica Biológica', 'Arco Sur', 'Nuevo Xalapa', 91224, 1, 6);

select *
from facultad;

#Edificio Facultad 1   Edificio 1

INSERT INTO edificio
VALUES (1, 'FEI', 1);

INSERT INTO aula
VALUES (1, 'F101', 1);
INSERT INTO aula
VALUES (2, 'F102', 1);
INSERT INTO aula
VALUES (3, 'F103', 1);
INSERT INTO aula
VALUES (4, 'LABRED', 1);
INSERT INTO aula
VALUES (5, 'Aula TC', 1);
INSERT INTO aula
VALUES (6, 'LABIS', 1);
INSERT INTO aula
VALUES (7, 'Aula 401', 1);
INSERT INTO aula
VALUES (8, 'Aula 402', 1);
INSERT INTO aula
VALUES (9, 'Aula 403', 1);
INSERT INTO aula
VALUES (10, 'Aula 404', 1);

INSERT INTO aula
VALUES (68, '201', 1);
INSERT INTO aula
VALUES (69, '206', 1);
INSERT INTO aula
VALUES (70, '204', 1);


#Edificio Facultad 2   Edificio 2

INSERT INTO edificio
VALUES (2, 'ECONEX', 2);

INSERT INTO aula
VALUES (11, 'Aula 102', 2);
INSERT INTO aula
VALUES (12, 'Aula 103', 2);
INSERT INTO aula
VALUES (13, 'Aula 104', 2);
INSERT INTO aula
VALUES (14, 'Aula 105', 2);
INSERT INTO aula
VALUES (15, 'Aula 106', 2);
INSERT INTO aula
VALUES (16, 'Aula 107', 2);
INSERT INTO aula
VALUES (17, 'Aula 108', 2);
INSERT INTO aula
VALUES (18, 'Aula 110', 2);
INSERT INTO aula
VALUES (19, 'Aula 111', 2);
INSERT INTO aula
VALUES (20, 'Aula 112', 2);
INSERT INTO aula
VALUES (21, 'Aula 113', 2);
INSERT INTO aula
VALUES (22, 'Laboratorio de electronica', 2);
INSERT INTO aula
VALUES (23, 'Aula 114', 2);
INSERT INTO aula
VALUES (24, 'Aula 115', 2);
INSERT INTO aula
VALUES (25, 'Aula 116', 2);
INSERT INTO aula
VALUES (26, 'Aula 117', 2);
INSERT INTO aula
VALUES (27, 'Aula 118', 2);
INSERT INTO aula
VALUES (28, 'Laboratorio de Matematicas', 2);
INSERT INTO aula
VALUES (29, 'Centro de Computo 1', 2);
INSERT INTO aula
VALUES (30, 'Centro de Computo 2', 2);
INSERT INTO aula
VALUES (31, 'Centro de Computo 3', 2);


#Edificio Facultad 3   Edificio 3

INSERT INTO edificio
VALUES (3, 'Edificio A', 3);

INSERT INTO aula
VALUES (32, 'Aula-1', 3);
INSERT INTO aula
VALUES (33, 'Aula-2', 3);
INSERT INTO aula
VALUES (34, 'Aula-3', 3);
INSERT INTO aula
VALUES (35, 'Aula-4', 3);
INSERT INTO aula
VALUES (36, 'Aula-5', 3);
INSERT INTO aula
VALUES (37, 'Aula-6', 3);
INSERT INTO aula
VALUES (38, 'Aula-7', 3);
INSERT INTO aula
VALUES (39, 'Aula-8', 3);
INSERT INTO aula
VALUES (40, 'Aula-9', 3);
INSERT INTO aula
VALUES (41, 'Aula-10', 3);
INSERT INTO aula
VALUES (42, 'Aula-11', 3);
INSERT INTO aula
VALUES (43, 'Aula-12', 3);

#edificios de la facultad de artes plasticas
insert into edificio
values (4, 'Art', 4);
insert into edificio
values (5, 'ArtB', 4);

#aula edificio1
insert into aula
values (44, 'A1', 4);
insert into aula
values (45, 'A2', 4);
insert into aula
values (46, 'A3', 4);
insert into aula
values (47, 'A4', 4);
insert into aula
values (48, 'A5', 4);
insert into aula
values (49, 'A6', 4);
#aula edificio2
insert into aula
values (50, 'A1', 5);
insert into aula
values (51, 'A2', 5);
insert into aula
values (52, 'A3', 5);
insert into aula
values (53, 'A4', 5);
insert into aula
values (54, 'A5', 5);
insert into aula
values (55, 'A6', 5);

#edificios de la facultad de Danza

insert into edificio
values (6, 'Danza', 5);
insert into edificio
values (7, 'DanzaB', 5);

#aula edificio1
insert into aula
values (56, 'A1', 6);
insert into aula
values (57, 'A2', 6);
insert into aula
values (58, 'A3', 6);
insert into aula
values (59, 'A4', 6);
insert into aula
values (60, 'A5', 6);
insert into aula
values (61, 'A6', 6);
#aula edificio2
insert into aula
values (62, 'A1', 7);
insert into aula
values (63, 'A2', 7);
insert into aula
values (64, 'A3', 7);
insert into aula
values (65, 'A4', 7);
insert into aula
values (66, 'A5', 7);
insert into aula
values (67, 'A6', 7);


#Programas Educativos de Facultad 1

INSERT INTO programaEducativo
VALUES (1, 'Redes y Servicios de Computo', 1);

INSERT INTO programaEducativo
VALUES (2, 'Estadistica', 1);

INSERT INTO programaEducativo
VALUES (3, 'Ingenieria de Software', 1);

INSERT INTO programaEducativo
VALUES (4, 'Tecnologias Computacionales', 1);


#Programas Educativos de Facultad 2

INSERT INTO programaEducativo
VALUES (5, 'Economia', 2);
INSERT INTO programaEducativo
VALUES (6, 'Geografia', 2);


#Programa Educativo de Facultad 3

INSERT INTO programaEducativo
VALUES (7, 'Ciencias Politicas y Gestion Publica', 3);
INSERT INTO programaEducativo
VALUES (8, 'Ciencias Politicas y Gestion Publica', 3);


#Experiencias educativas de Programa Educativo 1   Redes y Servicios de Computo

#idEE, nombre, creditos, foreign key (programaEduactivo)
INSERT INTO ee
VALUES (1, 'Arquitectura de Dispositivos de Red', 8, 1);
INSERT INTO ee
VALUES (2, 'Estructura de Datos', 7, 1);
INSERT INTO ee
VALUES (3, 'Fundamentos de Matematicas', 9, 1);
INSERT INTO ee
VALUES (4, 'Base de Datos', 8, 1);
INSERT INTO ee
VALUES (5, 'Introduccion a la Programacion', 9, 1);
INSERT INTO ee
VALUES (6, 'Programacion de Sistemas', 8, 1);
INSERT INTO ee
VALUES (7, 'Metodologia de la investigacion', 7, 1);
INSERT INTO ee
VALUES (8, 'Computacion Basica', 8, 1);
INSERT INTO ee
VALUES (9, 'Redes', 9, 1);
INSERT INTO ee
VALUES (10, 'Programacion', 8, 1);
INSERT INTO ee
VALUES (11, 'Habilidades del Pensamiento Critico y Creativoo', 9, 1);
INSERT INTO ee
VALUES (12, 'Administracion de Servidores', 7, 1);
INSERT INTO ee
VALUES (13, 'Analisis de Protocolos', 6, 1);
INSERT INTO ee
VALUES (14, 'Servicio Social', 8, 1);
INSERT INTO ee
VALUES (15, 'Enrutamiento Avanzado', 7, 1);
INSERT INTO ee
VALUES (16, 'Etica y Normatividad', 8, 1);
INSERT INTO ee
VALUES (17, 'Sistemas Operativos Aplicados', 8, 1);
INSERT INTO ee
VALUES (18, 'Administracion de Base de Datos', 8, 1);
INSERT INTO ee
VALUES (19, 'Desarrollo de Sistemas Web', 8, 1);
INSERT INTO ee
VALUES (20, 'Optativa 1 Pruebas de Penetracion', 8, 1);
INSERT INTO ee
VALUES (21, 'Optativa 2 Cibercrimen y Herramientas Digitales Forenses', 8, 1);
INSERT INTO ee
VALUES (22, 'Administracion de Proyectos de Red', 8, 1);
INSERT INTO ee
VALUES (23, 'Programacion en la Administracion de Redes', 8, 1);
INSERT INTO ee
VALUES (24, 'Experiencia Recepcional', 8, 1);
INSERT INTO ee
VALUES (25, 'Practica de Redes', 8, 1);


#Experiencias educativas de Programa Educativo 2   Estadistica

INSERT INTO ee
VALUES (26, 'Calculo Aplicado a la Estadistica', 6, 2);
INSERT INTO ee
VALUES (27, 'Estadistica Descriptiva y Exploratoria', 7, 2);
INSERT INTO ee
VALUES (28, 'Estadistica Multivariada', 6, 2);
INSERT INTO ee
VALUES (29, 'Programacion Estadistica', 9, 2);
INSERT INTO ee
VALUES (30, 'Probabilidad 1', 8, 2);


#Experiencias educativas de Programa Educativo 3   Ingenieria de Software

INSERT INTO ee
VALUES (31, 'Programacion', 8, 3);
INSERT INTO ee
VALUES (32, 'Paradigmas de Programacion', 8, 3);
INSERT INTO ee
VALUES (33, 'Principios de Diseño de Software', 8, 3);
INSERT INTO ee
VALUES (34, 'Requerimientos de Software', 8, 3);
INSERT INTO ee
VALUES (35, 'Desarrollo de Aplicaciones', 8, 3);


#Experiencias educativas de Programa Educativo 4   Tecnologias Computacionales

INSERT INTO ee
VALUES (36, 'Tecnologias de Informacion para la Innovacion', 7, 4);
INSERT INTO ee
VALUES (37, 'Organizacion de Computadoras', 8, 4);
INSERT INTO ee
VALUES (38, 'Interaccion Humano Computadora', 6, 4);
INSERT INTO ee
VALUES (39, 'Integracion de Soluciones', 8, 4);
INSERT INTO ee
VALUES (40, 'Optativa Interfaces de Usuario Avanzadas', 9, 4);


#Experiencias educativas de Programa Educativo 5   Economia

INSERT INTO ee
VALUES (41, 'Introduccion a la Economia', 6, 5);
INSERT INTO ee
VALUES (42, 'Historia del Pensamiento Economico', 8, 5);
INSERT INTO ee
VALUES (43, 'MicroEconomia', 7, 5);
INSERT INTO ee
VALUES (44, 'MacroEconomia', 8, 5);
INSERT INTO ee
VALUES (45, 'Economia Mexicana', 9, 5);


#Experiencias educativas de Programa Educativo 6   Geografia

INSERT INTO ee
VALUES (46, 'Fundamentos de Percepcion Remota', 6, 6);
INSERT INTO ee
VALUES (47, 'Introduccion a la Ciencia Geografia', 7, 6);
INSERT INTO ee
VALUES (48, 'Cartografia', 8, 6);
INSERT INTO ee
VALUES (49, 'Geomorfologia', 8, 6);
INSERT INTO ee
VALUES (50, 'Geografia de la Atmosfera y del Clima', 9, 6);

#Academicos de Facultad 1

INSERT INTO academico
VALUES (1, 'Martha', 'Elizabet', 'Dominguez', 'Barcenas', 'eldominguez@uv.mx');
INSERT INTO academico
VALUES (2, 'Victor', 'Manuel', 'Tlapa', 'Carrera', 'victomtc@uv.mx');
INSERT INTO academico (matricula, primerNombre, apellidoPat, apellidoMat, correo)
VALUES (3, 'Lorena', 'Alonso', 'Ramirez', 'lalonso@uv.mx');
INSERT INTO academico
VALUES (4, 'Carlos', 'Alberto', 'Ochoa', 'Rivera', 'cochoa@uv.mx');
INSERT INTO academico (matricula, primerNombre, apellidoPat, apellidoMat, correo)
VALUES (5, 'Aquiles', 'Orduña', 'Aquiles', 'aorduna@uv.mx');
INSERT INTO academico (matricula, primerNombre, apellidoPat, apellidoMat, correo)
VALUES (6, 'Angelica', 'Perez', 'Hernandez', 'angpehe@uv.mx');
INSERT INTO academico
VALUES (7, 'Maria', 'Silva', 'Garcia ', 'Ramirez', 'mariasgr@uv.mx');
INSERT INTO academico
VALUES (8, 'Maria', 'Dolores', 'Vargas ', 'Cerdan', 'mariadvc@uv.mx');
INSERT INTO academico
VALUES (9, 'Luis', 'Gerardo', 'Montané ', 'Jimenez', 'luisgmj@uv.mx');
INSERT INTO academico (matricula, primerNombre, apellidoPat, apellidoMat, correo)
VALUES (10, 'Gerardo', 'Contreras', 'Vega', 'gerardocv@uv.mx');
INSERT INTO academico
VALUES (11, 'Hector', 'Xavier', 'Limon', 'Riaño', 'hectxlr@uv.mx');
INSERT INTO academico
VALUES (12, 'Martha', 'Elizabet', 'Dominguez', 'Barcenas', 'eldominguez@uv.mx');
INSERT INTO academico
VALUES (13, 'Juan', 'Carlos', 'Perez', 'Arriaga', 'juaperez@uv.mx');
INSERT INTO academico
VALUES (14, 'Alberto', 'Jair', 'Cruz', 'Landa', 'albecruz@uv.mx');
INSERT INTO academico
VALUES (15, 'Juan', 'Luis', 'Lopez', 'Herrer', 'juanlulh@uv.mx');
INSERT INTO academico
VALUES (16, 'Luis', 'Jacobo', 'Perez', 'Guerrero', 'albecruz@uv.mx');
INSERT INTO academico
VALUES (17, 'Juan', 'Manuel', 'Gutierrez', 'Mendez', 'juangutierrez@uv.mx');
INSERT INTO academico (matricula, primerNombre, apellidoPat, apellidoMat, correo)
VALUES (18, 'William', 'Zarate', 'Navarro', 'wzarate@uv.mx');
INSERT INTO academico
VALUES (19, 'Itzel', 'Alessandra', 'Reyes', 'Flores', 'itreyes@uv.mx');
INSERT INTO academico (matricula, primerNombre, apellidoPat, apellidoMat, correo)
VALUES (20, 'Rodolfo', 'Baruch', 'Maldonado', 'ridobm@uv.mx');
INSERT INTO academico (matricula, primerNombre, apellidoPat, apellidoMat, correo)
VALUES (21, 'Lorena', 'Lopez', 'Lozada', 'lorenaloz@uv.mx');
INSERT INTO academico
VALUES (22, 'Maria', 'De Los Angeles', 'Arenas', 'Valdes', 'mariaava@uv.mx');
INSERT INTO academico
VALUES (23, 'Urbano', 'Francisco', 'Ortega', 'Rivera', 'urbanoforivera@uv.mx');

###agregados el martes 6
INSERT INTO academico
VALUES (24, 'Lizbeth', 'Alejandra', 'Hernandez', 'Gonzalez', 'lizahg@uv.mx');
INSERT INTO academico (matricula, primerNombre, apellidoPat, apellidoMat, correo)
VALUES (25, 'Saul', 'Dominguez', 'Isidro', 'sauldis@uv.mx');
INSERT INTO academico (matricula, primerNombre, apellidoPat, apellidoMat, correo)
VALUES (26, 'Aureliano', 'Aguilar', 'Bonilla', 'aurelianobo@uv.mx');
INSERT INTO academico
VALUES (27, 'Itzel', 'Alessandra', 'Reyes', 'Flores', 'alerf@uv.mx');
INSERT INTO academico
VALUES (28, 'Olga', 'Regina', 'Rosas', 'Tolentino', 'olgarrt@uv.mx');
INSERT INTO academico
VALUES (29, 'Angel', 'Juan', 'Sanchez', 'Garcia', 'angeljsg@uv.mx');
INSERT INTO academico
VALUES (30, 'Maria', 'de Lourdes', 'Watty', 'Urquidi', 'mariawu@uv.mx');
INSERT INTO academico
VALUES (31, 'Ana', 'Luz', 'Polo', 'Estrella', 'analpe@uv.mx');
INSERT INTO academico
VALUES (32, 'Juan', 'Luis', 'Lopez', 'Herrera', 'juanllh@uv.mx');
INSERT INTO academico
VALUES (33, 'Pablo', 'Israel', 'Guzman', 'Martinez', 'pabloigm@uv.mx');
INSERT INTO academico (matricula, primerNombre, apellidoPat, apellidoMat, correo)
VALUES (34, 'Maribel', 'Carmona', 'Garcia', 'maribelcg@uv.mx');
INSERT INTO academico (matricula, primerNombre, apellidoPat, apellidoMat, correo)
VALUES (35, 'Javier', 'Sanchez', 'Acosta', 'javsanchez@uv.mx');
INSERT INTO academico
VALUES (36, 'Maria', 'Karen', 'Cortes', 'Verdin', 'mariakcv@uv.mx');
INSERT INTO academico (matricula, primerNombre, apellidoPat, apellidoMat, correo)
VALUES (37, 'Carlos', 'Garcia', 'Trujillo', 'carlgt@uv.mx');
INSERT INTO academico (matricula, primerNombre, apellidoPat, apellidoMat, correo)
VALUES (38, 'Minerva', 'Reyes', 'Felix', 'minervarf@uv.mx');
INSERT INTO academico
VALUES (39, 'Jose', 'Fabian', 'Muñoz', 'Portilla', 'josefmp@uv.mx');
INSERT INTO academico
VALUES (40, 'Mario', 'Miguel', 'Alonso', 'Lopez', 'mariomlop@uv.mx');
INSERT INTO academico (matricula, primerNombre, apellidoPat, apellidoMat, correo)
VALUES (41, 'Miguel', 'Alonso', 'Lopez', 'mariomlop@uv.mx');
###
INSERT INTO academico (matricula, primerNombre, apellidoPat, apellidoMat, correo)
VALUES (42, 'Dolores', 'Mayo', 'Lara', 'doloresml@uv.mx');
INSERT INTO academico (matricula, primerNombre, apellidoPat, apellidoMat, correo)
VALUES (43, 'Artemio', 'Calin', 'Mapel', 'artemiocm@uv.mx');
INSERT INTO academico (matricula, primerNombre, apellidoPat, apellidoMat, correo)
VALUES (44, 'Enrique', 'Cruz', 'Hernandez', 'enriquech@uv.mx');



#Seccion Programa Educativo 1 Redes
#(NRC, periodoInicio, periodoFin, ee_id, matricula_academico)

#bloque 1 seccion 1
INSERT INTO seccion
VALUES (13434, '2023-08-21', '2023-12-08', 1, 1);
INSERT INTO seccion
VALUES (14451, '2023-08-21', '2023-12-08', 3, 2);
INSERT INTO seccion
VALUES (13460, '2023-08-21', '2023-12-08', 5, 18);
#bloque 3 seccion 1
INSERT INTO seccion
VALUES (75723, '2023-08-21', '2023-12-08', 4, 3);
INSERT INTO seccion
VALUES (13468, '2023-08-21', '2023-12-08', 2, 4);
INSERT INTO seccion
VALUES (75732, '2023-08-21', '2023-12-08', 7, 5);
INSERT INTO seccion
VALUES (75720, '2023-08-21', '2023-12-08', 6, 2);
INSERT INTO seccion
VALUES (75717, '2023-08-21', '2023-12-08', 9, 6);
INSERT INTO seccion
VALUES (76756, '2023-08-21', '2023-12-08', 8, 7);
INSERT INTO seccion
VALUES (95821, '2023-08-21', '2023-12-08', 10, 19);
INSERT INTO seccion
VALUES (98993, '2023-08-21', '2023-12-08', 11, 20);
#bloque 3 seccion 2
INSERT INTO seccion
VALUES (75724, '2023-08-21', '2023-12-08', 4, 8);
INSERT INTO seccion
VALUES (75731, '2023-08-21', '2023-12-08', 2, 9);
INSERT INTO seccion
VALUES (75733, '2023-08-21', '2023-12-08', 7, 21);
INSERT INTO seccion
VALUES (75721, '2023-08-21', '2023-12-08', 6, 22);
INSERT INTO seccion
VALUES (75718, '2023-08-21', '2023-12-08', 9, 4);
INSERT INTO seccion
VALUES (76733, '2023-08-21', '2023-12-08', 8, 7);
#bloque 3 seccion 3
INSERT INTO seccion
VALUES (95897, '2023-08-21', '2023-12-08', 5, 18);
#bloque 5 seccion 1
INSERT INTO seccion
VALUES (80693, '2023-08-21', '2023-12-08', 12, 10);
INSERT INTO seccion
VALUES (80695, '2023-08-21', '2023-12-08', 13, 6);
INSERT INTO seccion
VALUES (80697, '2023-08-21', '2023-12-08', 15, 4);
INSERT INTO seccion
VALUES (80700, '2023-08-21', '2023-12-08', 16, 16);
INSERT INTO seccion
VALUES (80705, '2023-08-21', '2023-12-08', 23, 11);
INSERT INTO seccion
VALUES (80707, '2023-08-21', '2023-12-08', 17, 12);
INSERT INTO seccion
VALUES (19666, '2023-08-21', '2023-12-08', 18, 13);
INSERT INTO seccion
VALUES (19667, '2023-08-21', '2023-12-08', 18, 13);
#bloque 5 seccion 2
INSERT INTO seccion
VALUES (83555, '2023-08-21', '2023-12-08', 12, 14);
INSERT INTO seccion
VALUES (83557, '2023-08-21', '2023-12-08', 13, 15);
INSERT INTO seccion
VALUES (83558, '2023-08-21', '2023-12-08', 15, 14);
INSERT INTO seccion
VALUES (83559, '2023-08-21', '2023-12-08', 16, 16);
INSERT INTO seccion
VALUES (83561, '2023-08-21', '2023-12-08', 23, 15);
INSERT INTO seccion
VALUES (83562, '2023-08-21', '2023-12-08', 17, 15);
#bloque 7 seccion 1
INSERT INTO seccion
VALUES (83565, '2023-08-21', '2023-12-08', 25, 14);
INSERT INTO seccion
VALUES (83566, '2023-08-21', '2023-12-08', 22, 17);
INSERT INTO seccion
VALUES (83567, '2023-08-21', '2023-12-08', 19, 11);
INSERT INTO seccion
VALUES (95922, '2023-08-21', '2023-12-08', 20, 10);
#bloque 7 seccion 2
INSERT INTO seccion
VALUES (87500, '2023-08-21', '2023-12-08', 25, 12);
INSERT INTO seccion
VALUES (87503, '2023-08-21', '2023-12-08', 22, 17);
INSERT INTO seccion
VALUES (87504, '2023-08-21', '2023-12-08', 19, 18);
INSERT INTO seccion
VALUES (95907, '2023-08-21', '2023-12-08', 21, 23);
#bloque 9 seccion 1
INSERT INTO seccion
VALUES (87507, '2023-08-21', '2023-12-08', 24, 8);
INSERT INTO seccion
VALUES (87508, '2023-08-21', '2023-12-08', 14, 14);
#bloque 9 seccion 2
INSERT INTO seccion
VALUES (91570, '2023-08-21', '2023-12-08', 24, 11);
### FIN DE LO QUE HIZO JESSICA


###SECCION###agregados el martes 6
#programa educativo 3 is
INSERT INTO seccion
VALUES (75778, '2023-08-21', '2023-12-08', 31, 27);
INSERT INTO seccion
VALUES (80607, '2023-08-21', '2023-12-08', 32, 30);
INSERT INTO seccion
VALUES (80610, '2023-08-21', '2023-12-08', 33, 36);
INSERT INTO seccion
VALUES (75635, '2023-08-21', '2023-12-08', 34, 31);
INSERT INTO seccion
VALUES (83501, '2023-08-21', '2023-12-08', 35, 37);
#estadistica
INSERT INTO seccion
VALUES (85506, '2023-08-21', '2023-12-08', 26, 38);
INSERT INTO seccion
VALUES (85508, '2023-08-21', '2023-12-08', 27, 39);
INSERT INTO seccion
VALUES (87228, '2023-08-21', '2023-12-08', 29, 40);
INSERT INTO seccion
VALUES (87235, '2023-08-21', '2023-12-08', 30, 41);
INSERT INTO seccion
VALUES (23868, '2023-08-21', '2023-12-08', 28, 26);
#tecnologias comp
INSERT INTO seccion
VALUES (81891, '2023-08-21', '2023-12-08', 36, 24);
INSERT INTO seccion
VALUES (75651, '2023-08-21', '2023-12-08', 37, 25);
INSERT INTO seccion
VALUES (80637, '2023-08-21', '2023-12-08', 38, 26);
INSERT INTO seccion
VALUES (83570, '2023-08-21', '2023-12-08', 39, 28);
INSERT INTO seccion
VALUES (83574, '2023-08-21', '2023-12-08', 40, 27);
#economia#
INSERT INTO seccion
VALUES (85527, '2023-08-21', '2023-12-08', 41, 42);
INSERT INTO seccion
VALUES (85532, '2023-08-21', '2023-12-08', 42, 43);
INSERT INTO seccion
VALUES (87359, '2023-08-21', '2023-12-08', 43, 42);
INSERT INTO seccion
VALUES (87752, '2023-08-21', '2023-12-08', 44, 44);
INSERT INTO seccion
VALUES (92679, '2023-08-21', '2023-12-08', 45, 43);


#Inicio IMPARTE

#(idImparte, numNRC, aula_id, estado, matricula_academico, dia, horaInicio, horaFin)
INSERT INTO imparte
VALUES (6, 13434, 4, 1, 1, 'Martes', '17:00:00', '19:00:00');
INSERT INTO imparte
VALUES (7, 13434, 10, 1, 1, 'Jueves', '15:00:00', '17:00:00');

INSERT INTO imparte
VALUES (8, 14451, 15, 1, 2, 'Lunes', '13:00:00', '15:00:00');
INSERT INTO imparte
VALUES (9, 14451, 14, 1, 2, 'Miercoles', '14:00:00', '15:00:00');
INSERT INTO imparte
VALUES (10, 14451, 1, 1, 2, 'Viernes', '13:00:00', '15:00:00');

INSERT INTO imparte
VALUES (11, 13460, 5, 1, 18, 'Martes', '15:00:00', '17:00:00');
INSERT INTO imparte
VALUES (12, 13460, 1, 1, 18, 'Miercoles', '15:00:00', '17:00:00');
INSERT INTO imparte
VALUES (13, 13460, 5, 1, 18, 'Jueves', '17:00:00', '19:00:00');

INSERT INTO imparte
VALUES (14, 75723, 31, 1, 3, 'Martes', '11:00:00', '13:00:00');#ya
INSERT INTO imparte
VALUES (15, 75723, 14, 1, 3, 'Miercoles', '9:00:00', '11:00:00');
INSERT INTO imparte
VALUES (16, 75723, 11, 1, 3, 'Jueves', '9:00:00', '11:00:00');

INSERT INTO imparte
VALUES (17, 13468, 30, 1, 4, 'Lunes', '9:00:00', '11:00:00');
INSERT INTO imparte
VALUES (18, 13468, 1, 1, 4, 'Miercoles', '11:00:00', '13:00:00');
INSERT INTO imparte
VALUES (19, 13468, 22, 1, 4, 'Jueves', '11:00:00', '13:00:00');

INSERT INTO imparte
VALUES (20, 75732, 5, 1, 5, 'Lunes', '11:00:00', '13:00:00');
INSERT INTO imparte
VALUES (21, 75732, 14, 1, 5, 'Martes', '9:00:00', '11:00:00');
INSERT INTO imparte
VALUES (22, 75732, 14, 1, 5, 'Viernes', '11:00:00', '12:00:00');

INSERT INTO imparte
VALUES (23, 75720, 29, 1, 2, 'Martes', '7:00:00', '9:00:00');
INSERT INTO imparte
VALUES (24, 75720, 14, 1, 2, 'Miercoles', '7:00:00', '9:00:00');
INSERT INTO imparte
VALUES (25, 75720, 13, 1, 2, 'Martes', '8:00:00', '9:00:00');

INSERT INTO imparte
VALUES (26, 75717, 10, 1, 6, 'Lunes', '7:00:00', '9:00:00');
INSERT INTO imparte
VALUES (27, 75717, 10, 1, 6, 'Jueves', '7:00:00', '9:00:00');
INSERT INTO imparte
VALUES (28, 75717, 4, 1, 6, 'Viernes', '9:00:00', '11:00:00');

INSERT INTO imparte
VALUES (29, 76756, 30, 1, 7, 'Lunes', '13:00:00', '15:00:00');#ya
INSERT INTO imparte
VALUES (36, 76756, 30, 1, 7, 'Martes', '13:00:00', '15:00:00');#ya
INSERT INTO imparte
VALUES (37, 76756, 30, 1, 7, 'Viernes', '13:00:00', '15:00:00');#ya

INSERT INTO imparte
VALUES (38, 95821, 14, 1, 19, 'Lunes', '9:00:00', '11:00:00');
INSERT INTO imparte
VALUES (39, 95821, 31, 1, 19, 'Miercoles', '11:00:00', '13:00:00');
INSERT INTO imparte
VALUES (40, 95821, 14, 1, 19, 'Jueves', '11:00:00', '13:00:00');

INSERT INTO imparte
VALUES (41, 98993, 1, 1, 20, 'Miercoles', '13:00:00', '15:00:00');
INSERT INTO imparte
VALUES (42, 98993, 1, 1, 20, 'Jueves', '13:00:00', '15:00:00');

INSERT INTO imparte
VALUES (43, 75724, 31, 1, 8, 'Lunes', '15:00:00', '17:00:00');
INSERT INTO imparte
VALUES (44, 75724, 10, 1, 8, 'Martes', '15:00:00', '17:00:00');
INSERT INTO imparte
VALUES (45, 75724, 14, 1, 8, 'Jueves', '17:00:00', '19:00:00');#ya

INSERT INTO imparte
VALUES (46, 75731, 5, 1, 9, 'Miercoles', '15:00:00', '17:00:00');
INSERT INTO imparte
VALUES (47, 75731, 1, 1, 9, 'Jueves', '15:00:00', '17:00:00');
INSERT INTO imparte
VALUES (48, 75731, 10, 1, 9, 'Viernes', '15:00:00', '17:00:00');

INSERT INTO imparte
VALUES (49, 75733, 10, 1, 21, 'Lunes', '12:00:00', '13:00:00');
INSERT INTO imparte
VALUES (50, 75733, 11, 1, 21, 'Martes', '17:00:00', '19:00:00');
INSERT INTO imparte
VALUES (51, 75733, 12, 1, 21, 'Miercoles', '19:00:00', '21:00:00');

INSERT INTO imparte
VALUES (52, 75721, 31, 1, 22, 'Lunes', '17:00:00', '19:00:00');
INSERT INTO imparte
VALUES (53, 75721, 5, 1, 22, 'Miercoles', '17:00:00', '19:00:00');
INSERT INTO imparte
VALUES (54, 75721, 10, 1, 22, 'Viernes', '17:00:00', '18:00:00');

INSERT INTO imparte
VALUES (55, 75718, 10, 1, 4, 'Lunes', '13:00:00', '15:00:00');
INSERT INTO imparte
VALUES (56, 75718, 10, 1, 4, 'Martes', '13:00:00', '15:00:00');
INSERT INTO imparte
VALUES (57, 75718, 4, 1, 4, 'Miercoles', '13:00:00', '15:00:00');

INSERT INTO imparte
VALUES (58, 76733, 30, 1, 7, 'Martes', '19:00:00', '21:00:00');
INSERT INTO imparte
VALUES (59, 76733, 30, 1, 7, 'Jueves', '19:00:00', '21:00:00');
INSERT INTO imparte
VALUES (60, 76733, 30, 1, 7, 'Viernes', '19:00:00', '21:00:00');

INSERT INTO imparte
VALUES (61, 95897, 30, 1, 18, 'Lunes', '19:00:00', '21:00:00');
INSERT INTO imparte
VALUES (62, 95897, 31, 1, 18, 'Martes', '19:00:00', '21:00:00');
INSERT INTO imparte
VALUES (63, 95897, 31, 1, 18, 'Jueves', '19:00:00', '21:00:00');

INSERT INTO imparte
VALUES (64, 80693, 22, 1, 10, 'Martes', '7:00:00', '9:00:00');
INSERT INTO imparte
VALUES (65, 80693, 22, 1, 10, 'Jueves', '7:00:00', '10:00:00');

INSERT INTO imparte
VALUES (66, 80695, 1, 1, 6, 'Martes', '13:00:00', '15:00:00');
INSERT INTO imparte
VALUES (67, 80695, 10, 1, 6, 'Jueves', '13:00:00', '15:00:00');

INSERT INTO imparte
VALUES (68, 80697, 4, 1, 4, 'Martes', '9:00:00', '11:00:00');
INSERT INTO imparte
VALUES (69, 80697, 4, 1, 4, 'Miercoles', '9:00:00', '11:00:00');
INSERT INTO imparte
VALUES (70, 80697, 10, 1, 4, 'Viernes', '9:00:00', '11:00:00');

INSERT INTO imparte
VALUES (71, 80700, 1, 1, 16, 'Martes', '11:00:00', '13:00:00');
INSERT INTO imparte
VALUES (72, 80700, 1, 1, 16, 'Viernes', '11:00:00', '13:00:00');

INSERT INTO imparte
VALUES (73, 80705, 1, 1, 11, 'Lunes', '7:00:00', '10:00:00');
INSERT INTO imparte
VALUES (74, 80705, 29, 1, 11, 'Miercoles', '7:00:00', '9:00:00');

INSERT INTO imparte
VALUES (75, 80707, 4, 1, 12, 'Lunes', '10:00:00', '13:00:00');
INSERT INTO imparte
VALUES (76, 80707, 4, 1, 12, 'Jueves', '11:00:00', '13:00:00');

INSERT INTO imparte
VALUES (77, 19666, 4, 1, 13, 'Martes', '11:00:00', '13:00:00');
INSERT INTO imparte
VALUES (78, 19667, 4, 1, 13, 'Miercoles', '11:00:00', '14:00:00');

INSERT INTO imparte
VALUES (79, 83555, 4, 1, 14, 'Jueves', '14:00:00', '17:00:00');
INSERT INTO imparte
VALUES (80, 83555, 22, 1, 14, 'Viernes', '15:00:00', '17:00:00');

INSERT INTO imparte
VALUES (81, 83557, 22, 1, 15, 'Lunes', '15:00:00', '17:00:00');
INSERT INTO imparte
VALUES (82, 83557, 22, 1, 15, 'Martes', '18:00:00', '20:00:00');

INSERT INTO imparte
VALUES (83, 83558, 4, 1, 14, 'Lunes', '13:00:00', '15:00:00');
INSERT INTO imparte
VALUES (84, 83558, 4, 1, 14, 'Martes', '13:00:00', '15:00:00');
INSERT INTO imparte
VALUES (85, 83558, 10, 1, 14, 'Miercoles', '13:00:00', '15:00:00');

INSERT INTO imparte
VALUES (86, 83559, 1, 1, 16, 'Lunes', '17:00:00', '19:00:00');
INSERT INTO imparte
VALUES (87, 83559, 11, 1, 16, 'Miercoles', '17:00:00', '19:00:00');

INSERT INTO imparte
VALUES (88, 83561, 22, 1, 15, 'Martes', '15:00:00', '18:00:00');
INSERT INTO imparte
VALUES (89, 83561, 22, 1, 15, 'Miercoles', '19:00:00', '21:00:00');

INSERT INTO imparte
VALUES (90, 83562, 22, 1, 15, 'Miercoles', '15:00:00', '17:00:00');
INSERT INTO imparte
VALUES (91, 83562, 22, 1, 15, 'Viernes', '17:00:00', '20:00:00');

INSERT INTO imparte
VALUES (92, 91570, 4, 1, 11, 'Martes', '15:00:00', '17:00:00');
INSERT INTO imparte
VALUES (93, 91570, 10, 1, 11, 'Jueves', '17:00:00', '19:00:00');


####IMPARTE###agregados el 6
INSERT INTO imparte
VALUES (130, 75778, 31, 1, 27, 'Martes', '15:00:00', '17:00:00');
INSERT INTO imparte
VALUES (131, 75778, 3, 1, 27, 'Miercoles', '15:00:00', '17:00:00');
INSERT INTO imparte
VALUES (132, 75778, 9, 1, 27, 'Viernes', '13:00:00', '15:00:00');

INSERT INTO imparte
VALUES (133, 80607, 13, 1, 30, 'Martes', '15:00:00', '17:00:00');
INSERT INTO imparte
VALUES (134, 80607, 30, 1, 30, 'Miercoles', '15:00:00', '17:00:00');
INSERT INTO imparte
VALUES (135, 80607, 15, 1, 30, 'Viernes', '17:00:00', '19:00:00');

INSERT INTO imparte
VALUES (136, 80610, 14, 1, 36, 'Lunes', '17:00:00', '19:00:00');
INSERT INTO imparte
VALUES (137, 80610, 29, 1, 36, 'Martes', '17:00:00', '19:00:00');
INSERT INTO imparte
VALUES (138, 80610, 19, 1, 36, 'Jueves', '17:00:00', '19:00:00');

INSERT INTO imparte
VALUES (139, 75635, 9, 1, 31, 'Lunes', '15:00:00', '17:00:00');
INSERT INTO imparte
VALUES (140, 75635, 9, 1, 31, 'Martes', '17:00:00', '19:00:00');
INSERT INTO imparte
VALUES (141, 75635, 31, 1, 31, 'Jueves', '15:00:00', '17:00:00');

INSERT INTO imparte
VALUES (142, 83501, 20, 1, 37, 'Lunes', '17:00:00', '20:00:00');
INSERT INTO imparte
VALUES (143, 83501, 29, 1, 37, 'Miercoles', '17:00:00', '19:00:00');

#Estadistica
INSERT INTO imparte
VALUES (144, 85506, 25, 1, 38, 'Martes', '11:00:00', '13:00:00');
INSERT INTO imparte
VALUES (145, 85506, 23, 1, 38, 'Miercoles', '15:00:00', '17:00:00');
INSERT INTO imparte
VALUES (146, 85506, 25, 1, 38, 'Viernes', '9:00:00', '11:00:00');

INSERT INTO imparte
VALUES (147, 85508, 25, 1, 39, 'Lunes', '7:00:00', '9:00:00');
INSERT INTO imparte
VALUES (148, 85508, 25, 1, 39, 'Miercoles', '11:00:00', '13:00:00');
INSERT INTO imparte
VALUES (149, 85508, 25, 1, 39, 'Viernes', '7:00:00', '9:00:00');

INSERT INTO imparte
VALUES (150, 87228, 16, 1, 40, 'Martes', '13:00:00', '15:00:00');
INSERT INTO imparte
VALUES (151, 87228, 16, 1, 40, 'Miercoles', '13:00:00', '15:00:00');
INSERT INTO imparte
VALUES (152, 87228, 29, 1, 40, 'Viernes', '11:00:00', '13:00:00');

INSERT INTO imparte
VALUES (153, 87235, 19, 1, 41, 'Lunes', '9:00:00', '11:00:00');
INSERT INTO imparte
VALUES (154, 87235, 14, 1, 41, 'Martes', '11:00:00', '13:00:00');
INSERT INTO imparte
VALUES (155, 87235, 14, 1, 41, 'Miercoles', '11:00:00', '13:00:00');

INSERT INTO imparte
VALUES (156, 23868, 19, 1, 26, 'Lunes', '7:00:00', '9:00:00');
INSERT INTO imparte
VALUES (157, 23868, 15, 1, 26, 'Martes', '7:00:00', '9:00:00');
INSERT INTO imparte
VALUES (158, 23868, 2, 1, 26, 'Miercoles', '11:00:00', '13:00:00');


#Tecnologias comp
INSERT INTO imparte
VALUES (159, 83570, 2, 1, 28, 'Lunes', '9:00:00', '11:00:00');
INSERT INTO imparte
VALUES (160, 83570, 2, 1, 28, 'Martes', '7:00:00', '10:00:00');

INSERT INTO imparte
VALUES (161, 83574, 2, 1, 27, 'Jueves', '9:00:00', '11:00:00');
INSERT INTO imparte
VALUES (162, 83574, 2, 1, 27, 'Viernes', '7:00:00', '9:00:00');

INSERT INTO imparte
VALUES (163, 80637, 30, 1, 26, 'Martes', '11:00:00', '13:00:00');
INSERT INTO imparte
VALUES (164, 80637, 10, 1, 26, 'Miercoles', '9:00:00', '11:00:00');
INSERT INTO imparte
VALUES (165, 80637, 8, 1, 26, 'Viernes', '11:00:00', '13:00:00');

INSERT INTO imparte
VALUES (166, 75651, 20, 1, 25, 'Martes', '7:00:00', '9:00:00');
INSERT INTO imparte
VALUES (167, 75651, 12, 1, 25, 'Miercoles', '7:00:00', '9:00:00');
INSERT INTO imparte
VALUES (168, 75651, 19, 1, 25, 'Jueves', '9:00:00', '11:00:00');

INSERT INTO imparte
VALUES (169, 81891, 19, 1, 24, 'Lunes', '17:00:00', '19:00:00');
INSERT INTO imparte
VALUES (170, 81891, 20, 1, 24, 'Viernes', '14:00:00', '16:00:00');

#Economia
INSERT INTO imparte
VALUES (171, 85527, 68, 1, 42, 'Lunes', '11:00:00', '13:00:00');
INSERT INTO imparte
VALUES (172, 85527, 68, 1, 42, 'Miercoles', '11:00:00', '13:00:00');
INSERT INTO imparte
VALUES (173, 85527, 68, 1, 42, 'Viernes', '11:00:00', '13:00:00');

INSERT INTO imparte
VALUES (174, 85532, 68, 1, 43, 'Martes', '9:00:00', '11:00:00');
INSERT INTO imparte
VALUES (175, 85532, 68, 1, 43, 'Jueves', '9:00:00', '11:00:00');
INSERT INTO imparte
VALUES (176, 85532, 68, 1, 43, 'Viernes', '13:00:00', '15:00:00');

INSERT INTO imparte
VALUES (177, 87359, 69, 1, 42, 'Lunes', '11:00:00', '13:00:00');
INSERT INTO imparte
VALUES (178, 87359, 69, 1, 42, 'Miercoles', '11:00:00', '13:00:00');
INSERT INTO imparte
VALUES (179, 87359, 69, 1, 42, 'Viernes', '11:00:00', '13:00:00');

INSERT INTO imparte
VALUES (180, 87752, 68, 1, 44, 'Lunes', '9:00:00', '11:00:00');
INSERT INTO imparte
VALUES (181, 87752, 68, 1, 44, 'Miercoles', '9:00:00', '11:00:00');
INSERT INTO imparte
VALUES (182, 87752, 68, 1, 44, 'Viernes', '9:00:00', '11:00:00');

INSERT INTO imparte
VALUES (183, 92679, 70, 1, 43, 'Lunes', '9:00:00', '11:00:00');
INSERT INTO imparte
VALUES (184, 92679, 70, 1, 43, 'Miercoles', '9:00:00', '11:00:00');
INSERT INTO imparte
VALUES (185, 92679, 70, 1, 43, 'Viernes', '9:00:00', '11:00:00');

#FIN



####ALUMNOS ##agregados el martes 6
insert into alumno
values (21022784, 'Sofia', 'Fernanda', 'Martinez', 'Espejel', 'zS21022784@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 3);
insert into alumno
values (21022785, 'Leslie', 'Marlen', 'Perez', 'Arriaga', 'zS21022785@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 3);
insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (21022786, 'Martha', 'Fernandez', 'Martinez', 'zS21022786@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 3);


## CREAR ALMNOS
Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (20017701, 'Amanda', 'Cruz ', 'Flores', 'zS20017701@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (20017702, 'Alfonso', 'Ibarra', ' García', 'zS20017702@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (20017703, 'Amparo', 'Valencia', ' Jiménez', 'zS20017703@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (20017704, 'Alejandro', 'Zuñiga ', ' Espinoza', 'zS20017704@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (20017705, 'Arturo', 'Ortiz', ' Molina', 'zS20017705@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (20017706, 'Adolfo', 'Luna', ' Martínez', 'zS20017706@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (20017707, 'Angélica', 'Herrera', ' Vargas', 'zS200177507@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (20017708, 'Alicia', 'Martínez', 'Martínez', 'zS20017708@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (20017709, 'Amaya', 'Campos', ' Lara', 'zS20017709@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (20017710, 'Antonio', 'Maldonado', ' Trejo', 'zS20017710@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (20017711, 'Beatriz ', 'García', ' García', 'zS20017711@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (20017712, 'Blanca', 'Valdez', ' Castillo', 'zS20017712@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (20017713, 'Carlos', 'Salas', ' Cortéz', 'zS20017713@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (20017714, 'Claudia', 'Cruz', 'Cortés', 'zS20017714@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (20017715, 'Carmen', 'Rosas', ' Jiménez', 'zS20017715@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (20017716, 'César', 'Cabrera', ' Nava', 'z20017716@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (20017717, 'Cecilia', 'Fuentes', 'Ortega', 'zS20017717@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (20017718, 'Cristina', 'Vega', 'Soto', 'zS20017718@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (20017719, 'Daniel', 'Rivera', 'López', 'zS20017719@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (20017720, 'David', 'Santiago', ' Sandoval', 'zS20017720@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (20017721, 'Diana', 'Robles', ' Alvarado', 'zS20017721@estudiantes.uv.mx',
        '2281,bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (20017722, 'Eduardo', 'Guzmán', ' Guerrero', 'zS20017722@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (20017723, 'Enrique', 'Santos ', ' Ruíz', 'zS20017723@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (20017724, 'Elizabeth', 'Roja', ' Ramírez', 'zS20017724@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (20017725, 'Edgar', 'Cervantes', ' Fuentes', 'zS20017725@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (20017726, 'Erika', 'Huerta', ' Pea', 'zS20017726@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (20017727, 'Ernesto', 'Rangel', ' Guitérrez', 'zS20017727@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (20017728, 'Francisco', 'De la Cruz', ' Meza', 'zS20017728@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (20017729, 'Fernando', 'Delgado', ' Luna', 'zS20017729@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (20017730, 'Felipe', ' Nava', 'Torres', 'zS20017730@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (20017731, 'Francisca', 'Padillo', 'Castro', 'zS20017731@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (20017732, 'Guadalupe', 'Ortega', ' Ortega', 'zS20017732@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (20017733, 'Gloria', 'Vega', ' Valencia', 'zS20017733@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (20017734, 'Gerardo', 'Orozco ', ' Reyes', 'zS20017734@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (20017735, 'Gabriela', 'Herrera', ' Morena', 'zS20017735@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (20017736, 'Guillermo', 'Castro', ' Ayala', 'zS20017736@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (20017737, 'Gabriel', 'Lara', ' Guerrero', 'zS20017737@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (20017738, 'Gustavo', 'Flores', ' Orozco', 'zS20017738@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (20017739, 'Héctor', 'Zuñiga', ' León', 'zS20017739@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);


#E
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017740, 'Cathi', 'Minda', 'Emmanuele', 'Benninck', 'zS20017740@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017741, 'Carlo', 'Vallie', 'Ormistone', 'Pionter', 'zS20017741@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017742, 'Gare', 'Giraldo', 'Varvell', 'Haill', 'zS20017742@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017743, 'Loren', 'Clemmy', 'Fleischmann', 'Bontoft', 'zS20017743@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017744, 'Innis', 'Crista', 'Lukovic', 'Arnaldy', 'zS20017744@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017745, 'Bellanca', 'Virge', 'Plascott', 'Ledwich', 'zS20017745@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017746, 'Jack', 'Alexander', 'Evensden', 'Yaus', 'zS20017746@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017747, 'Van', 'Drud', 'Ledwidge', 'Spollen', 'zS20017747@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017748, 'Othella', 'Rhys', 'Corbould', 'Foad', 'zS20017748@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017749, 'Woody', 'Gianina', 'Passo', 'Aberkirder', 'zS20017749@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017750, 'Jasmin', 'Dimitri', 'Doogue', 'Elcom', 'zS20017750@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017751, 'Elnora', 'Cornie', 'Possek', 'Lerohan', 'zS20017751@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017752, 'Gearard', 'Brandi', 'Guyers', 'Dybbe', 'zS20017752@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017753, 'Letisha', 'Forrester', 'Burgill', 'Rudkin', 'zS20017753@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017754, 'Vonni', 'Elsey', 'Domel', 'Lissemore', 'zS20017754@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017755, 'Lombard', 'Dorian', 'Fannon', 'Caitlin', 'zS20017755@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017756, 'Abbe', 'Nigel', 'Clemot', 'Cattellion', 'zS20017756@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017757, 'Corilla', 'Derwin', 'Seppey', 'Layfield', 'zS20017757@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017758, 'Madlen', 'Marline', 'Kilgannon', 'Triswell', 'zS20017758@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017759, 'Avis', 'Germaine', 'Sheryne', 'Flecknoe', 'zS20017759@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017760, 'Filide', 'Lynnelle', 'Risbrough', 'Scrowton', 'zS20017760@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017761, 'Lyn', 'Carmelina', 'Grealey', 'Chatenet', 'zS20017761@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017762, 'Mayne', 'Archy', 'Mannooch', 'Elintune', 'zS20017762@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017763, 'Yovonnda', 'Ursuline', 'Penman', 'Yakubovics', 'zS20017763@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017764, 'Lemmy', 'Mordecai', 'Hanway', 'Phlipon', 'zS20017764@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017766, 'Tommie', 'Cinderella', 'Royston', 'Wrassell', 'zS20017766@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017767, 'Katee', 'Yanaton', 'McQuaker', 'Gunby', 'zS20017767@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017768, 'Yehudi', 'Flora', 'Snowball', 'Stanfield', 'zS20017768@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017769, 'Stanford', 'Peter', 'Hubble', 'Butterworth', 'zS20017769@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017770, 'Fulvia', 'Nola', 'Asple', 'Dennehy', 'zS20017770@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017771, 'Bing', 'Moira', 'Sadlier', 'Konzelmann', 'zS20017771@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017772, 'Florella', 'Garik', 'Mewrcik', 'Magill', 'zS20017772@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017773, 'Dido', 'Saul', 'Blockwell', 'Brunini', 'zS20017773@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017774, 'Aleen', 'Barbaraanne', 'Bellinger', 'Masterman', 'zS20017774@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017775, 'Fax', 'Emmey', 'Whimp', 'Edmondson', 'zS20017775@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017776, 'Terencio', 'Pete', 'Tracey', 'Ivkovic', 'zS20017776@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017777, 'Warde', 'Selma', 'Ambrogioli', 'Elsie', 'zS20017777@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017778, 'Freddie', 'Silvie', 'Pafford', 'Cristofor', 'zS20017778@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017779, 'Flori', 'Markos', 'Ovill', 'Frankcom', 'zS20017779@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017780, 'Jacquie', 'Doretta', 'Johnes', 'Batchelor', 'zS20017780@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017781, 'Esma', 'Elana', 'Twelves', 'Wallbanks', 'zS20017781@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017783, 'Anica', 'Milli', 'Spick', 'Ranscomb', 'zS20017783@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017784, 'Mata', 'Truman', 'MacKimmie', 'Epperson', 'zS20017784@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017785, 'Saw', 'Francis', 'Duplain', 'Bente', 'zS20017785@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017786, 'Natalie', 'Starr', 'Goldberg', 'Piwall', 'zS20017786@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017787, 'Innis', 'Marwin', 'Sanper', 'Colombier', 'zS20017787@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017788, 'Joaquin', 'Remus', 'Cleve', 'Oriel', 'zS20017788@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017789, 'Giacinta', 'Neel', 'Bullcock', 'Pighills', 'zS20017789@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017791, 'Abba', 'Kandace', 'Fassam', 'Calderon', 'zS20017791@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017792, 'Stafani', 'Genna', 'Dobrovolny', 'Novis', 'zS20017792@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017793, 'Hayley', 'Damon', 'Djorevic', 'Elsmore', 'zS20017793@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017794, 'Ardelis', 'Berenice', 'Halbert', 'Brien', 'zS20017794@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017795, 'Georgiana', 'Isabelita', 'Essam', 'Benson', 'zS20017795@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017797, 'Man', 'Sherlock', 'Goggin', 'Stoak', 'zS20017797@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017798, 'Merrill', 'Donall', 'Tipple', 'Leming', 'zS20017798@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017799, 'Rodd', 'Quinn', 'Renhard', 'Legh', 'zS20017799@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017801, 'Rafe', 'Car', 'Caddy', 'Belvin', 'zS20017801@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017802, 'Lane', 'Brucie', 'Cage', 'Medwell', 'zS20017802@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017803, 'Giulia', 'Janice', 'Springtorp', 'Balchin', 'zS20017803@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017804, 'Lonnie', 'Lyman', 'Pauletto', 'Sappson', 'zS20017804@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017805, 'Harwell', 'Abelard', 'Frotton', 'Daldan', 'zS20017805@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017806, 'Gal', 'Gabriele', 'Ahren', 'Adelman', 'zS20017806@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017807, 'Jeri', 'Emory', 'Eakle', 'Kelberman', 'zS20017807@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017808, 'Adah', 'Celestine', 'Danskine', 'Toopin', 'zS20017808@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017809, 'Mitchell', 'Florella', 'Feria', 'Chatenet', 'zS20017809@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017810, 'Kingsly', 'Jeane', 'Goodspeed', 'Lantaff', 'zS20017810@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017811, 'Svend', 'Joane', 'Boutellier', 'Tankard', 'zS20017811@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017812, 'Aura', 'Johnathan', 'Extill', 'Semrad', 'zS20017812@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017813, 'Brittne', 'Bliss', 'Crucetti', 'Eastway', 'zS20017813@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017814, 'Issi', 'Hashim', 'Cordero', 'Moors', 'zS20017814@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017815, 'Lindon', 'Karole', 'Copas', 'Nand', 'zS20017815@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017816, 'Kyla', 'Trevar', 'Casaccia', 'Siehard', 'zS20017816@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017817, 'Florette', 'Sansone', 'Havoc', 'Brolechan', 'zS20017817@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017818, 'Fairleigh', 'Neely', 'Gleadhall', 'Gollard', 'zS20017818@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017819, 'Hallie', 'Cleo', 'Griffey', 'Drane', 'zS20017819@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017820, 'Constancia', 'Jody', 'Hairon', 'Traite', 'zS20017820@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017821, 'Millard', 'Gasparo', 'Arzu', 'Axcel', 'zS20017821@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017822, 'Isaiah', 'Walther', 'Massie', 'Vasilkov', 'zS20017822@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017823, 'Piggy', 'Thom', 'Ashling', 'Mathiasen', 'zS20017823@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017824, 'Thaddus', 'Geralda', 'Probets', 'Fewings', 'zS20017824@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017825, 'Dianna', 'Ardisj', 'Grenkov', 'Noraway', 'zS20017825@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017826, 'Redford', 'Jenna', 'Falks', 'Softley', 'zS20017826@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017827, 'Temp', 'Cassi', 'Keedy', 'Firbanks', 'zS20017827@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017828, 'Daron', 'Riva', 'Kubach', 'Herity', 'zS20017828@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017829, 'Angeline', 'Lillis', 'Sproson', 'Gooderidge', 'zS20017829@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017830, 'Alexandre', 'Christian', 'Abbatucci', 'Marle', 'zS20017830@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017831, 'Cirillo', 'Sharla', 'Simeoli', 'Swinyard', 'zS20017831@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017832, 'Alanna', 'Lindsay', 'Fugere', 'Coste', 'zS20017832@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017833, 'Kimbra', 'Averell', 'Snoxill', 'Van der Velde', 'zS20017833@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017834, 'Patin', 'Elita', 'Micah', 'McElvine', 'zS20017/34@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017835, 'Alex', 'Matt', 'Petschelt', 'Hannibal', 'zS20017835@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017836, 'Adrian', 'Waylin', 'Reedy', 'Rustedge', 'zS20017836@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017837, 'Jessy', 'Starr', 'Hassall', 'Muschette', 'zS20017837@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017838, 'Lauritz', 'Ingunna', 'Keune', 'Coundley', 'zS20017838@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017839, 'Garwin', 'Arie', 'Henrique', 'Matchitt', 'zS20017839@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);


insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017840, 'Burr', 'Eleanore', 'Bridel', 'Tsarovic', 'zS20017840@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017841, 'Odey', 'Iosep', 'Risbrough', 'Galliford', 'zS200178401@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017842, 'Elmore', 'Emanuel', 'Ashelford', 'Youings', 'zS20017842@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017843, 'Wynny', 'Conrad', 'Landrick', 'Quilligan', 'zS20017843@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017844, 'Merwin', 'Gerta', 'Pauwel', 'Whitehall', 'zS20017844@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017845, 'Phylis', 'Scottie', 'Mackriell', 'Willishire', 'zS20017845@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017846, 'Cozmo', 'Waylin', 'Winthrop', 'Kingett', 'zS20017846@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017847, 'Dilan', 'Ranna', 'Poles', 'Selbie', 'zS20017847@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017848, 'Sarene', 'Liza', 'Woodier', 'King', 'zS20017848@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017849, 'Fidela', 'Latashia', 'Pavinese', 'Masser', 'zS20017849@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017850, 'Beulah', 'Granthem', 'Gregori', 'Aizikovich', 'zS20017850@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017851, 'Ernesto', 'Clem', 'Edden', 'Greatreax', 'zS20017851@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017852, 'Golda', 'Chase', 'Dutteridge', 'Traise', 'zS20017852@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017853, 'Emera', 'Amata', 'Huxster', 'Geale', 'zS20017853@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017854, 'Elianore', 'Amaleta', 'Coxen', 'FitzGeorge', 'zS20017854@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017855, 'Hailee', 'Giles', 'Nouch', 'Flitcroft', 'zS20017855@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017856, 'Cecelia', 'Giacomo', 'Dockrell', 'Travers', 'zS20017856@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017857, 'Mathew', 'Charyl', 'Iannuzzi', 'Henner', 'zS20017857@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017858, 'Lincoln', 'Keith', 'Trewman', 'Ashpole', 'zS20017858@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017859, 'Ulick', 'Jaclin', 'McCutcheon', 'Grumble', 'zS20017859@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017860, 'Bernadine', 'Cherie', 'Clarae', 'Mamwell', 'zS20017860@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017861, 'Lorenzo', 'Wilbur', 'Szymaniak', 'McGuinness', 'zS20017861@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017862, 'Zonnya', 'Nadeen', 'Edel', 'Margerison', 'zS20017862@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017863, 'Sara', 'Rafaello', 'Mulrenan', 'Oliveto', 'zS20017863@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017864, 'Janos', 'Philipa', 'Novak', 'Blasiak', 'zS20017864@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017865, 'Anny', 'Celestyn', 'Abbie', 'Face', 'zS20017865@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017866, 'Bjorn', 'Simon', 'Cullagh', 'Fadian', 'zS20017866@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017867, 'Noam', 'Daniella', 'Sidebottom', 'Beckhouse', 'zS20017867@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017868, 'Jedd', 'Lincoln', 'Petchell', 'Elfitt', 'zS20017868@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017869, 'Idalia', 'Abdul', 'Feaveer', 'Iianon', 'zS20017869@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017870, 'Kasper', 'Win', 'Paulucci', 'Pardoe', 'zS20017870@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017871, 'Carri', 'Lennie', 'Haresign', 'Pierson', 'zS20017871@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017872, 'Sherwood', 'Jeanne', 'Fosh', 'Kirsch', 'zS20017872@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017873, 'Goddart', 'Wallie', 'Perin', 'Mingay', 'zS200173@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017874, 'Alta', 'Jessika', 'McIsaac', 'Bradick', 'zS200874@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017875, 'Megan', 'Wallis', 'Melburg', 'Plane', 'zS20017875@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017876, 'Desdemona', 'Bentley', 'Kitchin', 'Mallaby', 'zS20017876@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017877, 'Martainn', 'Phyllida', 'Caiger', 'Greneham', 'zS20017877@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017878, 'Lemuel', 'Kelley', 'Stubbin', 'Applewhite', 'zS20017878@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017879, 'Shaughn', 'Marvin', 'Stepto', 'Grigorian', 'zS20017879@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017880, 'Pernell', 'Candide', 'Portman', 'Culshew', 'zS20017880@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017881, 'Jennette', 'Vito', 'Colvine', 'De Paepe', 'zS20017881@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017882, 'Gabe', 'Fulton', 'Seely', 'Timcke', 'zS20017882@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017883, 'Bastien', 'Martica', 'Davenhill', 'Blamphin', 'zS20017883@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017884, 'Rusty', 'Orville', 'Emsden', 'Howe', 'zS20017884@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017885, 'Morganne', 'Lin', 'Baumann', 'Ather', 'zS20017885@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017886, 'Jenni', 'Clarey', 'O''Day', 'Stainbridge', 'zS20017886@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017887, 'Myranda', 'Zacharie', 'Bertomeu', 'Filchagin', 'zS20017887@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017888, 'Aurie', 'Julietta', 'Beefon', 'Moreman', 'zS20017888@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017889, 'Tybie', 'Fleming', 'Lowings', 'Hickisson', 'zS20017889@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017890, 'Vinnie', 'Yankee', 'Kapelhoff', 'Cream', 'zS20017890@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017891, 'Shirl', 'Nelly', 'Woller', 'Rubinfajn', 'zS20017891@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017892, 'Rriocard', 'Honoria', 'Lavall', 'Cleghorn', 'zS20017892@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017893, 'Elmira', 'Emogene', 'Rivaland', 'Follit', 'zS20017893@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017894, 'Archaimbaud', 'Kahlil', 'Habron', 'Bradford', 'zS20017894@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017895, 'Emeline', 'Nicoli', 'Cloutt', 'Zanitti', 'zS20017895@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017896, 'Leeann', 'Hailey', 'Haws', 'Vicioso', 'zS20017896@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017897, 'Willy', 'Maddy', 'Carous', 'Bayfield', 'zS20017897@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017898, 'Sher', 'Emerson', 'Kivlin', 'Decent', 'zS20017898@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017899, 'Sherlock', 'Casey', 'Vick', 'Pattle', 'zS20017899@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017900, 'Gabbey', 'Thea', 'Richten', 'Boreham', 'zS20017900@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017901, 'Jacqueline', 'Patricia', 'Humberston', 'McClune', 'zS20017901@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017902, 'Vania', 'Sigfried', 'McGuiness', 'Olliar', 'zS20017902@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017903, 'Eb', 'Marjory', 'Duhig', 'Collacombe', 'zS20017903@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017904, 'Skyler', 'Douglass', 'Saipy', 'Deesly', 'zS20017904@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017905, 'Maressa', 'Wyatan', 'Capelow', 'Sayle', 'zS20017905@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017906, 'Lilyan', 'Modestine', 'Haine', 'Soots', 'zS20017906@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017907, 'Ash', 'Mamie', 'Spradbrow', 'Twohig', 'zS20017907@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017908, 'Shani', 'Gusella', 'Bricket', 'Brownell', 'zS20017908@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017909, 'Minor', 'Linell', 'Scourge', 'Kundt', 'zS20017909@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017910, 'Herbert', 'Phillie', 'Coytes', 'Rivers', 'zS20017910@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017911, 'Levon', 'Sherm', 'Howbrook', 'Leek', 'zS20017911@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017912, 'Mil', 'Tomasine', 'Galtone', 'Openshaw', 'zS20017912@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017913, 'Wyatan', 'Alysa', 'Roarty', 'Body', 'zS20017913@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017914, 'Osbert', 'Georgeanna', 'Brinklow', 'Stidston', 'zS20017914@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017915, 'Hector', 'Tully', 'Bridell', 'Simon', 'zS20017915@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017916, 'Vern', 'Lily', 'Grunson', 'Richardon', 'zS20017916@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017917, 'Kriste', 'Deena', 'Duly', 'Van Brug', 'zS20017917@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017918, 'Britney', 'Aharon', 'Croyser', 'Erangey', 'zS20017918@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017919, 'Fulvia', 'Norma', 'Dimock', 'Brunt', 'zS20017919@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017920, 'Robenia', 'Wernher', 'de Wilde', 'Holdin', 'zS20017920@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017921, 'Bob', 'Bobina', 'Spence', 'Brachell', 'zS20017921@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017922, 'Cosmo', 'Laird', 'Amos', 'Aubery', 'zS20017922@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017923, 'Jaime', 'Alane', 'Clawson', 'Killerby', 'zS20017923@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017924, 'Powell', 'Annora', 'Roff', 'Tittershill', 'zS20017924@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017925, 'Nobie', 'Florentia', 'Hubbart', 'Warlowe', 'zS20017925@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017926, 'Ellerey', 'Marybelle', 'Martinek', 'Jordeson', 'zS20017926@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017927, 'Alphard', 'Chelsea', 'Normadell', 'MacCallester', 'zS20017927@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017928, 'Emmit', 'Ramona', 'Gaythor', 'Toulamain', 'zS20017928@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017929, 'Rowena', 'Lark', 'Howatt', 'Trinbey', 'zS20017929@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017930, 'Allx', 'Roxie', 'Falla', 'Aizikovitz', 'zS20017930@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017931, 'Mischa', 'Rockey', 'Whaymand', 'Winsome', 'zS20017931@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017932, 'Sax', 'Joyann', 'Banat', 'Iacobucci', 'zS20017932@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017933, 'Loraine', 'Felicity', 'Cortez', 'Dockray', 'zS20017933@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017934, 'Zoe', 'Saudra', 'Edinborough', 'Cissen', 'zS20017934@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017935, 'Hilde', 'Pepita', 'Revelle', 'Egdale', 'zS20017935@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017936, 'Pete', 'Caressa', 'Franchioni', 'Righy', 'zS20017936@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017937, 'Arni', 'Lyman', 'Harrowell', 'Biswell', 'zS20017937@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017938, 'Cornelius', 'Chrisy', 'Thacke', 'Finlaison', 'zS20017938@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017939, 'Nesta', 'Farrel', 'Gilmour', 'Kerfut', 'zS20017939@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);


insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017940, 'Kirstyn', 'Gabie', 'Chattaway', 'Forrestall', 'zS20017940@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017941, 'Johna', 'Sam', 'Mantram', 'Wyldish', 'zS20017941@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017942, 'Kimmi', 'Sheila-kathryn', 'Fouch', 'Joselin', 'zS20017942@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017943, 'Skippie', 'Amery', 'Nequest', 'Hackley', 'zS20017943@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017944, 'Garvy', 'Cleon', 'Comizzoli', 'Fearnehough', 'zS20017944@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017945, 'Shirlee', 'Humphrey', 'Chang', 'Blakes', 'zS20017945@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017946, 'Marian', 'Rogers', 'Durham', 'MacLardie', 'zS20017946@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017947, 'Tally', 'Tallie', 'Slaght', 'Stallybrass', 'zS20017947@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017948, 'Rosamond', 'Zoe', 'Odger', 'Darwen', 'zS20017948@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017949, 'Anastassia', 'Carlotta', 'Tonepohl', 'MacFaell', 'zS20017949@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017950, 'Maggy', 'Emmet', 'Mellmoth', 'Van den Oord', 'zS20017950@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017951, 'Noach', 'Win', 'Curnock', 'Western', 'zS20017951@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017952, 'Danyette', 'Jeth', 'Batrick', 'Gowthorpe', 'zS20017952@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017953, 'Claudio', 'Georgie', 'Stone', 'Daniel', 'zS20017953@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017954, 'Tamara', 'Sigrid', 'Petrovykh', 'Basile', 'zS20017954@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017955, 'Daphna', 'Gal', 'Striker', 'Gerrit', 'zS20017955@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017956, 'Annamarie', 'Wynn', 'Fazakerley', 'Coverley', 'zS20017956@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017957, 'Gabriell', 'Ole', 'Westover', 'Denkin', 'zS20017957@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017958, 'Wainwright', 'Happy', 'Myrkus', 'Josephi', 'zS20017958@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017959, 'Bobette', 'Ajay', 'Godart', 'Ossipenko', 'zS20017959@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017960, 'John', 'Gard', 'Ector', 'Thorold', 'zS20017960@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017961, 'Odo', 'Currey', 'Dilloway', 'Stranaghan', 'zS20017961@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017962, 'Geralda', 'Laurice', 'McMillian', 'Soal', 'zS20017962@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017963, 'Florencia', 'Neron', 'Palay', 'Hancke', 'zS20017963@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017964, 'Erminie', 'Merrick', 'Tunney', 'Coite', 'zS20017964@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017965, 'Mandie', 'Ketty', 'Cabell', 'Capron', 'zS20017965@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017966, 'Judi', 'Patten', 'Swanbourne', 'Brosel', 'zS20017966@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017967, 'Margalit', 'Roger', 'Fenelon', 'Noddle', 'zS20017967@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017968, 'Rudyard', 'Corie', 'Shaylor', 'Sturgeon', 'zS20017968@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017969, 'Raychel', 'Coleman', 'Driscoll', 'Durn', 'zS20017969@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017970, 'Sherill', 'Matelda', 'Mebes', 'Strognell', 'zS20017970@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017971, 'Hali', 'Anatol', 'Prozillo', 'Bruntje', 'zS20017971@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017972, 'Jacobo', 'Theresa', 'Chalcot', 'Prosser', 'zS20017972@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017973, 'Margarethe', 'Giles', 'Norvell', 'Ambresin', 'zS20017973@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017974, 'Thaine', 'Ariella', 'Billie', 'Loveland', 'zS20017974@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017975, 'Brendon', 'Cora', 'Longden', 'Pottinger', 'zS20017975@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017976, 'Horace', 'Mia', 'Whiteley', 'Liveing', 'zS20017976@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017977, 'Napoleon', 'Becka', 'Insley', 'Walthall', 'zS20017977@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017978, 'Abbott', 'Gloriane', 'Speed', 'Tomley', 'zS20017978@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017979, 'Clyde', 'Candis', 'Wood', 'Willeman', 'zS20017979@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017980, 'Edie', 'Lexis', 'Szymczyk', 'Glasheen', 'zS20017980@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017981, 'Wanids', 'Quincey', 'Bunker', 'Thurner', 'zS20017981@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017982, 'Jehanna', 'Ilysa', 'Bickers', 'Fishley', 'zS20017982@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017983, 'Harper', 'Giraldo', 'Baigent', 'Celle', 'zS20017983@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017984, 'Laure', 'Alain', 'Pauls', 'Losseljong', 'zS20017984@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017985, 'Augustine', 'Davina', 'Bardell', 'Ardley', 'zS20017985@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017986, 'Toddy', 'Delphine', 'Biddlestone', 'Foux', 'zS20017986@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017987, 'Delia', 'Darius', 'Madison', 'Benneton', 'zS20017987@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017988, 'Markos', 'Bruce', 'Oels', 'Hammerman', 'zS20017988@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (20017989, 'Christiane', 'Zorana', 'Martellini', 'Kedwell', 'zS20017989@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);


##usuarios jessica
INSERT INTO alumno
VALUES (20017765, 'Liliana', 'Guadalupe', 'Garcia', 'Herrera', 'zs20017765@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 1);
INSERT INTO alumno
VALUES (21015946, 'Maria', 'Teresa', 'Juan', 'Reyes', 'zs21015946@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 1);
INSERT INTO alumno
VALUES (21015951, 'Maria', 'Fernanda', 'Landa', 'Arrieta', 'zs21015951@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 1);
INSERT INTO alumno
VALUES (20017782, 'Luis', 'Carlos', 'Luna', 'Delgado', 'zs20017782@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 1);
INSERT INTO alumno
VALUES (21021654, 'Carlos', 'Manuel', 'Ramirez', 'Sosa', 'zs21021654@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 1);
INSERT INTO alumno
VALUES (20017800, 'Jose', 'Alejandro', 'Ramirez', 'Zavaleta', 'zs20017800@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 1);
INSERT INTO alumno
VALUES (21015916, 'Daniel', 'Sebastian', 'Sanchez', 'Medina', 'zs21015916@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 1);
INSERT INTO alumno
VALUES (21015957, 'Oscar', 'Alexis', 'Palomino', 'Martinez', 'zs21015957@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 1);
INSERT INTO alumno
VALUES (21015980, 'Carlos', 'Alberto', 'Tamariz', 'Morales', 'zs21015980@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 1);

INSERT INTO alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
VALUES (21015956, 'Yoselin', 'Hernandez', 'Avila', 'zs21015956@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 1);
INSERT INTO alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
VALUES (21015965, 'Rene', 'Hernandez', 'Castillo', 'zs21015965@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 1);
INSERT INTO alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
VALUES (21015960, 'Daniel', 'Martinez', 'Ramirez', 'zs21015960@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 1);
INSERT INTO alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
VALUES (21015959, 'Jessica', 'Peña', 'Montero', 'zs21015959@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 1);
INSERT INTO alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
VALUES (22024136, 'Moises', 'Reyes', 'Lagunes', 'zs22024136@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 1);
INSERT INTO alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
VALUES (21015961, 'Eduardo', 'Mendez', 'Landa', 'zs21015961@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 1);
INSERT INTO alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
VALUES (20017790, 'Jonathan', 'Peña', 'Perez', 'zs20017790@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 1);
INSERT INTO alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
VALUES (21015978, 'Rodrigo', 'Dominguez', 'Jimenez', 'zs20017790@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 1);
INSERT INTO alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
VALUES (21015915, 'Edson', 'Castillo', 'Moreno', 'zs210159150@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 1);
INSERT INTO alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
VALUES (20017796, 'Daniel', 'Pozos', 'Hernandez', 'zs20017796@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 1);


##NUEVOS ALUMNOS
Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (23017701, 'Amanda', 'Cruz ', 'Flores', 'zS23017701@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (2307702, 'Alfonso', 'Ibarra', ' García', 'zS23017702@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (23017703, 'Amparo', 'Valencia', ' Jiménez', 'zS23017703@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (23017704, 'Alejandro', 'Zuñiga ', ' Espinoza', 'zS23017704@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (23017705, 'Arturo', 'Ortiz', ' Molina', 'zS23017705@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (23017706, 'Adolfo', 'Luna', ' Martínez', 'zS23017706@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (23017707, 'Angélica', 'Herrera', ' Vargas', 'zS230177507@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (23017708, 'Alicia', 'Martínez', 'Martínez', 'zS23017708@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (23017709, 'Amaya', 'Campos', ' Lara', 'zS23017709@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (23017710, 'Antonio', 'Maldonado', ' Trejo', 'zS23017710@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (23017711, 'Beatriz ', 'García', ' García', 'zS23017711@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (23017712, 'Blanca', 'Valdez', ' Castillo', 'zS23017712@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (23017713, 'Carlos', 'Salas', ' Cortéz', 'zS23017713@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (23017714, 'Claudia', 'Cruz', 'Cortés', 'zS23017714@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (23017715, 'Carmen', 'Rosas', ' Jiménez', 'zS23017715@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (23017716, 'César', 'Cabrera', ' Nava', 'z23017716@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (23017717, 'Cecilia', 'Fuentes', 'Ortega', 'zS23017717@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (23017718, 'Cristina', 'Vega', 'Soto', 'zS23017718@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (23017719, 'Daniel', 'Rivera', 'López', 'zS23017719@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (23017720, 'David', 'Santiago', ' Sandoval', 'zS23017720@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (23017721, 'Diana', 'Robles', ' Alvarado', 'zS23017721@estudiantes.uv.mx',
        '2281,bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (23017722, 'Eduardo', 'Guzmán', ' Guerrero', 'zS23017722@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (23017723, 'Enrique', 'Santos ', ' Ruíz', 'zS23017723@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (23017724, 'Elizabeth', 'Roja', ' Ramírez', 'zS23017724@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (23017725, 'Edgar', 'Cervantes', ' Fuentes', 'zS23017725@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (23017726, 'Erika', 'Huerta', ' Pea', 'zS23017726@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (23017727, 'Ernesto', 'Rangel', ' Guitérrez', 'zS23017727@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (23017728, 'Francisco', 'De la Cruz', ' Meza', 'zS23017728@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (23017729, 'Fernando', 'Delgado', ' Luna', 'zS23017729@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (23017730, 'Felipe', ' Nava', 'Torres', 'zS23017730@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (23017731, 'Francisca', 'Padillo', 'Castro', 'zS23017731@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (23017732, 'Guadalupe', 'Ortega', ' Ortega', 'zS23017732@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (23017733, 'Gloria', 'Vega', ' Valencia', 'zS23017733@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (23017734, 'Gerardo', 'Orozco ', ' Reyes', 'zS23017734@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (23017735, 'Gabriela', 'Herrera', ' Morena', 'zS23017735@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (23017736, 'Guillermo', 'Castro', ' Ayala', 'zS23017736@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (23017737, 'Gabriel', 'Lara', ' Guerrero', 'zS23017737@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (23017738, 'Gustavo', 'Flores', ' Orozco', 'zS23017738@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

Insert into alumno (matricula, primerNombre, apellidoPat, apellidoMat, email, clave, programaEduactivo_id)
values (23017739, 'Héctor', 'Zuñiga', ' León', 'zS23017739@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017740, 'Cathi', 'Minda', 'Emmanuele', 'Benninck', 'zS23017740@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017741, 'Carlo', 'Vallie', 'Ormistone', 'Pionter', 'zS23017741@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017742, 'Gare', 'Giraldo', 'Varvell', 'Haill', 'zS23017742@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017743, 'Loren', 'Clemmy', 'Fleischmann', 'Bontoft', 'zS23017743@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017744, 'Innis', 'Crista', 'Lukovic', 'Arnaldy', 'zS23017744@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017745, 'Bellanca', 'Virge', 'Plascott', 'Ledwich', 'zS23017745@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017746, 'Jack', 'Alexander', 'Evensden', 'Yaus', 'zS23017746@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017747, 'Van', 'Drud', 'Ledwidge', 'Spollen', 'zS23017747@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017748, 'Othella', 'Rhys', 'Corbould', 'Foad', 'zS23017748@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017749, 'Woody', 'Gianina', 'Passo', 'Aberkirder', 'zS23017749@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017750, 'Jasmin', 'Dimitri', 'Doogue', 'Elcom', 'zS23017750@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017751, 'Elnora', 'Cornie', 'Possek', 'Lerohan', 'zS23017751@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017752, 'Gearard', 'Brandi', 'Guyers', 'Dybbe', 'zS23017752@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017753, 'Letisha', 'Forrester', 'Burgill', 'Rudkin', 'zS23017753@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017754, 'Vonni', 'Elsey', 'Domel', 'Lissemore', 'zS23017754@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017755, 'Lombard', 'Dorian', 'Fannon', 'Caitlin', 'zS23017755@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017756, 'Abbe', 'Nigel', 'Clemot', 'Cattellion', 'zS23017756@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017757, 'Corilla', 'Derwin', 'Seppey', 'Layfield', 'zS23017757@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017758, 'Madlen', 'Marline', 'Kilgannon', 'Triswell', 'zS23017758@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017759, 'Avis', 'Germaine', 'Sheryne', 'Flecknoe', 'zS23017759@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017760, 'Filide', 'Lynnelle', 'Risbrough', 'Scrowton', 'zS23017760@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017761, 'Lyn', 'Carmelina', 'Grealey', 'Chatenet', 'zS23017761@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017762, 'Mayne', 'Archy', 'Mannooch', 'Elintune', 'zS23017762@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017763, 'Yovonnda', 'Ursuline', 'Penman', 'Yakubovics', 'zS23017763@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017764, 'Lemmy', 'Mordecai', 'Hanway', 'Phlipon', 'zS23017764@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017766, 'Tommie', 'Cinderella', 'Royston', 'Wrassell', 'zS23017766@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017767, 'Katee', 'Yanaton', 'McQuaker', 'Gunby', 'zS23017767@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017768, 'Yehudi', 'Flora', 'Snowball', 'Stanfield', 'zS23017768@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017769, 'Stanford', 'Peter', 'Hubble', 'Butterworth', 'zS23017769@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017770, 'Fulvia', 'Nola', 'Asple', 'Dennehy', 'zS23017770@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017771, 'Bing', 'Moira', 'Sadlier', 'Konzelmann', 'zS23017771@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017772, 'Florella', 'Garik', 'Mewrcik', 'Magill', 'zS23017772@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017773, 'Dido', 'Saul', 'Blockwell', 'Brunini', 'zS23017773@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017774, 'Aleen', 'Barbaraanne', 'Bellinger', 'Masterman', 'zS23017774@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017775, 'Fax', 'Emmey', 'Whimp', 'Edmondson', 'zS23017775@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017776, 'Terencio', 'Pete', 'Tracey', 'Ivkovic', 'zS23017776@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017777, 'Warde', 'Selma', 'Ambrogioli', 'Elsie', 'zS23017777@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017778, 'Freddie', 'Silvie', 'Pafford', 'Cristofor', 'zS23017778@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017779, 'Flori', 'Markos', 'Ovill', 'Frankcom', 'zS23017779@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017780, 'Jacquie', 'Doretta', 'Johnes', 'Batchelor', 'zS23017780@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017781, 'Esma', 'Elana', 'Twelves', 'Wallbanks', 'zS23017781@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017783, 'Anica', 'Milli', 'Spick', 'Ranscomb', 'zS23017783@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017784, 'Mata', 'Truman', 'MacKimmie', 'Epperson', 'zS23017784@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017785, 'Saw', 'Francis', 'Duplain', 'Bente', 'zS23017785@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017786, 'Natalie', 'Starr', 'Goldberg', 'Piwall', 'zS23017786@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017787, 'Innis', 'Marwin', 'Sanper', 'Colombier', 'zS23017787@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017788, 'Joaquin', 'Remus', 'Cleve', 'Oriel', 'zS23017788@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017789, 'Giacinta', 'Neel', 'Bullcock', 'Pighills', 'zS23017789@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017791, 'Abba', 'Kandace', 'Fassam', 'Calderon', 'zS23017791@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017792, 'Stafani', 'Genna', 'Dobrovolny', 'Novis', 'zS23017792@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017793, 'Hayley', 'Damon', 'Djorevic', 'Elsmore', 'zS23017793@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017794, 'Ardelis', 'Berenice', 'Halbert', 'Brien', 'zS23017794@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017795, 'Georgiana', 'Isabelita', 'Essam', 'Benson', 'zS23017795@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017797, 'Man', 'Sherlock', 'Goggin', 'Stoak', 'zS23017797@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017798, 'Merrill', 'Donall', 'Tipple', 'Leming', 'zS23017798@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017799, 'Rodd', 'Quinn', 'Renhard', 'Legh', 'zS23017799@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017801, 'Rafe', 'Car', 'Caddy', 'Belvin', 'zS23017801@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017802, 'Lane', 'Brucie', 'Cage', 'Medwell', 'zS23017802@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017803, 'Giulia', 'Janice', 'Springtorp', 'Balchin', 'zS23017803@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017804, 'Lonnie', 'Lyman', 'Pauletto', 'Sappson', 'zS23017804@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017805, 'Harwell', 'Abelard', 'Frotton', 'Daldan', 'zS23017805@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017806, 'Gal', 'Gabriele', 'Ahren', 'Adelman', 'zS23017806@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017807, 'Jeri', 'Emory', 'Eakle', 'Kelberman', 'zS23017807@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017808, 'Adah', 'Celestine', 'Danskine', 'Toopin', 'zS23017808@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017809, 'Mitchell', 'Florella', 'Feria', 'Chatenet', 'zS23017809@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017810, 'Kingsly', 'Jeane', 'Goodspeed', 'Lantaff', 'zS23017810@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017811, 'Svend', 'Joane', 'Boutellier', 'Tankard', 'zS23017811@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017812, 'Aura', 'Johnathan', 'Extill', 'Semrad', 'zS23017812@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017813, 'Brittne', 'Bliss', 'Crucetti', 'Eastway', 'zS23017813@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017814, 'Issi', 'Hashim', 'Cordero', 'Moors', 'zS23017814@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017815, 'Lindon', 'Karole', 'Copas', 'Nand', 'zS23017815@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017816, 'Kyla', 'Trevar', 'Casaccia', 'Siehard', 'zS23017816@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017817, 'Florette', 'Sansone', 'Havoc', 'Brolechan', 'zS23017817@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017818, 'Fairleigh', 'Neely', 'Gleadhall', 'Gollard', 'zS23017818@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017819, 'Hallie', 'Cleo', 'Griffey', 'Drane', 'zS23017819@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017820, 'Constancia', 'Jody', 'Hairon', 'Traite', 'zS23017820@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017821, 'Millard', 'Gasparo', 'Arzu', 'Axcel', 'zS23017821@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017822, 'Isaiah', 'Walther', 'Massie', 'Vasilkov', 'zS23017822@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017823, 'Piggy', 'Thom', 'Ashling', 'Mathiasen', 'zS23017823@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017824, 'Thaddus', 'Geralda', 'Probets', 'Fewings', 'zS23017824@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017825, 'Dianna', 'Ardisj', 'Grenkov', 'Noraway', 'zS23017825@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017826, 'Redford', 'Jenna', 'Falks', 'Softley', 'zS23017826@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017827, 'Temp', 'Cassi', 'Keedy', 'Firbanks', 'zS23017827@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017828, 'Daron', 'Riva', 'Kubach', 'Herity', 'zS23017828@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017829, 'Angeline', 'Lillis', 'Sproson', 'Gooderidge', 'zS23017829@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017830, 'Alexandre', 'Christian', 'Abbatucci', 'Marle', 'zS23017830@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017831, 'Cirillo', 'Sharla', 'Simeoli', 'Swinyard', 'zS23017831@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017832, 'Alanna', 'Lindsay', 'Fugere', 'Coste', 'zS23017832@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017833, 'Kimbra', 'Averell', 'Snoxill', 'Van der Velde', 'zS23017833@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017834, 'Patin', 'Elita', 'Micah', 'McElvine', 'zS23017834@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017835, 'Alex', 'Matt', 'Petschelt', 'Hannibal', 'zS23017835@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017836, 'Adrian', 'Waylin', 'Reedy', 'Rustedge', 'zS23017836@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017837, 'Jessy', 'Starr', 'Hassall', 'Muschette', 'zS23017837@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017838, 'Lauritz', 'Ingunna', 'Keune', 'Coundley', 'zS23017838@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017839, 'Garwin', 'Arie', 'Henrique', 'Matchitt', 'zS23017839@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017840, 'Burr', 'Eleanore', 'Bridel', 'Tsarovic', 'zS23017840@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017841, 'Odey', 'Iosep', 'Risbrough', 'Galliford', 'zS230178401@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017842, 'Elmore', 'Emanuel', 'Ashelford', 'Youings', 'zS23017842@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017843, 'Wynny', 'Conrad', 'Landrick', 'Quilligan', 'zS23017843@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017844, 'Merwin', 'Gerta', 'Pauwel', 'Whitehall', 'zS23017844@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017845, 'Phylis', 'Scottie', 'Mackriell', 'Willishire', 'zS23017845@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017846, 'Cozmo', 'Waylin', 'Winthrop', 'Kingett', 'zS23017846@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017847, 'Dilan', 'Ranna', 'Poles', 'Selbie', 'zS23017847@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017848, 'Sarene', 'Liza', 'Woodier', 'King', 'zS23017848@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017849, 'Fidela', 'Latashia', 'Pavinese', 'Masser', 'zS23017849@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017850, 'Beulah', 'Granthem', 'Gregori', 'Aizikovich', 'zS23017850@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017851, 'Ernesto', 'Clem', 'Edden', 'Greatreax', 'zS23017851@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017852, 'Golda', 'Chase', 'Dutteridge', 'Traise', 'zS23017852@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017853, 'Emera', 'Amata', 'Huxster', 'Geale', 'zS23017853@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017854, 'Elianore', 'Amaleta', 'Coxen', 'FitzGeorge', 'zS23017854@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017855, 'Hailee', 'Giles', 'Nouch', 'Flitcroft', 'zS23017855@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017856, 'Cecelia', 'Giacomo', 'Dockrell', 'Travers', 'zS23017856@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017857, 'Mathew', 'Charyl', 'Iannuzzi', 'Henner', 'zS23017857@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017858, 'Lincoln', 'Keith', 'Trewman', 'Ashpole', 'zS23017858@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017859, 'Ulick', 'Jaclin', 'McCutcheon', 'Grumble', 'zS23017859@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017860, 'Bernadine', 'Cherie', 'Clarae', 'Mamwell', 'zS23017860@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017861, 'Lorenzo', 'Wilbur', 'Szymaniak', 'McGuinness', 'zS23017861@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017862, 'Zonnya', 'Nadeen', 'Edel', 'Margerison', 'zS23017862@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017863, 'Sara', 'Rafaello', 'Mulrenan', 'Oliveto', 'zS23017863@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017864, 'Janos', 'Philipa', 'Novak', 'Blasiak', 'zS23017864@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017865, 'Anny', 'Celestyn', 'Abbie', 'Face', 'zS23017865@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017866, 'Bjorn', 'Simon', 'Cullagh', 'Fadian', 'zS23017866@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017867, 'Noam', 'Daniella', 'Sidebottom', 'Beckhouse', 'zS23017867@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017868, 'Jedd', 'Lincoln', 'Petchell', 'Elfitt', 'zS23017868@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017869, 'Idalia', 'Abdul', 'Feaveer', 'Iianon', 'zS23017869@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017870, 'Kasper', 'Win', 'Paulucci', 'Pardoe', 'zS23017870@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017871, 'Carri', 'Lennie', 'Haresign', 'Pierson', 'zS23017871@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017872, 'Sherwood', 'Jeanne', 'Fosh', 'Kirsch', 'zS23017872@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017873, 'Goddart', 'Wallie', 'Perin', 'Mingay', 'zS230173@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017874, 'Alta', 'Jessika', 'McIsaac', 'Bradick', 'zS230874@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017875, 'Megan', 'Wallis', 'Melburg', 'Plane', 'zS23017875@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017876, 'Desdemona', 'Bentley', 'Kitchin', 'Mallaby', 'zS23017876@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017877, 'Martainn', 'Phyllida', 'Caiger', 'Greneham', 'zS23017877@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017878, 'Lemuel', 'Kelley', 'Stubbin', 'Applewhite', 'zS23017878@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017879, 'Shaughn', 'Marvin', 'Stepto', 'Grigorian', 'zS23017879@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017880, 'Pernell', 'Candide', 'Portman', 'Culshew', 'zS23017880@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017881, 'Jennette', 'Vito', 'Colvine', 'De Paepe', 'zS23017881@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017882, 'Gabe', 'Fulton', 'Seely', 'Timcke', 'zS23017882@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017883, 'Bastien', 'Martica', 'Davenhill', 'Blamphin', 'zS23017883@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017884, 'Rusty', 'Orville', 'Emsden', 'Howe', 'zS23017884@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017885, 'Morganne', 'Lin', 'Baumann', 'Ather', 'zS23017885@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017886, 'Jenni', 'Clarey', 'O''Day', 'Stainbridge', 'zS23017886@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017887, 'Myranda', 'Zacharie', 'Bertomeu', 'Filchagin', 'zS23017887@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017888, 'Aurie', 'Julietta', 'Beefon', 'Moreman', 'zS23017888@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017889, 'Tybie', 'Fleming', 'Lowings', 'Hickisson', 'zS23017889@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017890, 'Vinnie', 'Yankee', 'Kapelhoff', 'Cream', 'zS23017890@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017891, 'Shirl', 'Nelly', 'Woller', 'Rubinfajn', 'zS23017891@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017892, 'Rriocard', 'Honoria', 'Lavall', 'Cleghorn', 'zS23017892@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017893, 'Elmira', 'Emogene', 'Rivaland', 'Follit', 'zS23017893@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017894, 'Archaimbaud', 'Kahlil', 'Habron', 'Bradford', 'zS23017894@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017895, 'Emeline', 'Nicoli', 'Cloutt', 'Zanitti', 'zS23017895@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017896, 'Leeann', 'Hailey', 'Haws', 'Vicioso', 'zS23017896@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017897, 'Willy', 'Maddy', 'Carous', 'Bayfield', 'zS23017897@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017898, 'Sher', 'Emerson', 'Kivlin', 'Decent', 'zS23017898@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017899, 'Sherlock', 'Casey', 'Vick', 'Pattle', 'zS23017899@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017900, 'Gabbey', 'Thea', 'Richten', 'Boreham', 'zS23017900@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017901, 'Jacqueline', 'Patricia', 'Humberston', 'McClune', 'zS23017901@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017902, 'Vania', 'Sigfried', 'McGuiness', 'Olliar', 'zS23017902@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017903, 'Eb', 'Marjory', 'Duhig', 'Collacombe', 'zS23017903@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017904, 'Skyler', 'Douglass', 'Saipy', 'Deesly', 'zS23017904@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017905, 'Maressa', 'Wyatan', 'Capelow', 'Sayle', 'zS23017905@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017906, 'Lilyan', 'Modestine', 'Haine', 'Soots', 'zS23017906@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017907, 'Ash', 'Mamie', 'Spradbrow', 'Twohig', 'zS23017907@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017908, 'Shani', 'Gusella', 'Bricket', 'Brownell', 'zS23017908@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017909, 'Minor', 'Linell', 'Scourge', 'Kundt', 'zS23017909@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017910, 'Herbert', 'Phillie', 'Coytes', 'Rivers', 'zS23017910@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017911, 'Levon', 'Sherm', 'Howbrook', 'Leek', 'zS23017911@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017912, 'Mil', 'Tomasine', 'Galtone', 'Openshaw', 'zS23017912@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017913, 'Wyatan', 'Alysa', 'Roarty', 'Body', 'zS23017913@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017914, 'Osbert', 'Georgeanna', 'Brinklow', 'Stidston', 'zS23017914@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017915, 'Hector', 'Tully', 'Bridell', 'Simon', 'zS23017915@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017916, 'Vern', 'Lily', 'Grunson', 'Richardon', 'zS23017916@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017917, 'Kriste', 'Deena', 'Duly', 'Van Brug', 'zS23017917@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017918, 'Britney', 'Aharon', 'Croyser', 'Erangey', 'zS23017918@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017919, 'Fulvia', 'Norma', 'Dimock', 'Brunt', 'zS23017919@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017920, 'Robenia', 'Wernher', 'de Wilde', 'Holdin', 'zS23017920@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017921, 'Bob', 'Bobina', 'Spence', 'Brachell', 'zS23017921@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017922, 'Cosmo', 'Laird', 'Amos', 'Aubery', 'zS23017922@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017923, 'Jaime', 'Alane', 'Clawson', 'Killerby', 'zS23017923@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017924, 'Powell', 'Annora', 'Roff', 'Tittershill', 'zS23017924@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017925, 'Nobie', 'Florentia', 'Hubbart', 'Warlowe', 'zS23017925@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017926, 'Ellerey', 'Marybelle', 'Martinek', 'Jordeson', 'zS23017926@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017927, 'Alphard', 'Chelsea', 'Normadell', 'MacCallester', 'zS23017927@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017928, 'Emmit', 'Ramona', 'Gaythor', 'Toulamain', 'zS23017928@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017929, 'Rowena', 'Lark', 'Howatt', 'Trinbey', 'zS23017929@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017930, 'Allx', 'Roxie', 'Falla', 'Aizikovitz', 'zS23017930@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017931, 'Mischa', 'Rockey', 'Whaymand', 'Winsome', 'zS23017931@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017932, 'Sax', 'Joyann', 'Banat', 'Iacobucci', 'zS23017932@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017933, 'Loraine', 'Felicity', 'Cortez', 'Dockray', 'zS23017933@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017934, 'Zoe', 'Saudra', 'Edinborough', 'Cissen', 'zS23017934@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017935, 'Hilde', 'Pepita', 'Revelle', 'Egdale', 'zS23017935@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017936, 'Pete', 'Caressa', 'Franchioni', 'Righy', 'zS23017936@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017937, 'Arni', 'Lyman', 'Harrowell', 'Biswell', 'zS23017937@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017938, 'Cornelius', 'Chrisy', 'Thacke', 'Finlaison', 'zS23017938@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017939, 'Nesta', 'Farrel', 'Gilmour', 'Kerfut', 'zS23017939@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017940, 'Kirstyn', 'Gabie', 'Chattaway', 'Forrestall', 'zS23017940@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017941, 'Johna', 'Sam', 'Mantram', 'Wyldish', 'zS23017941@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017942, 'Kimmi', 'Sheila-kathryn', 'Fouch', 'Joselin', 'zS23017942@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017943, 'Skippie', 'Amery', 'Nequest', 'Hackley', 'zS23017943@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017944, 'Garvy', 'Cleon', 'Comizzoli', 'Fearnehough', 'zS23017944@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017945, 'Shirlee', 'Humphrey', 'Chang', 'Blakes', 'zS23017945@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017946, 'Marian', 'Rogers', 'Durham', 'MacLardie', 'zS23017946@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017947, 'Tally', 'Tallie', 'Slaght', 'Stallybrass', 'zS23017947@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017948, 'Rosamond', 'Zoe', 'Odger', 'Darwen', 'zS23017948@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017949, 'Anastassia', 'Carlotta', 'Tonepohl', 'MacFaell', 'zS23017949@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017950, 'Maggy', 'Emmet', 'Mellmoth', 'Van den Oord', 'zS23017950@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017951, 'Noach', 'Win', 'Curnock', 'Western', 'zS23017951@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017952, 'Danyette', 'Jeth', 'Batrick', 'Gowthorpe', 'zS23017952@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017953, 'Claudio', 'Georgie', 'Stone', 'Daniel', 'zS23017953@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017954, 'Tamara', 'Sigrid', 'Petrovykh', 'Basile', 'zS23017954@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017955, 'Daphna', 'Gal', 'Striker', 'Gerrit', 'zS23017955@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017956, 'Annamarie', 'Wynn', 'Fazakerley', 'Coverley', 'zS23017956@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017957, 'Gabriell', 'Ole', 'Westover', 'Denkin', 'zS23017957@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017958, 'Wainwright', 'Happy', 'Myrkus', 'Josephi', 'zS23017958@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017959, 'Bobette', 'Ajay', 'Godart', 'Ossipenko', 'zS23017959@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017960, 'John', 'Gard', 'Ector', 'Thorold', 'zS23017960@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017961, 'Odo', 'Currey', 'Dilloway', 'Stranaghan', 'zS23017961@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017962, 'Geralda', 'Laurice', 'McMillian', 'Soal', 'zS23017962@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017963, 'Florencia', 'Neron', 'Palay', 'Hancke', 'zS23017963@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017964, 'Erminie', 'Merrick', 'Tunney', 'Coite', 'zS23017964@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017965, 'Mandie', 'Ketty', 'Cabell', 'Capron', 'zS23017965@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017966, 'Judi', 'Patten', 'Swanbourne', 'Brosel', 'zS23017966@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017967, 'Margalit', 'Roger', 'Fenelon', 'Noddle', 'zS23017967@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017968, 'Rudyard', 'Corie', 'Shaylor', 'Sturgeon', 'zS23017968@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017969, 'Raychel', 'Coleman', 'Driscoll', 'Durn', 'zS23017969@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017970, 'Sherill', 'Matelda', 'Mebes', 'Strognell', 'zS23017970@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017971, 'Hali', 'Anatol', 'Prozillo', 'Bruntje', 'zS23017971@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017972, 'Jacobo', 'Theresa', 'Chalcot', 'Prosser', 'zS23017972@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017973, 'Margarethe', 'Giles', 'Norvell', 'Ambresin', 'zS23017973@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017974, 'Thaine', 'Ariella', 'Billie', 'Loveland', 'zS23017974@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017975, 'Brendon', 'Cora', 'Longden', 'Pottinger', 'zS23017975@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017976, 'Horace', 'Mia', 'Whiteley', 'Liveing', 'zS23017976@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017977, 'Napoleon', 'Becka', 'Insley', 'Walthall', 'zS23017977@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017978, 'Abbott', 'Gloriane', 'Speed', 'Tomley', 'zS23017978@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017979, 'Clyde', 'Candis', 'Wood', 'Willeman', 'zS23017979@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017980, 'Edie', 'Lexis', 'Szymczyk', 'Glasheen', 'zS23017980@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017981, 'Wanids', 'Quincey', 'Bunker', 'Thurner', 'zS23017981@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017982, 'Jehanna', 'Ilysa', 'Bickers', 'Fishley', 'zS23017982@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017983, 'Harper', 'Giraldo', 'Baigent', 'Celle', 'zS23017983@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017984, 'Laure', 'Alain', 'Pauls', 'Losseljong', 'zS23017984@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017985, 'Augustine', 'Davina', 'Bardell', 'Ardley', 'zS23017985@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017986, 'Toddy', 'Delphine', 'Biddlestone', 'Foux', 'zS23017986@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017987, 'Delia', 'Darius', 'Madison', 'Benneton', 'zS23017987@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017988, 'Markos', 'Bruce', 'Oels', 'Hammerman', 'zS23017988@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);
insert into alumno (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat, email, clave,
                    programaEduactivo_id)
values (23017989, 'Christiane', 'Zorana', 'Martellini', 'Kedwell', 'zS23017989@estudiantes.uv.mx',
        '05550bc685f04599b689922632e7baf0719d003649362002c83ace6253b03d49', 4);

select *
from cursa;

select *
from cursa;
### CURSAR MATERIAS ###
drop table cursa;
### idCursa - Matricula alumno - NRC Seccion ###
insert into cursa
values (0, 21015977, 19667); #adminsitracion de base de datos
insert into cursa
values (1, 21015977, 75732); #metodologia de la investigacion
insert into cursa
values (2, 21015977, 75718); #redes
insert into cursa
values (3, 21015977, 13468); #estructura de datos

insert into cursa
values (4, 20017790, 19667); #adminsitracion de base de datos
insert into cursa
values (5, 20017790, 75732); #metodologia de la investigacion
insert into cursa
values (6, 20017790, 75718); #redes
insert into cursa
values (7, 20017790, 13468); #estructura de datos

insert into cursa
values (8, 21015959, 19667); #adminsitracion de base de datos
insert into cursa
values (9, 21015959, 75732); #metodologia de la investigacion
insert into cursa
values (10, 21015959, 75718); #redes
insert into cursa
values (11, 21015959, 13468); #estructura de datos

insert into cursa
values (12, 21015915, 19667); #adminsitracion de base de datos
insert into cursa
values (13, 21015915, 75732); #metodologia de la investigacion
insert into cursa
values (14, 21015915, 75718); #redes
insert into cursa
values (15, 21015915, 13468); #estructura de datos

insert into cursa
values (16, 20017800, 19667); #adminsitracion de base de datos
insert into cursa
values (17, 20017800, 75732); #metodologia de la investigacion
insert into cursa
values (18, 20017800, 75718); #redes
insert into cursa
values (19, 20017800, 13468); #estructura de datos

insert into cursa
values (20, 20017701, 19667);
insert into cursa
values (21, 20017701, 75732);
insert into cursa
values (22, 20017701, 75718);
insert into cursa
values (23, 20017701, 13468);

insert into cursa
values (24, 20017702, 19667);
insert into cursa
values (25, 20017702, 75732);
insert into cursa
values (26, 20017702, 75718);
insert into cursa
values (27, 20017702, 13468);

insert into cursa
values (28, 20017703, 19667);
insert into cursa
values (29, 20017703, 75732);
insert into cursa
values (30, 20017703, 75718);
insert into cursa
values (31, 20017703, 13468);

insert into cursa
values (32, 20017704, 19667);
insert into cursa
values (33, 20017704, 75732);
insert into cursa
values (34, 20017704, 75718);
insert into cursa
values (35, 20017704, 13468);

insert into cursa
values (36, 20017705, 19667);
insert into cursa
values (37, 20017705, 75732);
insert into cursa
values (38, 20017705, 75718);
insert into cursa
values (39, 20017705, 13468);

insert into cursa
values (40, 20017706, 19667);
insert into cursa
values (41, 20017706, 75732);
insert into cursa
values (42, 20017706, 75718);
insert into cursa
values (43, 20017706, 13468);

insert into cursa
values (44, 20017707, 19667);
insert into cursa
values (45, 20017707, 75732);
insert into cursa
values (46, 20017707, 75718);
insert into cursa
values (47, 20017707, 13468);

insert into cursa
values (48, 20017708, 19667);
insert into cursa
values (49, 20017708, 75732);
insert into cursa
values (50, 20017708, 75718);
insert into cursa
values (51, 20017708, 13468);

insert into cursa
values (52, 20017709, 19667);
insert into cursa
values (53, 20017709, 75732);
insert into cursa
values (54, 20017709, 75718);
insert into cursa
values (55, 20017709, 13468);

insert into cursa
values (56, 20017710, 19667);
insert into cursa
values (57, 20017710, 75732);
insert into cursa
values (58, 20017710, 75718);
insert into cursa
values (59, 20017710, 13468);

insert into cursa
values (60, 20017711, 19667);
insert into cursa
values (61, 20017711, 75732);
insert into cursa
values (62, 20017711, 75718);
insert into cursa
values (63, 20017711, 13468);

insert into cursa
values (64, 20017712, 19667);
insert into cursa
values (65, 20017712, 75732);
insert into cursa
values (66, 20017712, 75718);
insert into cursa
values (67, 20017712, 13468);

insert into cursa
values (68, 20017713, 19667);
insert into cursa
values (69, 20017713, 75732);
insert into cursa
values (70, 20017713, 75718);
insert into cursa
values (71, 20017713, 13468);

insert into cursa
values (72, 20017714, 19667);
insert into cursa
values (73, 20017714, 75732);
insert into cursa
values (74, 20017714, 75718);
insert into cursa
values (75, 20017714, 13468);

insert into cursa
values (76, 20017715, 19667);
insert into cursa
values (77, 20017715, 75732);
insert into cursa
values (78, 20017715, 75718);
insert into cursa
values (79, 20017715, 13468);

insert into cursa
values (80, 20017716, 13434);
insert into cursa
values (81, 20017716, 14451);
insert into cursa
values (82, 20017716, 13460);
insert into cursa
values (83, 20017716, 75724);

insert into cursa
values (84, 20017717, 13434);
insert into cursa
values (85, 20017717, 14451);
insert into cursa
values (86, 20017717, 13460);
insert into cursa
values (87, 20017717, 75724);

insert into cursa
values (88, 20017718, 13434);
insert into cursa
values (89, 20017718, 14451);
insert into cursa
values (90, 20017718, 13460);
insert into cursa
values (91, 20017718, 75724);

insert into cursa
values (92, 20017719, 13434);
insert into cursa
values (93, 20017719, 14451);
insert into cursa
values (94, 20017719, 13460);
insert into cursa
values (95, 20017719, 75724);

insert into cursa
values (96, 20017720, 13434);
insert into cursa
values (97, 20017720, 14451);
insert into cursa
values (98, 20017720, 13460);
insert into cursa
values (99, 20017720, 75724);

insert into cursa
values (100, 20017721, 13434);
insert into cursa
values (101, 20017721, 14451);
insert into cursa
values (102, 20017721, 13460);
insert into cursa
values (103, 20017721, 75724);

insert into cursa
values (104, 20017722, 13434);
insert into cursa
values (105, 20017722, 14451);
insert into cursa
values (106, 20017722, 13460);
insert into cursa
values (107, 20017722, 75724);

insert into cursa
values (108, 20017723, 13434);
insert into cursa
values (109, 20017723, 14451);
insert into cursa
values (110, 20017723, 13460);
insert into cursa
values (111, 20017723, 75724);

insert into cursa
values (112, 20017724, 13434);
insert into cursa
values (113, 20017724, 14451);
insert into cursa
values (114, 20017724, 13460);
insert into cursa
values (115, 20017724, 75724);

insert into cursa
values (116, 20017725, 13434);
insert into cursa
values (117, 20017725, 14451);
insert into cursa
values (118, 20017725, 13460);
insert into cursa
values (119, 20017725, 75724);

insert into cursa
values (120, 20017726, 13434);
insert into cursa
values (121, 20017726, 14451);
insert into cursa
values (122, 20017726, 13460);
insert into cursa
values (123, 20017726, 75724);

insert into cursa
values (124, 20017727, 13434);
insert into cursa
values (125, 20017727, 14451);
insert into cursa
values (126, 20017727, 13460);
insert into cursa
values (127, 20017727, 75724);

insert into cursa
values (128, 20017728, 13434);
insert into cursa
values (129, 20017728, 14451);
insert into cursa
values (130, 20017728, 13460);
insert into cursa
values (131, 20017728, 75724);

insert into cursa
values (132, 20017729, 13434);
insert into cursa
values (133, 20017729, 14451);
insert into cursa
values (134, 20017729, 13460);
insert into cursa
values (135, 20017729, 75724);

insert into cursa
values (136, 20017730, 13434);
insert into cursa
values (137, 20017730, 14451);
insert into cursa
values (138, 20017730, 13460);
insert into cursa
values (139, 20017730, 75724);

insert into cursa
values (140, 20017731, 13434);
insert into cursa
values (141, 20017731, 14451);
insert into cursa
values (142, 20017731, 13460);
insert into cursa
values (143, 20017731, 75724);

insert into cursa
values (144, 20017732, 13434);
insert into cursa
values (145, 20017732, 14451);
insert into cursa
values (146, 20017732, 13460);
insert into cursa
values (147, 20017732, 75724);

insert into cursa
values (148, 20017733, 13434);
insert into cursa
values (149, 20017733, 14451);
insert into cursa
values (150, 20017733, 13460);
insert into cursa
values (151, 20017733, 75724);

insert into cursa
values (152, 20017734, 13434);
insert into cursa
values (153, 20017734, 14451);
insert into cursa
values (154, 20017734, 13460);
insert into cursa
values (155, 20017734, 75724);
insert into cursa
values (156, 20017734, 13460);
insert into cursa
values (157, 20017734, 75723);
insert into cursa
values (158, 20017734, 13460);
insert into cursa
values (159, 20017734, 13460);

insert into cursa
values (160, 20017735, 75723);
insert into cursa
values (161, 20017735, 13468);
insert into cursa
values (162, 20017735, 75732);

insert into cursa
values (163, 20017736, 75720);
insert into cursa
values (164, 20017736, 75717);
insert into cursa
values (165, 20017736, 76756);
insert into cursa
values (166, 20017736, 95821);

insert into cursa
values (167, 20017737, 75720);
insert into cursa
values (168, 20017737, 75717);
insert into cursa
values (169, 20017737, 76756);
insert into cursa
values (170, 20017737, 95821);

insert into cursa
values (171, 20017738, 75720);
insert into cursa
values (172, 20017738, 75717);
insert into cursa
values (173, 20017738, 76756);
insert into cursa
values (174, 20017738, 95821);

insert into cursa
values (175, 20017739, 75720);
insert into cursa
values (176, 20017739, 75717);
insert into cursa
values (177, 20017739, 76756);
insert into cursa
values (178, 20017739, 95821);

insert into cursa
values (179, 20017740, 75720);
insert into cursa
values (180, 20017740, 75717);
insert into cursa
values (181, 20017740, 76756);
insert into cursa
values (182, 20017740, 95821);

insert into cursa
values (183, 20017741, 75720);
insert into cursa
values (184, 20017741, 75717);
insert into cursa
values (185, 20017741, 76756);
insert into cursa
values (186, 20017741, 95821);

insert into cursa
values (187, 20017742, 75720);
insert into cursa
values (188, 20017742, 75717);
insert into cursa
values (189, 20017742, 76756);
insert into cursa
values (190, 20017742, 95821);

insert into cursa
values (191, 20017743, 75720);
insert into cursa
values (192, 20017743, 75717);
insert into cursa
values (193, 20017743, 76756);
insert into cursa
values (194, 20017743, 95821);

insert into cursa
values (195, 20017744, 75720);
insert into cursa
values (196, 20017744, 75717);
insert into cursa
values (197, 20017744, 76756);
insert into cursa
values (198, 20017744, 95821);

insert into cursa
values (199, 20017745, 75720);
insert into cursa
values (200, 20017745, 75717);
insert into cursa
values (201, 20017745, 76756);
insert into cursa
values (202, 20017745, 95821);

insert into cursa
values (203, 20017746, 75720);
insert into cursa
values (204, 20017746, 75717);
insert into cursa
values (205, 20017746, 76756);
insert into cursa
values (206, 20017746, 95821);

insert into cursa
values (207, 20017747, 75720);
insert into cursa
values (208, 20017747, 75717);
insert into cursa
values (209, 20017747, 76756);
insert into cursa
values (210, 20017747, 95821);

insert into cursa
values (211, 20017748, 75720);
insert into cursa
values (212, 20017748, 75717);
insert into cursa
values (213, 20017748, 76756);
insert into cursa
values (214, 20017748, 95821);

insert into cursa
values (215, 20017749, 75720);
insert into cursa
values (216, 20017749, 75717);
insert into cursa
values (217, 20017749, 76756);
insert into cursa
values (218, 20017749, 95821);

insert into cursa
values (219, 20017750, 75720);
insert into cursa
values (220, 20017750, 75717);
insert into cursa
values (221, 20017750, 76756);
insert into cursa
values (222, 20017750, 95821);

insert into cursa
values (223, 20017751, 75720);
insert into cursa
values (224, 20017751, 75717);
insert into cursa
values (225, 20017751, 76756);
insert into cursa
values (226, 20017751, 95821);

insert into cursa
values (227, 20017752, 75720);
insert into cursa
values (228, 20017752, 75717);
insert into cursa
values (229, 20017752, 76756);
insert into cursa
values (230, 20017752, 95821);

insert into cursa
values (231, 20017753, 75720);
insert into cursa
values (232, 20017753, 75717);
insert into cursa
values (233, 20017753, 76756);
insert into cursa
values (234, 20017753, 95821);

insert into cursa
values (235, 20017754, 75720);
insert into cursa
values (236, 20017754, 75717);
insert into cursa
values (237, 20017754, 76756);
insert into cursa
values (238, 20017754, 95821);

insert into cursa
values (239, 20017755, 75720);
insert into cursa
values (240, 20017755, 75717);
insert into cursa
values (241, 20017755, 76756);
insert into cursa
values (242, 20017755, 95821);

insert into cursa
values (243, 20017756, 75720);
insert into cursa
values (244, 20017756, 75717);
insert into cursa
values (245, 20017756, 76756);
insert into cursa
values (246, 20017756, 95821);

insert into cursa
values (247, 20017759, 98993);
insert into cursa
values (248, 20017759, 75724);
insert into cursa
values (249, 20017759, 75731);
insert into cursa
values (250, 20017759, 75733);

insert into cursa
values (251, 20017760, 98993);
insert into cursa
values (252, 20017760, 75724);
insert into cursa
values (253, 20017760, 75731);
insert into cursa
values (254, 20017760, 75733);

insert into cursa
values (255, 20017761, 98993);
insert into cursa
values (256, 20017761, 75724);
insert into cursa
values (257, 20017761, 75731);
insert into cursa
values (258, 20017761, 75733);

insert into cursa
values (259, 20017762, 98993);
insert into cursa
values (260, 20017762, 75724);
insert into cursa
values (261, 20017762, 75731);
insert into cursa
values (262, 20017762, 75733);

insert into cursa
values (263, 20017763, 98993);
insert into cursa
values (264, 20017763, 75724);
insert into cursa
values (265, 20017763, 75731);
insert into cursa
values (266, 20017763, 75733);

insert into cursa
values (267, 20017764, 98993);
insert into cursa
values (268, 20017764, 75724);
insert into cursa
values (269, 20017764, 75731);
insert into cursa
values (270, 20017764, 75733);

insert into cursa
values (271, 20017765, 98993);
insert into cursa
values (272, 20017765, 75724);
insert into cursa
values (273, 20017765, 75731);
insert into cursa
values (274, 20017765, 75733);

insert into cursa
values (275, 20017766, 98993);
insert into cursa
values (276, 20017766, 75724);
insert into cursa
values (277, 20017766, 75731);
insert into cursa
values (278, 20017766, 75733);

insert into cursa
values (279, 20017767, 98993);
insert into cursa
values (280, 20017767, 75724);
insert into cursa
values (281, 20017767, 75731);
insert into cursa
values (282, 20017767, 75733);

insert into cursa
values (283, 20017768, 98993);
insert into cursa
values (284, 20017768, 75724);
insert into cursa
values (285, 20017768, 75731);
insert into cursa
values (286, 20017768, 75733);

insert into cursa
values (287, 20017769, 98993);
insert into cursa
values (288, 20017769, 75724);
insert into cursa
values (289, 20017769, 75731);
insert into cursa
values (290, 20017769, 75733);

insert into cursa
values (291, 20017770, 98993);
insert into cursa
values (292, 20017770, 75724);
insert into cursa
values (293, 20017770, 75731);
insert into cursa
values (294, 20017770, 75733);

insert into cursa
values (295, 20017771, 98993);
insert into cursa
values (296, 20017771, 75724);
insert into cursa
values (297, 20017771, 75731);
insert into cursa
values (298, 20017771, 75733);

insert into cursa
values (299, 20017772, 98993);
insert into cursa
values (300, 20017772, 75724);
insert into cursa
values (301, 20017772, 75731);
insert into cursa
values (302, 20017772, 75733);

insert into cursa
values (303, 20017773, 98993);
insert into cursa
values (304, 20017773, 75724);
insert into cursa
values (305, 20017773, 75731);
insert into cursa
values (306, 20017773, 75733);

insert into cursa
values (307, 20017774, 98993);
insert into cursa
values (308, 20017774, 75724);
insert into cursa
values (309, 20017774, 75731);
insert into cursa
values (310, 20017774, 75733);

insert into cursa
values (311, 20017775, 98993);
insert into cursa
values (312, 20017775, 75724);
insert into cursa
values (313, 20017775, 75731);
insert into cursa
values (314, 20017775, 75733);

insert into cursa
values (315, 20017776, 98993);
insert into cursa
values (316, 20017776, 75724);
insert into cursa
values (317, 20017776, 75731);
insert into cursa
values (318, 20017776, 75733);

insert into cursa
values (319, 20017777, 98993);
insert into cursa
values (320, 20017777, 75724);
insert into cursa
values (321, 20017777, 75731);
insert into cursa
values (322, 20017777, 75733);

insert into cursa
values (323, 20017778, 98993);
insert into cursa
values (324, 20017778, 75724);
insert into cursa
values (325, 20017778, 75731);
insert into cursa
values (326, 20017778, 75733);

insert into cursa
values (327, 20017779, 98993);
insert into cursa
values (328, 20017779, 75724);
insert into cursa
values (329, 20017779, 75731);
insert into cursa
values (330, 20017779, 75733);

insert into cursa
values (331, 20017780, 95897);
insert into cursa
values (332, 20017780, 80693);
insert into cursa
values (333, 20017780, 80695);
insert into cursa
values (334, 20017780, 80697);

insert into cursa
values (335, 20017781, 95897);
insert into cursa
values (336, 20017781, 80693);
insert into cursa
values (337, 20017781, 80695);
insert into cursa
values (338, 20017781, 80697);

insert into cursa
values (339, 20017782, 95897);
insert into cursa
values (340, 20017782, 80693);
insert into cursa
values (341, 20017782, 80695);
insert into cursa
values (342, 20017782, 80697);

insert into cursa
values (343, 20017783, 95897);
insert into cursa
values (344, 20017783, 80693);
insert into cursa
values (345, 20017783, 80695);
insert into cursa
values (346, 20017783, 80697);

insert into cursa
values (347, 20017784, 95897);
insert into cursa
values (348, 20017784, 80693);
insert into cursa
values (349, 20017784, 80695);
insert into cursa
values (350, 20017784, 80697);

insert into cursa
values (351, 20017785, 95897);
insert into cursa
values (352, 20017785, 80693);
insert into cursa
values (353, 20017785, 80695);
insert into cursa
values (354, 20017785, 80697);

insert into cursa
values (355, 20017786, 95897);
insert into cursa
values (356, 20017786, 80693);
insert into cursa
values (357, 20017786, 80695);
insert into cursa
values (358, 20017786, 80697);

insert into cursa
values (359, 20017787, 95897);
insert into cursa
values (360, 20017787, 80693);
insert into cursa
values (361, 20017787, 80695);
insert into cursa
values (362, 20017787, 80697);

insert into cursa
values (363, 20017788, 95897);
insert into cursa
values (364, 20017788, 80693);
insert into cursa
values (365, 20017788, 80695);
insert into cursa
values (366, 20017788, 80697);

insert into cursa
values (367, 20017789, 95897);
insert into cursa
values (368, 20017789, 80693);
insert into cursa
values (369, 20017789, 80695);
insert into cursa
values (370, 20017789, 80697);

insert into cursa
values (371, 20017790, 95897);
insert into cursa
values (372, 20017790, 80693);
insert into cursa
values (373, 20017790, 80695);
insert into cursa
values (374, 20017790, 80697);

insert into cursa
values (375, 20017791, 95897);
insert into cursa
values (376, 20017791, 80693);
insert into cursa
values (377, 20017791, 80695);
insert into cursa
values (378, 20017791, 80697);

insert into cursa
values (379, 20017792, 95897);
insert into cursa
values (380, 20017792, 80693);
insert into cursa
values (381, 20017792, 80695);
insert into cursa
values (382, 20017792, 80697);

insert into cursa
values (383, 20017793, 95897);
insert into cursa
values (384, 20017793, 80693);
insert into cursa
values (385, 20017793, 80695);
insert into cursa
values (386, 20017793, 80697);

insert into cursa
values (387, 20017794, 95897);
insert into cursa
values (388, 20017794, 80693);
insert into cursa
values (389, 20017794, 80695);
insert into cursa
values (390, 20017794, 80697);

insert into cursa
values (391, 20017795, 95897);
insert into cursa
values (392, 20017795, 80693);
insert into cursa
values (393, 20017795, 80695);
insert into cursa
values (394, 20017795, 80697);

insert into cursa
values (395, 20017796, 95897);
insert into cursa
values (396, 20017796, 80693);
insert into cursa
values (397, 20017796, 80695);
insert into cursa
values (398, 20017796, 80697);

insert into cursa
values (399, 20017797, 95897);
insert into cursa
values (400, 20017797, 80693);
insert into cursa
values (401, 20017797, 80695);
insert into cursa
values (402, 20017797, 80697);

insert into cursa
values (403, 20017798, 95897);
insert into cursa
values (404, 20017798, 80693);
insert into cursa
values (405, 20017798, 80695);
insert into cursa
values (406, 20017798, 80697);

insert into cursa
values (407, 20017799, 95897);
insert into cursa
values (408, 20017799, 80693);
insert into cursa
values (409, 20017799, 80695);
insert into cursa
values (410, 20017799, 80697);

insert into cursa
values (411, 20017800, 95897);
insert into cursa
values (412, 20017800, 80693);
insert into cursa
values (413, 20017800, 80695);
insert into cursa
values (414, 20017800, 80697);

insert into cursa
values (415, 20017801, 95897);
insert into cursa
values (416, 20017801, 80693);
insert into cursa
values (417, 20017801, 80695);
insert into cursa
values (418, 20017801, 80697);

insert into cursa
values (419, 20017802, 80700);
insert into cursa
values (420, 20017802, 80705);
insert into cursa
values (421, 20017802, 80707);
insert into cursa
values (422, 20017802, 19666);

insert into cursa
values (423, 20017803, 80700);
insert into cursa
values (424, 20017803, 80705);
insert into cursa
values (425, 20017803, 80707);
insert into cursa
values (426, 20017803, 19666);

insert into cursa
values (427, 20017804, 80700);
insert into cursa
values (428, 20017804, 80705);
insert into cursa
values (429, 20017804, 80707);
insert into cursa
values (430, 20017804, 19666);

insert into cursa
values (431, 20017805, 80700);
insert into cursa
values (432, 20017805, 80705);
insert into cursa
values (433, 20017805, 80707);
insert into cursa
values (434, 20017805, 19666);

insert into cursa
values (435, 20017806, 80700);
insert into cursa
values (436, 20017806, 80705);
insert into cursa
values (437, 20017806, 80707);
insert into cursa
values (438, 20017806, 19666);

insert into cursa
values (439, 20017807, 80700);
insert into cursa
values (440, 20017807, 80705);
insert into cursa
values (441, 20017807, 80707);
insert into cursa
values (442, 20017807, 19666);

insert into cursa
values (443, 20017808, 80700);
insert into cursa
values (444, 20017808, 80705);
insert into cursa
values (445, 20017808, 80707);
insert into cursa
values (446, 20017808, 19666);

insert into cursa
values (447, 20017809, 80700);
insert into cursa
values (448, 20017809, 80705);
insert into cursa
values (449, 20017809, 80707);
insert into cursa
values (450, 20017809, 19666);

insert into cursa
values (451, 20017810, 80700);
insert into cursa
values (452, 20017810, 80705);
insert into cursa
values (453, 20017810, 80707);
insert into cursa
values (454, 20017810, 19666);

insert into cursa
values (455, 20017811, 80700);
insert into cursa
values (456, 20017811, 80705);
insert into cursa
values (457, 20017811, 80707);
insert into cursa
values (458, 20017811, 19666);

insert into cursa
values (459, 20017812, 80700);
insert into cursa
values (460, 20017812, 80705);
insert into cursa
values (461, 20017812, 80707);
insert into cursa
values (462, 20017812, 19666);

insert into cursa
values (463, 20017813, 80700);
insert into cursa
values (464, 20017813, 80705);
insert into cursa
values (465, 20017813, 80707);
insert into cursa
values (466, 20017813, 19666);

insert into cursa
values (467, 20017814, 80700);
insert into cursa
values (468, 20017814, 80705);
insert into cursa
values (469, 20017814, 80707);
insert into cursa
values (470, 20017814, 19666);

insert into cursa
values (471, 20017815, 80700);
insert into cursa
values (472, 20017815, 80705);
insert into cursa
values (473, 20017815, 80707);
insert into cursa
values (474, 20017815, 19666);

insert into cursa
values (475, 20017816, 80700);
insert into cursa
values (476, 20017816, 80705);
insert into cursa
values (477, 20017816, 80707);
insert into cursa
values (478, 20017816, 19666);

insert into cursa
values (479, 20017817, 80700);
insert into cursa
values (480, 20017817, 80705);
insert into cursa
values (481, 20017817, 80707);
insert into cursa
values (482, 20017817, 19666);

insert into cursa
values (483, 20017818, 80700);
insert into cursa
values (484, 20017818, 80705);
insert into cursa
values (485, 20017818, 80707);
insert into cursa
values (486, 20017818, 19666);

insert into cursa
values (487, 20017819, 19667);
insert into cursa
values (488, 20017819, 83555);
insert into cursa
values (489, 20017819, 83557);
insert into cursa
values (490, 20017819, 83558);

insert into cursa
values (491, 20017820, 19667);
insert into cursa
values (492, 20017820, 83555);
insert into cursa
values (493, 20017820, 83557);
insert into cursa
values (494, 20017820, 83558);

insert into cursa
values (495, 20017821, 19667);
insert into cursa
values (496, 20017821, 83555);
insert into cursa
values (497, 20017821, 83557);
insert into cursa
values (498, 20017821, 83558);

insert into cursa
values (499, 20017822, 19667);
insert into cursa
values (500, 20017822, 83555);
insert into cursa
values (501, 20017822, 83557);
insert into cursa
values (502, 20017822, 83558);

insert into cursa
values (503, 20017823, 19667);
insert into cursa
values (504, 20017823, 83555);
insert into cursa
values (505, 20017823, 83557);
insert into cursa
values (506, 20017823, 83558);

insert into cursa
values (507, 20017824, 19667);
insert into cursa
values (508, 20017824, 83555);
insert into cursa
values (509, 20017824, 83557);
insert into cursa
values (510, 20017824, 83558);

insert into cursa
values (511, 20017825, 19667);
insert into cursa
values (512, 20017825, 83555);
insert into cursa
values (513, 20017825, 83557);
insert into cursa
values (514, 20017825, 83558);

insert into cursa
values (515, 20017826, 19667);
insert into cursa
values (516, 20017826, 83555);
insert into cursa
values (517, 20017826, 83557);
insert into cursa
values (518, 20017826, 83558);

insert into cursa
values (519, 20017827, 19667);
insert into cursa
values (520, 20017827, 83555);
insert into cursa
values (521, 20017827, 83557);
insert into cursa
values (522, 20017827, 83558);

insert into cursa
values (523, 20017828, 19667);
insert into cursa
values (524, 20017828, 83555);
insert into cursa
values (525, 20017828, 83557);
insert into cursa
values (526, 20017828, 83558);

insert into cursa
values (527, 20017829, 19667);
insert into cursa
values (528, 20017829, 83555);
insert into cursa
values (573, 20017829, 83557);
insert into cursa
values (574, 20017829, 83558);

insert into cursa
values (529, 20017830, 19667);
insert into cursa
values (530, 20017830, 83555);
insert into cursa
values (531, 20017830, 83557);
insert into cursa
values (532, 20017830, 83558);

insert into cursa
values (533, 20017831, 19667);
insert into cursa
values (534, 20017831, 83555);
insert into cursa
values (535, 20017831, 83557);
insert into cursa
values (536, 20017831, 83558);

insert into cursa
values (537, 20017832, 19667);
insert into cursa
values (538, 20017832, 83555);
insert into cursa
values (539, 20017832, 83557);
insert into cursa
values (540, 20017832, 83558);

insert into cursa
values (541, 20017833, 19667);
insert into cursa
values (542, 20017833, 83555);
insert into cursa
values (543, 20017833, 83557);
insert into cursa
values (544, 20017833, 83558);

insert into cursa
values (545, 20017834, 19667);
insert into cursa
values (546, 20017834, 83555);
insert into cursa
values (547, 20017834, 83557);
insert into cursa
values (548, 20017834, 83558);

insert into cursa
values (549, 20017835, 19667);
insert into cursa
values (550, 20017835, 83555);
insert into cursa
values (551, 20017835, 83557);
insert into cursa
values (552, 20017835, 83558);

insert into cursa
values (553, 20017836, 19667);
insert into cursa
values (554, 20017836, 83555);
insert into cursa
values (555, 20017836, 83557);
insert into cursa
values (556, 20017836, 83558);

insert into cursa
values (557, 20017837, 19667);
insert into cursa
values (558, 20017837, 83555);
insert into cursa
values (559, 20017837, 83557);
insert into cursa
values (560, 20017837, 83558);

insert into cursa
values (561, 20017838, 19667);
insert into cursa
values (562, 20017838, 83555);
insert into cursa
values (563, 20017838, 83557);
insert into cursa
values (564, 20017838, 83558);

insert into cursa
values (565, 20017839, 19667);
insert into cursa
values (566, 20017839, 83555);
insert into cursa
values (567, 20017839, 83557);
insert into cursa
values (568, 20017839, 83558);

insert into cursa
values (569, 20017840, 19667);
insert into cursa
values (570, 20017840, 83555);
insert into cursa
values (571, 20017840, 83557);
insert into cursa
values (572, 20017840, 83558);

insert into cursa
values (575, 20017841, 83562);
insert into cursa
values (576, 20017841, 91570);

insert into cursa
values (577, 20017842, 83559);
insert into cursa
values (578, 20017842, 83561);
insert into cursa
values (579, 20017842, 83562);
insert into cursa
values (580, 20017842, 91570);

insert into cursa
values (581, 20017843, 83559);
insert into cursa
values (582, 20017843, 83561);
insert into cursa
values (583, 20017843, 83562);
insert into cursa
values (584, 20017843, 91570);

insert into cursa
values (585, 20017844, 83559);
insert into cursa
values (586, 20017844, 83561);
insert into cursa
values (587, 20017844, 83562);
insert into cursa
values (588, 20017844, 91570);

insert into cursa
values (589, 20017845, 83559);
insert into cursa
values (590, 20017845, 83561);
insert into cursa
values (591, 20017845, 83562);
insert into cursa
values (592, 20017845, 91570);

insert into cursa
values (593, 20017846, 83559);
insert into cursa
values (594, 20017846, 83561);
insert into cursa
values (595, 20017846, 83562);
insert into cursa
values (596, 20017846, 91570);

insert into cursa
values (597, 20017847, 83559);
insert into cursa
values (598, 20017847, 83561);
insert into cursa
values (599, 20017847, 83562);
insert into cursa
values (600, 20017847, 91570);

insert into cursa
values (601, 20017848, 83559);
insert into cursa
values (602, 20017848, 83561);
insert into cursa
values (603, 20017848, 83562);
insert into cursa
values (604, 20017848, 91570);

insert into cursa
values (605, 20017849, 83559);
insert into cursa
values (606, 20017849, 83561);
insert into cursa
values (607, 20017849, 83562);
insert into cursa
values (608, 20017849, 91570);

insert into cursa
values (609, 20017850, 83559);
insert into cursa
values (610, 20017850, 83561);
insert into cursa
values (611, 20017850, 83562);
insert into cursa
values (612, 20017850, 91570);

insert into cursa
values (613, 20017851, 83559);
insert into cursa
values (614, 20017851, 83561);
insert into cursa
values (615, 20017851, 83562);
insert into cursa
values (616, 20017851, 91570);

insert into cursa
values (617, 20017852, 83559);
insert into cursa
values (618, 20017852, 83561);
insert into cursa
values (619, 20017852, 83562);
insert into cursa
values (620, 20017852, 91570);

insert into cursa
values (621, 20017853, 83559);
insert into cursa
values (622, 20017853, 83561);
insert into cursa
values (623, 20017853, 83562);
insert into cursa
values (624, 20017853, 91570);

insert into cursa
values (625, 20017854, 83559);
insert into cursa
values (626, 20017854, 83561);
insert into cursa
values (627, 20017854, 83562);
insert into cursa
values (628, 20017854, 91570);

insert into cursa
values (629, 20017855, 83559);
insert into cursa
values (630, 20017855, 83561);
insert into cursa
values (631, 20017855, 83562);
insert into cursa
values (632, 20017855, 91570);

insert into cursa
values (633, 20017856, 83559);
insert into cursa
values (634, 20017856, 83561);
insert into cursa
values (635, 20017856, 83562);
insert into cursa
values (636, 20017856, 91570);

insert into cursa
values (637, 20017857, 83559);
insert into cursa
values (638, 20017857, 83561);
insert into cursa
values (639, 20017857, 83562);
insert into cursa
values (640, 20017857, 91570);

insert into cursa
values (641, 20017858, 83559);
insert into cursa
values (642, 20017858, 83561);
insert into cursa
values (643, 20017858, 83562);
insert into cursa
values (644, 20017858, 91570);

insert into cursa
values (645, 20017859, 83559);
insert into cursa
values (646, 20017859, 83561);
insert into cursa
values (647, 20017859, 83562);
insert into cursa
values (648, 20017859, 91570);

insert into cursa
values (649, 20017860, 83559);
insert into cursa
values (650, 20017860, 83561);
insert into cursa
values (651, 20017860, 83562);
insert into cursa
values (652, 20017860, 91570);

insert into cursa
values (653, 20017861, 83559);
insert into cursa
values (654, 20017861, 83561);
insert into cursa
values (655, 20017861, 83562);
insert into cursa
values (656, 20017861, 91570);

insert into cursa
values (657, 20017862, 83559);
insert into cursa
values (658, 20017862, 83561);
insert into cursa
values (659, 20017862, 83562);
insert into cursa
values (660, 20017862, 91570);

insert into cursa
values (661, 20017864, 83559);
insert into cursa
values (662, 20017864, 83561);
insert into cursa
values (663, 20017864, 83562);
insert into cursa
values (664, 20017864, 91570);

insert into cursa
values (665, 20017865, 83565);
insert into cursa
values (666, 20017865, 87500);
insert into cursa
values (667, 20017865, 83567);
insert into cursa
values (668, 20017865, 95922);

insert into cursa
values (669, 20017866, 83565);
insert into cursa
values (670, 20017866, 87500);
insert into cursa
values (671, 20017866, 83567);
insert into cursa
values (672, 20017866, 95922);

insert into cursa
values (673, 20017867, 83565);
insert into cursa
values (674, 20017867, 87500);
insert into cursa
values (675, 20017867, 83567);
insert into cursa
values (676, 20017867, 95922);

insert into cursa
values (677, 20017868, 83565);
insert into cursa
values (678, 20017868, 87500);
insert into cursa
values (679, 20017868, 83567);
insert into cursa
values (680, 20017868, 95922);

insert into cursa
values (681, 20017869, 83565);
insert into cursa
values (682, 20017869, 87500);
insert into cursa
values (683, 20017869, 83567);
insert into cursa
values (684, 20017869, 95922);

insert into cursa
values (685, 20017870, 83565);
insert into cursa
values (686, 20017870, 87500);
insert into cursa
values (687, 20017870, 83567);
insert into cursa
values (688, 20017870, 95922);

insert into cursa
values (689, 20017871, 83565);
insert into cursa
values (690, 20017871, 87500);
insert into cursa
values (691, 20017871, 83567);
insert into cursa
values (692, 20017871, 95922);

insert into cursa
values (693, 20017872, 83565);
insert into cursa
values (694, 20017872, 87500);
insert into cursa
values (695, 20017872, 83567);
insert into cursa
values (696, 20017872, 95922);

insert into cursa
values (697, 20017873, 83565);
insert into cursa
values (698, 20017873, 87500);
insert into cursa
values (699, 20017873, 83567);
insert into cursa
values (700, 20017873, 95922);

insert into cursa
values (701, 20017874, 83565);
insert into cursa
values (702, 20017874, 87500);
insert into cursa
values (703, 20017874, 83567);
insert into cursa
values (704, 20017874, 95922);

insert into cursa
values (705, 20017875, 83565);
insert into cursa
values (706, 20017875, 87500);
insert into cursa
values (707, 20017875, 83567);
insert into cursa
values (708, 20017875, 95922);

insert into cursa
values (709, 20017876, 83565);
insert into cursa
values (710, 20017876, 87500);
insert into cursa
values (711, 20017876, 83567);
insert into cursa
values (712, 20017876, 95922);

insert into cursa
values (713, 20017877, 83565);
insert into cursa
values (714, 20017877, 87500);
insert into cursa
values (715, 20017877, 83567);
insert into cursa
values (716, 20017877, 95922);

insert into cursa
values (717, 20017878, 83565);
insert into cursa
values (718, 20017878, 87500);
insert into cursa
values (719, 20017878, 83567);
insert into cursa
values (720, 20017878, 95922);

insert into cursa
values (721, 20017879, 83565);
insert into cursa
values (722, 20017879, 87500);
insert into cursa
values (723, 20017879, 83567);
insert into cursa
values (724, 20017879, 95922);

insert into cursa
values (725, 20017880, 83565);
insert into cursa
values (726, 20017880, 87500);
insert into cursa
values (727, 20017880, 83567);
insert into cursa
values (728, 20017880, 95922);

insert into cursa
values (729, 20017881, 83565);
insert into cursa
values (730, 20017881, 87500);
insert into cursa
values (731, 20017881, 83567);
insert into cursa
values (732, 20017881, 95922);

insert into cursa
values (733, 20017882, 83565);
insert into cursa
values (734, 20017882, 87500);
insert into cursa
values (735, 20017882, 83567);
insert into cursa
values (736, 20017882, 95922);

insert into cursa
values (737, 20017883, 83565);
insert into cursa
values (738, 20017883, 87500);
insert into cursa
values (739, 20017883, 83567);
insert into cursa
values (740, 20017883, 95922);

insert into cursa
values (741, 20017884, 83565);
insert into cursa
values (742, 20017884, 87500);
insert into cursa
values (743, 20017884, 83567);
insert into cursa
values (744, 20017884, 95922);

insert into cursa
values (745, 20017885, 83565);
insert into cursa
values (746, 20017885, 87500);
insert into cursa
values (747, 20017885, 83567);
insert into cursa
values (748, 20017885, 95922);

insert into cursa
values (749, 20017886, 83565);
insert into cursa
values (750, 20017886, 87500);
insert into cursa
values (751, 20017886, 83567);
insert into cursa
values (752, 20017886, 95922);

insert into cursa
values (753, 20017887, 75778);
insert into cursa
values (754, 20017887, 80607);
insert into cursa
values (755, 20017887, 80610);
insert into cursa
values (756, 20017887, 75635);

insert into cursa
values (757, 20017888, 75778);
insert into cursa
values (758, 20017888, 80607);
insert into cursa
values (759, 20017888, 80610);
insert into cursa
values (760, 20017888, 75635);

insert into cursa
values (761, 20017889, 75778);
insert into cursa
values (762, 20017889, 80607);
insert into cursa
values (763, 20017889, 80610);
insert into cursa
values (764, 20017889, 75635);

insert into cursa
values (765, 20017890, 75778);
insert into cursa
values (766, 20017890, 80607);
insert into cursa
values (767, 20017890, 80610);
insert into cursa
values (768, 20017890, 75635);

insert into cursa
values (769, 20017891, 75778);
insert into cursa
values (770, 20017891, 80607);
insert into cursa
values (771, 20017891, 80610);
insert into cursa
values (772, 20017891, 75635);

insert into cursa
values (773, 20017892, 75778);
insert into cursa
values (774, 20017892, 80607);
insert into cursa
values (775, 20017892, 80610);
insert into cursa
values (776, 20017892, 75635);

insert into cursa
values (777, 20017893, 75778);
insert into cursa
values (778, 20017893, 80607);
insert into cursa
values (779, 20017893, 80610);
insert into cursa
values (780, 20017893, 75635);

insert into cursa
values (781, 20017894, 75778);
insert into cursa
values (782, 20017894, 80607);
insert into cursa
values (783, 20017894, 80610);
insert into cursa
values (784, 20017894, 75635);

insert into cursa
values (785, 20017895, 75778);
insert into cursa
values (786, 20017895, 80607);
insert into cursa
values (787, 20017895, 80610);
insert into cursa
values (788, 20017895, 75635);

insert into cursa
values (789, 20017896, 75778);
insert into cursa
values (790, 20017896, 80607);
insert into cursa
values (791, 20017896, 80610);
insert into cursa
values (792, 20017896, 75635);

insert into cursa
values (793, 20017897, 75778);
insert into cursa
values (794, 20017897, 80607);
insert into cursa
values (795, 20017897, 80610);
insert into cursa
values (796, 20017897, 75635);

insert into cursa
values (797, 20017898, 75778);
insert into cursa
values (798, 20017898, 80607);
insert into cursa
values (799, 20017898, 80610);
insert into cursa
values (800, 20017898, 75635);

insert into cursa
values (801, 20017899, 75778);
insert into cursa
values (802, 20017899, 80607);
insert into cursa
values (803, 20017899, 80610);
insert into cursa
values (804, 20017899, 75635);

insert into cursa
values (805, 20017900, 75778);
insert into cursa
values (806, 20017900, 80607);
insert into cursa
values (807, 20017900, 80610);
insert into cursa
values (808, 20017900, 75635);

insert into cursa
values (809, 20017901, 75778);
insert into cursa
values (810, 20017901, 80607);
insert into cursa
values (811, 20017901, 80610);
insert into cursa
values (812, 20017901, 75635);

insert into cursa
values (813, 20017902, 75778);
insert into cursa
values (814, 20017902, 80607);
insert into cursa
values (815, 20017902, 80610);
insert into cursa
values (816, 20017902, 75635);

insert into cursa
values (817, 20017903, 75778);
insert into cursa
values (818, 20017903, 80607);
insert into cursa
values (819, 20017903, 80610);
insert into cursa
values (820, 20017903, 75635);

insert into cursa
values (821, 20017904, 75778);
insert into cursa
values (822, 20017904, 80607);
insert into cursa
values (823, 20017904, 80610);
insert into cursa
values (825, 20017904, 75635);

insert into cursa
values (826, 20017905, 75778);
insert into cursa
values (827, 20017905, 80607);
insert into cursa
values (828, 20017905, 80610);
insert into cursa
values (829, 20017905, 75635);

insert into cursa
values (830, 20017906, 75778);
insert into cursa
values (831, 20017906, 80607);
insert into cursa
values (832, 20017906, 80610);
insert into cursa
values (833, 20017906, 75635);

insert into cursa
values (834, 20017907, 75778);
insert into cursa
values (835, 20017907, 80607);
insert into cursa
values (836, 20017907, 80610);
insert into cursa
values (837, 20017907, 75635);

insert into cursa
values (838, 20017908, 75778);
insert into cursa
values (839, 20017908, 80607);
insert into cursa
values (840, 20017908, 80610);
insert into cursa
values (841, 20017908, 75635);

insert into cursa
values (824, 20017909, 83501);


insert into cursa
values (842, 20017909, 85506);
insert into cursa
values (843, 20017909, 85508);
insert into cursa
values (844, 20017909, 87228);
insert into cursa
values (845, 20017909, 87235);

insert into cursa
values (846, 20017910, 85506);
insert into cursa
values (847, 20017910, 85508);
insert into cursa
values (848, 20017910, 87228);
insert into cursa
values (849, 20017910, 87235);

insert into cursa
values (850, 20017911, 85506);
insert into cursa
values (851, 20017911, 85508);
insert into cursa
values (852, 20017911, 87228);
insert into cursa
values (853, 20017911, 87235);

insert into cursa
values (854, 20017912, 85506);
insert into cursa
values (855, 20017912, 85508);
insert into cursa
values (856, 20017912, 87228);
insert into cursa
values (857, 20017912, 87235);

insert into cursa
values (858, 20017913, 85506);
insert into cursa
values (859, 20017913, 85508);
insert into cursa
values (860, 20017913, 87228);
insert into cursa
values (861, 20017913, 87235);

insert into cursa
values (862, 20017914, 85506);
insert into cursa
values (863, 20017914, 85508);
insert into cursa
values (864, 20017914, 87228);
insert into cursa
values (865, 20017914, 87235);

insert into cursa
values (866, 20017915, 85506);
insert into cursa
values (867, 20017915, 85508);
insert into cursa
values (868, 20017915, 87228);
insert into cursa
values (869, 20017915, 87235);

insert into cursa
values (870, 20017916, 85506);
insert into cursa
values (871, 20017916, 85508);
insert into cursa
values (872, 20017916, 87228);
insert into cursa
values (873, 20017916, 87235);

insert into cursa
values (874, 20017917, 85506);
insert into cursa
values (875, 20017917, 85508);
insert into cursa
values (876, 20017917, 87228);
insert into cursa
values (877, 20017917, 87235);

insert into cursa
values (878, 20017918, 85506);
insert into cursa
values (879, 20017918, 85508);
insert into cursa
values (880, 20017918, 87228);
insert into cursa
values (881, 20017918, 87235);

insert into cursa
values (882, 20017919, 85506);
insert into cursa
values (883, 20017919, 85508);
insert into cursa
values (884, 20017919, 87228);
insert into cursa
values (885, 20017919, 87235);

insert into cursa
values (886, 20017920, 85506);
insert into cursa
values (887, 20017920, 85508);
insert into cursa
values (888, 20017920, 87228);
insert into cursa
values (889, 20017920, 87235);

insert into cursa
values (890, 20017921, 85506);
insert into cursa
values (891, 20017921, 85508);
insert into cursa
values (892, 20017921, 87228);
insert into cursa
values (893, 20017921, 87235);

insert into cursa
values (894, 20017922, 85506);
insert into cursa
values (895, 20017922, 85508);
insert into cursa
values (896, 20017922, 87228);
insert into cursa
values (897, 20017922, 87235);

insert into cursa
values (898, 20017923, 85506);
insert into cursa
values (899, 20017923, 85508);
insert into cursa
values (900, 20017923, 87228);
insert into cursa
values (901, 20017923, 87235);

insert into cursa
values (902, 20017924, 85506);
insert into cursa
values (903, 20017924, 85508);
insert into cursa
values (904, 20017924, 87228);
insert into cursa
values (905, 20017924, 87235);

insert into cursa
values (906, 20017925, 85506);
insert into cursa
values (907, 20017925, 85508);
insert into cursa
values (908, 20017925, 87228);
insert into cursa
values (909, 20017925, 87235);

insert into cursa
values (910, 20017926, 85506);
insert into cursa
values (911, 20017926, 85508);
insert into cursa
values (912, 20017926, 87228);
insert into cursa
values (913, 20017926, 87235);

insert into cursa
values (914, 20017927, 85506);
insert into cursa
values (915, 20017927, 85508);
insert into cursa
values (916, 20017927, 87228);
insert into cursa
values (917, 20017927, 87235);

insert into cursa
values (918, 20017928, 85506);
insert into cursa
values (919, 20017928, 85508);
insert into cursa
values (920, 20017928, 87228);
insert into cursa
values (921, 20017928, 87235);

insert into cursa
values (922, 20017929, 85506);
insert into cursa
values (923, 20017929, 85508);
insert into cursa
values (924, 20017929, 87228);
insert into cursa
values (925, 20017929, 87235);

insert into cursa
values (926, 20017930, 85506);
insert into cursa
values (927, 20017930, 85508);
insert into cursa
values (928, 20017930, 87228);
insert into cursa
values (929, 20017930, 87235);

insert into cursa
values (930, 20017931, 85506);
insert into cursa
values (931, 20017931, 85508);
insert into cursa
values (932, 20017931, 87228);
insert into cursa
values (933, 20017931, 87235);

insert into cursa
values (934, 20017932, 85506);
insert into cursa
values (935, 20017932, 85508);
insert into cursa
values (936, 20017932, 87228);
insert into cursa
values (937, 20017932, 87235);

insert into cursa
values (938, 20017933, 23868);
insert into cursa
values (939, 20017933, 81891);
insert into cursa
values (940, 20017933, 75651);
insert into cursa
values (941, 20017933, 80637);

insert into cursa
values (942, 20017934, 23868);
insert into cursa
values (943, 20017934, 81891);
insert into cursa
values (944, 20017934, 75651);
insert into cursa
values (945, 20017934, 80637);

insert into cursa
values (946, 20017935, 23868);
insert into cursa
values (947, 20017935, 81891);
insert into cursa
values (948, 20017935, 75651);
insert into cursa
values (949, 20017935, 80637);

insert into cursa
values (950, 20017936, 23868);
insert into cursa
values (951, 20017936, 81891);
insert into cursa
values (952, 20017936, 75651);
insert into cursa
values (953, 20017936, 80637);

insert into cursa
values (954, 20017937, 23868);
insert into cursa
values (955, 20017937, 81891);
insert into cursa
values (956, 20017937, 75651);
insert into cursa
values (957, 20017937, 80637);

insert into cursa
values (958, 20017938, 23868);
insert into cursa
values (959, 20017938, 81891);
insert into cursa
values (960, 20017938, 75651);
insert into cursa
values (961, 20017938, 80637);

insert into cursa
values (962, 20017939, 23868);
insert into cursa
values (963, 20017939, 81891);
insert into cursa
values (964, 20017939, 75651);
insert into cursa
values (965, 20017939, 80637);

insert into cursa
values (966, 20017940, 23868);
insert into cursa
values (967, 20017940, 81891);
insert into cursa
values (968, 20017940, 75651);
insert into cursa
values (969, 20017940, 80637);

insert into cursa
values (970, 20017941, 23868);
insert into cursa
values (971, 20017941, 81891);
insert into cursa
values (972, 20017941, 75651);
insert into cursa
values (973, 20017941, 80637);

insert into cursa
values (974, 20017942, 23868);
insert into cursa
values (975, 20017942, 81891);
insert into cursa
values (976, 20017942, 75651);
insert into cursa
values (977, 20017942, 80637);

insert into cursa
values (978, 20017943, 23868);
insert into cursa
values (979, 20017943, 81891);
insert into cursa
values (980, 20017943, 75651);
insert into cursa
values (981, 20017943, 80637);

insert into cursa
values (982, 20017944, 23868);
insert into cursa
values (983, 20017944, 81891);
insert into cursa
values (984, 20017944, 75651);
insert into cursa
values (985, 20017944, 80637);

insert into cursa
values (986, 20017945, 23868);
insert into cursa
values (987, 20017945, 81891);
insert into cursa
values (988, 20017945, 75651);
insert into cursa
values (989, 20017945, 80637);

insert into cursa
values (990, 20017946, 23868);
insert into cursa
values (991, 20017946, 81891);
insert into cursa
values (992, 20017946, 75651);
insert into cursa
values (993, 20017946, 80637);

insert into cursa
values (994, 20017947, 23868);
insert into cursa
values (995, 20017947, 81891);
insert into cursa
values (996, 20017947, 75651);
insert into cursa
values (997, 20017947, 80637);

insert into cursa
values (998, 20017948, 23868);
insert into cursa
values (999, 20017948, 81891);
insert into cursa
values (1009, 20017948, 75651);
insert into cursa
values (1010, 20017948, 80637);

insert into cursa
values (1011, 20017949, 23868);
insert into cursa
values (1012, 20017949, 81891);
insert into cursa
values (1013, 20017949, 75651);
insert into cursa
values (1014, 20017949, 80637);

insert into cursa
values (1015, 20017950, 23868);
insert into cursa
values (1016, 20017950, 81891);
insert into cursa
values (1017, 20017950, 75651);
insert into cursa
values (1018, 20017950, 80637);

insert into cursa
values (1019, 20017951, 23868);
insert into cursa
values (1020, 20017951, 81891);
insert into cursa
values (1021, 20017951, 75651);
insert into cursa
values (1022, 20017951, 80637);

insert into cursa
values (1023, 20017952, 23868);
insert into cursa
values (1024, 20017952, 81891);
insert into cursa
values (1025, 20017952, 75651);
insert into cursa
values (1026, 20017952, 80637);

insert into cursa
values (1027, 20017953, 23868);
insert into cursa
values (1028, 20017953, 81891);
insert into cursa
values (1029, 20017953, 75651);
insert into cursa
values (1030, 20017953, 80637);

insert into cursa
values (1031, 20017954, 23868);
insert into cursa
values (1032, 20017954, 81891);
insert into cursa
values (1033, 20017954, 75651);
insert into cursa
values (1034, 20017954, 80637);

insert into cursa
values (1035, 20017955, 23868);
insert into cursa
values (1036, 20017955, 81891);
insert into cursa
values (1037, 20017955, 75651);
insert into cursa
values (1038, 20017955, 80637);

insert into cursa
values (1039, 20017956, 23868);
insert into cursa
values (1040, 20017956, 81891);
insert into cursa
values (1041, 20017956, 75651);
insert into cursa
values (1042, 20017956, 80637);

insert into cursa
values (1043, 20017957, 23868);
insert into cursa
values (1044, 20017957, 81891);
insert into cursa
values (1045, 20017957, 75651);
insert into cursa
values (1046, 20017957, 80637);

insert into cursa
values (1047, 20017958, 83570);
insert into cursa
values (1048, 20017958, 83574);
insert into cursa
values (1049, 20017958, 85527);
insert into cursa
values (1050, 20017958, 85532);

insert into cursa
values (1051, 20017959, 83570);
insert into cursa
values (1052, 20017959, 83574);
insert into cursa
values (1053, 20017959, 85527);
insert into cursa
values (1054, 20017959, 85532);

insert into cursa
values (1055, 20017960, 83570);
insert into cursa
values (1056, 20017960, 83574);
insert into cursa
values (1057, 20017960, 85527);
insert into cursa
values (1058, 20017960, 85532);

insert into cursa
values (1059, 20017961, 83570);
insert into cursa
values (1060, 20017961, 83574);
insert into cursa
values (1061, 20017961, 85527);
insert into cursa
values (1062, 20017961, 85532);

insert into cursa
values (1063, 20017962, 83570);
insert into cursa
values (1064, 20017962, 83574);
insert into cursa
values (1065, 20017962, 85527);
insert into cursa
values (1066, 20017962, 85532);

insert into cursa
values (1067, 20017963, 83570);
insert into cursa
values (1068, 20017963, 83574);
insert into cursa
values (1069, 20017963, 85527);
insert into cursa
values (1070, 20017963, 85532);

insert into cursa
values (1071, 20017964, 83570);
insert into cursa
values (1072, 20017964, 83574);
insert into cursa
values (1073, 20017964, 85527);
insert into cursa
values (1074, 20017964, 85532);

insert into cursa
values (1075, 20017965, 83570);
insert into cursa
values (1076, 20017965, 83574);
insert into cursa
values (1077, 20017965, 85527);
insert into cursa
values (1078, 20017965, 85532);

insert into cursa
values (1079, 20017966, 83570);
insert into cursa
values (1080, 20017966, 83574);
insert into cursa
values (1081, 20017966, 85527);
insert into cursa
values (1082, 20017966, 85532);

insert into cursa
values (1083, 20017967, 83570);
insert into cursa
values (1084, 20017967, 83574);
insert into cursa
values (1085, 20017967, 85527);
insert into cursa
values (1086, 20017967, 85532);

insert into cursa
values (1087, 20017968, 83570);
insert into cursa
values (1088, 20017968, 83574);
insert into cursa
values (1089, 20017968, 85527);
insert into cursa
values (1090, 20017968, 85532);

insert into cursa
values (1091, 20017969, 83570);
insert into cursa
values (1092, 20017969, 83574);
insert into cursa
values (1093, 20017969, 85527);
insert into cursa
values (1094, 20017969, 85532);

insert into cursa
values (1095, 20017970, 83570);
insert into cursa
values (1096, 20017970, 83574);
insert into cursa
values (1097, 20017970, 85527);
insert into cursa
values (1098, 20017970, 85532);

insert into cursa
values (1099, 20017971, 83570);
insert into cursa
values (1100, 20017971, 83574);
insert into cursa
values (1101, 20017971, 85527);
insert into cursa
values (1102, 20017971, 85532);

insert into cursa
values (1103, 20017972, 83570);
insert into cursa
values (1104, 20017972, 83574);
insert into cursa
values (1105, 20017972, 85527);
insert into cursa
values (1106, 20017972, 85532);

insert into cursa
values (1107, 20017973, 83570);
insert into cursa
values (1108, 20017973, 83574);
insert into cursa
values (1109, 20017973, 85527);
insert into cursa
values (1110, 20017973, 85532);

insert into cursa
values (1111, 20017974, 83570);
insert into cursa
values (1112, 20017974, 83574);
insert into cursa
values (1113, 20017974, 85527);
insert into cursa
values (1114, 20017974, 85532);

insert into cursa
values (1115, 20017975, 83570);
insert into cursa
values (1116, 20017975, 83574);
insert into cursa
values (1117, 20017975, 85527);
insert into cursa
values (1118, 20017975, 85532);

insert into cursa
values (1119, 20017976, 83570);
insert into cursa
values (1120, 20017976, 83574);
insert into cursa
values (1121, 20017976, 85527);
insert into cursa
values (1122, 20017976, 85532);

insert into cursa
values (1123, 20017977, 83570);
insert into cursa
values (1124, 20017977, 83574);
insert into cursa
values (1125, 20017977, 85527);
insert into cursa
values (1126, 20017977, 85532);

insert into cursa
values (1127, 20017978, 87359);
insert into cursa
values (1128, 20017978, 87752);
insert into cursa
values (1129, 20017978, 92679);

insert into cursa
values (1130, 20017979, 87359);
insert into cursa
values (1131, 20017979, 87752);
insert into cursa
values (1132, 20017979, 92679);

insert into cursa
values (1133, 20017980, 87359);
insert into cursa
values (1134, 20017980, 87752);
insert into cursa
values (1135, 20017980, 92679);

insert into cursa
values (1136, 20017981, 87359);
insert into cursa
values (1137, 20017981, 87752);
insert into cursa
values (1138, 20017981, 92679);

insert into cursa
values (1139, 20017982, 87359);
insert into cursa
values (1140, 20017982, 87752);
insert into cursa
values (1141, 20017982, 92679);

insert into cursa
values (1142, 20017983, 87359);
insert into cursa
values (1143, 20017983, 87752);
insert into cursa
values (1144, 20017983, 92679);

insert into cursa
values (1145, 20017984, 87359);
insert into cursa
values (1146, 20017984, 87752);
insert into cursa
values (1147, 20017984, 92679);

insert into cursa
values (1148, 20017985, 87359);
insert into cursa
values (1149, 20017985, 87752);
insert into cursa
values (1150, 20017985, 92679);

insert into cursa
values (1151, 20017986, 87359);
insert into cursa
values (1152, 20017986, 87752);
insert into cursa
values (1153, 20017986, 92679);

insert into cursa
values (1154, 20017987, 87359);
insert into cursa
values (1155, 20017987, 87752);
insert into cursa
values (1156, 20017987, 92679);

insert into cursa
values (1157, 20017988, 87359);
insert into cursa
values (1158, 20017988, 87752);
insert into cursa
values (1159, 20017988, 92679);

insert into cursa
values (1160, 20017989, 87359);
insert into cursa
values (1161, 20017989, 87752);
insert into cursa
values (1162, 20017989, 92679);
###
insert into cursa
values (1000, 21022784, 75778);
insert into cursa
values (1001, 21022785, 75778);
insert into cursa
values (1002, 21022786, 75778);
insert into cursa
values (1003, 21022784, 80607);
insert into cursa
values (1004, 21022785, 80607);
insert into cursa
values (1005, 21022786, 80607);
insert into cursa
values (1006, 21022784, 80610);
insert into cursa
values (1007, 21022785, 80610);
insert into cursa
values (1008, 21022786, 80610);
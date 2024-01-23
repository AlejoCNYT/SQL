-- Estructura y Restricciones Declarativas
-- Persistencia
-- Crear tablas
CREATE TABLE academia (
    codigoAcademia NUMBER(10) NOT NULL,
    nombreAcademia VARCHAR2(30) NOT NULL,
    estilo VARCHAR2(50) NOT NULL,
    web VARCHAR2(100) NOT NULL
);

CREATE TABLE sede (
    codigoSede NUMBER(10) NOT NULL,
    direccion VARCHAR2(300) NOT NULL,
    telefono NUMBER(10) NOT NULL,
    nombreSede VARCHAR2(30) NOT NULL,
    codigoSedeAcademia NUMBER(10) NOT NULL
);

CREATE TABLE entrenamiento (  
    codigoEntrenamiento NUMBER(10) NOT NULL,
    horario DATE NOT NULL,
    precio NUMBER(9,2) NOT NULL,
    rutina VARCHAR2(500) NOT NULL,
    enfoque VARCHAR2(20) NOT NULL,
    codigoEntrenamientoAprendiz NUMBER(10) NOT NULL,
    codigoEntrenamientoInstructor NUMBER(10) NOT NULL,
    codigoEntrenamientoSede NUMBER(10) NOT NULL
);

CREATE TABLE persona (
    codigoPersona NUMBER(10) NOT NULL,
    nombre VARCHAR2(50) NOT NULL,
    edad NUMBER(2) NOT NULL,
    email VARCHAR2(50) NOT NULL,
    telefono NUMBER(15) NOT NULL,
    sexo VARCHAR2(1) NOT NULL,
    imc NUMBER(4,2) NOT NULL,
    especialidad VARCHAR2(20),
    codigoEventoPersona NUMBER(10)
);

CREATE TABLE aprendiz (
    codigoAprendiz NUMBER(10),
    implementos VARCHAR2(50),
    rango VARCHAR2(20) DEFAULT 'blanco'
);

CREATE TABLE instructor (
    codigoInstructor NUMBER(10) NOT NULL,
    juez VARCHAR2(10) DEFAULT 'false' NOT NULL,
    dan VARCHAR2(5) DEFAULT 'I',
    codigoInstructorSede NUMBER(10) NOT NULL,
    codigoInstructorExamen NUMBER(10) NOT NULL
);

CREATE TABLE enfrentamiento (
    codigoEnfrentamiento NUMBER(10) NOT NULL,
    duracion NUMBER(3) NOT NULL,
    tipo VARCHAR(20) NOT NULL,
    round_ NUMBER(2) NOT NULL,
    codigoEnfrentamientoEntrenamiento NUMBER(10) 
);

CREATE TABLE historial (
    codigoHistorial NUMBER(10) NOT NULL,
    codigoHistorialEnfrentamiento NUMBER(10) NOT NULL,
    codigoHistorialPersona NUMBER(10) NOT NULL
);

CREATE TABLE merito (
    codigoMerito NUMBER(10) NOT NULL,
    especialidad VARCHAR2(20) NOT NULL,
    descripcion VARCHAR2(50) NOT NULL,
    codigoMeritoEnfrentamiento NUMBER(10),
    codigoMeritoPersona NUMBER(10) NOT NULL,
    desempeño VARCHAR2(1) NOT NULL,
    codigoMeritoEvento NUMBER(10)
);

CREATE TABLE evento ( 
    codigoEvento NUMBER(10) NOT NULL,
    fecha DATE NOT NULL,
    direccion VARCHAR2(50) NOT NULL,
    codigoEventoAcademia NUMBER(10) NOT NULL,
    codigoEventoPersona NUMBER(10) NOT NULL
);

CREATE TABLE examen (
    codigoExamen NUMBER(10) NOT NULL,
    precio NUMBER(9,2) NOT NULL,
    especialidad VARCHAR2(20),
    participantes NUMBER(4) NOT NULL
);

CREATE TABLE campeonato (
    codigoCampeonato NUMBER(10) NOT NULL,
    tipo VARCHAR2(10),
    recaudo NUMBER(9,2) NOT NULL,
    faltas NUMBER(3),
    empates NUMBER(3),
    participantes NUMBER(10) NOT NULL
    
);

CREATE TABLE colaborador (
    codigoColaborador NUMBER(10) NOT NULL,
    organizacion VARCHAR(100) NOT NULL,
    apoyo VARCHAR(20) NOT NULL,
    donacion NUMBER(9,2),
    material VARCHAR(500),
    codigoColaboradorCampeonato NUMBER(10) NOT NULL
);

-- Atributos
ALTER TABLE academia ADD CONSTRAINT chk_academia_web CHECK (web LIKE 'http%' AND web LIKE '%.com%');
ALTER TABLE academia ADD CONSTRAINT chk_academia_estilo CHECK (estilo IN ('Oh Do Kwan','Chang Moo Kwan','Moo Duk Kwan','Chong Do Kwan'));
ALTER TABLE entrenamiento ADD CONSTRAINT chk_entrenamento_enfoque CHECK (enfoque IN('combate','armas','figura'));
ALTER TABLE enfrentamiento ADD CONSTRAINT chk_enfrentamiento_tipo CHECK (tipo IN('combate','armas','figura'));
ALTER TABLE persona ADD CONSTRAINT chk_persona_email CHECK (email LIKE '%@%');
ALTER TABLE persona ADD CONSTRAINT chk_persona_edad CHECK (edad >= 3);
ALTER TABLE persona ADD CONSTRAINT chk_persona_sexo CHECK (sexo IN('M','F'));
ALTER TABLE persona ADD CONSTRAINT chk_persona_especialidad CHECK (especialidad IN('combate','armas','figura'));
ALTER TABLE aprendiz ADD CONSTRAINT chk_aprendiz_rango CHECK (rango IN('blanco','franja-amarillo','amarillo','franja-verde','verde','franja-rojo','rojo','franja-negro','negro'));
ALTER TABLE instructor ADD CONSTRAINT chk_instructor_dan CHECK (dan IN('I','II','III','IV','V','VI','VII','VIII','IX','X'));
ALTER TABLE instructor ADD CONSTRAINT chk_instructor_juez CHECK (juez IN('true','false'));
ALTER TABLE enfrentamiento ADD CONSTRAINT chk_enfrentaiento_tipo CHECK (tipo IN ('combate','armas','figura'));
ALTER TABLE merito ADD CONSTRAINT chk_merito_especialidad CHECK (especialidad IN('combate','armas','figura'));
ALTER TABLE examen ADD CONSTRAINT chk_examen_especialidad CHECK (especialidad IN('combate','armas','figura'));
ALTER TABLE merito ADD CONSTRAINT chk_merito_desempeño CHECK (desempeño IN('A','B','C','D','F'));
ALTER TABLE campeonato ADD CONSTRAINT chk_campeonato_tipo CHECK (tipo IN('combate','armas','figura'));
ALTER TABLE colaborador ADD CONSTRAINT chk_colaborador_apoyo CHECK (apoyo IN('dinero', 'voluntario', 'donacion'));

-- Primarias
ALTER TABLE sede ADD CONSTRAINT pk_codigo PRIMARY KEY (codigoSede);
ALTER TABLE academia ADD CONSTRAINT pk_academia PRIMARY KEY (codigoAcademia);
ALTER TABLE entrenamiento ADD CONSTRAINT pk_codigoEntrenamiento PRIMARY KEY (codigoEntrenamiento);
ALTER TABLE aprendiz ADD CONSTRAINT pk_aprendiz PRIMARY KEY (codigoAprendiz);
ALTER TABLE persona ADD CONSTRAINT pk_persona PRIMARY KEY (codigoPersona);
ALTER TABLE instructor ADD CONSTRAINT pk_instructor PRIMARY KEY (codigoInstructor);
ALTER TABLE historial ADD CONSTRAINT pk_historial PRIMARY KEY (codigoHistorial);
ALTER TABLE enfrentamiento ADD CONSTRAINT pk_enfrentamiento PRIMARY KEY (codigoEnfrentamiento);
ALTER TABLE merito ADD CONSTRAINT pk_merito PRIMARY KEY (codigoMerito);
ALTER TABLE evento ADD CONSTRAINT pk_evento PRIMARY KEY (codigoEvento);
ALTER TABLE examen ADD CONSTRAINT pk_examen PRIMARY KEY (codigoExamen);
ALTER TABLE campeonato ADD CONSTRAINT pk_campeonato PRIMARY KEY (codigoCampeonato);
ALTER TABLE colaborador ADD CONSTRAINT pk_colaborador PRIMARY KEY (codigoColaborador);

-- Unicas
ALTER TABLE sede ADD CONSTRAINT uk_sede UNIQUE (direccion,nombreSede);
ALTER TABLE academia ADD CONSTRAINT uk_academia UNIQUE (nombreAcademia,web);
ALTER TABLE persona ADD CONSTRAINT uk_persona UNIQUE (email);

-- Foraneas
ALTER TABLE enfrentamiento ADD CONSTRAINT fk_enfrentamiento_entrenamiento FOREIGN KEY (codigoEnfrentamientoEntrenamiento) REFERENCES entrenamiento(codigoEntrenamiento);
ALTER TABLE entrenamiento ADD CONSTRAINT fk_entrenamiento_sede FOREIGN KEY (codigoEntrenamientoSede) REFERENCES sede(codigoSede);
ALTER TABLE sede ADD CONSTRAINT fk_sede_academia FOREIGN KEY (codigoSedeAcademia) REFERENCES academia(codigoAcademia);
ALTER TABLE entrenamiento ADD CONSTRAINT fk_entrenamiento_aprendiz FOREIGN KEY (codigoEntrenamientoAprendiz) REFERENCES aprendiz(codigoAprendiz);
ALTER TABLE entrenamiento ADD CONSTRAINT fk_entrenamiento_instructor FOREIGN KEY (codigoEntrenamientoInstructor) REFERENCES instructor(codigoInstructor);
ALTER TABLE aprendiz ADD CONSTRAINT fk_aprendiz_persona FOREIGN KEY (codigoAprendiz) REFERENCES persona(codigoPersona);
ALTER TABLE instructor ADD CONSTRAINT fk_instructor_persona FOREIGN KEY (codigoInstructor) REFERENCES persona(codigoPersona);
ALTER TABLE evento ADD CONSTRAINT fk_evento_academia FOREIGN KEY (codigoEventoAcademia) REFERENCES academia(codigoAcademia);
ALTER TABLE evento ADD CONSTRAINT fk_evento_persona FOREIGN KEY (codigoEventoPersona) REFERENCES persona(codigoPersona);
ALTER TABLE instructor ADD CONSTRAINT fk_instructor_examen FOREIGN KEY (codigoInstructorExamen) REFERENCES examen(codigoExamen);
ALTER TABLE instructor ADD CONSTRAINT fk_instructor_sede FOREIGN KEY (codigoInstructorSede) REFERENCES sede(codigoSede);
ALTER TABLE examen ADD CONSTRAINT fk_examen_evento FOREIGN KEY (codigoExamen) REFERENCES evento(codigoEvento);
ALTER TABLE campeonato ADD CONSTRAINT fk_campeonato_evento FOREIGN KEY (codigoCampeonato) REFERENCES evento(codigoEvento);
ALTER TABLE colaborador ADD CONSTRAINT fk_colaborador_campeonato FOREIGN KEY (codigoColaboradorCampeonato) REFERENCES campeonato(codigoCampeonato);
ALTER TABLE merito ADD CONSTRAINT fk_merito_enfrentamiento FOREIGN KEY (codigoMeritoEnfrentamiento) REFERENCES enfrentamiento(codigoEnfrentamiento);
ALTER TABLE merito ADD CONSTRAINT fk_merito_persona FOREIGN KEY (codigoMeritoPersona) REFERENCES persona(codigoPersona);
ALTER TABLE merito ADD CONSTRAINT fk_merito_evento FOREIGN KEY (codigoMeritoEvento) REFERENCES evento(codigoEvento);
ALTER TABLE historial ADD CONSTRAINT fk_historial_enfrentamiento FOREIGN KEY (codigoHistorialEnfrentamiento) REFERENCES enfrentamiento(codigoEnfrentamiento);
ALTER TABLE historial ADD CONSTRAINT fk_historial_persona FOREIGN KEY (codigoHistorialPersona) REFERENCES persona(codigoPersona);

--XTablas
DROP TABLE sede CASCADE CONSTRAINTS;
DROP TABLE entrenamiento CASCADE CONSTRAINTS;
DROP TABLE academia CASCADE CONSTRAINTS;
DROP TABLE persona CASCADE CONSTRAINTS;
DROP TABLE aprendiz CASCADE CONSTRAINTS;
DROP TABLE instructor CASCADE CONSTRAINTS;
DROP TABLE enfrentamiento CASCADE CONSTRAINTS;
DROP TABLE merito CASCADE CONSTRAINTS;
DROP TABLE historial CASCADE CONSTRAINTS;
DROP TABLE colaborador CASCADE CONSTRAINTS;
DROP TABLE campeonato CASCADE CONSTRAINTS;
DROP TABLE examen CASCADE CONSTRAINTS;
DROP TABLE evento CASCADE CONSTRAINTS;

-- Cosultas 
-- Gerenciales

-- Operativas

-- Administrador
-- Consultar Instructores
SELECT ROWNUM AS indicador, evento.codigoEvento, persona.nombre, NVL(persona.especialidad,'No registra') AS ESPECIALIDAD, instructor.juez, persona.telefono
  FROM instructor JOIN persona ON (persona.codigoPersona = instructor.codigoInstructor)
                  JOIN evento ON (evento.codigoEventoPersona = persona.codigoPersona)
WHERE instructor.juez = 'true';
                  
-- Consultar Aprendiz
   SELECT ROWNUM AS indicator, persona.nombre, NVL(aprendiz.implementos, 'No registra') AS IMPLEMENTOS, merito.descripcion, persona.email, sede.nombreSede AS SEDE, sede.telefono
     FROM sede JOIN instructor ON (sede.codigoSede = instructor.codigoInstructorSede)
            JOIN persona ON (instructor.codigoInstructor = persona.codigoPersona)
            JOIN aprendiz ON (aprendiz.codigoAprendiz = persona.codigoPersona)
            JOIN merito ON (merito.codigoMeritoPersona = persona.codigoPersona)
    WHERE merito.descripcion LIKE 'medalla%'
 ORDER BY persona.nombre ASC;

-- INSTRUCTOR
-- Consultar Meritos
SELECT DISTINCT persona.nombre, merito.descripcion AS Reconocimiento, evento.direccion, ROWNUM AS indicador
  FROM  persona JOIN merito ON (persona.codigoPersona = merito.codigoMeritoPersona)
                JOIN evento ON (merito.codigoMeritoEvento = evento.codigoEvento)
ORDER BY Reconocimiento ASC;

-- Consultar Examen
  SELECT  aprendiz.rango, COUNT(codigoPersona) AS Cinturones_Actuales
    FROM aprendiz JOIN persona ON (aprendiz.codigoAprendiz = persona.codigoPersona)
                  JOIN evento ON (evento.codigoEventoPersona = persona.codigoPersona)
GROUP BY aprendiz.rango;

-- Consultar Entrenamiento
SELECT ROWNUM AS indicador, persona.nombre AS Instructor, entrenamiento.horario AS FECHA, entrenamiento.rutina, entrenamiento.precio AS PRECIO_LECCION, enfrentamiento.tipo
  FROM persona JOIN instructor ON (persona.codigoPersona = instructor.codigoInstructor)
               JOIN entrenamiento ON (entrenamiento.codigoEntrenamientoInstructor = instructor.codigoInstructor)
               JOIN enfrentamiento ON (entrenamiento.codigoEntrenamiento = enfrentamiento.codigoEnfrentamientoEntrenamiento);

-- Consultar Merito
SELECT ROWNUM AS indicador, persona.codigoPersona, campeonato.tipo, merito.desempeï¿½o, evento.fecha
  FROM merito JOIN persona ON (merito.codigoMeritoPersona = persona.codigoPersona)
              JOIN evento ON (evento.codigoEvento = merito.codigoMeritoEvento)
              JOIN campeonato ON (campeonato.codigoCampeonato = evento.codigoEvento)
 WHERE campeonato.codigoCampeonato = 0175927392;
 
-- Consultar colaborador
 SELECT ROWNUM AS indicador, evento.codigoEvento AS EVENTO, colaborador.organizacion, TO_CHAR(colaborador.donacion/campeonato.recaudo*100,'999.99') || '%' AS Aporte
   FROM evento JOIN campeonato ON (campeonato.codigoCampeonato = evento.codigoEvento)
               JOIN colaborador ON (colaborador.codigoColaboradorCampeonato = campeonato.codigoCampeonato)
  WHERE colaborador.apoyo = 'dinero';

-- Encargado
-- Consultar Instructores 
SELECT ROWNUM AS indicador, codigoEntrenamiento, persona.nombre, enfrentamiento.tipo
  FROM  entrenamiento JOIN enfrentamiento ON (entrenamiento.codigoEntrenamiento = enfrentamiento.codigoEnfrentamientoEntrenamiento)
                      JOIN Aprendiz ON (entrenamiento.codigoEntrenamientoAprendiz = aprendiz.codigoAprendiz)
                      JOIN persona ON (aprendiz.codigoAprendiz = persona.codigoPersona);
                      
-- Consultar Enfrentamientos
SELECT ROWNUM AS indicador, persona.nombre, persona.imc, enfrentamiento.duracion*enfrentamiento.round_ AS TIEMPO
  FROM persona JOIN historial ON (codigoPersona = codigoHistorialPersona)
               JOIN enfrentamiento ON (enfrentamiento.codigoEnfrentamiento = codigoHistorialEnfrentamiento);

-- Colaborador
-- Consultar Academias
SELECT academia.nombreAcademia, academia.web, campeonato.participantes, evento.fecha
  FROM academia JOIN sede ON (academia.codigoAcademia = sede.codigoSedeAcademia)
                JOIN instructor ON (instructor.codigoInstructorSede = sede.codigoSede)
                JOIN persona ON (instructor.codigoInstructor = persona.codigoPersona)
                JOIN evento ON (evento.codigoEventoPersona = persona.codigoPersona)
                JOIN campeonato ON (evento.codigoEvento = campeonato.codigoCampeonato)
                JOIN colaborador ON (colaborador.codigoColaboradorCampeonato = campeonato.codigoCampeonato);

-- PoblarOK
INSERT INTO academia (nombreAcademia, estilo, web) VALUES ('Jung Kwon', 'Oh Do Kwan', 'http://www.ashevilleselfdefense.com/about-us.com');
INSERT INTO academia (nombreAcademia, estilo, web) VALUES ('K-Tigers Taekwondo', 'Oh Do Kwan', 'https://cafe.daum.com');
INSERT INTO academia (nombreAcademia, estilo, web) VALUES ('Songahm Taekwondo', 'Chong Do Kwan','https://www.escuelachosan.com/post/taekwondo-estilo-chung-do-kwan');
INSERT INTO academia (nombreAcademia, estilo, web) VALUES ('Songahm Korea', 'Chong Do Kwan','http://www.worldtaekwondo.com');
INSERT INTO academia (nombreAcademia, estilo, web) VALUES ('Taekwondo Songahm', 'Oh Do Kwan','http://www.worldtaekwondo.com');

INSERT INTO sede (codigoSede, direccion, telefono, nombreSede, codigoSedeAcademia) VALUES (1623723845, 'Calle 3 Nro 24 - 26', 3678375293, 'Chan hun Colombia', 3678375293);
INSERT INTO sede (codigoSede, direccion, telefono, nombreSede, codigoSedeAcademia) VALUES (2623723845, 'Cra 6 Nro 63 - 11', 3678375493, 'Kukkiwon', 6345233423);
INSERT INTO sede (codigoSede, direccion, telefono, nombreSede, codigoSedeAcademia) VALUES (8346325754, 'Calle 51 Nro 47 - 71', 3678335293, 'Taekwondowon', 4237457233);
INSERT INTO sede (codigoSede, direccion, telefono, nombreSede, codigoSedeAcademia) VALUES (7345314634, 'Calle 63 Nro 64 - 32', 3678377393, 'Taekwondo Center', 5252379334);
INSERT INTO sede (codigoSede, direccion, telefono, nombreSede, codigoSedeAcademia) VALUES (6246744536, 'Carrera 13 Nro 74 - 31', 3678375893, 'International Taekwondo', 6346434634);

INSERT INTO persona (codigoPersona, nombre, edad, email, telefono, sexo, imc, especialidad) VALUES (4750275839, 'Andres Hernesto Perez', 6, 'Andres_h03@hotmail.com', 3224116273, 'M', 58.3, 'armas');
INSERT INTO persona (codigoPersona, nombre, edad, email, telefono, sexo, imc, especialidad) VALUES (4758629503, 'Camilo Rizo', 11, 'CamTK5@yahoo.com', 3052748588, 'M', 63.2, 'figura');
INSERT INTO persona (codigoPersona, nombre, edad, email, telefono, sexo, imc, especialidad) VALUES (4758394856, 'Maria Paula Poblado', 17, 'pau7po@gmail.com', 3037276283, 'F', 44.6, null);
INSERT INTO persona (codigoPersona, nombre, edad, email, telefono, sexo, imc, especialidad) VALUES (8494528475, 'Alejandra Murcia', 21, 'murcialj@outlook.com', 3002139887, 'F', 54.3, 'figura');
INSERT INTO persona (codigoPersona, nombre, edad, email, telefono, sexo, imc, especialidad) VALUES (0184957367, 'Otilia Eslava', 13, 'OtiEs@mail.com', 3147890089, 'F', 41.8, 'combate');

INSERT INTO aprendiz (codigoAprendiz, implementos, rango) VALUES (4750275839, null, 'blanco');
INSERT INTO aprendiz (codigoAprendiz, implementos, rango) VALUES (4758629503, 'Casco, bo, paleta', 'verde');
INSERT INTO aprendiz (codigoAprendiz, implementos, rango) VALUES (4758394856, null, 'blanco');
INSERT INTO aprendiz (codigoAprendiz, implementos, rango) VALUES (8494528475, 'Dobok, hogu, manopla, moktog, makiwara', 'negro');
INSERT INTO aprendiz (codigoAprendiz, implementos, rango) VALUES (0184957367, 'Pads, casco', 'amarillo');

INSERT INTO evento (codigoEvento, fecha, direccion, codigoEventoAcademia, codigoEventoPersona) VALUES (8429305294, TO_DATE('14/12/2024', 'DD/MM/YYYY'), 'Calle 4 Nro 13 - 23', 3678375293, 4750275839);
INSERT INTO evento (codigoEvento, fecha, direccion, codigoEventoAcademia, codigoEventoPersona) VALUES (5738429340, TO_DATE('06/03/2024', 'DD/MM/YYYY'), 'Cra 5 Nro 34 - 76', 6345233423, 4758629503);----------------------**********
INSERT INTO evento (codigoEvento, fecha, direccion, codigoEventoAcademia, codigoEventoPersona) VALUES (5893048254, TO_DATE('14/12/2024', 'DD/MM/YYYY'), 'Calle 36 Nro 63 - 4', 4237457233, 4758394856);
INSERT INTO evento (codigoEvento, fecha, direccion, codigoEventoAcademia, codigoEventoPersona) VALUES (0175927392, TO_DATE('24/07/2024', 'DD/MM/YYYY'), 'Cra 73 Nro 3 - 126', 5252379334, 8494528475);
INSERT INTO evento (codigoEvento, fecha, direccion, codigoEventoAcademia, codigoEventoPersona) VALUES (0184023843, TO_DATE('06/03/2024', 'DD/MM/YYYY'), 'Cra 42 Nro 52 - 35', 6346434634, 0184957367);

INSERT INTO campeonato (codigoCampeonato, tipo, recaudo, faltas, empates, participantes) VALUES (8429305294, 'combate', 5345768.12, 7, 1, 254);
INSERT INTO campeonato (codigoCampeonato, tipo, recaudo, faltas, empates, participantes) VALUES (5738429340, 'figura', 4356192.54, 5, 0, 219);
INSERT INTO campeonato (codigoCampeonato, tipo, recaudo, faltas, empates, participantes) VALUES (5893048254, 'combate', 9352123.23, 11, 3, 434);
INSERT INTO campeonato (codigoCampeonato, tipo, recaudo, faltas, empates, participantes) VALUES (0175927392, 'armas', 897263.43, 9, 2, 411);
INSERT INTO campeonato (codigoCampeonato, tipo, recaudo, faltas, empates, participantes) VALUES (0184023843, 'figura', 7191239.53, 6, 3, 385);

INSERT INTO colaborador (codigoColaborador, organizacion, apoyo, donacion, material, codigoColaboradorCampeonato) VALUES (2309157573, 'Panaderia Jurassic Pan', 'dinero', 235873.53, null, 8429305294);
INSERT INTO colaborador (codigoColaborador, organizacion, apoyo, donacion, material, codigoColaboradorCampeonato) VALUES (2394875934, 'EscuelaIng', 'voluntario', null, null, 5738429340);
INSERT INTO colaborador (codigoColaborador, organizacion, apoyo, donacion, material, codigoColaboradorCampeonato) VALUES (0932873489, 'Alcaldia Cundinamarca', 'voluntario', null, null, 5893048254);
INSERT INTO colaborador (codigoColaborador, organizacion, apoyo, donacion, material, codigoColaboradorCampeonato) VALUES (1345098734, 'Pizza Domino s', 'dinero', 303897.53, null, 0175927392);
INSERT INTO colaborador (codigoColaborador, organizacion, apoyo, donacion, material, codigoColaboradorCampeonato) VALUES (0981345934, 'Liga ITF Colombia', 'donacion', null, 'Patrocinio y Coliseo El pueblo', 0184023843);

INSERT INTO examen (codigoExamen, precio, especialidad, participantes) VALUES (8429305294, 120000.00, 'combate', 36);
INSERT INTO examen (codigoExamen, precio, especialidad, participantes) VALUES (5738429340, 160000.00, null, 128);
INSERT INTO examen (codigoExamen, precio, especialidad, participantes) VALUES (5893048254, 150000.00, 'armas', 5);
INSERT INTO examen (codigoExamen, precio, especialidad, participantes) VALUES (0175927392, 90000.00, 'figura', 89);
INSERT INTO examen (codigoExamen, precio, especialidad, participantes) VALUES (0184023843, 110000.00, 'armas', 58);

INSERT INTO instructor (codigoInstructor, juez, dan, codigoInstructorSede, codigoInstructorExamen) VALUES (4750275839, 'false', 'II', 1623723845, 8429305294);
INSERT INTO instructor (codigoInstructor, juez, dan, codigoInstructorSede, codigoInstructorExamen) VALUES (4758629503, 'false', 'II', 2623723845, 5738429340); 
INSERT INTO instructor (codigoInstructor, juez, dan, codigoInstructorSede, codigoInstructorExamen) VALUES (4758394856, 'true', 'V', 8346325754, 5893048254);
INSERT INTO instructor (codigoInstructor, juez, dan, codigoInstructorSede, codigoInstructorExamen) VALUES (8494528475, 'false', 'IV', 7345314634, 0175927392);
INSERT INTO instructor (codigoInstructor, juez, dan, codigoInstructorSede, codigoInstructorExamen) VALUES (0184957367, 'true', 'VII', 6246744536, 0184023843);

INSERT INTO entrenamiento (codigoEntrenamiento, horario, precio, rutina, enfoque, CodigoEntrenamientoAprendiz, CodigoEntrenamientoInstructor, CodigoEntrenamientoSede) VALUES (6237892346, TO_DATE('24/11/2025', 'DD/MM/YYYY'), 5000.21, 'pierna - serie repeticiones - figuras con pierna', 'figura', 4750275839, 4750275839, 1623723845);
INSERT INTO entrenamiento (codigoEntrenamiento, horario, precio, rutina, enfoque, CodigoEntrenamientoAprendiz, CodigoEntrenamientoInstructor, CodigoEntrenamientoSede) VALUES (5235323432, TO_DATE('24/05/2024', 'DD/MM/YYYY'), 8000.00, 'pierna - serie repeticiones - figuras con pierna', 'armas', 4758629503, 4758629503, 2623723845);
INSERT INTO entrenamiento (codigoEntrenamiento, horario, precio, rutina, enfoque, CodigoEntrenamientoAprendiz, CodigoEntrenamientoInstructor, CodigoEntrenamientoSede) VALUES (6723809023, TO_DATE('24/04/2026', 'DD/MM/YYYY'), 12000.00, 'pierna - serie repeticiones - figuras con pierna', 'figura', 4758394856, 4758394856, 8346325754);
INSERT INTO entrenamiento (codigoEntrenamiento, horario, precio, rutina, enfoque, CodigoEntrenamientoAprendiz, CodigoEntrenamientoInstructor, CodigoEntrenamientoSede) VALUES (7826923096, TO_DATE('25/10/2023', 'DD/MM/YYYY'), 20000.00, 'pierna - serie repeticiones - figuras con pierna', 'combate', 8494528475, 8494528475, 7345314634);
INSERT INTO entrenamiento (codigoEntrenamiento, horario, precio, rutina, enfoque, CodigoEntrenamientoAprendiz, CodigoEntrenamientoInstructor, CodigoEntrenamientoSede) VALUES (2349687630, TO_DATE('20/02/2028', 'DD/MM/YYYY'), 32000.00, 'pierna - serie repeticiones - figuras con pierna', 'combate', 0184957367, 0184957367, 6246744536);

INSERT INTO enfrentamiento (codigoEnfrentamiento, duracion, tipo, round_, codigoEnfrentamientoEntrenamiento) VALUES (5723809984, 2, 'figura', 1, 6237892346);
INSERT INTO enfrentamiento (codigoEnfrentamiento, duracion, tipo, round_, codigoEnfrentamientoEntrenamiento) VALUES (6720238975, 1, 'armas', 2, 5235323432);
INSERT INTO enfrentamiento (codigoEnfrentamiento, duracion, tipo, round_, codigoEnfrentamientoEntrenamiento) VALUES (5897039458, 3, 'combate', 1, 6723809023);
INSERT INTO enfrentamiento (codigoEnfrentamiento, duracion, tipo, round_, codigoEnfrentamientoEntrenamiento) VALUES (5892870623, 2, 'armas', 4, 7826923096);
INSERT INTO enfrentamiento (codigoEnfrentamiento, duracion, tipo, round_, codigoEnfrentamientoEntrenamiento) VALUES (6709329487, 1, 'figura', 3, 2349687630);

INSERT INTO merito (codigoMerito, especialidad, descripcion, codigoMeritoEnfrentamiento, codigoMeritoPersona, desempeño, codigoMeritoEvento) VALUES (6434535645, 'figura', 'medalla de plata', 5723809984, 4750275839, 'A', 8429305294);
INSERT INTO merito (codigoMerito, especialidad, descripcion, codigoMeritoEnfrentamiento, codigoMeritoPersona, desempeño, codigoMeritoEvento) VALUES (3475737824, 'armas', 'medalla de oro', 6720238975, 4758629503, 'B', 5738429340);
INSERT INTO merito (codigoMerito, especialidad, descripcion, codigoMeritoEnfrentamiento, codigoMeritoPersona, desempeño, codigoMeritoEvento) VALUES (7323454658, 'figura', 'medalla de plata', 5897039458, 4758394856, 'A', 5893048254);
INSERT INTO merito (codigoMerito, especialidad, descripcion, codigoMeritoEnfrentamiento, codigoMeritoPersona, desempeño, codigoMeritoEvento) VALUES (0923857837, 'combate', 'medalla de bronce', 5892870623, 8494528475, 'B', 0175927392);
INSERT INTO merito (codigoMerito, especialidad, descripcion, codigoMeritoEnfrentamiento, codigoMeritoPersona, desempeño, codigoMeritoEvento) VALUES (0134789345, 'armas', 'medalla de bronce', 6709329487, 0184957367, 'C', 0184023843);

INSERT INTO historial (codigoHistorial, codigoHistorialEnfrentamiento, codigoHistorialPersona) VALUES (5237803765, 5723809984, 4750275839);
INSERT INTO historial (codigoHistorial, codigoHistorialEnfrentamiento, codigoHistorialPersona) VALUES (7523408939, 6720238975, 4758629503);
INSERT INTO historial (codigoHistorial, codigoHistorialEnfrentamiento, codigoHistorialPersona) VALUES (0134578208, 5897039458, 4758394856);
INSERT INTO historial (codigoHistorial, codigoHistorialEnfrentamiento, codigoHistorialPersona) VALUES (0349087293, 5892870623, 8494528475);
INSERT INTO historial (codigoHistorial, codigoHistorialEnfrentamiento, codigoHistorialPersona) VALUES (0134895729, 6709329487, 0184957367);

select * from academia;
-- PoblarNoOk
-- SEDE
-- Valor demasiado grande en nombre sede 
INSERT INTO sede (codigoSede, direccion, telefono, nombreSede, codigoSedeAcademia) VALUES (6246744536, 'Carrera 13 Nro 74 - 31', 3678375893, 'International Taekwondo Headquarters', 6346434634);
-- Pk unica no repetible
INSERT INTO sede (codigoSede, direccion, telefono, nombreSede, codigoSedeAcademia) VALUES (8346325754, 'Calle 51 Nro 47 - 71', 3678335293, 'Taekwondowon', 5829823479);
-- FK no coincide en codigoSedeAcademia a codigoAcademia
INSERT INTO sede (codigoSede, direccion, telefono, nombreSede, codigoSedeAcademia) VALUES (5720382945, 'Carrera 13 Nro 74 - 31', 3678375893, 'International Taekwondo', 6783994834);

-- ACADEMIA
-- estilo invï¿½lido
INSERT INTO academia (codigoAcademia, nombreAcademia, estilo, web) VALUES (3678375293, 'Jung Kwon', 'WTF', 'http://www.ashevilleselfdefense.com/about-us.com');
-- No contiene http
INSERT INTO academia (codigoAcademia, nombreAcademia, estilo, web) VALUES (6345233423, 'K-Tigers Taekwondo', 'Oh Do Kwan', 'www.cafe.daum.net/tkdjido');
-- No contiene .com
INSERT INTO academia (codigoAcademia, nombreAcademia, estilo, web) VALUES (6345233423, 'K-Tigers Taekwondo', 'Oh Do Kwan', 'https://cafe.daum.net/tkdjido');

-- ENTRENAMIENTO
-- Mes debe ser posterior
INSERT INTO entrenamiento (codigoEntrenamiento, horario, precio, rutina, enfoque, CodigoEntrenamientoAprendiz, CodigoEntrenamientoInstructor, CodigoEntrenamientoSede) VALUES (5235323432, '2023-7-30 08:30:00', 5000.00, 'pierna - serie repeticiones - figuras con pierna', 'figuras', 8456482567, 8249249426, 0274503645);
-- Too many values, falta considerar algunos errores
INSERT INTO entrenamiento (codigoEntrenamiento, horario, precio, rutina, enfoque) VALUES (5235323432, '2024-7-30 08:30:00', 5000.00, 'pierna - serie repeticiones - figuras con pierna', 'figuras', 8456482567, 8249249426, 0274503645);
-- Formato de fecha inadecuado
INSERT INTO entrenamiento (codigoEntrenamiento, horario, precio, rutina, enfoque, CodigoEntrenamientoAprendiz, CodigoEntrenamientoInstructor, CodigoEntrenamientoSede) VALUES (5235323432, '2023-12-30 08:30:00', 5000.00, 'pierna - serie repeticiones - figuras con pierna', 'figuras', 8456482567, 8249249426, 0274503645);

-- Persona
-- No tiene atriburo de sexo
INSERT INTO persona (codigoPersona, nombre, edad, email, telefono, imc, especialidad) VALUES (4750275839, 'Andres Hernesto Perez', 6, 'Andres_h03@hotmail.com', 3224116273, 58.3, 'armas');
-- falta llenar atributo
INSERT INTO persona (codigoPersona, nombre, edad, email, telefono, sexo, imc, especialidad) VALUES (8494528475, 'Alejandra Murcia', 21, 'murcialj@outlook.com', 3002139887, 54.3, 'figura');
-- Numero de digitos excede la precision indicada
INSERT INTO persona (codigoPersona, nombre, edad, email, telefono, sexo, imc, especialidad) VALUES (4758629503, 'Camilo Rizo', 11, 'CamTK5@yahoo.com', 3052748588, 'M', 613.2, 'figura');

-- Aprendiz
-- Clave principal no encontrada
INSERT INTO aprendiz (codigoAprendiz, implementos, rango) VALUES (4758143859, null, 'blanco')
--  Pk no existe
INSERT INTO aprendiz (codigoAprendiz, implementos, rango) VALUES (4857364951, 'Pads, casco', 'amarillo')
-- Atributo no puede ser nulo
INSERT INTO aprendiz (codigoAprendiz, implementos, rango) VALUES (4758629503, 'Casco, bo, paleta', null)

-- Evento
-- PK no existe
INSERT INTO evento (codigoEvento, fecha, direccion, codigoEventoAcademia, codigoEventoPersona) VALUES (5738405369, '14/12/2024', 'Calle 4 Nro 13 - 23', 3678375293, 4750275839);
-- PK unica
INSERT INTO evento (codigoEvento, fecha, direccion, codigoEventoAcademia, codigoEventoPersona) VALUES (5893048254, '06/03/2024', 'Cra 42 Nro 52 - 35', 6346434634, 0184957367);
-- Fk no coincide
INSERT INTO evento (codigoEvento, fecha, direccion, codigoEventoAcademia, codigoEventoPersona) VALUES (5278304289, '06/03/2024', 'Cra 42 Nro 52 - 35', 5278923942, 5728307293);

-- Examen
-- Valor no puede ser nulo
INSERT INTO examen(codigoExamen, precio, especialidad, participantes) VALUES (5738405369, 120000.00, 36, null);
-- precio muy grande
INSERT INTO examen (codigoExamen, precio, especialidad, participantes) VALUES (0175927392, 10000000000.00, 'figura', 89);
-- Fk no coincide
INSERT INTO examen (codigoExamen, precio, especialidad, participantes) VALUES (5718290102, 90000.00, 'figura', 89);

-- Campeonato
-- empate no es vï¿½lido
INSERT INTO campeonato (codigoCampeonato, tipo, recaudo, faltas, empate, participantes) VALUES (8429305294, 'combate', 5345768.12, 7, 1, 254);
-- tipo no puede ser nulo
INSERT INTO campeonato (codigoCampeonato, tipo, recaudo, faltas, empate, participantes) VALUES (7523087938, null, 5345768.12, 7, 1, 254);
-- valor no vï¿½lido de recaudo
INSERT INTO campeonato (codigoCampeonato, tipo, recaudo, faltas, empate, participantes) VALUES (2384075968, 'combate', 7209872033.34, 7, 1, 254);

-- Colaborador
-- Muchos valores, el numero 3 corresponde a atributo no existente
INSERT INTO colaborador (codigoColaborador, organizacion, apoyo, donacion, material, codigoColaboradorCampeonato) VALUES (2309157573, 'Panaderia Jurassic Pan', 'dinero', 235873.53, null, 3, 8429305294);
-- Tipo de apoyo incorrecto
INSERT INTO colaborador (codigoColaborador, organizacion, apoyo, donacion, material, codigoColaboradorCampeonato) VALUES (2309589834, 'Federacion ITF', 'Dinero', 235873.53, null, 8429305294);
-- Tipo de apoyo incorrecto
INSERT INTO colaborador (codigoColaborador, organizacion, apoyo, donacion, material, codigoColaboradorCampeonato) VALUES (0909134539, 'Academia Oriental de idioma', 'volunatio', null, null, 8429305294);

-- Instructor
-- Falta codigoInstructorSede
INSERT INTO instructor (codigoInstructor, juez, dan, codigoInstructorSede, codigoInstructorExamen) VALUES (4859472048, false, 'blanco', 8429305294);
-- valor falso deve ser varchar
INSERT INTO instructor (codigoInstructor, juez, dan, codigoInstructorSede, codigoInstructorExamen) VALUES (4859472048, false, 'blanco', 1623723845, 8429305294);
-- dan debe ser nï¿½mero romano 
INSERT INTO instructor (codigoInstructor, juez, dan, codigoInstructorSede, codigoInstructorExamen) VALUES (4859472048, 'false', 'blanco', 1623723845, 8429305294);

-- Entrenamiento
-- Enfoque es incorrecto
INSERT INTO entrenamiento (codigoEntrenamiento, horario, precio, rutina, enfoque, CodigoEntrenamientoAprendiz, CodigoEntrenamientoInstructor, CodigoEntrenamientoSede) VALUES (5235323432, '24/05/2024', 8000.00, 'pierna - serie repeticiones - figuras con pierna', 'armass', 4758629503, 4758629503, 2623723845);
-- fk entrenamiento no existe
INSERT INTO entrenamiento (codigoEntrenamiento, horario, precio, rutina, enfoque, CodigoEntrenamientoAprendiz, CodigoEntrenamientoInstructor, CodigoEntrenamientoSede) VALUES (6723809023, '24/04/2026', 12000.00, 'pierna - serie repeticiones - figuras con pierna', 'figura', 4758394856, 4758394856, 572839793);
-- fk de instructor no coincide
INSERT INTO entrenamiento (codigoEntrenamiento, horario, precio, rutina, enfoque, CodigoEntrenamientoAprendiz, CodigoEntrenamientoInstructor, CodigoEntrenamientoSede) VALUES (6723809023, '24/04/2026', 12000.00, 'pierna - serie repeticiones - figuras con pierna', 'figura', 4758394856, 6243708923, 8346325754);

-- Enfrentamiento
-- CodigoEnfrentamintoEntrenamiento no existe
INSERT INTO enfrentamiento (codigoEnfrentamiento, duracion, tipo, round_, codigoEntrenamientoEnfrentamiento) VALUES (57238093984, 2, 'figura', 1, 2038723789);
-- identifocador codigoEntrenamientoEnfrentamiento no vï¿½lido
INSERT INTO enfrentamiento (codigoEnfrentamiento, duracion, tipo, round_, codigoEntrenamientoEnfrentamiento) VALUES (57238093984, 2, 'figura', 1, 6237892346);
-- Imprecision del codigoEnfrentamiento
INSERT INTO enfrentamiento (codigoEnfrentamiento, duracion, tipo, round_, codigoEnfrentamientoEntrenamiento) VALUES (57238093984, 2, 'figura', 1, 6237892346);

-- Historial
-- Codigo historial no puede ser null
INSERT INTO historial (codigoHistorial, codigoHistorialEnfrentamiento, codigoHistorialPersona) VALUES (, 5723809984, 4750275839);
-- codigoHistorialEnfrentamiento no coincide
INSERT INTO historial (codigoHistorial, codigoHistorialEnfrentamiento, codigoHistorialPersona) VALUES (5723809984, 2936401658, 3759104736);
-- codigoHistorialPersona esde tipo no valido
INSERT INTO historial (codigoHistorial, codigoHistorialEnfrentamiento, codigoHistorialPersona) VALUES (5723809984, 2936401658, 'Tipo invalido');

-- XPoblar
DELETE FROM sede;
DELETE FROM entrenamiento;
DELETE FROM academia;
DELETE FROM persona;
DELETE FROM aprendiz;
DELETE FROM instructor;
DELETE FROM enfrentamiento;
DELETE FROM merito;
DELETE FROM historial;
DELETE FROM colaborador;
DELETE FROM campeonato;
DELETE FROM examen;
DELETE FROM evento;

-- Restricciones Declarativas, Procedimentales y Automatizaciï¿½n
-- Disparadores
-- Autogenerar codigos de tablas
CREATE OR REPLACE TRIGGER trg_academia_codigo
BEFORE INSERT ON academia
FOR EACH ROW
DECLARE
    v_academia_codigo NUMBER(10);
BEGIN
    -- Generar un nï¿½mero aleatorio de 10 dï¿½gitos como cï¿½digo
    v_academia_codigo := FLOOR(DBMS_RANDOM.VALUE(1000000000, 9999999999));

    -- Asignar el cï¿½digo generado a la columna codigoAcademia
    :NEW.codigoAcademia := v_academia_codigo;
END;
/

CREATE OR REPLACE TRIGGER trg_sede_codigo
BEFORE INSERT ON sede
FOR EACH ROW
DECLARE
    v_sede_codigo NUMBER(10);
BEGIN
    -- Generar un n?mero aleatorio de 10 d?gitos como c?digo
    v_sede_codigo := FLOOR(DBMS_RANDOM.VALUE(1000000000, 9999999999));

    -- Asignar el c?digo generado a la columna codigoAcademia
    :NEW.codigoSede := v_sede_codigo;
END;
/

CREATE OR REPLACE TRIGGER trg_entrenamiento_codigo
BEFORE INSERT ON entrenamiento
FOR EACH ROW
DECLARE
    v_entrenamiento_codigo NUMBER(10);
BEGIN
    -- Generar un nï¿½mero aleatorio de 10 dï¿½gitos como cï¿½digo
    v_entrenamiento_codigo := FLOOR(DBMS_RANDOM.VALUE(1000000000, 9999999999));

    -- Asignar el cï¿½digo generado a la columna codigoAcademia
    :NEW.codigoEntrenamiento := v_entrenamiento_codigo;
END;
/

CREATE OR REPLACE TRIGGER trg_persona_codigo
BEFORE INSERT ON persona
FOR EACH ROW
DECLARE
    v_persona_codigo NUMBER(10);
BEGIN
    -- Generar un nï¿½mero aleatorio de 10 dï¿½gitos como cï¿½digo
    v_persona_codigo := FLOOR(DBMS_RANDOM.VALUE(1000000000, 9999999999));

    -- Asignar el cï¿½digo generado a la columna codigoAcademia
    :NEW.codigoPersona := v_persona_codigo;
END;
/

CREATE OR REPLACE TRIGGER trg_merito_codigo
BEFORE INSERT ON merito
FOR EACH ROW
DECLARE
    v_merito_codigo NUMBER(10);
BEGIN
    -- Generar un nï¿½mero aleatorio de 10 dï¿½gitos como cï¿½digo
    v_merito_codigo := FLOOR(DBMS_RANDOM.VALUE(1000000000, 9999999999));

    -- Asignar el cï¿½digo generado a la columna codigoAcademia
    :NEW.codigoMerito := v_merito_codigo;
END;
/

CREATE OR REPLACE TRIGGER trg_historial_codigo
BEFORE INSERT ON historial
FOR EACH ROW
DECLARE
    v_historial_codigo NUMBER(10);
BEGIN
    -- Generar un nï¿½mero aleatorio de 10 dï¿½gitos como cï¿½digo
    v_historial_codigo := FLOOR(DBMS_RANDOM.VALUE(1000000000, 9999999999));

    -- Asignar el cï¿½digo generado a la columna codigoAcademia
    :NEW.codigoHistorial := v_historial_codigo;
END;
/

CREATE OR REPLACE TRIGGER trg_enfrentamiento_codigo
BEFORE INSERT ON enfrentamiento
FOR EACH ROW
DECLARE
    v_enfrentamiento_codigo NUMBER(10);
BEGIN
    -- Generar un nï¿½mero aleatorio de 10 dï¿½gitos como cï¿½digo
    v_enfrentamiento_codigo := FLOOR(DBMS_RANDOM.VALUE(1000000000, 9999999999));

    -- Asignar el cï¿½digo generado a la columna codigoAcademia
    :NEW.codigoEnfrentamiento := v_enfrentamiento_codigo;
END;
/

CREATE OR REPLACE TRIGGER trg_evento_codigo
BEFORE INSERT ON evento
FOR EACH ROW
DECLARE
    v_evento_codigo NUMBER(10);
BEGIN
    -- Generar un nï¿½mero aleatorio de 10 dï¿½gitos como cï¿½digo
    v_evento_codigo := FLOOR(DBMS_RANDOM.VALUE(1000000000, 9999999999));

    -- Asignar el cï¿½digo generado a la columna codigoAcademia
    :NEW.codigoEvento := v_evento_codigo;
END;
/

CREATE OR REPLACE TRIGGER trg_colaborador_codigo
BEFORE INSERT ON colaborador
FOR EACH ROW
DECLARE
    v_colaborador_codigo NUMBER(10);
BEGIN
    -- Generar un nï¿½mero aleatorio de 10 dï¿½gitos como cï¿½digo
    v_colaborador_codigo := FLOOR(DBMS_RANDOM.VALUE(1000000000, 9999999999));

    -- Asignar el cï¿½digo generado a la columna codigoAcademia
    :NEW.codigoColaborador := v_colaborador_codigo;
END;
/

-- La fecha de entrenamiento debe ser posterior a la actual
CREATE OR REPLACE TRIGGER trg_entrenamiento_fecha
BEFORE INSERT OR UPDATE ON entrenamiento
FOR EACH ROW
DECLARE
    fecha_actual DATE;
BEGIN
    -- Obtener la fecha actual
    SELECT SYSDATE INTO fecha_actual FROM DUAL;

    -- Validar que la fecha del entrenamiento es posterior a la de hoy
    IF :NEW.horario <= fecha_actual THEN
        RAISE_APPLICATION_ERROR(-20001, 'La fecha del entrenamiento debe ser posterior a la actual');
    END IF;
END;
/

-- Valida si el tipo de enfrentamiento es armas, la duracion debe ser mayor a 3 y los round deben ser menores de 3
CREATE OR REPLACE TRIGGER tgr_enfrentamiento_tipo_armas
BEFORE INSERT OR UPDATE ON enfrentamiento
FOR EACH ROW
BEGIN
    -- Validar si el tipo de enfrentamiento es "armas"
    IF :NEW.tipo = 'armas' THEN
        -- Validar que la duraciï¿½n sea mayor a 3
        IF :NEW.duracion <= 3 THEN
            RAISE_APPLICATION_ERROR(-20001, 'La duraciï¿½n debe ser mayor a 3 para enfrentamientos de tipo "armas"');
        END IF;

        -- Validar que los rounds sean menores a 3
        IF :NEW.round_ >= 3 THEN
            RAISE_APPLICATION_ERROR(-20002, 'El nï¿½mero de rounds debe ser menor a 3 para enfrentamientos de tipo "armas"');
        END IF;
    END IF;
END;
/

-- Calida que si el tipo de enfrentamiento es figura, no dura mas de 10 y tiene al menos 2 round
CREATE OR REPLACE TRIGGER tgr_enfrentamiento_tipo_figura
BEFORE INSERT OR UPDATE ON enfrentamiento
FOR EACH ROW
BEGIN
    -- Validar si el tipo de enfrentamiento es "figura"
    IF :NEW.tipo = 'figura' THEN
        -- Validar que la duraciï¿½n sea menor a 10
        IF :NEW.duracion <= 10 THEN
            RAISE_APPLICATION_ERROR(-20001, 'La duraciï¿½n debe ser menor a 10 para enfrentamientos de tipo "figura"');
        END IF;

        -- Validar que los rounds sean mayor a 2
        IF :NEW.round_ >= 2 THEN
            RAISE_APPLICATION_ERROR(-20002, 'El nï¿½mero de rounds debe ser mayor a 2 para enfrentamientos de tipo "figura"');
        END IF;
    END IF;
END;
/

-- Si es un enfrentamiento de combate, no debe durar mï¿½s de 3
CREATE OR REPLACE TRIGGER tgr_enfrentamiento_tipo_combate
BEFORE INSERT OR UPDATE ON enfrentamiento
FOR EACH ROW
BEGIN
    -- Validar si el tipo de enfrentamiento es "combate"
    IF :NEW.duracion = 'combate' THEN
        -- Validar que la duraciï¿½n sea mayor a 3
        IF :NEW.duracion <= 3 THEN
            RAISE_APPLICATION_ERROR(-20001, 'La duraciï¿½n no debe ser mayor a 3 para enfrentamientos de tipo "combate"');
        END IF;

    END IF;
END;
/

-- La fecha del evento debe ser mayor o igual a la actual
CREATE OR REPLACE TRIGGER tr_fecha_evento
BEFORE INSERT ON evento
FOR EACH ROW
BEGIN
    IF :NEW.fecha < SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20001, 'La fecha del evento debe ser mayor o igual a la actual');
    END IF;
END;
/

-- Sï¿½lo se pueden actualizar atributos de email, telefono, imc, especialidad, implementos y rango, en un aprendiz.
CREATE OR REPLACE TRIGGER trg_actualizar_aprendiz
BEFORE UPDATE ON persona
FOR EACH ROW
BEGIN
    IF UPDATING('codigoPersona') OR UPDATING('nombre') OR UPDATING('sexo') OR UPDATING('nombre') THEN
            RAISE_APPLICATION_ERROR(-20002, 'No se permite actualizar este caracter');
    END IF;
END;
/

-- La nueva edad debe ser mayor que la anterior.
CREATE OR REPLACE TRIGGER actualiza_persona_edad
BEFORE UPDATE ON persona
FOR EACH ROW
BEGIN
    IF :NEW.edad <= :OLD.edad THEN
        RAISE_APPLICATION_ERROR(-20001, 'La nueva edad debe ser mayor que la anterior');
    END IF;
END;
/

-- Las personas no se pueden eliminar
CREATE OR REPLACE TRIGGER tgr_eliminar_persona
BEFORE DELETE ON persona
FOR EACH ROW
BEGIN
        RAISE_APPLICATION_ERROR(-20002, 'La persona no se puede eliminar.');
END;
/

-- DisparadoresNoOk
-- La especialidad sï¿½lo se puede cambiar cuando se cambia el rango. Es mï¿½s complejo de elaborar.
CREATE OR REPLACE TRIGGER actualiza_especialidad
BEFORE UPDATE ON aprendiz
FOR EACH ROW
BEGIN
    IF :NEW.rango <> :OLD.rango THEN
        UPDATE persona
        SET especialidad = 
            CASE 
                WHEN :NEW.rango = 'blanco' THEN 
                    CASE 
                        WHEN 'blanco' THEN 'Armas'
                        WHEN 'blanco' THEN 'Figuras'
                        WHEN 'blanco' THEN 'Combate'
                        ELSE null;
                    END
                WHEN :NEW.rango = 'franja-amarillo' THEN 'NuevaEspecialidadFranjaAmarillo'
                -- Agrega mï¿½s casos segï¿½n tus necesidades
                ELSE 'NuevaEspecialidadDefault'
            END
        WHERE codigoPersona = :NEW.codigoAprendiz;
    END IF;
END;
/

-- La edad de la persona debe ir siempre en crecimiento. La condicion se debe validar en el condicional.
CREATE OR REPLACE TRIGGER actualiza_persona_edad
BEFORE UPDATE ON persona
FOR EACH ROW
BEGIN
    IF :NEW.edad <> :OLD.edad THEN
        :NEW.edad > :OLD.edad;
    END IF;
END;
/

-- Atributos actualizables en aprendiz. Tiene doble IF. Faltan comillas en atributos no actualizables.
CREATE OR REPLACE TRIGGER trg_actualizar_aprendiz
BEFORE UPDATE ON persona
FOR EACH ROW
BEGIN
    IF
        IF UPDATING(codigoPersona) OR UPDATING(nombre) OR UPDATING(sexo) OR UPDATING(nombre) THEN
            RAISE_APPLICATION_ERROR(-20002, 'No se permite actualizar este caracter');
    END IF;
END;

-- El instructor sï¿½lo puede ser juez si su dan es mayor a 3. No deberï¿½a compilar por tipo juez y por tipo de dan.
CREATE OR REPLACE TRIGGER tgr_instructor_juez
BEFORE INSERT OR UPDATE ON instructor
FOR EACH ROW
DECLARE
    v_dan NUMBER;
BEGIN
    -- Obtener el valor de dan para el nuevo instructor
    SELECT dan INTO v_dan FROM instructor WHERE codigoInstructor = :NEW.codigoInstructor;

    -- Verificar la condiciï¿½n para ser juez
    IF :NEW.juez = 'S' AND v_dan <= 3 THEN
        RAISE_APPLICATION_ERROR(-20001, 'El instructor solo puede ser juez si su dan es mayor a 3.');
    END IF;
END;
/

-- Implementos del aprendiz, son null al inicio. Esto se contempla por cuenta propia al asignar datos a una tabla.
CREATE OR REPLACE TRIGGER trg_aprendiz_implementos
BEFORE INSERT OR UPDATE ON aprendiz
FOR EACH ROW
BEGIN
    IF :NEW.aprendiz THEN
        :NEW.implementos := null;
    END IF;
END;
/

-- La especialidad de una nueva persona en la academia, es null. Esto se contempla por cuenta propia al asignar datos a una tabla.
CREATE OR REPLACE TRIGGER trg_persona_especialidad
BEFORE INSERT OR UPDATE ON persona
FOR EACH ROW
BEGIN
    IF :NEW.persona THEN
        :NEW.especialidad := null;
    END IF;
END;
/

-- La implementaciï¿½n es vï¿½lida pero el comportamiento no es el deseado. El mï¿½rito sï¿½lo se puede actualizar cuando el aprendiz participï¿½ en algï¿½n evento asociado.
CREATE OR REPLACE TRIGGER tgr_aprendiz_merito
BEFORE UPDATE ON merito
FOR EACH ROW
BEGIN
    IF :NEW.codigoMeritoEvento IS NULL THEN
        RAISE_APPLICATION_ERROR(-20002, 'La tabla de mï¿½rito solo puede ser actualizada si tiene asociado un cï¿½digo de evento.');
    END IF;
END;
/


-- XDisparadores
DROP TRIGGER trg_sede_codigo;
DROP TRIGGER trg_academia_codigo;
DROP TRIGGER trg_entrenamiento_codigo;
DROP TRIGGER trg_persona_codigo;
DROP TRIGGER trg_merito_codigo;
DROP TRIGGER trg_historial_codigo;
DROP TRIGGER trg_evento_codigo;
DROP TRIGGER trg_colaborador_codigo;
DROP TRIGGER trg_enfrentamiento_codigo;
DROP TRIGGER trg_entrenamiento_fecha;
DROP TRIGGER tgr_enfrentamiento_tipo_armas;
DROP TRIGGER tgr_enfrentamiento_tipo_figura;
DROP TRIGGER tgr_enfrentamiento_tipo_combate;
DROP TRIGGER tgr_persona_imc;
DROP TRIGGER tr_fecha_evento;
DROP TRIGGER tgr_eliminar_persona;
DROP TRIGGER actualiza_persona_edad;
DROP TRIGGER tgr_aprendiz_especialidad;
DROP TRIGGER trg_actualizar_aprendiz;

-- Indices
-- Indices para la tabla de academia
CREATE INDEX idx_nombre_academia ON academia(nombreAcademia);
CREATE INDEX idx_web ON academia(web);

-- Indexes for the sede table
CREATE INDEX idx_direccion_sede ON sede(direccion);
CREATE INDEX idx_telefono_sede ON sede(telefono);
CREATE INDEX idx_nombre_sede ON sede(nombreSede);

-- Indexes for the entrenamiento table
CREATE INDEX idx_horario_entrenamiento ON entrenamiento(horario);
CREATE INDEX idx_precio_entrenamiento ON entrenamiento(precio);
CREATE INDEX idx_enfoque_entrenamiento ON entrenamiento(enfoque);

-- Indexes for the persona table
CREATE INDEX idx_nombre_persona ON persona(nombre);
CREATE INDEX idx_edad_persona ON persona(edad);

-- Indexes for the instructor table
CREATE INDEX idx_juez_instructor ON instructor(juez);
CREATE INDEX idx_dan_instructor ON instructor(dan);

-- Indexes for the enfrentamiento table
CREATE INDEX idx_duracion_enfrentamiento ON enfrentamiento(duracion);
CREATE INDEX idx_tipo_enfrentamiento ON enfrentamiento(tipo);

-- Indexes for the evento table
CREATE INDEX idx_fecha_evento ON evento(fecha);
CREATE INDEX idx_direccion_evento ON evento(direccion);

-- Indexes for the examen table
CREATE INDEX idx_precio_examen ON examen(precio);
CREATE INDEX idx_participantes_examen ON examen(participantes);

-- Indexes for the campeonato table
CREATE INDEX idx_recaudo_campeonato ON campeonato(recaudo);
CREATE INDEX idx_tipo_campeonato ON campeonato(tipo);

-- Vistas
-- InformaciÃ³n sobre examen de todos los aprendices
CREATE VIEW VistaExamenAprendiz AS
 SELECT p.codigoPersona, p.nombre, p.edad, a.rango, v.codigoEvento, v.fecha, v.direccion, x.especialidad
 FROM persona p JOIN aprendiz a ON (p.codigoPersona = a.codigoAprendiz)
                JOIN evento v ON (v.codigoEvento = p.codigoPersona)
                JOIN examen x ON (x.codigoExamen = v.codigoEvento);

-- InformaciÃ³n sobre competencias
CREATE VIEW VistaCompetenciaPersonas AS
 SELECT p.codigoPersona, p.nombre, p.edad, a.rango, v.codigoEvento, v.fecha, v.direccion, c.recaudo
 FROM persona p JOIN aprendiz a ON (p.codigoPersona = a.codigoAprendiz)
                JOIN instructor i ON (p.codigoPersona = i.codigoInstructor)
                JOIN evento v ON (v.codigoEvento = p.codigoPersona)
                JOIN campeonato c ON (c.codigoCampeonato = v.codigoEvento);

-- Entrenamientos que dicta un instructor
CREATE VIEW VistaEntrenamientoInstructor AS
 SELECT n.codigoEntrenamiento, n.rutina, n.horario, p.nombre, i.dan
 FROM instructor i JOIN entrenamiento n ON (i.codigoInstructor = n.codigoEntrenamientoInstructor)
                   JOIN persona p ON (p.codigoPersona = i.codigoInstructor);
                   
-- XVistas
DROP VIEW VistaExamenAprendiz;
DROP VIEW VistaCompetenciaPersonas;
DROP VIEW VistaEntrenamientoInstructor;

-- xIndices
-- Drop indexes for the academia table
DROP INDEX idx_nombre_academia;
DROP INDEX idx_web;

-- Drop indexes for the sede table
DROP INDEX idx_direccion_sede;
DROP INDEX idx_telefono_sede;
DROP INDEX idx_nombre_sede;

-- Drop indexes for the entrenamiento table
DROP INDEX idx_horario_entrenamiento;
DROP INDEX idx_precio_entrenamiento;
DROP INDEX idx_enfoque_entrenamiento;

-- Drop indexes for the persona table
DROP INDEX idx_nombre_persona;
DROP INDEX idx_edad_persona;

-- Drop indexes for the instructor table
DROP INDEX idx_juez_instructor;
DROP INDEX idx_dan_instructor;

-- Drop indexes for the enfrentamiento table
DROP INDEX idx_duracion_enfrentamiento;
DROP INDEX idx_tipo_enfrentamiento;

-- Drop indexes for the evento table
DROP INDEX idx_fecha_evento;
DROP INDEX idx_direccion_evento;

-- Drop indexes for the examen table
DROP INDEX idx_precio_examen;
DROP INDEX idx_participantes_examen;

-- Drop indexes for the campeonato table
DROP INDEX idx_recaudo_campeonato;
DROP INDEX idx_tipo_campeonato;

-- Cursor
-- Obtiene todos los meritos relacionados a un enfrentamiento especifico
DECLARE
    v_codigoMerito merito.codigoMerito%TYPE;
    v_especialidad merito.especialidad%TYPE;
    v_descripcion merito.descripcion%TYPE;
    v_codigoMeritoEnfrentamiento merito.codigoMeritoEnfrentamient%TYPE;
    v_codigoMeritoPersona merito.codigoMeritoPersona%TYPE;
    v_desempeÃ±o merito.desempeÃ±o%TYPE;
    v_duracion Enfrentamiento.duracion%TYPE;
    v_tipo Enfrentamiento.tipo%TYPE;
    v_round Enfrentamiento.round_%TYPE;    

    CURSOR c_merito_enfrentamientos IS
        SELECT m.codigoMerito, m.especialidad, m.descripcion, m.descripcion, m.codigoMeritoEnfrentamiento, m.codigoMeritoPersona, m.desempeÃ±o AS nombre_anexo, m.anexoU
        FROM merito m
        LEFT JOIN enfrentamiento e ON m.codigoMerito = e.codigoEnfrentamiento;
BEGIN

    OPEN c_merito_enfrentamientos;
    LOOP
        FETCH c_merito_enfrentamientos INTO v_codigoMerito, v_especialidad, v_descripcion, v_codigoMeritoEnfrentamiento, v_codigoMeritoPersona, v_desempeÃ±o, v_duracion, v_tipo, v_round;

        EXIT WHEN c_merito_enfrentamientos%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('CÃ³digo: ' || v_codigoMerito || ', Descripcion: ' || v_descripcion || ', DesempeÃ±o: ' || v_desempeÃ±o);

    END LOOP;

    CLOSE c_merito_enfrentamientos;
END;
/

--Devuelve todos los mÃ©ritos generados el dia de la consulta
DECLARE
    v_codigoMerito merito.codigoMerito%TYPE;
    v_especialidad merito.especialidad%TYPE;
    v_descripcion merito.descripcion%TYPE;
    v_codigoMeritoEnfrentamiento merito.codigoMeritoEnfrentamient%TYPE;
    v_codigoMeritoPersona merito.codigoMeritoPersona%TYPE;
    v_desempeÃ±o merito.desempeño%TYPE;

    v_fecha_generacion DATE := TO_DATE(SYSDATE, 'YYYY-MM-DD');

    CURSOR c_merito_fecha IS
        SELECT codigoMerito, especialidad, descripcion, codigoMeritoEnfrentamient, codigoMeritoPersona, desempeÃ±o
        FROM merito
BEGIN

    OPEN c_merito_fecha;

    LOOP
        FETCH c_merito_fecha INTO v_codigoMerito, v_especialidad, v_descripcion, v_codigoMeritoEnfrentamiento, v_codigoMeritoPersona, v_desempeÃ±o;

        EXIT WHEN c_merito_fecha%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('CÃ³digo: ' || v_codigoMerito || ', Descripcion: ' || v_descripcion || ', DesempeÃ±o: ' || v_desempeÃ±o);
        
    END LOOP;

    CLOSE c_merito_fecha;
END;
/

-- Paquetes
/*CRUDE*/
CREATE OR REPLACE PACKAGE PC_Merito IS
    PROCEDURE ad(
        xcodigoMerito IN NUMBER,
        xespecialidad IN VARCHAR2,
        xdescripcion IN VARCHAR2,
        xcodigoMeritoEnfrentamiento IN NUMBER,
        xcodigoMeritoPersona IN NUMBER,
        xdesempeño IN VARCHAR2,
        xcodigoMeritoEvento IN NUMBER
    );
    PROCEDURE mo_Merito(xcodigoMerito IN NUMBER, xespecialidad IN VARCHAR2);
    PROCEDURE ad_enfrentamiento(
        xcodigoEnfrentamiento IN NUMBER,
        xduracion IN NUMBER,
        xtipo IN VARCHAR2,
        xround_ IN NUMBER,
        xcodigoEnfrentamientoEntrenamiento IN NUMBER
    );
    PROCEDURE mo_enfrentamiento(
        xcodigoEnfrentamiento IN NUMBER,
        xduracion IN NUMBER,
        xtipo IN VARCHAR2,
        xround_ IN NUMBER
    );
    PROCEDURE eliminar(xcodigoMerito IN NUMBER);
    FUNCTION consultar RETURN SYS_REFCURSOR;
END PC_Merito;
/

CREATE OR REPLACE PACKAGE BODY PC_Merito IS
    PROCEDURE ad(
        xcodigoMerito IN NUMBER,
        xespecialidad IN VARCHAR2,
        xdescripcion IN VARCHAR2,
        xcodigoMeritoEnfrentamiento IN NUMBER,
        xcodigoMeritoPersona IN NUMBER,
        xdesempeño IN VARCHAR2,
        xcodigoMeritoEvento IN NUMBER
    )
    IS
    BEGIN
        INSERT INTO merito (
            codigoMerito,
            especialidad,
            descripcion,
            codigoMeritoEnfrentamiento,
            codigoMeritoPersona,
            desempeño,
            codigoMeritoEvento
        )
        VALUES (
            xcodigoMerito,
            xespecialidad,
            xdescripcion,
            xcodigoMeritoEnfrentamiento,
            xcodigoMeritoPersona,
            xdesempeño,
            xcodigoMeritoEvento
        );
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20007, 'No se puede insertar el merito.');
    END;

    PROCEDURE mo_Merito(xcodigoMerito IN NUMBER, xespecialidad IN VARCHAR2)
    IS
    BEGIN
        UPDATE merito SET especialidad = xespecialidad WHERE codigoMerito = xcodigoMerito;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20006, 'No se puede actualizar el mérito.');
    END;

    PROCEDURE ad_enfrentamiento(
        xcodigoEnfrentamiento IN NUMBER,
        xduracion IN NUMBER,
        xtipo IN VARCHAR2,
        xround_ IN NUMBER,
        xcodigoEnfrentamientoEntrenamiento IN NUMBER
    )
    IS
    BEGIN
        INSERT INTO enfrentamiento (
            codigoEnfrentamiento,
            duracion,
            tipo,
            round_,
            codigoEnfrentamientoEntrenamiento
        )
        VALUES (
            xcodigoEnfrentamiento,
            xduracion,
            xtipo,
            xround_,
            xcodigoEnfrentamientoEntrenamiento
        );
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20007, 'No se puede insertar el enfrentamiento.');
    END;

    PROCEDURE mo_enfrentamiento(
        xcodigoEnfrentamiento IN NUMBER,
        xduracion IN NUMBER,
        xtipo IN VARCHAR2,
        xround_ IN NUMBER
    )
    IS
    BEGIN
        UPDATE enfrentamiento
        SET duracion = xduracion, tipo = xtipo, round_ = xround_
        WHERE codigoEnfrentamiento = xcodigoEnfrentamiento;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20007, 'No se puede actualizar el enfrentamiento.');
    END;

    PROCEDURE eliminar(xcodigoMerito IN NUMBER)
    IS
    BEGIN
        DELETE FROM merito WHERE codigoMerito = xcodigoMerito;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20008, 'No se puede eliminar el merito.');
    END;

    FUNCTION consultar RETURN SYS_REFCURSOR
    IS
        consulta SYS_REFCURSOR;
    BEGIN
        OPEN consulta FOR SELECT * FROM merito;
        RETURN consulta;
    END;
END PC_Merito;
/

CREATE OR REPLACE PACKAGE PC_evento AS
  -- Procedimiento para añadir un nuevo evento
  PROCEDURE agregar_evento(
    p_codigo VARCHAR2,
    p_fecha DATE,
    p_direccion VARCHAR2,
    p_codigoAcademia NUMBER,
    p_codigoEventoPersona NUMBER
  );

  -- Procedimiento para modificar un evento existente
  PROCEDURE modificar_evento(
    p_codigoEvento NUMBER,
    p_fecha DATE,
    p_direccion VARCHAR2
  );

  -- Procedimiento para eliminar un evento
  PROCEDURE eliminar_evento(p_codigoEvento NUMBER);
END PC_evento;
/

CREATE OR REPLACE PACKAGE BODY PC_evento AS
  -- Procedimiento para añadir un nuevo evento
  PROCEDURE agregar_evento(
    p_codigo VARCHAR2,
    p_fecha DATE,
    p_direccion VARCHAR2,
    p_codigoAcademia NUMBER,
    p_codigoEventoPersona NUMBER
  ) AS
  BEGIN
    INSERT INTO evento (codigoEvento, fecha, direccion, codigoEventoAcademia, codigoEventoPersona)
    VALUES (p_codigo, p_fecha, p_direccion, p_codigoAcademia, p_codigoEventoPersona);
  END agregar_evento;

  -- Procedimiento para modificar un evento existente
  PROCEDURE modificar_evento(
    p_codigoEvento NUMBER,
    p_fecha DATE,
    p_direccion VARCHAR2
  ) AS
  BEGIN
    UPDATE evento
    SET fecha = p_fecha,
        direccion = p_direccion
    WHERE codigoEvento = p_codigoEvento;
  END modificar_evento;

  -- Procedimiento para eliminar un evento
  PROCEDURE eliminar_evento(p_codigoEvento NUMBER) AS
  BEGIN
    DELETE FROM evento
    WHERE codigoEvento = p_codigoEvento;
  END eliminar_evento;
END PC_evento;
/
CREATE OR REPLACE PACKAGE PC_Examen AS
    PROCEDURE adicionar_examen(
        p_codigoExamen IN NUMBER,
        p_precio IN NUMBER,
        p_especialidad IN VARCHAR2,
        p_participantes IN NUMBER
    );

    PROCEDURE modificar_examen(
        p_codigoExamen IN NUMBER,
        p_precio IN NUMBER,
        p_especialidad IN VARCHAR2,
        p_participantes IN NUMBER
    );

    PROCEDURE eliminar_examen(p_codigoExamen IN NUMBER);
END PC_Examen;
/

CREATE OR REPLACE PACKAGE BODY PC_Examen AS
    PROCEDURE adicionar_examen(
        p_codigoExamen IN NUMBER,
        p_precio IN NUMBER,
        p_especialidad IN VARCHAR2,
        p_participantes IN NUMBER
    )
    IS
    BEGIN
        INSERT INTO examen (
            codigoExamen,
            precio,
            especialidad,
            participantes
        )
        VALUES (
            p_codigoExamen,
            p_precio,
            p_especialidad,
            p_participantes
        );

        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20001, 'Error al adicionar el examen.');
    END adicionar_examen;

    PROCEDURE modificar_examen(
        p_codigoExamen IN NUMBER,
        p_precio IN NUMBER,
        p_especialidad IN VARCHAR2,
        p_participantes IN NUMBER
    )
    IS
    BEGIN
        UPDATE examen
        SET precio = p_precio,
            especialidad = p_especialidad,
            participantes = p_participantes
        WHERE codigoExamen = p_codigoExamen;

        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20002, 'Error al modificar el examen.');
    END modificar_examen;

    PROCEDURE eliminar_examen(p_codigoExamen IN NUMBER)
    IS
    BEGIN
        DELETE FROM examen WHERE codigoExamen = p_codigoExamen;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20003, 'Error al eliminar el examen.');
    END eliminar_examen;
END PC_Examen;
/



-- xPaquete

DROP PACKAGE BODY PC_Merito;
DROP PACKAGE PC_Merito;
DROP PACKAGE BODY PC_evento;
DROP PACKAGE PC_evento;
DROP PACKAGE BODY PC_Examen;
DROP PACKAGE PC_Examen;

--Seguridad
CREATE ROLE instructor;
CREATE ROLE encargado;
CREATE ROLE organizadorEvento;
CREATE ROLE programador;

GRANT INSERT, SELECT, UPDATE ON entrenamiento, enfrentamiento, merito, sede TO instructor;
GRANT INSERT, SELECT, UPDATE, DELETE ON evento, colaborador, academia TO encargado;
GRANT ALL PRIVILEGES ON evento TO organizadorEvento;
GRANT ALL PRIVILEGES ON examen TO organizadorEvento;

INSERT INTO academia (codigoAcademia, nombreAcademia, estilo, web) VALUES (3678375293,'Taekwondo Songahm', 'Oh Do Kwan','http://www.worldtaekwondo.com');
INSERT INTO persona (codigoPersona, nombre, edad, email, telefono, sexo, imc, especialidad) VALUES (4750275839, 'Andres Hernesto Perez', 6, 'Andres_h03@hotmail.com', 3224116273, 'M', 58.3, 'armas');

SET ROLE organizadorEvento;
BEGIN
  PC_evento.agregar_evento(8429305294, TO_DATE('14/12/2024', 'DD/MM/YYYY'), 'Calle 4 Nro 13 - 23', 3678375293,4750275839);
  PC_evento.agregar_evento(5738429340, TO_DATE('06/03/2024', 'DD/MM/YYYY'), 'Cra 5 Nro 34 - 76', 3678375293,4750275839);
  PC_evento.agregar_evento(5893048254, TO_DATE('14/12/2024', 'DD/MM/YYYY'), 'Calle 36 Nro 63 - 4', 3678375293,4750275839);
  PC_evento.agregar_evento(0175927392, TO_DATE('24/07/2024', 'DD/MM/YYYY'), 'Cra 73 Nro 3 - 126', 3678375293,4750275839);
  PC_evento.agregar_evento(0184023843, TO_DATE('06/03/2024', 'DD/MM/YYYY'), 'Cra 42 Nro 52 - 35', 3678375293,4750275839);
END;
SET ROLE ALL;
--XSeguridad
REVOKE INSERT, SELECT, UPDATE ON entrenamiento, enfrentamiento, merito, sede TO instructor;
REVOKE INSERT, SELECT, UPDATE, DELETE ON evento, colaborador, academia TO encargado;
REVOKE ALL PRIVILEGES ON evento TO organizadorEvento;
REVOKE ALL PRIVILEGES ON examen TO organizadorEvento;

DROP ROLE instructor;
DROP ROLE encargado;
DROP ROLE organizadorEvento;
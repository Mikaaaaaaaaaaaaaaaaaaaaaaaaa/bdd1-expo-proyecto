DROP DATABASE IF EXISTS EXPO_PROYECTO;
CREATE DATABASE EXPO_PROYECTO;
USE EXPO_PROYECTO;

CREATE TABLE EXPO_PROYECTO (
	identificador_expo INTEGER NOT NULL PRIMARY KEY,
	descripcion VARCHAR (50),
	año DATE
);

CREATE TABLE EMPRESA (
	cuit_empresa INTEGER NOT NULL PRIMARY KEY,
	nombre VARCHAR (50),
	informacion TEXT,
	identificador_expo INTEGER,
    
    FOREIGN KEY (identificador_expo) REFERENCES EXPO_PROYECTO(identificador_expo)
);

CREATE TABLE NOTA_PERIODISTICA (
	identificador_nota INTEGER NOT NULL PRIMARY KEY, 
	enlaces BLOB
);

CREATE TABLE PROYECTO (
	codigo_proyecto INTEGER NOT NULL PRIMARY KEY,
	nombre_proyecto VARCHAR (50),
	descripcion VARCHAR (50),
	objetivo VARCHAR (50),
	fotos BLOB,
	videos BLOB,
	poster BLOB
);

CREATE TABLE CONTIENE (
	identificador_expo INTEGER NOT NULL,
	codigo_proyecto INTEGER NOT NULL,
    
	PRIMARY KEY (identificador_expo, codigo_proyecto),

    FOREIGN KEY (identificador_expo) REFERENCES EXPO_PROYECTO(identificador_expo),
	FOREIGN KEY (codigo_proyecto) REFERENCES PROYECTO(codigo_proyecto)
);

CREATE TABLE STAND (
	identificador_stand INTEGER NOT NULL PRIMARY KEY,
	descripcion VARCHAR (50),
	cuit_empresa INTEGER,
	codigo_proyecto INTEGER,
	identificador_expo INTEGER,
    
    FOREIGN KEY (cuit_empresa) REFERENCES EMPRESA(cuit_empresa),
    FOREIGN KEY (codigo_proyecto) REFERENCES PROYECTO(codigo_proyecto),
    FOREIGN KEY (identificador_expo) REFERENCES EXPO_PROYECTO(identificador_expo)
);

CREATE TABLE TAG (
	codigo_tag INTEGER NOT NULL PRIMARY KEY,
	descripcion VARCHAR (50)
);

CREATE TABLE ASISTENTE (
	codigo_asistente INTEGER NOT NULL PRIMARY KEY,
	procedencia_pais VARCHAR (50),
	procedencia_provincia VARCHAR (50),
	procedencia_ciudad VARCHAR (50),
	procedencia_establecimiento VARCHAR (50),
	email VARCHAR (50),
	nombre VARCHAR (50),
	apellido VARCHAR (50),
	interes VARCHAR (50),
	identificador_expo INTEGER,
    
    FOREIGN KEY (identificador_expo) REFERENCES EXPO_PROYECTO(identificador_expo)
);

CREATE TABLE TIPO_ACTIVIDAD (
	codigo_tipo_actividad INTEGER NOT NULL PRIMARY KEY,
	descripcion VARCHAR (50)
);

CREATE TABLE ACTIVIDAD (
	identificador_actividad INTEGER NOT NULL PRIMARY KEY,
	fecha_y_hora DATETIME,
	lugar VARCHAR (50),
	publico VARCHAR (50),
	nombre VARCHAR (50),
	codigo_tipo_actividad INTEGER,
    
    FOREIGN KEY (codigo_tipo_actividad) REFERENCES TIPO_ACTIVIDAD(codigo_tipo_actividad)
);

CREATE TABLE CHARLA (
	identificador_charla INTEGER NOT NULL PRIMARY KEY,
	tema VARCHAR(70)
);

CREATE TABLE ENLACES (
	identificador_actividad INTEGER NOT NULL PRIMARY KEY,
	enlaces BLOB
);

CREATE TABLE CATEGORIA (
	codigo_categoria INTEGER NOT NULL PRIMARY KEY,
	descripcion VARCHAR (50)
);

CREATE TABLE PREMIO (
	identificador_premio INTEGER NOT NULL PRIMARY KEY,
	medallas TINYINT,
	distinciones VARCHAR(50),
	codigo_asistente INTEGER,
	codigo_proyecto INTEGER,
	codigo_categoria INTEGER,
    
    FOREIGN KEY (codigo_asistente) REFERENCES ASISTENTE(codigo_asistente),
    FOREIGN KEY (codigo_proyecto) REFERENCES PROYECTO(codigo_proyecto),
    FOREIGN KEY (codigo_categoria) REFERENCES CATEGORIA(codigo_categoria)
);

CREATE TABLE ESTUDIANTE (
	codigo_estudiante INTEGER NOT NULL PRIMARY KEY,
	apellido VARCHAR (50),
	nombre VARCHAR (50),
	carrera_precedencia VARCHAR (50),
	codigo_proyecto INTEGER,
    
    FOREIGN KEY (codigo_proyecto) REFERENCES PROYECTO(codigo_proyecto)
);

CREATE TABLE ESTABLECIMIENTO (
	identificador_establecimiento INTEGER NOT NULL PRIMARY KEY,
	tipo VARCHAR (50),
	direccion_numero VARCHAR (50),
	direccion_calle VARCHAR (50),
	direccion_codigo_postal VARCHAR (50)
);

CREATE TABLE DOCENTE (
	legajo_docente INTEGER NOT NULL PRIMARY KEY,
	nombre_y_apellido VARCHAR (50),
	titulo VARCHAR (50)
);

CREATE TABLE COORDINA (
	codigo_estudiante INTEGER NOT NULL,
	identificador_establecimiento INTEGER NOT NULL,
	legajo_docente INTEGER NOT NULL,
    
	PRIMARY KEY (codigo_estudiante, identificador_establecimiento),
    
    FOREIGN KEY (codigo_estudiante) REFERENCES ESTUDIANTE(codigo_estudiante),
    FOREIGN KEY (identificador_establecimiento) REFERENCES ESTABLECIMIENTO(identificador_establecimiento),
    FOREIGN KEY (legajo_docente) REFERENCES DOCENTE(legajo_docente)
);

CREATE TABLE PROGRAMA (
	identificador_actividad INTEGER NOT NULL,
	cuit_empresa INTEGER NOT NULL,
    
    PRIMARY KEY (identificador_actividad, cuit_empresa),
    
    FOREIGN KEY (identificador_actividad) REFERENCES ACTIVIDAD(identificador_actividad),
    FOREIGN KEY (cuit_empresa) REFERENCES EMPRESA(cuit_empresa)
);

CREATE TABLE DISPONE (
	identificador_expo INTEGER NOT NULL,
	identificador_nota INTEGER NOT NULL,
    
    PRIMARY KEY (identificador_expo, identificador_nota),
    
    FOREIGN KEY (identificador_expo) REFERENCES EXPO_PROYECTO(identificador_expo),
    FOREIGN KEY (identificador_nota) REFERENCES NOTA_PERIODISTICA(identificador_nota)
);

CREATE TABLE `DESCRIBE` (
	identificador_stand INTEGER NOT NULL,
	codigo_tag INTEGER NOT NULL,
    
    PRIMARY KEY (identificador_stand, codigo_tag),
    
    FOREIGN KEY (identificador_stand) REFERENCES STAND(identificador_stand),
    FOREIGN KEY (codigo_tag) REFERENCES TAG(codigo_tag)
);

CREATE TABLE DA (
	codigo_asistente INTEGER NOT NULL,
	identificador_nota INTEGER NOT NULL,
    
    PRIMARY KEY (codigo_asistente, identificador_nota),
    
    FOREIGN KEY (codigo_asistente) REFERENCES ASISTENTE(codigo_asistente),
    FOREIGN KEY (identificador_nota) REFERENCES NOTA_PERIODISTICA(identificador_nota)
);

CREATE TABLE PARTICIPA (
	identificador_actividad INTEGER NOT NULL,
	codigo_asistente INTEGER NOT NULL,
	modalidad VARCHAR (50),
	fecha DATE,
    
    PRIMARY KEY (identificador_actividad, codigo_asistente),
    
    FOREIGN KEY (identificador_actividad) REFERENCES ACTIVIDAD(identificador_actividad),
    FOREIGN KEY (codigo_asistente) REFERENCES ASISTENTE(codigo_asistente)
);





-- Insertar registros en la tabla EXPO_PROYECTO.
INSERT INTO EXPO_PROYECTO (identificador_expo, descripcion, año)
VALUES (1, 'Sistema de gestión escolar', '2023-11-01'),
	   (2, 'App de turismo local', '2023-11-02'),
       (3, 'Plataforma de reciclaje urbano', '2023-11-03'),
       (4, 'Control de stock para pymes', '2023-11-04'),
       (5, 'Expo visual', '2023-11-05');
       
       SELECT * FROM EXPO_PROYECTO;

-- Insertar registros en la tabla EMPRESA.
INSERT INTO EMPRESA (cuit_empresa, nombre, informacion, identificador_expo)
VALUES (101, 'TecnoSur', 'Desarrolla soluciones educativas digitales', 1),
	   (102, 'ViajeYA', 'Startup de turismo inteligente', 2),
       (103, 'EcoRecicla', 'Empresa dedicada al reciclaje urbano', 3),
       (104, 'PymeControl', 'Software de gestión para pequeñas empresas', 4);
       
       SELECT * FROM EMPRESA;

-- Insertar registros en la tabla NOTA_PERIODISTICA.
 INSERT INTO NOTA_PERIODISTICA (identificador_nota, enlaces)
 VALUES (1, LOAD_FILE('C:/notas/n1.pdf')),
		(2, LOAD_FILE('C:/notas/n2.pdf')),
        (3, LOAD_FILE('C:/notas/n3.pdf')),
        (4, LOAD_FILE('C:/notas/n4.pdf'));
        
        SELECT * FROM NOTA_PERIODISTICA;
 
 -- Insertar registros en la tabla PROYECTO.
INSERT INTO PROYECTO (codigo_proyecto, nombre_proyecto, descripcion, objetivo, fotos, videos, poster)
VALUES (1, 'Gestión Escolar', 'Sistema para administrar escuelas', 'Optimizar procesos educativos', NULL, NULL, NULL),
	   (2, 'Turismo Inteligente', 'App para guiar turistas en tiempo real', 'Mejorar la experiencia de viaje', NULL, NULL, NULL),
       (3, 'Reciclaje Urbano', 'Plataforma para gestión de residuos', 'Fomentar el reciclaje comunitario', NULL, NULL, NULL),
       (4, 'Control de Stock', 'Software para pymes', 'Evitar pérdidas por falta de inventario', NULL, NULL, NULL),
       (5, 'Expo Virtual', 'Sitio web para mostrar proyectos', 'Difundir trabajos académicos', NULL, NULL, NULL);
       
       SELECT * FROM PROYECTO;

-- Insertar registros en la tabla CONTIENE.
INSERT INTO CONTIENE (identificador_expo, codigo_proyecto)
VALUES (1, 1),
	   (2, 2),
       (3, 3),
       (4, 4),
       (5, 5);
       
       SELECT * FROM CONTIENE;

-- Insertar registros en la tabla STAND.
INSERT INTO STAND (identificador_stand, descripcion, cuit_empresa, codigo_proyecto, identificador_expo)
VALUES (1, 'STAND educativo interactivo', 101, 1, 1),
	   (2, 'STAND de turismo con realidad aumentada', 102, 2, 2),
       (3, 'STAND ecológico con materiales reciclados', 103, 3, 3),
       (4, 'STAND tecnológico para pymes', 104, 4, 4);
       
       SELECT * FROM STAND;

-- Insertar registros en la tabla TAG.
INSERT INTO TAG (codigo_tag, descripcion)
VALUES (1, 'IA Innovación tecnológica'),
	   (2, 'Sustentabilidad'),
       (3, 'Educación digital'),
       (4, 'Turismo inteligente');
       
       SELECT * FROM TAG;

-- Insertar registros en la tabla ASISTENTE.
INSERT INTO ASISTENTE (codigo_asistente, procedencia_pais, procedencia_provincia, procedencia_ciuDAd, procedencia_ESTABLECIMIENTO, email, nombre, apellido, interes, identificador_expo)
VALUES (1, 'Argentina', 'Buenos Aires', 'Rafael Castillo', 'Escuela Técnica 1', 'lucas.gomez@email.com', 'Lucas', 'Gómez', 'Tecnología educativa', 1),
	   (2, 'Argentina', 'Córdoba', 'Villa María', 'Instituto Técnico VM', 'maria.lopez@email.com', 'María', 'López', 'Turismo digital', 2),
       (3, 'Argentina', 'Santa Fe', 'Rosario', 'Colegio San Martín', 'juan.perez@email.com', 'Juan', 'Pérez', 'Reciclaje urbano', 3),
       (4, 'Argentina', 'Mendoza', 'San Rafael', 'Escuela de Comercio', 'carla.mendez@email.com', 'Carla', 'Méndez', 'Gestión empresarial', 4);
       
       SELECT * FROM ASISTENTE;

-- Insertar registros en la tabla TIPO_ACTIVIDAD.
INSERT INTO TIPO_ACTIVIDAD (codigo_tipo_actividad, descripcion)
VALUES (1, 'Charla expositiva'),
	   (2, 'Demostración interactiva'),
       (3, 'Presentación de póster'),
       (4, 'Taller práctico');
       
       SELECT * FROM TIPO_ACTIVIDAD;

-- Insertar registros en la tabla ACTIVIDAD.
INSERT INTO ACTIVIDAD (identificador_actividad, fecha_y_hora, lugar, publico, nombre, codigo_tipo_actividad)
VALUES (1, '2025-11-10 10:00:00', 'Auditorio Principal', 'Estudiantes secundarios', 'Charla educativa', 1),
	   (2, '2025-11-10 14:30:00', 'Sala de las americas', 'Docentes y alumnos', 'Demostración de app turística', 2),
       (3, '2025-11-11 09:00:00', 'Salon de deportes', 'Familiares y amigos', 'Presentación de pósteres', 3),
       (4, '2025-11-11 16:00:00', 'Aula 110', 'Estudiantes universitarios', 'Taller Practico', 4);
       
       SELECT * FROM ACTIVIDAD;

-- Insertar registros en la tabla CHARLA.
INSERT INTO CHARLA (identificador_charla, tema)
VALUES (1, 'CHARLA de Inteligencia Artificial en la educación'),
	   (2, 'CHARLA Turismo digital y experiencias inmersivas'),
       (3, 'CHARLA Reciclaje urbano y tecnología verde'),
       (4, 'CHARLA Emprendimientos tecnológicos desde la escuela');
       
       SELECT * FROM CHARLA;

-- Insertar registros en la tabla ENLACES.
INSERT INTO ENLACES (identificador_actividad, enlaces)
VALUES (1, 'https://expo2025.com/ACTIVIDAD1'),
	   (2, 'https://expo2025.com/ACTIVIDAD2'),
       (3, 'https://expo2025.com/ACTIVIDAD3'),
       (4, 'https://expo2025.com/ACTIVIDAD4');
       
       SELECT * FROM ENLACES;

-- Insertar registros en la tabla CATEGORIA.
INSERT INTO CATEGORIA (codigo_categoria, descripcion)
VALUES (1, 'Tecnología'),
	   (2, 'Medio ambiente'),
       (3, 'Educación y formación'),
       (4, 'Turismo');
       
       SELECT * FROM CATEGORIA;

-- Insertar registros en la tabla PREMIO.
INSERT INTO PREMIO (identificador_premio, medallas, distinciones, codigo_asistente, codigo_proyecto, codigo_categoria)
VALUES (1, 1, 'Mejor innovación educativa', 1, 1, 1),
	   (2, 2, 'Impacto ambiental destacado', 2, 2, 2),
       (3, 1, 'Mejor Presentación', 3, 3, 3),
       (4, 3, 'Premio del público', 4, 4, 4);
       
       SELECT * FROM PREMIO;

-- Insertar registros en la tabla ESTUDIANTE.
INSERT INTO ESTUDIANTE (codigo_estudiante, apellido, nombre, carrera_precedencia, codigo_proyecto)
VALUES (1, 'González', 'Lucía', 'Ingeniería en Sistemas', 1),
	   (2, 'Ramírez', 'Tomás', 'Ingeniería en Sistemas', 2),
       (3, 'Fernández', 'Sofía', 'Diseño Industrial', 3),
       (4, 'Pereyra', 'Martín', 'Diseño Industrial', 4);
       
       SELECT * FROM ESTUDIANTE;

-- Insertar registros en la tabla ESTABLECIMIENTO.
INSERT INTO ESTABLECIMIENTO (identificador_establecimiento, tipo, direccion_numero, direccion_calle, direccion_codigo_postal)
VALUES (1, 'Escuela Técnica', '1250', 'Av. San Martín', '1755'),
	   (2, 'Instituto Superior', '430', 'Calle Belgrano', '5900'),
       (3, 'Universidad', '101', 'Av. Las Heras', '2000'),
       (4, 'Colegio Secundario 174', '789', 'Calle Mitre', '5600');
       
       SELECT * FROM ESTABLECIMIENTO;

-- Insertar registros en la tabla DOCENTE.
INSERT INTO DOCENTE (legajo_docente, nombre_y_apellido, titulo)
VALUES (1001, 'Laura Benítez', 'Licenciada en Educación'),
	   (1002, 'Carlos Medina', 'Ingeniero en Sistemas'),
       (1003, 'Ana Torres', 'Doctora en Ciencias Ambientales'),
       (1004, 'Julián Ríos', 'Profesor en Historia');
       
       SELECT * FROM DOCENTE;

-- Insertar registros en la tabla COORDINA.
INSERT INTO COORDINA (codigo_estudiante, identificador_establecimiento, legajo_docente)
VALUES (1, 1, 1001),
	   (2, 2, 1002),
       (3, 3, 1003),
       (4, 4, 1004);
       
       SELECT * FROM COORDINA;

-- Insertar registros en la tabla PROGRAMA.
INSERT INTO PROGRAMA (identificador_actividad, cuit_empresa)
VALUES (1, 101),
	   (2, 102),
       (3, 103),
       (4, 104);
       
       SELECT * FROM PROGRAMA;

-- Insertar registros en la tabla DISPONE.
INSERT INTO DISPONE (identificador_expo, identificador_nota)
VALUES (1, 1),
	   (2, 2),
       (3, 3),
       (4, 4);
       
       SELECT * FROM DISPONE;

-- Insertar registros en la tabla `DESCRIBE`.
INSERT INTO `DESCRIBE` (identificador_stand, codigo_tag)
VALUES (1, 1),
	   (2, 2),
       (3, 3),
       (4, 4);
       
       SELECT * FROM `DESCRIBE`;

-- Insertar registros en la tabla DA.
INSERT INTO DA (codigo_asistente, identificador_nota)
VALUES (1, 1),
	   (2, 2),
       (3, 3),
       (4, 4);
       
       SELECT * FROM DA;

-- Insertar registros en la tabla participa.
INSERT INTO PARTICIPA (identificador_actividad, codigo_asistente, modalidad, fecha)
VALUES (1, 1, 'Presencial', '2025-10-15'),
	   (2, 2, 'Virtual', '2025-10-16'),
       (3, 3, 'Presencial', '2025-10-17'),
       (4, 4, 'Híbrida', '2025-10-18');
       
       SELECT * FROM PARTICIPA;





-- D) i. Listar los proyectos premiados con sus integrantes y coordinador por categoría por expo.
SELECT e.descripcion AS 'EXPO',
	   cat.descripcion AS 'CATEGORÍA',
       p.nombre_proyecto AS 'PROYECTO',
       est.nombre AS 'NOMBRE INTEGRANTE',
       est.apellido AS 'APELLIDO INTEGRANTE',
       d.nombre_y_apellido AS 'COORDINADOR',
       es.tipo AS 'ESTABLECIMIENTO'
FROM PROYECTO p
JOIN PREMIO prem ON prem.codigo_proyecto = p.codigo_proyecto
JOIN CATEGORIA cat ON prem.codigo_categoria = cat.codigo_categoria
JOIN ESTUDIANTE est ON est.codigo_proyecto = p.codigo_proyecto
JOIN COORDINA coor ON coor.codigo_estudiante = est.codigo_estudiante
JOIN DOCENTE d ON d.legajo_docente = coor.legajo_docente
JOIN ESTABLECIMIENTO es ON es.identificador_establecimiento = coor.identificador_establecimiento
JOIN CONTIENE c ON c.codigo_proyecto = p.codigo_proyecto
JOIN EXPO_PROYECTO e ON e.identificador_expo = c.identificador_expo
ORDER BY e.descripcion, cat.descripcion, p.nombre_proyecto;

-- D) ii. Mostrar la agenda día por día de todas las actividades ofrecidas en las Expos.
SELECT a.nombre AS 'ACTIVIDAD',
	   a.lugar AS 'LUGAR',
       a.publico AS 'PÚBLICO',
       a.fecha_y_hora AS 'FECHA Y HORA',
       exp.descripcion AS 'EXPO'
FROM ACTIVIDAD a
JOIN PROGRAMA pro ON pro.identificador_actividad = a.identificador_actividad
JOIN EMPRESA em ON em.cuit_empresa = pro.cuit_empresa
JOIN EXPO_PROYECTO exp ON exp.identificador_expo = em.identificador_expo
ORDER BY DATE(a.fecha_y_hora), a.nombre;

-- D) iii. Generar una consulta que permita filtrar proyectos por los tags generados por IA según la data de cada proyecto.
SELECT DISTINCT pro.nombre_proyecto AS 'PROYECTO',
				t.descripcion AS 'TAG'
FROM PROYECTO pro
JOIN STAND s ON s.codigo_proyecto = pro.codigo_proyecto
JOIN `DESCRIBE` dsc ON dsc.identificador_stand = s.identificador_stand
JOIN TAG t ON t.codigo_tag = dsc.codigo_tag
WHERE t.descripcion LIKE '%IA%';

-- D) iv. Crear una vista que muestre un resumen completo del perfil del proyecto con toda la data asociada.
CREATE VIEW VISTA_PERFIL_PROYECTO AS
SELECT pro.codigo_proyecto AS 'CODIGO PROYECTO',
    pro.nombre_proyecto AS 'NOMBRE PROYECTO',
    pro.descripcion AS 'DESCRIPCION PROYECTO',
    pro.objetivo AS 'OBJETIVO PROYECTO',
    pro.fotos AS 'FOTOS PROYECTO',
    pro.videos AS 'VIDEOS PROYECTO',
    pro.poster AS 'POSTER PROYECTO',
    
    pr.distinciones AS 'PREMIO',
    cat.descripcion AS 'CATEGORIA PREMIO',
    
    est.nombre AS 'NOMBRE INTEGRANTE',
    est.apellido AS 'APELLIDO INTEGRANTE',
    
    d.nombre_y_apellido AS 'COORDINADOR',
    es.tipo AS 'ESTABLECIMIENTO',
    t.descripcion AS 'TAG',
    ep.descripcion AS 'EXPO'
FROM PROYECTO pro
LEFT JOIN PREMIO pr ON pr.codigo_proyecto = pro.codigo_proyecto
LEFT JOIN CATEGORIA cat ON pr.codigo_categoria = cat.codigo_categoria
LEFT JOIN ESTUDIANTE est ON est.codigo_proyecto = pro.codigo_proyecto
LEFT JOIN COORDINA coor ON coor.codigo_estudiante = est.codigo_estudiante
LEFT JOIN DOCENTE d ON d.legajo_docente = coor.legajo_docente
LEFT JOIN ESTABLECIMIENTO es ON es.identificador_establecimiento = coor.identificador_establecimiento
LEFT JOIN STAND s ON s.codigo_proyecto = pro.codigo_proyecto
LEFT JOIN `DESCRIBE` dsc ON dsc.identificador_stand = s.identificador_stand
LEFT JOIN TAG t ON t.codigo_tag = dsc.codigo_tag
LEFT JOIN EMPRESA em ON em.cuit_empresa = s.cuit_empresa
LEFT JOIN EXPO_PROYECTO ep ON ep.identificador_expo = em.identificador_expo;

SELECT * FROM VISTA_PERFIL_PROYECTO;

-- D) v. Mostrar las carreras predominantes en los proyectos presentados en orden decreciente con cantidad de proyectos por cada una y por establecimiento.
SELECT est.carrera_precedencia AS 'CARRERA',
	   es.tipo AS 'ESTABLECIMIENTO',
       COUNT(DISTINCT est.codigo_proyecto) AS 'CANTIDAD PROYECTO'
FROM ESTUDIANTE est
JOIN COORDINA coor ON coor.codigo_estudiante = est.codigo_estudiante
JOIN ESTABLECIMIENTO es ON es.identificador_establecimiento = coor.identificador_establecimiento
GROUP BY est.carrera_precedencia, es.tipo
ORDER BY COUNT(DISTINCT est.codigo_proyecto) DESC;
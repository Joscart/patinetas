-- Crear tabla de categorías
CREATE TABLE public.tb_categoria (
    id_cat SERIAL PRIMARY KEY,
    descripcion_cat TEXT NOT NULL
);

-- Crear tabla estado civil
CREATE TABLE public.tb_estadocivil (
    id_est SERIAL PRIMARY KEY,
    descripcion_est TEXT NOT NULL
);

-- Crear tabla perfiles
CREATE TABLE public.tb_perfil (
    id_per SERIAL PRIMARY KEY,
    descripcion_per TEXT NOT NULL
);

-- Crear tabla páginas
CREATE TABLE public.tb_pagina (
    id_pag SERIAL PRIMARY KEY,
    descripcion_pag TEXT NOT NULL,
    path_pag TEXT NOT NULL
);

-- Crear tabla productos con clave foránea hacia categorías
CREATE TABLE public.tb_producto (
    id_pr SERIAL PRIMARY KEY,
    id_cat INTEGER REFERENCES public.tb_categoria(id_cat) ON DELETE CASCADE,
    nombre_pr TEXT NOT NULL,
    cantidad_pr INTEGER NOT NULL,
    precio_pr DOUBLE PRECISION NOT NULL,
    foto_pr BYTEA,
	estado INTEGER DEFAULT 0 NOT NULL,
	valor DOUBLE PRECISION
);

-- Crear tabla usuario con claves foráneas hacia estado civil y perfil
CREATE TABLE public.tb_usuario (
    id_us SERIAL PRIMARY KEY,
    id_per INTEGER REFERENCES public.tb_perfil(id_per) ON DELETE SET NULL,
    id_est INTEGER REFERENCES public.tb_estadocivil(id_est) ON DELETE SET NULL,
    nombre_us TEXT NOT NULL,
    cedula_us TEXT UNIQUE NOT NULL,
    correo_us TEXT UNIQUE NOT NULL,
    clave_us TEXT NOT NULL,
	bloqueo INTEGER DEFAULT 0 NOT NULL
);

-- Crear tabla perfil-página para asignación de accesos
CREATE TABLE public.tb_perfilpagina (
    id_perpag SERIAL PRIMARY KEY,
    id_per INTEGER REFERENCES public.tb_perfil(id_per) ON DELETE CASCADE,
    id_pag INTEGER REFERENCES public.tb_pagina(id_pag) ON DELETE CASCADE
);

-- Insertar registros en tb_categoria con categorías reales
INSERT INTO tb_categoria (descripcion_cat) VALUES
('Skateboard'),
('Longboard'),
('Cruiser'),
('Pennyboard'),
('Waveboard');

-- Insertar registros en tb_producto con nombres reales de patinetas
INSERT INTO tb_producto (id_cat, nombre_pr, cantidad_pr, precio_pr, foto_pr) VALUES
(1, 'Santa Cruz Classic Dot', 10, 99.99, NULL),
(1, 'Element Section', 15, 89.99, NULL),
(2, 'Landyachtz Drop Cat', 20, 199.99, NULL),
(2, 'Arbor Axis Bamboo', 5, 179.99, NULL),
(3, 'Globe Big Blazer', 8, 129.99, NULL),
(3, 'Sector 9 Ledger', 12, 139.99, NULL),
(4, 'Penny Australia Classic', 7, 109.99, NULL),
(4, 'Ridge Mini Cruiser', 9, 99.99, NULL),
(5, 'RipStik Caster Board', 11, 79.99, NULL),
(5, 'Street Surfing Wave Original', 6, 89.99, NULL);

-- Insertar datos en tb_estadocivil
INSERT INTO tb_estadocivil (descripcion_est) VALUES
('Soltero'),
('Casado'),
('Divorciado'),
('Viudo');

-- Insertar datos en tb_perfil
INSERT INTO tb_perfil (descripcion_per) VALUES
('Administrador'),
('Cliente'),
('Vendedor');

-- Insertar registros en tb_pagina
INSERT INTO public.tb_pagina (descripcion_pag, path_pag) VALUES
('Carrito de Compras', 'http://localhost:8080/patinetas/carrito.jsp'),
('Administrar Usuarios', 'http://localhost:8080/patinetas/usuarios.jsp'),
('Administrar Productos', 'http://localhost:8080/patinetas/productos.jsp'),
('Bitácora', 'http://localhost:8080/patinetas/bitacora.jsp'),
('Ofertas', 'http://localhost:8080/patinetas/ofertas.jsp'),
('Cambio Clave', 'http://localhost:8080/patinetas/cambioClave.jsp'),
('Cerrar Sesión', 'http://localhost:8080/patinetas/cerrarsesion.jsp');

-- Insertar registros en tb_perfilpagina
/* Perfil Administrador */
INSERT INTO public.tb_perfilpagina (id_per, id_pag) VALUES
(1, 2), -- Administrar Usuarios
(1, 4), -- Bitácora
(1, 6), -- Cambio Clave
(1, 7); -- Cerrar Sesión

/* Perfil Cliente */
INSERT INTO public.tb_perfilpagina (id_per, id_pag) VALUES
(2, 1), -- Carrito de Compras
(2, 6), -- Cambio Clave
(2, 7); -- Cerrar Sesión

/* Perfil Empleado */
INSERT INTO public.tb_perfilpagina (id_per, id_pag) VALUES
(3, 3), -- Administrar Productos
(3, 5), -- Ofertas
(3, 6), -- Cambio Clave
(3, 7); -- Cerrar Sesión

-- Insertar datos en tb_usuario
INSERT INTO tb_usuario (id_per, id_est, nombre_us, cedula_us, correo_us, clave_us) VALUES
(1, 1, 'Joscart', '1728573153', 'jguallasaminc@est.ups.edu.ec', 'queso123');



create table "auditoria".TB_AUDITORIA (
   ID_AUD               SERIAL               not null,
   TABLA_AUD            TEXT                 null,
   OPERACION_AUD        TEXT                 null,
   VALORANTERIOR_AUD    TEXT                 null,
   VALORNUEVO_AUD       TEXT                 null,
   FECHA_AUD            DATE                 null,
   USUARIO_AUD          TEXT                 null,
   ESQUEMA_AUD          TEXT                 null,
   ACTIVAR_AUD          BOOL                 null,
   TRIGGER_AUD          BOOL                 null,
   constraint PK_TB_AUDITORIA primary key (ID_AUD)
);

/*==============================================================*/
/* Index: TB_AUDITORIA_PK                                       */
/*==============================================================*/
create unique index TB_AUDITORIA_PK on "auditoria".TB_AUDITORIA (
ID_AUD
);

INSERT INTO "auditoria".tb_auditoria (tabla_aud, esquema_aud, trigger_aud)
 select pgtb.tablename, pgtb.schemaname, pgtb.hastriggers  from pg_tables pgtb  where pgtb.schemaname like 'public'


CREATE OR REPLACE FUNCTION fn_log_audit()
  RETURNS trigger AS
$BODY$
BEGIN
  IF (TG_OP = 'DELETE') THEN
    INSERT INTO "auditoria".tb_auditoria ("tabla_aud", "operacion_aud", "valoranterior_aud", "valornuevo_aud", "fecha_aud", "usuario_aud")
           VALUES (TG_TABLE_NAME, 'D', OLD, NULL, now(), USER);
    RETURN OLD;
  ELSIF (TG_OP = 'UPDATE') THEN
    INSERT INTO "auditoria".tb_auditoria ("tabla_aud", "operacion_aud", "valoranterior_aud", "valornuevo_aud", "fecha_aud", "usuario_aud")
           VALUES (TG_TABLE_NAME, 'U', OLD, NEW, now(), USER);
    RETURN NEW;
  ELSIF (TG_OP = 'INSERT') THEN
    INSERT INTO "auditoria".tb_auditoria ("tabla_aud", "operacion_aud", "valoranterior_aud", "valornuevo_aud", "fecha_aud", "usuario_aud")
           VALUES (TG_TABLE_NAME, 'I', NULL, NEW, now(), USER);
    RETURN NEW;
  END IF;
  RETURN NULL;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION fn_log_audit()
  OWNER TO postgres;


CREATE TRIGGER tb_producto_tg_audit AFTER INSERT OR UPDATE OR DELETE  ON tb_producto  FOR EACH ROW  EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER tb_usuario_tg_audit AFTER INSERT OR UPDATE OR DELETE  ON tb_usuario  FOR EACH ROW  EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER tb_categoria_tg_audit AFTER INSERT OR UPDATE OR DELETE  ON tb_categoria  FOR EACH ROW  EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER tb_estadocivil_tg_audit AFTER INSERT OR UPDATE OR DELETE  ON tb_estadocivil  FOR EACH ROW  EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER tb_pagina_tg_audit AFTER INSERT OR UPDATE OR DELETE  ON tb_pagina  FOR EACH ROW  EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER tb_perfil_tg_audit AFTER INSERT OR UPDATE OR DELETE  ON tb_perfil  FOR EACH ROW  EXECUTE PROCEDURE fn_log_audit();
CREATE TRIGGER tb_perfilpagina_tg_audit AFTER INSERT OR UPDATE OR DELETE  ON tb_perfilpagina  FOR EACH ROW  EXECUTE PROCEDURE fn_log_audit();
--CREATE TRIGGER tb_parametros_tg_audit AFTER INSERT OR UPDATE OR DELETE  ON tb_parametros  FOR EACH ROW  EXECUTE PROCEDURE fn_log_audit();

/*
0 normal
1 oferta
*/
ALTER TABLE public.tb_producto
ADD COLUMN estado INTEGER NOT NULL DEFAULT 0,
ADD COLUMN valor DOUBLE PRECISION;

UPDATE tb_producto SET estado = 1, valor = 79.99 WHERE id_cat = 1

INSERT INTO public.tb_pagina (descripcion_pag, path_pag) VALUES
('Ofertas', 'http://localhost:8080/e-commerce-test/ofertas.jsp');

INSERT INTO public.tb_perfilpagina (id_per, id_pag) VALUES
(3, 7); -- Ofertas

SELECT * FROM tb_producto WHERE estado = 1 ORDER BY id_pr

--Fotos
UPDATE public.tb_producto SET foto_pr = pg_read_binary_file('D:\Descargas\perrito.jpg')::bytea
WHERE id_pr = 1;

SELECT CONCAT('data:image/png;base64,', encode(foto_pr, 'base64')) AS foto_base64
FROM public.tb_producto
WHERE id_pr = 1;


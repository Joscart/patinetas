

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


--liquibase formatted sql
--changeset kkazala:models_body_pkg failOnError:true stripComments:false splitStatements:true rollbackSplitStatements:true runOnChange:true context:pakiety
--rollback select 1 from dual;
CREATE OR REPLACE PACKAGE BODY MODELS_BODY_PKG AS
  PROCEDURE VALIDATE_FORMULA (
  in_formula IN clob
  ) AS
    l_left_parenthesis_count number;
    l_right_parenthesis_count number;
  BEGIN
    NULL;
  END;

  PROCEDURE INSERT_MODEL
  AS
    l_models_row WKSP_CHARLIEDEV.MODELS%ROWTYPE;
  BEGIN
    l_models_row.NAME := v('P11_NAME');
    l_models_row.FORMULA := REGEXP_REPLACE(v('P11_FORMULA'), '([[:digit:]|\.])[[:space:]]*', '\1');

    INSERT INTO WKSP_CHARLIEDEV.MODELS VALUES l_models_row;
    COMMIT;
  END;
END MODELS_BODY_PKG;
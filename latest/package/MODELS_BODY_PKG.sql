--liquibase formatted sql
--changeset kkazala:models_body_pkg failOnError:true stripComments:false splitStatements:true rollbackSplitStatements:true runOnChange:true context:pakiety
--rollback select 1 from dual;
CREATE OR REPLACE PACKAGE BODY MODELS_BODY_PKG AS
  PROCEDURE VALIDATE_FORMULA (
  in_formula IN clob
  ) AS
    l_formula CLOB := in_formula;
  BEGIN
    l_formula := 'SELECT ' || l_formula || ' FROM BETS_V WHERE ROWNUM = 1';

    WHILE LENGTH(l_formula) <70000
    LOOP
      l_formula := l_formula || chr(10) || '--comment';
    END LOOP;

    EXECUTE IMMEDIATE l_formula;
  EXCEPTION
    WHEN OTHERS THEN raise_application_error (-20001, 'Nieprawidłowa formuła.');
    --WHEN OTHERS THEN raise_application_error (-20002, chr(10)||' Failed: ' || l_formula || ' ' || SQLERRM);
  END;

  PROCEDURE INSERT_MODEL
  AS
    l_models_row WKSP_CHARLIEDEV.MODELS%ROWTYPE;
  BEGIN
    l_models_row.NAME := v('P' || v('APP_PAGE_ID') || '_NAME');
    l_models_row.FORMULA := REGEXP_REPLACE(v('P' || v('APP_PAGE_ID') || '_FORMULA'), '([[:digit:]|\.])[[:space:]]*', '\1');
    VALIDATE_FORMULA(l_models_row.FORMULA);

    INSERT INTO WKSP_CHARLIEDEV.MODELS VALUES l_models_row;
    COMMIT;
  END;

  PROCEDURE EDIT_MODEL
  AS
    l_models_row WKSP_CHARLIEDEV.MODELS%ROWTYPE;
  BEGIN
    l_models_row.NAME := v('P' || v('APP_PAGE_ID') || '_NAME');
    l_models_row.FORMULA := REGEXP_REPLACE(v('P' || v('APP_PAGE_ID') || '_FORMULA'), '([[:digit:]|\.])[[:space:]]*', '\1');
    VALIDATE_FORMULA(l_models_row.FORMULA);

    UPDATE WKSP_CHARLIEDEV.MODELS
      SET NAME = l_models_row.NAME,
          FORMULA = l_models_row.FORMULA
      WHERE ID = v('P' || v('APP_PAGE_ID') || '_ID');
    COMMIT;
  END;
END MODELS_BODY_PKG;
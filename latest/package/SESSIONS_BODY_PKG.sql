--liquibase formatted sql
--changeset kkazala:SESSIONS_BODY_PKG failOnError:true stripComments:false splitStatements:true rollbackSplitStatements:true runOnChange:true context:pakiety
--comment dodanie body pakietu do rozliczania sesji
--rollback select 1 from dual;
CREATE OR REPLACE PACKAGE BODY SESSIONS_BODY_PKG AS
  PROCEDURE CALCULATE_SALES_COMMISSIONS (
    in_program_id IN NUMBER
  ) AS
    l_programs_row WKSP_CHARLIEDEV.PROGRAMS%ROWTYPE;
    l_formula WKSP_CHARLIEDEV.MODLES.FORMULA%TYPE;
    l_result WKSP_CHARLIEDEV.CALCULATED_SALES_COMMISSIONS.CALCULATED_AMOUNT%TYPE;
  BEGIN
    SELECT * INTO l_programs_row FROM WKSP_CHARLIEDEV.PROGRAMS WHERE ID = in_program_id;
    SELECT FORMULA INTO l_formula FROM WKSP_CHARLIEDEV.MODELS WHERE ID = l_programs_row.MODEL_ID;

    l_formula := 'SELECT ' || l_formula || ' FROM COMMISSION_DATA_V WHERE SPORTS_LEAGUE_ID = ' || l_programs_row.ORGANIZATION_ID || ' AND BET_DATE BETWEEN ' || l_programs_row.DATE_FROM || ' AND ' || l_programs_row.DATE_TO;

    WHILE LENGTH(l_formula) <70000
    LOOP
      l_formula := l_formula || chr(10) || '--comment';
    END LOOP;

    EXECUTE IMMEDIATE l_formula;
  EXCEPTION WHEN OTHERS THEN
    raise_application_error (-20001, chr(10)||' Failed: ' || l_formula || ' ' || SQLERRM);
  END;
END SESSIONS_BODY_PKG;
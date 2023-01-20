--liquibase formatted sql
--changeset kkazala:SESSIONS_BODY_PKG failOnError:true stripComments:false splitStatements:true rollbackSplitStatements:true runOnChange:true context:pakiety
--comment dodanie body pakietu do rozliczania sesji
--rollback select 1 from dual;
CREATE OR REPLACE PACKAGE BODY SESSIONS_BODY_PKG AS

  --procedura do liczenia prowizji z programu prowizyjnego
  PROCEDURE CALCULATE_SALES_COMMISSIONS (
    in_program_id IN NUMBER--,
    --out_result OUT WKSP_CHARLIEDEV.CALCULATED_SALES_COMMISSIONS.CALCULATED_AMOUNT%TYPE
  ) AS
    l_programs_row WKSP_CHARLIEDEV.PROGRAMS%ROWTYPE;
    l_formula WKSP_CHARLIEDEV.MODELS.FORMULA%TYPE;
    l_result WKSP_CHARLIEDEV.CALCULATED_SALES_COMMISSIONS.CALCULATED_AMOUNT%TYPE;
    l_model_name WKSP_CHARLIEDEV.MODELS.NAME%TYPE;
    l_sport_league WKSP_CHARLIEDEV.SPORTS_LEAGUES.NAME%TYPE;
  BEGIN
    --przypisywanie wartości zmiennym
    SELECT * INTO l_programs_row FROM WKSP_CHARLIEDEV.PROGRAMS WHERE ID = in_program_id;
    SELECT FORMULA, NAME INTO l_formula, l_model_name FROM WKSP_CHARLIEDEV.MODELS WHERE ID = l_programs_row.MODEL_ID;
    SELECT NAME INTO l_sport_league FROM WKSP_CHARLIEDEV.SPORTS_LEAGUES WHERE ID = l_programs_row.ORGANIZATION_ID;

    --select zwracający prowizję
    l_formula := 'SELECT SUM(' || l_formula || ') FROM COMMISSION_DATA_V WHERE SPORTS_LEAGUE_ID = ' || l_programs_row.ORGANIZATION_ID || ' AND BET_DATE BETWEEN '
                   || 'TO_DATE(''' || l_programs_row.DATE_FROM ||''',''MM/DD/YYYY'')' || ' AND ' || 'TO_DATE(''' || l_programs_row.DATE_TO || ''', ''MM/DD/YYYY'')';

    EXECUTE IMMEDIATE l_formula INTO l_result;
    l_result := ROUND(NVL(l_result, 0), 2);

    --zapisanie wyników do tabeli z obliczonymi prowizjami
    INSERT_CALCULATED_SALES_COMMISSIONS(l_programs_row.NAME, l_model_name, l_result, l_programs_row.DATE_TO, l_programs_row.DATE_FROM, CURRENT_DATE, l_sport_league);
    --przypisanie informacji o ostatnim uruchomieniu do odpalonego programu
    UPDATE WKSP_CHARLIEDEV.PROGRAMS SET LAST_START = CURRENT_DATE WHERE ID = in_program_id;
    COMMIT;

  EXCEPTION WHEN OTHERS THEN
    raise_application_error (-20001, chr(10)||' Failed: ' || l_formula || ' ' || SQLERRM);
  END;

  --procedura do zapisu danych
  PROCEDURE INSERT_CALCULATED_SALES_COMMISSIONS (
    in_program_name WKSP_CHARLIEDEV.CALCULATED_SALES_COMMISSIONS.PROGRAM_NAME%TYPE,
    in_model_name WKSP_CHARLIEDEV.CALCULATED_SALES_COMMISSIONS.MODEL_NAME%TYPE,
    in_calculated_amount WKSP_CHARLIEDEV.CALCULATED_SALES_COMMISSIONS.CALCULATED_AMOUNT%TYPE,
    in_date_to WKSP_CHARLIEDEV.CALCULATED_SALES_COMMISSIONS.DATE_TO%TYPE,
    in_date_from WKSP_CHARLIEDEV.CALCULATED_SALES_COMMISSIONS.DATE_FROM%TYPE,
    in_calculation_date WKSP_CHARLIEDEV.CALCULATED_SALES_COMMISSIONS.CALCULATION_DATE%TYPE,
    in_sport_league WKSP_CHARLIEDEV.SPORTS_LEAGUES.NAME%TYPE
  )
  AS
  BEGIN
    INSERT INTO WKSP_CHARLIEDEV.CALCULATED_SALES_COMMISSIONS (PROGRAM_NAME, MODEL_NAME, CALCULATED_AMOUNT, DATE_TO, DATE_FROM, CALCULATION_DATE, SPORT_LEAGUE)
      VALUES (in_program_name, in_model_name, in_calculated_amount, in_date_to, in_date_from, in_calculation_date, in_sport_league);
    COMMIT;
  END;

END SESSIONS_BODY_PKG;

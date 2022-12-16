--liquibase formatted sql
--changeset kkazala:SESSIONS_SPEC_PKG failOnError:true stripComments:false splitStatements:true rollbackSplitStatements:true runOnChange:true context:pakiety
--comment dodanie spec pakietu do rozliczania sesji
--rollback select 1 from dual;
CREATE OR REPLACE PACKAGE SESSIONS_SPEC_PKG AS
  PROCEDURE CALCULATE_SALES_COMMISSIONS (
    in_program_id IN NUMBER);

  PROCEDURE INSERT_MODEL;
END SESSIONS_SPEC_PKG;
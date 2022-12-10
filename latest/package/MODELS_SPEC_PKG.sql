--liquibase formatted sql
--changeset kkazala:models_spec_pkg failOnError:true stripComments:false splitStatements:true rollbackSplitStatements:true runOnChange:true context:pakiety
--rollback select 1 from dual;
CREATE OR REPLACE PACKAGE MODELS_BODY_PKG AS
  PROCEDURE VALIDATE_FORMULA (
    in_formula IN clob);

  PROCEDURE INSERT_MODEL;
END MODELS_BODY_PKG;
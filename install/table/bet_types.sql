--liquibase formatted sql
--changeset kjagiello:BET_TYPES2 failOnError:true stripComments:false splitStatements:true rollbackSplitStatements:true runOnChange:true
--rollback drop table BET_TYPES;
CREATE TABLE BET_TYPES
(
   ID              NUMBER        NOT NULL,
   NAME            VARCHAR2(150) NOT NULL,
   ORGANIZATION_ID NUMBER        NOT NULL
);

COMMENT ON TABLE BET_TYPES                  IS 'Dane dot. typów zakładów';
COMMENT ON COLUMN BET_TYPES.ID              IS 'Identyfikator zakładu';
COMMENT ON COLUMN BET_TYPES.NAME            IS 'Nazwa zakładu';
COMMENT ON COLUMN BET_TYPES.ORGANIZATION_ID IS 'Identyfikator organizacji sportowej (klucz obcy)';
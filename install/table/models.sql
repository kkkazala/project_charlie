--liquibase formatted sql
--changeset kjagiello:MODELS5 failOnError:true stripComments:false splitStatements:true rollbackSplitStatements:true runOnChange:true
--rollback drop table MODELS;
CREATE TABLE MODELS
(
   ID      NUMBER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1)  PRIMARY KEY,
   FORMULA VARCHAR2(1000) NOT NULL
);

COMMENT ON TABLE MODELS          IS 'Dane dot. modelu prowizyjnego';
COMMENT ON COLUMN MODELS.ID      IS 'Identyfikator modelu';
COMMENT ON COLUMN MODELS.FORMULA IS 'Wzór do wyliczania prowizji';
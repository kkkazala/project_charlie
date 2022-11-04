--liquibase formatted sql
--changeset kjagiello:MODELS failOnError:true stripComments:false splitStatements:true rollbackSplitStatements:true runOnChange:false
--rollback drop table MODELS;
CREATE TABLE MODELS
(
   ID      NUMBER         NOT NULL,
   FORMULA VARCHAR2(1000) NOT NULL
);

COMMENT ON TABLE MODELS          IS 'Dane dot. modelu prowizyjnego';
COMMENT ON COLUMN MODELS.ID      IS 'Identyfikator modelu';
COMMENT ON COLUMN MODELS.FORMULA IS 'Wzór do wyliczania prowizji';

ALTER TABLE MODELS ADD CONSTRAINT PK_MODELS PRIMARY KEY (ID);
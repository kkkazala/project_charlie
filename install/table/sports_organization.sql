--liquibase formatted sql
--changeset kjagiello:SPORTS_ORGANIZATIONS failOnError:true stripComments:false splitStatements:true rollbackSplitStatements:true runOnChange:false
--rollback drop table SPORTS_ORGANIZATIONS;
CREATE TABLE SPORTS_ORGANIZATIONS
(
   ID          NUMBER        NOT NULL,
   NAME        VARCHAR2(150) NOT NULL,
   VAT         VARCHAR2(100),
   NATIONALITY VARCHAR2(100)
);

COMMENT ON TABLE SPORTS_ORGANIZATIONS              IS 'Dane dot. organizacji sportowych';
COMMENT ON COLUMN SPORTS_ORGANIZATIONS.ID          IS 'Identyfikator organizacji sportowej';
COMMENT ON COLUMN SPORTS_ORGANIZATIONS.NAME        IS 'Nazwa organizacji sportowej';
COMMENT ON COLUMN SPORTS_ORGANIZATIONS.VAT         IS 'Numer vat';
COMMENT ON COLUMN SPORTS_ORGANIZATIONS.NATIONALITY IS 'Pochodzenie organizacji sportowej';

ALTER TABLE SPORTS_ORGANIZATIONS ADD CONSTRAINT PK_SPORTS_ORGANIZATIONS PRIMARY KEY (ID);

CREATE INDEX INX1_SPORTS_ORGANIZATIONS ON SPORTS_ORGANIZATIONS (ID);

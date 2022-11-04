--liquibase formatted sql
--changeset kjagiello:SPORTS_ORGANIZATIONS5 failOnError:true stripComments:false splitStatements:true rollbackSplitStatements:true runOnChange:true
--rollback drop table SPORTS_ORGANIZATIONS;
CREATE TABLE SPORTS_ORGANIZATIONS
(
   ID          NUMBER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1)  PRIMARY KEY,
   NAME        VARCHAR2(150) NOT NULL,
   VAT         VARCHAR2(100),
   NATIONALITY VARCHAR2(100)
);

COMMENT ON TABLE SPORTS_ORGANIZATIONS              IS 'Dane dot. organizacji sportowych';
COMMENT ON COLUMN SPORTS_ORGANIZATIONS.ID          IS 'Identyfikator organizacji sportowej';
COMMENT ON COLUMN SPORTS_ORGANIZATIONS.NAME        IS 'Nazwa organizacji sportowej';
COMMENT ON COLUMN SPORTS_ORGANIZATIONS.VAT         IS 'Numer vat';
COMMENT ON COLUMN SPORTS_ORGANIZATIONS.NATIONALITY IS 'Pochodzenie organizacji sportowej';
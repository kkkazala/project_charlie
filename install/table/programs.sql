--liquibase formatted sql
--changeset kjagiello:PROGRAMS2 failOnError:true stripComments:false splitStatements:true rollbackSplitStatements:true runOnChange:true
--rollback drop table PROGRAMS;
CREATE TABLE PROGRAMS
(
   ID              NUMBER NOT NULL,
   MODEL_ID        NUMBER NOT NULL,
   ORGANIZATION_ID NUMBER NOT NULL,
   DATE_FROM       DATE,
   DATE_TO         DATE
);

COMMENT ON TABLE PROGRAMS                  IS 'Dane dot. programu prowizyjnego';
COMMENT ON COLUMN PROGRAMS.ID              IS 'Identyfikator programu';
COMMENT ON COLUMN PROGRAMS.MODEL_ID        IS 'Identyfikator modelu prowizyjnego (klucz obcy)';
COMMENT ON COLUMN PROGRAMS.ORGANIZATION_ID IS 'Identyfikator organizacji sportowej (klucz obcy)';
COMMENT ON COLUMN PROGRAMS.DATE_FROM       IS 'Data rozpoczęcia';
COMMENT ON COLUMN PROGRAMS.DATE_TO         IS 'Data zakończenia';
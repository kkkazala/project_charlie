--liquibase formatted sql
--changeset kjagiello:TEAMS2 failOnError:true stripComments:false splitStatements:true rollbackSplitStatements:true runOnChange:true
--rollback drop table TEAMS;
CREATE TABLE WKSP_CHARLIEDEV.TEAMS
(
   ID              NUMBER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1)  PRIMARY KEY,
   NAME            VARCHAR2(100) NOT NULL,
   ORGANIZATION_ID NUMBER        NOT NULL
);

COMMENT ON TABLE WKSP_CHARLIEDEV.TEAMS                  IS 'Dane dot. zespołów';
COMMENT ON COLUMN WKSP_CHARLIEDEV.TEAMS.ID              IS 'Identyfikator zespołu';
COMMENT ON COLUMN WKSP_CHARLIEDEV.TEAMS.NAME            IS 'Nazwa zespołu';
COMMENT ON COLUMN WKSP_CHARLIEDEV.TEAMS.ORGANIZATION_ID IS 'Identyfikator organizacji sportowej (klucz obcy)';

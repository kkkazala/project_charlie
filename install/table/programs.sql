--liquibase formatted sql
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

ALTER TABLE PROGRAMS ADD CONSTRAINT PK_PROGRAMS PRIMARY KEY (ID);
ALTER TABLE PROGRAMS ADD CONSTRAINT FK1_PROGRAMS FOREIGN KEY (MODEL_ID) REFERENCES MODELS (ID);
ALTER TABLE PROGRAMS ADD CONSTRAINT FK2_PROGRAMS FOREIGN KEY (ORGANIZATION_ID) REFERENCES SPORTS_ORGANIZATIONS (ID);
--liquibase formatted sql
--changeset kjagiello:bet_types failOnError:true stripComments:false splitStatements:true rollbackSplitStatements:true runOnChange:false
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
/*
ALTER TABLE BET_TYPES ADD CONSTRAINT PK_BET_TYPES PRIMARY KEY (ID);
ALTER TABLE BET_TYPES ADD CONSTRAINT FK1_BET_TYPES FOREIGN KEY (ORGANIZATION_ID) REFERENCES SPORTS_ORGANIZATIONS (ID);
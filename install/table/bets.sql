--liquibase formatted sql
--changeset kjagiello:BETS2 failOnError:true stripComments:false splitStatements:true rollbackSplitStatements:true runOnChange:true
--rollback drop table BETS;
CREATE TABLE BETS
(
   ID              NUMBER NOT NULL,
   AMOUNT          NUMBER NOT NULL,
   MULTIPLIER      NUMBER NOT NULL,
   DATE_OF_BET     DATE,
   ORGANIZATION_ID NUMBER NOT NULL,
   BET_TYPE_ID     NUMBER NOT NULL,
   PROMOTION_ID    NUMBER NOT NULL
);

COMMENT ON TABLE BETS                  IS 'Dane dot. zakładu';
COMMENT ON COLUMN BETS.ID              IS 'Identyfikator zakładu';
COMMENT ON COLUMN BETS.AMOUNT          IS 'Kwota zakładu';
COMMENT ON COLUMN BETS.MULTIPLIER      IS 'Mnożnik zakładu';
COMMENT ON COLUMN BETS.DATE_OF_BET     IS 'Data zakładu';
COMMENT ON COLUMN BETS.ORGANIZATION_ID IS 'Identyfikator organizacji sportowej (klucz obcy)';
COMMENT ON COLUMN BETS.BET_TYPE_ID     IS 'Identyfikator typu zakładu (klucz obcy)';
COMMENT ON COLUMN BETS.PROMOTION_ID    IS 'Identyfikator promocji (klucz obcy)';
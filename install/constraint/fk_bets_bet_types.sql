--liquibase formatted sql
--changeset kjagiello:FK2_BETS failOnError:true stripComments:false splitStatements:true rollbackSplitStatements:true runOnChange:true
--rollback alter table BETS drop constraint FK2_BETS;
ALTER TABLE BETS ADD CONSTRAINT FK2_BETS FOREIGN KEY (BET_TYPE_ID) REFERENCES BET_TYPES (ID);
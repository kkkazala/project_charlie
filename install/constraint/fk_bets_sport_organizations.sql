--liquibase formatted sql
--changeset kjagiello:FK1_BETS failOnError:true stripComments:false splitStatements:true rollbackSplitStatements:true runOnChange:true
--rollback alter table BETS drop constraint FK1_BETS;
ALTER TABLE BETS ADD CONSTRAINT FK1_BETS FOREIGN KEY (ORGANIZATION_ID) REFERENCES SPORTS_ORGANIZATIONS (ID);
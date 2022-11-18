--liquibase formatted sql
--changeset kjagiello:FK3_BETS failOnError:true stripComments:false splitStatements:true rollbackSplitStatements:true runOnChange:true
--rollback alter table BETS drop constraint FK3_BETS;
ALTER TABLE BETS ADD CONSTRAINT FK3_BETS FOREIGN KEY (PROMOTION_ID) REFERENCES PROMOTIONS (ID);
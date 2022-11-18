--liquibase formatted sql
--changeset kjagiello:FK1_CALCULATED_SALES_COMMISSIONS failOnError:true stripComments:false splitStatements:true rollbackSplitStatements:true runOnChange:true
--rollback alter table CALCULATED_SALES_COMMISSIONS drop constraint FK1_CALCULATED_SALES_COMMISSIONS;
ALTER TABLE CALCULATED_SALES_COMMISSIONS ADD CONSTRAINT FK1_CALCULATED_SALES_COMMISSIONS FOREIGN KEY (PROGRAM_ID) REFERENCES PROGRAMS (ID);
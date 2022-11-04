--liquibase formatted sql
--changeset kjagiello:CALCULATED_SALES_COMMISSIONS2 failOnError:true stripComments:false splitStatements:true rollbackSplitStatements:true runOnChange:true
--rollback drop table CALCULATED_SALES_COMMISSIONS;
CREATE TABLE CALCULATED_SALES_COMMISSIONS
(
   ID                NUMBER NOT NULL,
   PROGRAM_ID        NUMBER NOT NULL,
   CALCULATED_AMOUNT NUMBER NOT NULL
);

COMMENT ON TABLE CALCULATED_SALES_COMMISSIONS                    IS 'Dane dot. wyliczonych prowizji';
COMMENT ON COLUMN CALCULATED_SALES_COMMISSIONS.ID                IS 'Identyfikator wyliczonej prowizji';
COMMENT ON COLUMN CALCULATED_SALES_COMMISSIONS.PROGRAM_ID        IS 'Identyfikator programu prowizyjnego (klucz obcy)';
COMMENT ON COLUMN CALCULATED_SALES_COMMISSIONS.CALCULATED_AMOUNT IS 'Wyliczona kwota';
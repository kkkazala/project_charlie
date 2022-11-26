--liquibase formatted sql
--changeset kjagiello:FK2_PROGRAMS failOnError:true stripComments:false splitStatements:true rollbackSplitStatements:true runOnChange:true
--rollback alter table PROGRAMS drop constraint FK2_PROGRAMS;
ALTER TABLE PROGRAMS ADD CONSTRAINT FK2_PROGRAMS FOREIGN KEY (ORGANIZATION_ID) REFERENCES SPORTS_LEAGUES (ID);
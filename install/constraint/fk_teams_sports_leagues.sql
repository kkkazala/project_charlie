--liquibase formatted sql
--changeset kjagiello:FK1_TEAMS failOnError:true stripComments:false splitStatements:true rollbackSplitStatements:true runOnChange:true
--rollback alter table TEAMS drop constraint FK1_TEAMS;
ALTER TABLE TEAMS ADD CONSTRAINT FK1_TEAMS FOREIGN KEY (ORGANIZATION_ID) REFERENCES SPORTS_LEAGUES (ID);
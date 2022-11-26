--liquibase formatted sql
--changeset kjagiello:FK1_BET_TYPES failOnError:true stripComments:false splitStatements:true rollbackSplitStatements:true runOnChange:true
--rollback alter table BET_TYPES drop constraint FK1_BET_TYPES;
ALTER TABLE BET_TYPES ADD CONSTRAINT FK1_BET_TYPES FOREIGN KEY (ORGANIZATION_ID) REFERENCES SPORTS_LEAGUES (ID);
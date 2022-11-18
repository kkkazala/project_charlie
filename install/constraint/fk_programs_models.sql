--liquibase formatted sql
--changeset kjagiello:FK1_PROGRAMS failOnError:true stripComments:false splitStatements:true rollbackSplitStatements:true runOnChange:true
--rollback alter table PROGRAMS drop constraint FK1_PROGRAMS;
ALTER TABLE PROGRAMS ADD CONSTRAINT FK1_PROGRAMS FOREIGN KEY (MODEL_ID) REFERENCES MODELS (ID);
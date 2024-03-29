--liquibase formatted sql
--changeset kkazala:SPORTS_LEAGUES failOnError:true stripComments:false splitStatements:true rollbackSplitStatements:true
--rollback drop table SPORTS_LEAGUES;
CREATE TABLE SPORTS_LEAGUES
(
   ID          NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY  PRIMARY KEY,
   NAME        VARCHAR2(255) NOT NULL UNIQUE,
   MODIFIER    NUMBER
);

COMMENT ON TABLE SPORTS_LEAGUES              IS 'Dane dot. lig sportowych';
COMMENT ON COLUMN SPORTS_LEAGUES.ID          IS 'Identyfikator ligi sportowej';
COMMENT ON COLUMN SPORTS_LEAGUES.NAME        IS 'Nazwa ligi sportowej';
COMMENT ON COLUMN SPORTS_LEAGUES.MODIFIER    IS 'Mnożnik dla ligi sportowej';


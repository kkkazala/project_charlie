--liquibase formatted sql
--changeset kjagiello:PROMOTIONS5 failOnError:true stripComments:false splitStatements:true rollbackSplitStatements:true runOnChange:true
--rollback drop table PROMOTIONS;
CREATE TABLE PROMOTIONS
(
   ID                   NUMBER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1)  PRIMARY KEY,
   NAME                 VARCHAR2(150) NOT NULL,
   PROMOTION_MULTIPLIER NUMBER        NOT NULL
);

COMMENT ON TABLE PROMOTIONS                       IS 'Dane dot. promocji';
COMMENT ON COLUMN PROMOTIONS.ID                   IS 'Identyfikator promocji';
COMMENT ON COLUMN PROMOTIONS.NAME                 IS 'Nazwa promocji';
COMMENT ON COLUMN PROMOTIONS.PROMOTION_MULTIPLIER IS 'Mnożnik promocji';
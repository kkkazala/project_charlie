--liquibase formatted sql
--changeset kjagiello:PROMOTIONS failOnError:true stripComments:false splitStatements:true rollbackSplitStatements:true runOnChange:false
--rollback drop table PROMOTIONS;
CREATE TABLE PROMOTIONS
(
   ID                   NUMBER        NOT NULL,
   NAME                 VARCHAR2(150) NOT NULL,
   PROMOTION_MULTIPLIER NUMBER        NOT NULL
);

COMMENT ON TABLE PROMOTIONS                       IS 'Dane dot. promocji';
COMMENT ON COLUMN PROMOTIONS.ID                   IS 'Identyfikator promocji';
COMMENT ON COLUMN PROMOTIONS.NAME                 IS 'Nazwa promocji';
COMMENT ON COLUMN PROMOTIONS.PROMOTION_MULTIPLIER IS 'Mnożnik promocji';

ALTER TABLE PROMOTIONS ADD CONSTRAINT PK_PROMOTIONS PRIMARY KEY (ID);

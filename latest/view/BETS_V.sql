--liquibase formatted sql
--changeset kkazala:BETS_V failOnError:true stripComments:false splitStatements:true rollbackSplitStatements:true runOnChange:true
--rollback drop table BET_TYPES;
CREATE OR REPLACE VIEW WKSP_CHARLIEDEV.BETS_V AS
SELECT
    B.ID AS BET_ID,
    B.AMOUNT AS BET_AMOUNT,
    BT.NAME AS BET_TYPE,
    B.MULTIPLIER AS BET_MMULTIPLIER,
    B.DATE_OF_BET AS BET_DATE,
    PM.NAME AS PROMOTION_NAME,
    PM.PROMOTION_MULTIPLIER AS PROMOTION_MULTIPLIER
FROM BETS B
JOIN BET_TYPES BT on (B.BET_TYPE_ID = BT.ID)
JOIN SPORTS_ORGANIZATIONS SO on( B.ORGANIZATION_ID = SO.ID)
LEFT JOIN PROMOTIONS PM ON (B.PROMOTION_ID = PM.ID);
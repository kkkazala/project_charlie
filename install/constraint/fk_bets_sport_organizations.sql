ALTER TABLE BETS ADD CONSTRAINT FK1_BETS FOREIGN KEY (ORGANIZATION_ID) REFERENCES SPORTS_ORGANIZATIONS (ID);
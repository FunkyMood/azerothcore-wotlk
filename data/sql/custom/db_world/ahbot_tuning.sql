-- AuctionHouseBot tuning (mod-ah-bot, Azerothcore only - Ironcore has no mod-ah-bot).
-- Goal: sell more gathering/crafting materials (White/Green trade goods - herbs, ore, leather, cloth are
-- all White quality natively) at meaningfully higher prices, and shift equipment listings toward Green
-- over Blue. Captures the live state reached via direct UPDATEs during a prior session so a fresh DB
-- import reproduces the same AH behavior instead of the module's stock defaults.
-- Companion conf change (not DB, already on disk): env/dist/etc/modules/mod_ahbot.conf,
-- AuctionHouseBot.ItemsPerCycle raised from 200 to 500.
-- With the two-faction AH enabled, only the Neutral market (7) is active.
UPDATE `mod_auctionhousebot` SET
    `minitems` = 1200,
    `maxitems` = 1200
WHERE `auctionhouse` = 7;

UPDATE `mod_auctionhousebot` SET
    `percentwhitetradegoods` = 50,
    `percentgreentradegoods` = 22,
    `percentwhiteitems` = 20,
    `percentgreenitems` = 25,
    `percentblueitems` = 10,
    `percentpurpleitems` = 5,
    `minpricewhite` = 700,
    `maxpricewhite` = 1000,
    `buyerpricewhite` = 30,
    `buyerpricegreen` = 30,
    `buyerbidsperinterval` = 30
WHERE `auctionhouse` IN (2, 6, 7);

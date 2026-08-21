-- Rare and epic equipment should remain more rewarding than common materials.
UPDATE `mod_auctionhousebot`
SET `buyerpriceblue` = 15,
    `buyerpricepurple` = 20
WHERE `auctionhouse` IN (2, 6, 7);

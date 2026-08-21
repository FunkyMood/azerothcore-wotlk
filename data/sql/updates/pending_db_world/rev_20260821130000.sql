-- Keep the Auction House Bot as a dependable buyer without making vendor-price
-- arbitrage an excessive gold source. These values are multipliers, not percentages.
UPDATE `mod_auctionhousebot`
SET `buyerpricegrey` = 1,
    `buyerpricewhite` = 10,
    `buyerpricegreen` = 10,
    `buyerpriceblue` = 5,
    `buyerpricepurple` = 5,
    `buyerpriceorange` = 8,
    `buyerpriceyellow` = 10
WHERE `auctionhouse` IN (2, 6, 7);

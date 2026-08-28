-- Sir Gideon's "Tell me about this place" is now a set of pages, one per
-- feature of this realm, rather than a single block that could only ever
-- mention three things and had already fallen out of date. Text ids 200020+;
-- 200001 stays as the opening page the submenu is reached from.
--
-- Written plainly rather than in Gideon's voice: these pages exist to tell a
-- player how the realm actually works, so figures are given as figures and
-- commands sit on their own line where they can be read at a glance.
--
-- $B is a line break, $N the player's name.
DELETE FROM `npc_text` WHERE `ID` BETWEEN 200020 AND 200028;
INSERT INTO `npc_text` (`ID`, `text0_0`) VALUES
-- 200028 is the topic index itself. Deliberately blank: the list of pages
-- is the content, and the old preamble above it only pushed the topics
-- down the frame.
(200028, ' '),
(200020, 'Companions - bot characters that play alongside you.$B$BSUMMONING - your own characters, from this account:$B.playerbots bot add <name>$B.playerbots bot remove <name>$B$BTo use characters from another of your accounts, link them first:$B.playerbots account link$B$BGIVING ORDERS - whisper the bot, or type in party chat:$Bhelp - the full list of what it understands$Bfollow / stay / flee - how it positions itself$Battack - strike your current target$Bequip / sell / trade - handle its gear and goods$Bstats / talents / spells - inspect it$B$BIts behaviour is set with co (in combat) and nc (out of combat), adding or removing a strategy:$Bco +threat$Bco -cc$B$BThe wandering bots you meet in the world are not yours to command. They log in shortly after a real player joins the realm, and log out once it empties.'),
(200021, 'Experience rate - adjustable per character.$B$BRight-click your experience bar, or type:$B.xp set <number>$B$BRange: 0 to 10. Default: 1.$B$BThe rate applies only to the character that sets it. Each of your other characters keeps its own.'),
(200022, 'Challenges - optional rulesets, taken from me.$B$BHardcore: death is permanent.$BSemi-Hardcore: death costs you all worn gear and all carried gold.$BSelf-Crafted: you may only wear what you crafted yourself.$BItem Quality: you may only wear grey and white gear.$BQuest XP Only: kills grant no experience.$BArtisan: only professions grant experience.$BIron Man: no groups, enchants, potions, talents or trade skills.$B$BMost can be combined. Where two would contradict each other, the second is not offered.$B$BEach one shows exactly what it does before you accept it.'),
(200023, 'Bulletin boards - one in every capital, with a quartermaster beside it.$B$BTwo kinds of contract are posted:$BBounties - kill a specific creature.$BWork orders - craft and deliver goods.$B$BContracts are matched to your level and to the regions near that capital. Each capital posts different work.$B$BThe board rotates. What is available changes from day to day.'),
(200024, 'Professions - four primary, not two.$B$BYou may learn four primary professions at once. Maximum skill: 450.$B$BTrainers hide professions you cannot currently learn. Once you have four, no new ones are offered; unlearn one and they reappear.$B$BSecondary skills - cooking, fishing, first aid - do not count against the four.'),
(200025, 'Dungeon difficulty scales to your group size, doubled.$B$B1 player is tuned as 2.$B2 players as 4.$B3 players as 6, and so on.$B$BThis applies to dungeons and raids. You do not need a full group to enter, and the difficulty grows with your number rather than ahead of it.'),
(200026, 'Appearance and character creation.$B$BTransmogrification: a vendor stands in the auction house of every capital. He changes how your gear looks, using appearances you have owned. Stats are unaffected.$B$BRace and class restrictions are removed. Any race may play any class.'),
(200027, 'Other things worth knowing.$B$BAuction house: stocked and bid on automatically, so there is always a market even with nobody online.$B$BMail: delivered instantly, including auction results. There is no one hour delay.$B$BCampfires: build one away from an inn and you will get more than a campfire.');

-- The Orgrimmar bulletin board and the two Argent Dawn npcs beside it, moved
-- away from the bonfire.
--
-- Where they stood, the plank was eleven yards from the Mighty Blaze in the
-- Valley of Strength, close enough that the fire read as part of the posting
-- rather than scenery behind it. They now sit some forty yards clear of it,
-- keeping the same triangle: the quartermaster to one side of the board, the
-- wayfinder to the other.
--
-- The board and the wayfinder are keyed by guid because ten of each exist,
-- one per capital, and only Orgrimmar's moves. The quartermaster is keyed by
-- entry: a single spawn exists, and its guid on this realm does not match the
-- one its own insert names, so following the entry survives that.
--
-- A gameobject is turned by its rotation quaternion, not by `orientation` -
-- the client reads the former. Both are set, rotation2/rotation3 being
-- sin(o/2) and cos(o/2) for a rotation about z.

UPDATE `gameobject` SET
    `position_x` = 1596.5,
    `position_y` = -4444.62,
    `position_z` = 6.74818,
    `orientation` = 1.9025,
    `rotation2` = 0.814156,
    `rotation3` = 0.580646
WHERE `guid` = 5714552;

UPDATE `creature` SET
    `position_x` = 1592.93,
    `position_y` = -4445.49,
    `position_z` = 6.36676,
    `orientation` = 1.88884
WHERE `guid` = 5980021;

UPDATE `creature` SET
    `position_x` = 1600.51,
    `position_y` = -4443.3,
    `position_z` = 7.13525,
    `orientation` = 1.91633
WHERE `id` = 800011;

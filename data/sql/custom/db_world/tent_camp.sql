-- Camp tent: custom prop, reuses the "WotLK Light Tent" model (displayId 8001, from base game gameobject
-- 190794). Purely decorative, spawned by lua_scripts/hookah_emote.lua on the opposite side of Camp's
-- campfire from the hookah. Entry 500002 chosen after confirming it's free (follows 500001, the hookah).
DELETE FROM `gameobject_template` WHERE `entry` = 500002;
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`,
    `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`,
    `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`,
    `Data22`, `Data23`, `AIName`, `ScriptName`) VALUES
(500002, 5, 8001, 'Camp Tent', '', '', '', 1,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, '', '');

-- Camp tent rug: custom prop, reuses the "Mag'har Rug" model (displayId 6942, from base game gameobject
-- 182257) at the same size (2) the user tested and approved in game. Spawned directly under the tent.
-- Entry 500003 chosen after confirming it's free.
DELETE FROM `gameobject_template` WHERE `entry` = 500003;
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`,
    `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`,
    `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`,
    `Data22`, `Data23`, `AIName`, `ScriptName`) VALUES
(500003, 5, 6942, 'Camp Tent Rug', '', '', '', 2,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, '', '');

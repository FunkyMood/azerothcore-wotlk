-- T'chali's Hookah: custom clickable prop, reuses the real "T'chali's Hookah" model (displayId 5497,
-- taken from the base game's gameobject 184744) purely for its visual - the interaction logic is 100%
-- custom (see lua_scripts/hookah_emote.lua), the object's own native GOOBER behavior is suppressed there.
DELETE FROM `gameobject_template` WHERE `entry` = 500001;
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`,
    `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`,
    `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`,
    `Data22`, `Data23`, `AIName`, `ScriptName`) VALUES
(500001, 10, 5497, 'T\'chali\'s Hookah', '', '', '', 1,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, '', '');

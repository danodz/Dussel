vasserand = PlayerSpaceship():setFaction("Vindh"):setTemplate("VCorvette"):setCallSign("VSR"):setPosition(0, 0);
-- Batterie d'appoint
vasserand:setEnergyLevelMax(900);
vasserand:setEnergyLevel(900);
-- Propulseur Amélioré V1
vasserand:setImpulseMaxSpeed(87)
vasserand:setRotationMaxSpeed(13)
-- Cargo supplémentaire (+2 mines);
vasserand:setWeaponStorageMax("Mine", 4);
vasserand:setWeaponStorage("Mine", 4);
-- 1 nuke
vasserand:setWeaponStorage("Nuke", 1);

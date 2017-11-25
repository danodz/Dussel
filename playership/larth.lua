larth = PlayerSpaceship():setFaction("Vindh"):setTemplate("VCorvette"):setCallSign("LARTH"):setPosition(0, 0);
-- Coque Renforcée +20
larth:setHull(170);
larth:setEnergyLevel(900);
-- Tourelle Laser   Arc, Dir, Range, CycleTime, dmg
larth:setBeam(2, 360, 0, 800.0, 6, 5);

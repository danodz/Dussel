template = ShipTemplate():setName("Mothership"):setClass("Mothership", "Jumper"):setModel("battleship_destroyer_1_upgraded"):setType("playership")
template:setDescription([[Transporte des chasseurs]])
template:setDockClasses("Starfighter", "Frigates", "Corvette", "Chasseur");
template:setHull(150)
template:setShields(100, 100)
template:setSpeed(80, 10, 10)
template:setCombatManeuver(300, 150)
template:setJumpDrive(true)
template:setEnergyStorage(800)
template:setRepairCrewCount(1)-- Arc, Dir, Range, CycleTime, Dmgtemplate:setBeam(0,20, 0, 2000.0, 6.0, 6)
template:setBeam(1,100, 0, 1000.0, 6.0, 10)
template:setTubes(4, 10.0)
template:setWeaponStorage("HVLI", 4)
template:setWeaponStorage("Mine", 2)
template:setWeaponStorage("Homing", 6)
template:setWeaponStorage("EMP", 2)
template:setWeaponStorage("Nuke", 1)
--template:setTubeDirection(1, 0)
template:setTubeDirection(0, 0)
template:setTubeDirection(1, -90)
template:setTubeDirection(2, 90)
template:setTubeDirection(3, 180)
template:setWeaponTubeExclusiveFor(0, "HVLI")
template:weaponTubeDisallowMissle(1, "Mine")
template:weaponTubeDisallowMissle(2, "Mine")
template:setWeaponTubeExclusiveFor(3, "Mine")
template:addRoomSystem(1, 1, 2, 1, "Maneuver");
template:addRoomSystem(3, 1, 1, 1, "BeamWeapons");
template:addRoomSystem(2, 2, 1, 2, "RearShield");
template:addRoomSystem(3, 2, 2, 2, "Reactor");
template:addRoomSystem(5, 2, 2, 1, "JumpDrive");
template:addRoomSystem(5, 3, 2, 1, "warp");
template:addRoomSystem(7, 2, 1, 2, "FrontShield");
template:addRoomSystem(1, 4, 2, 1, "Impulse");
template:addRoomSystem(3, 4, 1, 1, "MissileSystem");
template:addDoor(3, 1, false);
template:addDoor(3, 2, true);
template:addDoor(3, 2, false);
template:addDoor(5, 2, false);
template:addDoor(5, 3, false);
template:addDoor(7, 3, false);
template:addDoor(3, 4, true);
template:addDoor(3, 4, false);


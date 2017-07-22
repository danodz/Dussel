ship = ShipTemplate():setName("Exercice"):setClass("Simulation","Exercice"):setModel("battleship_destroyer_1_upgraded"):setType("playership")
ship:setRadarTrace("radar_fighter.png")
ship:setHull(100)
ship:setShields(200, 200)
ship:setSpeed(120, 20, 20)
ship:setCombatManeuver(600, 300)
ship:setJumpDrive(true)
ship:setEnergyStorage(1000)
ship:setRepairCrewCount(4)

--                  Arc, Dir, Range, CycleTime, Dmg
ship:setBeam(0,90, 25, 1000.0, 6.0, 10)
ship:setBeam(1,90, -25, 1000.0, 6.0, 10)
ship:setTubes(4, 10.0)
ship:setWeaponStorage("Homing", 15)
ship:setWeaponStorage("Nuke", 2)
ship:setWeaponStorage("EMP", 4)
ship:setWeaponStorage("HVLI", 20)
ship:setWeaponStorage("Mine", 6)
ship:setTubeDirection(1,90);
ship:setTubeDirection(2,-90);
ship:setTubeDirection(3,180);
ship:weaponTubeDisallowMissle(0,"Mine");
ship:weaponTubeDisallowMissle(1,"Mine");
ship:weaponTubeDisallowMissle(2,"Mine");
ship:setWeaponTubeExclusiveFor(3,"Mine");

ship:addRoomSystem(1, 1, 2, 1, "Maneuver");
ship:addRoomSystem(3, 1, 1, 1, "BeamWeapons");
ship:addRoomSystem(2, 2, 1, 2, "RearShield");
ship:addRoomSystem(3, 2, 2, 2, "Reactor");
ship:addRoomSystem(5, 2, 2, 1, "JumpDrive");
ship:addRoomSystem(7, 2, 1, 2, "FrontShield");
ship:addRoomSystem(1, 4, 2, 1, "Impulse");
ship:addRoomSystem(3, 4, 1, 1, "MissileSystem");

ship:addDoor(3, 1, false);
ship:addDoor(3, 2, true);
ship:addDoor(3, 2, false);
ship:addDoor(5, 2, false);
ship:addDoor(5, 3, false);
ship:addDoor(7, 3, false);
ship:addDoor(3, 4, true);
ship:addDoor(3, 4, false);

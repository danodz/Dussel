ship = ShipTemplate():setName("Examen"):setClass("Simulation","Basic"):setModel("battleship_destroyer_1_upgraded"):setType("playership")
ship:setRadarTrace("radar_fighter.png")
ship:setHull(100)
ship:setShields(200, 200)
ship:setSpeed(120, 20, 20)
ship:setCombatManeuver(600, 300)
ship:setJumpDrive(true)
ship:setEnergyStorage(1000)
ship:setRepairCrewCount(2)

--                  Arc, Dir, Range, CycleTime, Dmg
ship:setBeam(0,90, 25, 1000.0, 6.0, 10)
ship:setBeam(1,90, -25, 1000.0, 6.0, 10)
ship:setTubes(16, 10.0)
ship:setWeaponStorage("Mine", 999)
ship:setWeaponStorage("Homing", 999)

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

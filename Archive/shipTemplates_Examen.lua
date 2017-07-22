ship = ShipTemplate():setName("Examen"):setClass("Simulation", "Basic"):setModel("battleship_destroyer_1_upgraded"):setType("playership")
ship:setRadarTrace("radar_dread.png")
ship:setHull(10000)
ship:setShields(200, 200)
ship:setSpeed(100, 10, 20)
ship:setJumpDrive(true)
ship:setCombatManeuver(400, 250)
--                  Arc, Dir, Range, CycleTime, Dmg
ship:setBeam(0,100, -20, 1500.0, 6.0, 8)
ship:setBeam(1,100,  20, 1500.0, 6.0, 8)
ship:setTubes(2, 10.0)
ship:setWeaponStorage("Homing", 15)
ship:setTubeDirection(0, -90)
ship:setTubeDirection(1,  90)

ship:addRoomSystem(1, 0, 2, 1, "Maneuver");
ship:addRoomSystem(1, 1, 2, 1, "BeamWeapons");
ship:addRoom(2, 2, 2, 1);
ship:addRoomSystem(0, 3, 1, 2, "RearShield");
ship:addRoomSystem(1, 3, 2, 2, "Reactor");
ship:addRoomSystem(3, 3, 2, 2, "Warp");
ship:addRoomSystem(5, 3, 1, 2, "JumpDrive");
ship:addRoom(6, 3, 2, 1);
ship:addRoom(6, 4, 2, 1);
ship:addRoomSystem(8, 3, 1, 2, "FrontShield");
ship:addRoom(2, 5, 2, 1);
ship:addRoomSystem(1, 6, 2, 1, "MissileSystem");
ship:addRoomSystem(1, 7, 2, 1, "Impulse");
ship:addDoor(1, 1, true);
ship:addDoor(2, 2, true);
ship:addDoor(3, 3, true);
ship:addDoor(1, 3, false);
ship:addDoor(3, 4, false);
ship:addDoor(3, 5, true);
ship:addDoor(2, 6, true);
ship:addDoor(1, 7, true);
ship:addDoor(5, 3, false);
ship:addDoor(6, 3, false);
ship:addDoor(6, 4, false);
ship:addDoor(8, 3, false);
ship:addDoor(8, 4, false);

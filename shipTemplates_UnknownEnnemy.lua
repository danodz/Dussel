ship = ShipTemplate():setName("Unknown"):setClass("Unknown", "Unknown"):setModel("battleship_destroyer_1_upgraded")
ship:setRadarTrace("radar_dread.png")
ship:setHull(300)
ship:setShields(300, 300)
ship:setSpeed(150, 30, 50)
ship:setCombatManeuver(400, 250)
--                  Arc, Dir, Range, CycleTime, Dmg
ship:setBeam(0,360, 0, 1500.0, 2.0, 5)
ship:setTubes(7, 10.0)
ship:setWeaponStorage("Homing", 999)
ship:setWeaponStorage("Nuke", 10)
ship:setWeaponStorage("Mine", 10)
ship:setWeaponStorage("EMP", 10)
ship:setTubeDirection(0, 90)
ship:setTubeDirection(1,  90)
ship:setTubeDirection(2, -90)
ship:setTubeDirection(3, -90)
ship:setTubeDirection(4, 0)
ship:setTubeDirection(5, 0)
ship:setTubeDirection(6, 180)

ship:addRoomSystem(1, 0, 2, 1, "Maneuver");
ship:addRoomSystem(1, 1, 2, 1, "BeamWeapons");
ship:addRoom(2, 2, 2, 1);
ship:addRoomSystem(0, 3, 1, 2, "RearShield");
ship:addRoomSystem(1, 3, 2, 2, "Reactor");
ship:addRoomSystem(3, 3, 2, 2, "Warp");
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

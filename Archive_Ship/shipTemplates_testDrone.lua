ship = ShipTemplate():setName("TestDrone"):setClass("Tester","BasicTester"):setModel("AtlasHeavyFighterYellow"):setType("cpuship")
ship:setRadarTrace("radar_fighter.png")
ship:setHull(40)
ship:setSpeed(120, 50, 20)
ship:setCombatManeuver(600, 300)
ship:setJumpDrive(false)
ship:setEnergyStorage(1000)

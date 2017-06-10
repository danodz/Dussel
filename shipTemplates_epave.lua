ship = ShipTemplate():setName("epave"):setClass("Wreck","Wrecked"):setModel("AtlasHeavyFighterYellow"):setType("cpuship")
ship:setRadarTrace("radar_fighter.png")
ship:setHull(200)
ship:setSpeed(0, 0, 0)
ship:setJumpDrive(false)
ship:setEnergyStorage(1000)
ship:setBeamWeapon(1,360, 0, 1000, 2, 2)
ship:setDockClasses("Starfighter", "Frigates", "Corvette");

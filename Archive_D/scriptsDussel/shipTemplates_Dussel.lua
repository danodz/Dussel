--[[                  Dussel
Depuis le déclin de la fédération, les vaisseaux que l'on retrouve dans l'espace célésien son limités, improvisés et aucun ne peut rivaliser avec les grandes stations de bataille fédérés.

Les vaisseaux les plus communs sont divisés en six sous-classes : 
* Intercepteur / interceptor : Petit, rapide avec une grande maneuvrabilité. Sans jump ou warp
* Éclaireur / Scout : Petit, rapide, grande maneuvrabilité, avec jump et warp. Peu de missiles. Utile pour découvrir et miner le territoire. 
* Frégate / Frigate : Moyen, balancé
* Destroyer / Destroyer : Gros, lent, arme de destruction principalement sur les côtés. 
* Croiseur / Cruiser : Gros, peut héberger des intercepteurs, lent, principalement armé de lasers

On retrouvera plus rarement les suviants : 
* Destroyer lourd / Heavy destroyer
* Croiseur lourd / Heavy cruiser
* Croiseur de bataille / Battlecruiser
* Support : Large scale support roles. Drone carriers fall in this category. As well as mobile repair centers.
* Freighter: Large scale transport ships. Most common here are the jump freighters, using specialized jumpdrives to cross large distances with large amounts of cargo.

Chaque faction modifie les vaisseaux types selon leurs technologies : 
* Empire du vindh : beam +2 dmg, hull +50
* Sainte Alliance des Mérillons : beam -1 sec, shield +20/+20
* Conglomérat d'Arianne : speed (+10, +2, +2), WeaponStorage +50%, Radartrace = Transport
----------------------------------------------------------]]

--[[----------------------Raptor----------------------]]
template = ShipTemplate():setName("Raptor"):setClass("Dussel","Raptor"):setModel("small_frigate_4")
template:setDescription([[Le Raptor est un vaisseau éclaireur munis d'un système de saut stellaire. Souvent employé pour explorer les territoires dangereux et miner le territoire. Sa maneuvrabilité en fait un redoutable ennemi sur le champs de bataille]])
template:setRadarTrace("radar_fighter.png")
template:setHull(75)
template:setShields(200, 200)
template:setSpeed(120, 20, 20)
template:setCombatManeuver(600, 300)
template:setJumpDrive(true)

template:setEnergyStorage(800)
template:setRepairCrewCount(2)

--                  Arc, Dir, Range, CycleTime, Dmg
template:setBeam(0,20, 0, 2000.0, 6.0, 6)
template:setBeam(1,100, 0, 1000.0, 6.0, 10)
template:setTubes(3, 10.0)
template:setWeaponStorage("Mine", 10)
template:setWeaponStorage("Homing", 6)
template:setWeaponStorage("EMP", 2)
template:setTubeDirection(0, 0)
template:setTubeDirection(1, -130)
template:setTubeDirection(2,  130)
template:weaponTubeDisallowMissle(0, "Mine")
template:setWeaponTubeExclusiveFor(1, "Mine")
template:setWeaponTubeExclusiveFor(2, "Mine")

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

--Airlock doors
--template:addDoor(2, 2, false);
--template:addDoor(2, 5, false);

--[----------------------Vindh----------------------]

variation = template:copy("R-Ouvrier"):setClass("Dussel","Raptor")
variation:setBeam(0,15, 0, 2000.0, 6.0, 8)
variation:setBeam(1,100, 0, 1000.0, 6.0, 12)
variation:setHull(100)
variation:setDescription([[Similaire au raptor, l'Ouvrier bénificie des coques renforcées du vindh et de lasers à fusion plus puissants]])


variation = variation:copy("Ouvrier"):setType("playership"):setClass("Vindh","Raptor")
variation:setCombatManeuver(600, 300)

--[---------------------Mérillon----------------------]

variation = template:copy("R-Apotre"):setClass("Dussel","Raptor")
variation:setModel("LindwurmFighterWhite")
variation:setBeam(0,15, 0, 2000.0, 5.0, 6)
variation:setBeam(1,100, 0, 1000.0, 5.0, 10)
variation:setShields(220,220)
variation:setDescription([[Similaire au raptor, l'Apotre bénificie des saints boucliers et de lasers à meilleure cadence]])

variation = variation:copy("Apotre"):setType("playership"):setClass("Merillon","Raptor")
variation:setCombatManeuver(600, 300)

--[---------------------Arianne----------------------]

variation = template:copy("R-Camelot"):setClass("Dussel","Raptor")
variation:setModel("transport_3_1")
variation:setRadarTrace("radar_transport.png")
variation:setSpeed(130, 24, 24)
variation:setWeaponStorage("Mine", 15)
variation:setWeaponStorage("Homing", 9)
variation:setWeaponStorage("EMP", 3)
variation:setDescription([[ Le Camelot, vaisseau de transport converti en vaisseau éclaireur, possède de plus grandes quantités de missiles et une propulsion accrue]])

variation = variation:copy("Camelot"):setType("playership"):setClass("Arianne","Raptor")
variation:setCombatManeuver(600, 300)


---////////////////////////// \\\\\\\\\\\\\\\\\\\\\\\\\\---


--[[----------------------Frigate----------------------]]
template = ShipTemplate():setName("Frigate"):setClass("Dussel","Frigate"):setModel("battleship_destroyer_1_upgraded")
template:setDescription([[La frégate est un vaisseau balancé utilisé pour toute type de mission et préconisé par les aventuriers ]])
template:setRadarTrace("radar_cruiser.png")
template:setHull(150)
template:setShields(200, 200)
template:setSpeed(90, 10, 10)
template:setCombatManeuver(400, 250)
template:setJumpDrive(true)

template:setEnergyStorage(1000)
template:setRepairCrewCount(3)

--                  Arc, Dir, Range, CycleTime, Dmg
template:setBeam(0,100, -20, 1500.0, 6.0, 8)
template:setBeam(1,100,  20, 1500.0, 6.0, 8)
template:setWeaponStorage("Homing", 12)
template:setWeaponStorage("Nuke", 1)
template:setWeaponStorage("Mine", 8)
template:setWeaponStorage("EMP", 4)
template:setTubes(5, 8.0) -- Amount of torpedo tubes, and loading time of the tubes.
template:setTubeDirection(0, -90)
template:setTubeDirection(1, -90)
template:setTubeDirection(2,  90)
template:setTubeDirection(3,  90)
template:setTubeDirection(4, 180):setWeaponTubeExclusiveFor(4, "Mine")

template:weaponTubeDisallowMissle(0, "Mine"):weaponTubeDisallowMissle(1, "Mine")
template:weaponTubeDisallowMissle(2, "Mine"):weaponTubeDisallowMissle(3, "Mine")


template:addRoomSystem(1, 0, 2, 1, "Maneuver");
template:addRoomSystem(1, 1, 2, 1, "BeamWeapons");
template:addRoom(2, 2, 2, 1);

template:addRoomSystem(0, 3, 1, 2, "RearShield");
template:addRoomSystem(1, 3, 2, 2, "Reactor");
template:addRoomSystem(3, 3, 2, 2, "Warp");
template:addRoomSystem(5, 3, 1, 2, "JumpDrive");
template:addRoom(6, 3, 2, 1);
template:addRoom(6, 4, 2, 1);
template:addRoomSystem(8, 3, 1, 2, "FrontShield");

template:addRoom(2, 5, 2, 1);
template:addRoomSystem(1, 6, 2, 1, "MissileSystem");
template:addRoomSystem(1, 7, 2, 1, "Impulse");

template:addDoor(1, 1, true);
template:addDoor(2, 2, true);
template:addDoor(3, 3, true);
template:addDoor(1, 3, false);
template:addDoor(3, 4, false);
template:addDoor(3, 5, true);
template:addDoor(2, 6, true);
template:addDoor(1, 7, true);
template:addDoor(5, 3, false);
template:addDoor(6, 3, false);
template:addDoor(6, 4, false);
template:addDoor(8, 3, false);
template:addDoor(8, 4, false);

--Airlock doors
--template:addDoor(2, 2, false);
--template:addDoor(2, 5, false);

--[----------------------Vindh----------------------]

variation = template:copy("F-Camarade"):setClass("Dussel","Frigate")


variation:setBeam(0,100, -20, 1500.0, 6.0, 10)
variation:setBeam(1,100,  20, 1500.0, 6.0, 10)
variation:setHull(200)
variation:setDescription([[ Le Camarade bénificie des coques renforcées du vindh et de lasers à fusion plus puissants]])

variation = variation:copy("Camarade"):setType("playership"):setClass("Vindh","Frigate")
variation:setCombatManeuver(400, 250)

--[---------------------Mérillon----------------------]

variation = template:copy("F-Celesien"):setClass("Dussel","Frigate")
variation:setModel("AdlerLongRangeScoutWhite")
variation:setBeam(0,100, -20, 1500.0, 5.0, 8)
variation:setBeam(1,100,  20, 1500.0, 5.0, 8)
variation:setShields(220,220)
variation:setDescription([[ Le Célésien bénificie des saints boucliers et de lasers à meilleure cadence]])

variation = variation:copy("Celesien"):setType("playership"):setClass("Merillon","Frigate")
variation:setCombatManeuver(400, 250)

--[---------------------Arianne----------------------]

variation = template:copy("F-Marchand"):setClass("Dussel","Frigate")
variation:setModel("transport_5_3")
variation:setRadarTrace("radar_transport.png")
variation:setSpeed(100, 12, 12)
template:setWeaponStorage("Homing", 18)
template:setWeaponStorage("Mine", 12)
template:setWeaponStorage("EMP", 6)
variation:setDescription([[ Le marchand, vaisseau de transport converti, possède un plus grand cargo d'armement et une propulsion accrue]])

variation = variation:copy("Marchand"):setType("playership"):setClass("Arianne","Frigate")
variation:setCombatManeuver(400, 250)



---////////////////////////// \\\\\\\\\\\\\\\\\\\\\\\\\\---


--[[----------------------Destroyer----------------------]]
template = ShipTemplate():setName("Destroyer"):setClass("Dussel","Destroyer"):setModel("battleship_destroyer_5_upgraded")
template:setDescription([[Le destroyer est un vaisseau de guerre redoutable. Lent à manoeuvrer, quiconque entre toutetfois dans sa ligne de tir peut faire ses prières...]])
template:setRadarTrace("radar_dread.png")
template:setHull(300)
template:setShields(200, 200)
template:setSpeed(60, 5, 5)
template:setCombatManeuver(200, 125)
template:setJumpDrive(true)

template:setEnergyStorage(1200)
template:setRepairCrewCount(4)

--                  Arc, Dir, Range, CycleTime, Dmg
template:setBeam(0,0, 0, 0, 0, 0)
template:setBeam(5,360, 0, 750.0, 6.0, 8)
template:setBeam(1,60, -75, 1500.0, 6.0, 8)
template:setBeam(2,60, 105, 1500.0, 6.0, 8)
template:setBeam(3,60, -105, 1500.0, 6.0, 8)
template:setBeam(4,60, 75, 1500.0, 6.0, 8)
template:setTubes(8, 6.0)
template:setWeaponStorage("Homing", 20)
template:setWeaponStorage("HVLI", 30)
template:setWeaponStorage("Nuke", 2)
template:setWeaponStorage("EMP", 6)
template:setTubeDirection(0, -85)
template:setTubeDirection(1, -90)
template:setTubeDirection(2,  -90)
template:setTubeDirection(3,  -95)
template:setTubeDirection(4, 85)
template:setTubeDirection(5, 90)
template:setTubeDirection(6,  90)
template:setTubeDirection(7,  95)

template:addRoomSystem(1, 0, 3, 1, "Maneuver");
template:addRoomSystem(2, 1, 2, 2, "Reactor");
template:addRoomSystem(1, 2, 1, 3, "RearShield");
template:addRoomSystem(5, 2, 3, 1, "MissileSystem");
template:addRoomSystem(8, 2, 1, 3, "FrontShield");
template:addRoomSystem(2, 3, 2, 1, "Warp");
template:addRoom(5, 3, 3, 1);
template:addRoom(4, 2, 1, 3);
template:addRoomSystem(2, 4, 2, 2, "JumpDrive");
template:addRoomSystem(5, 4, 3, 1, "BeamWeapons");
template:addRoomSystem(1, 6, 3, 1, "Impulse");

template:addDoor(2, 1, true);
template:addDoor(3, 3, true);
template:addDoor(6, 3, true);
template:addDoor(3, 4, true);
template:addDoor(6, 4, true);
template:addDoor(2, 6, true);


template:addDoor(2, 3, false);
template:addDoor(4, 2, false);
template:addDoor(4, 4, false);
template:addDoor(5, 3, false);
template:addDoor(8, 3, false);


--Airlock doors
--template:addDoor(2, 2, false);
--template:addDoor(2, 5, false);

--[----------------------Vindh----------------------]

variation = template:copy("D-Artheurge"):setClass("Dussel","Destroyer")

variation:setBeam(0,0, 0, 0, 0, 0)
variation:setBeam(5,360, 0, 750.0, 6.0, 10)
variation:setBeam(1,60, -75, 1500.0, 6.0, 10)
variation:setBeam(2,60, 105, 1500.0, 6.0, 10)
variation:setBeam(3,60, -105, 1500.0, 6.0, 10)
variation:setBeam(4,60, 75, 1500.0, 6.0, 10)
variation:setHull(350)
variation:setDescription([[ L'Artheurge est une version dan-geu-reuse du camarade et bénificie des coques renforcées du vindh et de lasers à fusion plus puissants]])

variation = variation:copy("Artheurge"):setType("playership"):setClass("Vindh","Destroyer")
variation:setCombatManeuver(200, 125)


--[---------------------Mérillon----------------------]

variation = template:copy("D-Eveque"):setClass("Dussel","Destroyer")
variation:setModel("AtlasHeavyFighterWhite")

variation:setBeam(0,0, 0, 0, 0, 0)
variation:setBeam(1,60, -75, 1500.0, 5.0, 8)
variation:setBeam(2,60, 105, 1500.0, 5.0, 8)
variation:setBeam(3,60, -105, 1500.0, 5.0, 8)
variation:setBeam(4,60, 75, 1500.0, 5.0, 8)
variation:setBeam(5,360, 0, 750.0, 5.0, 8)
variation:setShields(220,220)
variation:setDescription([[ L'Évêque bénificie des saints boucliers et de lasers à meilleure cadence]])

variation = variation:copy("Eveque"):setType("playership"):setClass("Merillon","Destroyer")
variation:setCombatManeuver(200, 125)


--[---------------------Arianne----------------------]

variation = template:copy("D-Caravanne"):setClass("Dussel","Destroyer")
variation:setModel("transport_2_4")
variation:setRadarTrace("radar_transport.png")
variation:setSpeed(70, 7, 7)
variation:setWeaponStorage("Homing", 30)
variation:setWeaponStorage("HVLI", 40)
variation:setWeaponStorage("Nuke", 3)
variation:setWeaponStorage("EMP", 9)
variation:setDescription([[ La caravanne, vaisseau de transport converti, possède un plus grand cargo d'armement et une propulsion accrue]])

variation = variation:copy("Caravanne"):setType("playership"):setClass("Arianne","Destroyer")
variation:setCombatManeuver(200, 125)


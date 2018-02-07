-- Name: succubi cherubim 02
-- Description: Amener un nouveau produit au labo
-- Type: Basic

require("utils.lua")
require("util_random_transports.lua")

players = {};
availableItems = {};
merillonShips = {};
patrolling = {};
packageDropped = false;
spotted = false;

--[[{{utils/dussel.lua}}]]--

--[[{{utils/trading.lua}}]]--

function init()
    --[[{{playership/succubiCherubim.lua}}]]--

    decors()

    -- Créer le vaisseau du joueur
    spawnSuccubiCherubim(-70741, 10321);
    succubiCherubim:setWeaponStorage("EMP", 1):setWeaponStorage("HVLI", 3)
    
    -- Station de départ
    SpaceStation():setTemplate("Small Station"):setFaction("Arianne"):setCallSign("krief logos"):setPosition(-69829, 10626)

    -- Station objectif (endroit où aller porter la cargaison)
    objectiveStation = SpaceStation():setTemplate("Large Station"):setFaction("Dussel"):setCallSign("Labo"):setPosition(270715, 30108)

    -- Stations de ravitaillement
    endGameA = SpaceStation():setTemplate("Small Station"):setFaction("Arianne"):setCallSign("DS12937"):setPosition(70335, 50348)
    endGameB = SpaceStation():setTemplate("Small Station"):setFaction("Arianne"):setCallSign("DS12938"):setPosition(190765, -28083)

    -- Troupes de chasseurs Merillons
    mkPatrollingShip(26326, -12034,8072, -42310)
    mkPatrollingShip(7913, 47667,34238, 37022)
    mkPatrollingShip(81964, 8129,36187, 82951)
    mkPatrollingShip(97460, -18978,67363, 51218)
    mkPatrollingShip(142321, -13989,133890, 45929)
    mkPatrollingShip(110828, 52034,33960, 37578)
    mkPatrollingShip(151315, 34692,128045, 98260)
    mkPatrollingShip(154249, 94710,127766, 100487)
    mkPatrollingShip(184930, 97692,203758, 24495)
    mkPatrollingShip(201810, 69598,172582, 44816)
    mkPatrollingShip(189578, 11666,117745, -53166)
    mkPatrollingShip(254569, 1549,274182, 86848)
    mkPatrollingShip(311834, 13284,276425, 85141)
    mkPatrollingShip(188167, -43402,265275, -6402)
    mkPatrollingShip(83423, -55055,-51496, -58177)
    mkPatrollingShip(-16942, -26149,-22269, 47878)
    mkPatrollingShip(-61812, 72440,-37022, 35073)
    mkPatrollingShip(7871, 92222,81837, 85177)

    table.insert(merillonShips, CpuShip():setFaction("Merillon"):setTemplate("Adv. Striker"):setCallSign("SS13"):setPosition(191993, 40906):orderRoaming());
    table.insert(merillonShips, CpuShip():setFaction("Merillon"):setTemplate("Adv. Striker"):setCallSign("CV15"):setPosition(216476, -18269):orderRoaming());


    -- Ajouter pour chaque "F-Camarade" 4x Adder MK5 en formation (à 500,0 / 0,500 / -500,0 / 0,-500)
        --  :orderFlyFormation(P<SpaceObject> object, sf::Vector2f offset)

    mkFormation(28686, 13603)
    mkFormation(217134, 68718)
    mkFormation(135576, -36501)
    mkFormation(100224, 92100)
    mkFormation(143091, 149998)
    mkFormation(152277, -116112)
    mkFormation(267239, -82709)
    mkFormation(285610, 112142)
    mkFormation(-114668, 97667)
    mkFormation(-75698, -76585)

    -- stations merillon (surtout pour random transport et pour la narration)
    -- p-e mettre que ceux-ci produisent des troupes (voir code du Grosvernor ou des scénarios de contrôles de stations)
    SpaceStation():setTemplate("Medium Station"):setFaction("Merillon"):setCallSign("DS13206"):setPosition(88583, -14337)
    SpaceStation():setTemplate("Medium Station"):setFaction("Merillon"):setCallSign("DS13207"):setPosition(206707, -18646)
    SpaceStation():setTemplate("Medium Station"):setFaction("Merillon"):setCallSign("DS13208"):setPosition(316213, 80720)

    -- supplydrop pour aider les joueurs, mais aussi les mettre à découvert
    SupplyDrop():setFaction("Arianne"):setPosition(110075, -10161):setEnergy(500):setWeaponStorage("Homing", 4):setWeaponStorage("Nuke", 1):setWeaponStorage("Mine", 2):setWeaponStorage("EMP", 1)
    SupplyDrop():setFaction("Arianne"):setPosition(212736, 19497):setEnergy(500):setWeaponStorage("Homing", 4):setWeaponStorage("Nuke", 1):setWeaponStorage("Mine", 2):setWeaponStorage("EMP", 1)

    -- warpjammer pour le décors    
    WarpJammer():setFaction("Merillon"):setPosition(218820, 14934)
    WarpJammer():setFaction("Merillon"):setPosition(51791, 6177)
    WarpJammer():setFaction("Dussel"):setPosition(264435, 29955)
    WarpJammer():setFaction("Dussel"):setPosition(271227, 24246)
    WarpJammer():setFaction("Dussel"):setPosition(277953, 31101)
    WarpJammer():setFaction("Dussel"):setPosition(270152, 37440)
end

function update()
    local notSpotted = false;
    for i,ship in pairs(merillonShips) do
        if ship:getTarget() == succubiCherubim then
            notSpotted = true;
            if not spotted then
                ship:sendCommsMessage(succubiCherubim, "Que faites vous dans ce secteur ?? Intrus !\nNous devons vérifier votre cargo.")
                spotted = true;
            end
        end
    end
    spotted = notSpotted;

    for i,ship in pairs(patrolling) do
        local x,y = ship:getPosition();
        local targetX = ship.patrolStatus.positions[ship.patrolStatus.targetIndex].x;
        local targetY = ship.patrolStatus.positions[ship.patrolStatus.targetIndex].y;
        if distance(ship, targetX, targetY) <= 1000 then
            if ship.patrolStatus.positions[ship.patrolStatus.targetIndex + 1] then
                ship.patrolStatus.targetIndex = ship.patrolStatus.targetIndex + 1;
            else
                ship.patrolStatus.targetIndex = 1;
            end
            local targetX = ship.patrolStatus.positions[ship.patrolStatus.targetIndex].x;
            local targetY = ship.patrolStatus.positions[ship.patrolStatus.targetIndex].y;
            ship:orderFlyTowards(targetX, targetY);
        end
    end

    if succubiCherubim:isDocked(objectiveStation) and not packageDropped then
        -- Vaisseaux du vindh à faire apparaître en embuscade une fois que le joueur a porté la marchandise
        -- Voir s'il faut changer les order "roaming" au profit d'un "attack target" en ciblant le joueur.
        V1 = CpuShip():setFaction("Charognards"):setTemplate("F-Camarade"):setCallSign("BR28"):setPosition(266244, 23956):orderAttack(succubiCherubim):setWeaponStorage("EMP", 0)
        CpuShip():setFaction("Charognards"):setTemplate("C-Ouvrier"):setCallSign("VK38"):setPosition(267336, 24442):orderDefendTarget(V1):setWeaponStorage("Homing", 1)
        CpuShip():setFaction("Charognards"):setTemplate("C-Ouvrier"):setCallSign("BR39"):setPosition(265335, 24018):orderDefendTarget(V1):setWeaponStorage("Homing", 1)
    
        V2 = CpuShip():setFaction("Charognards"):setTemplate("F-Camarade"):setCallSign("VS29"):setPosition(278499, 24019):orderAttack(succubiCherubim):setWeaponStorage("EMP", 0)
        CpuShip():setFaction("Charognards"):setTemplate("C-Ouvrier"):setCallSign("NC36"):setPosition(279226, 25476):orderDefendTarget(V2):setWeaponStorage("Homing", 1)
        CpuShip():setFaction("Charognards"):setTemplate("C-Ouvrier"):setCallSign("VK37"):setPosition(277951, 22807):orderDefendTarget(V2):setWeaponStorage("Homing", 1)
        
        V3 = CpuShip():setFaction("Charognards"):setTemplate("F-Camarade"):setCallSign("CSS30"):setPosition(277466, 37969):orderAttack(succubiCherubim):setWeaponStorage("EMP", 0)
        CpuShip():setFaction("Charognards"):setTemplate("C-Ouvrier"):setCallSign("CSS34"):setPosition(276615, 38942):orderDefendTarget(V3):setWeaponStorage("Homing", 1)
        CpuShip():setFaction("Charognards"):setTemplate("C-Ouvrier"):setCallSign("SS35"):setPosition(278497, 37546):orderDefendTarget(V3):setWeaponStorage("Homing", 1)
        
        V4 = CpuShip():setFaction("Charognards"):setTemplate("F-Camarade"):setCallSign("VK31"):setPosition(263030, 36575):orderAttack(succubiCherubim):setWeaponStorage("EMP", 0)
        CpuShip():setFaction("Charognards"):setTemplate("C-Ouvrier"):setCallSign("CV32"):setPosition(262665, 35605):orderDefendTarget(V4):setWeaponStorage("Homing", 1)
        CpuShip():setFaction("Charognards"):setTemplate("C-Ouvrier"):setCallSign("CV33"):setPosition(263878, 37912):orderDefendTarget(V4):setWeaponStorage("Homing", 1)
        
        endGameA:sendCommsMessage(succubiCherubim, "Viens te réfugier chez nous dans le secteur ".. endGameA:getSectorName() .."ou chez notre homologue qui se trouve au secteur " .. endGameB:getSectorName());
        packageDropped = true;
    end
    if packageDropped and (succubiCherubim:isDocked(endGameA) or succubiCherubim:isDocked(endGameB)) then
        victory("Arianne");
    end

end

function mkPatrollingShip(x1,y1,x2,y2)
    local ship = CpuShip():setFaction("Merillon"):setTemplate("Adv. Striker"):setCallSign(srandom(irandom(2,3)) .. irandom(10,999)):setPosition(x1, y1)
    table.insert(merillonShips, ship);
    patrol(ship, {{x = x1, y = y1},{x = x2, y = y2}});
end

function mkFormation(x,y)
    local ship = CpuShip():setFaction("Merillon"):setTemplate("F-Camarade"):setCallSign(srandom(irandom(2,3)) .. irandom(10,999)):setPosition(x, y):orderStandGround():setWeaponStorage("EMP", 1):setWeaponStorage("Nuke", 0)
    CpuShip():setFaction("Merillon"):setTemplate("Adder MK5"):setCallSign(srandom(irandom(2,3)) .. irandom(10,999)):setPosition(x+500, y):setWeaponStorage("HVLI", 3):orderDefendLocation(x,y);
    CpuShip():setFaction("Merillon"):setTemplate("Adder MK5"):setCallSign(srandom(irandom(2,3)) .. irandom(10,999)):setPosition(x-500, y):setWeaponStorage("HVLI", 3):orderDefendLocation(x,y);
    CpuShip():setFaction("Merillon"):setTemplate("Adder MK5"):setCallSign(srandom(irandom(2,3)) .. irandom(10,999)):setPosition(x, y+500):setWeaponStorage("HVLI", 3):orderDefendLocation(x,y);
    CpuShip():setFaction("Merillon"):setTemplate("Adder MK5"):setCallSign(srandom(irandom(2,3)) .. irandom(10,999)):setPosition(x, y-500):setWeaponStorage("HVLI", 3):orderDefendLocation(x,y);
    table.insert(merillonShips, ship);
end

function patrol(ship, positions)
    table.insert( patrolling, ship);
    ship.patrolStatus = { positions = positions
                        , targetIndex = 1
                        };
    local targetX = ship.patrolStatus.positions[ship.patrolStatus.targetIndex].x;
    local targetY = ship.patrolStatus.positions[ship.patrolStatus.targetIndex].y;
    ship:orderFlyTowards(targetX, targetY);
end

function decors ()
    Nebula():setPosition(-69277, 6411)
    Nebula():setPosition(-63504, -16192)
    Nebula():setPosition(-46047, 11132)
    Nebula():setPosition(-55408, 32891)
    Nebula():setPosition(-6325, 5566)
    Nebula():setPosition(-15939, 28084)
    Nebula():setPosition(-36939, 35674)
    Nebula():setPosition(-22264, 46806)
    Nebula():setPosition(23529, 61986)
    Nebula():setPosition(32638, 37445)
    Nebula():setPosition(54396, 4301)
    Nebula():setPosition(54143, 50601)
    Nebula():setPosition(70841, 61227)
    Nebula():setPosition(66793, 51613)
    Nebula():setPosition(186464, -26312)
    Nebula():setPosition(161164, -31626)
    Nebula():setPosition(117900, -17457)
    Nebula():setPosition(140164, 7590)
    Nebula():setPosition(86022, 20240)
    Nebula():setPosition(65275, 24794)
    Nebula():setPosition(132574, 47059)
    Nebula():setPosition(143201, 59203)
    Nebula():setPosition(173055, 43264)
    Nebula():setPosition(201392, 23782)
    Nebula():setPosition(217584, 11132)
    Nebula():setPosition(237318, -6831)
    Nebula():setPosition(263631, -5819)
    Nebula():setPosition(206705, 1771)
    Nebula():setPosition(228210, -1771)
    Nebula():setPosition(238077, 11132)
    Nebula():setPosition(233523, 27072)
    Nebula():setPosition(230234, 53384)
    Nebula():setPosition(256294, 55408)
    Nebula():setPosition(300063, 18722)
    Nebula():setPosition(283112, 37951)
    Nebula():setPosition(260342, 27325)
    Nebula():setPosition(59456, -6072)
    Nebula():setPosition(12903, -18975)
    Nebula():setPosition(-135104, -14927)
    Nebula():setPosition(-51613, -62239)
    Nebula():setPosition(9614, -75142)
    Nebula():setPosition(6072, -44276)
    Nebula():setPosition(62745, -64516)
    Nebula():setPosition(112587, -95130)
    Nebula():setPosition(57179, -108792)
    Nebula():setPosition(120430, -68817)
    Nebula():setPosition(118153, -55155)
    Nebula():setPosition(180645, -79949)
    Nebula():setPosition(210247, -44782)
    Nebula():setPosition(229981, -53637)
    Nebula():setPosition(232258, -37192)
    Nebula():setPosition(259836, -38457)
    Nebula():setPosition(312208, -26312)
    Nebula():setPosition(319292, -2530)
    Nebula():setPosition(332635, 32425)
    Nebula():setPosition(323003, 65631)
    Nebula():setPosition(274080, 85403)
    Nebula():setPosition(208427, 97824)
    Nebula():setPosition(184092, 68166)
    Nebula():setPosition(125537, 99852)
    Nebula():setPosition(79403, 84896)
    Nebula():setPosition(34790, 105175)
    Nebula():setPosition(-3233, 119370)
    Nebula():setPosition(-28328, 89459)
    Nebula():setPosition(14764, 77798)
    Nebula():setPosition(-68632, 97570)
    Nebula():setPosition(-83081, 68673)
    Nebula():setPosition(-130483, 76531)
    Nebula():setPosition(-166224, 65378)
    Nebula():setPosition(-131497, 41550)
    Nebula():setPosition(-120343, 61068)
    Nebula():setPosition(-101839, 90726)
    Nebula():setPosition(-105388, 111259)
    Nebula():setPosition(-25286, 137621)
    Nebula():setPosition(-27821, 159928)
    Nebula():setPosition(45183, 130777)
    Nebula():setPosition(-183968, 22539)
    Nebula():setPosition(-132764, -38551)
    Nebula():setPosition(-93474, -49198)
    Nebula():setPosition(-87897, -30693)
    Nebula():setPosition(-33651, -110034)
    Nebula():setPosition(-15401, -66688)
    BlackHole():setPosition(166856, 64871)
        Asteroid():setPosition(40444, -47301)
    Asteroid():setPosition(51091, -42485)
    Asteroid():setPosition(45260, -36655)
    Asteroid():setPosition(56160, -32092)
    Asteroid():setPosition(51344, -23727)
    Asteroid():setPosition(59963, -18911)
    Asteroid():setPosition(59202, -12827)
    Asteroid():setPosition(54893, -25248)
    Asteroid():setPosition(50837, -30571)
    Asteroid():setPosition(45260, -36401)
    Asteroid():setPosition(70609, -3195)
    Asteroid():setPosition(59709, 2889)
    Asteroid():setPosition(66300, 4664)
    Asteroid():setPosition(64018, 15817)
    Asteroid():setPosition(73397, 17338)
    Asteroid():setPosition(70355, 24689)
    Asteroid():setPosition(75172, 26717)
    Asteroid():setPosition(69342, 34321)
    Asteroid():setPosition(75172, 36096)
    Asteroid():setPosition(69848, 47249)
    Asteroid():setPosition(81255, 50291)
    Asteroid():setPosition(78467, 60430)
    Asteroid():setPosition(72890, 61698)
    Asteroid():setPosition(73651, 69556)
    Asteroid():setPosition(82523, 70063)
    Asteroid():setPosition(75932, 45982)
    Asteroid():setPosition(73144, 54600)
    Asteroid():setPosition(85058, 83244)
    Asteroid():setPosition(94437, 82737)
    Asteroid():setPosition(88353, 88821)
    Asteroid():setPosition(94183, 96932)
    Asteroid():setPosition(205717, 608)
    Asteroid():setPosition(222447, 2636)
    Asteroid():setPosition(223207, 8719)
    Asteroid():setPosition(232840, 4157)
    Asteroid():setPosition(240191, 9480)
    Asteroid():setPosition(243486, 13789)
    Asteroid():setPosition(251344, 13029)
    Asteroid():setPosition(257428, 9480)
    Asteroid():setPosition(243232, 6945)
    Asteroid():setPosition(225489, 5424)
    Asteroid():setPosition(215096, -913)
    Asteroid():setPosition(211800, -3702)
    Asteroid():setPosition(202675, -8011)
    Asteroid():setPosition(190001, -8771)
    Asteroid():setPosition(178847, -10799)
    Asteroid():setPosition(172510, -16376)
    Asteroid():setPosition(168961, -18150)
    Asteroid():setPosition(171750, -6743)
    Asteroid():setPosition(191015, -5729)
    Asteroid():setPosition(199126, 2636)
    Asteroid():setPosition(206477, -1927)
    Asteroid():setPosition(192282, -17136)
    Asteroid():setPosition(187719, -13334)
    Asteroid():setPosition(185945, -2181)
    Asteroid():setPosition(203942, -1420)
    Asteroid():setPosition(109139, -70368)
    Asteroid():setPosition(127643, -62764)
    Asteroid():setPosition(136008, -60989)
    Asteroid():setPosition(139810, -50850)
    Asteroid():setPosition(125108, -61496)
    Asteroid():setPosition(116490, -67833)
    Asteroid():setPosition(112688, -62003)
    Asteroid():setPosition(139303, -59468)
    Asteroid():setPosition(152992, -51103)
    Asteroid():setPosition(166680, -48315)
    Asteroid():setPosition(165412, 104283)
    Asteroid():setPosition(173017, 91356)
    Asteroid():setPosition(175045, 77160)
    Asteroid():setPosition(190001, 83497)
    Asteroid():setPosition(194056, 87046)
    Asteroid():setPosition(215349, 91609)
    Asteroid():setPosition(205210, 102255)
    Asteroid():setPosition(196845, 98960)
    Asteroid():setPosition(207745, 93890)
    Asteroid():setPosition(211800, 86793)
    Asteroid():setPosition(221940, 82230)
    Asteroid():setPosition(227009, 79188)
    Asteroid():setPosition(314462, 18859)
    Asteroid():setPosition(294944, 17084)
    Asteroid():setPosition(293930, 7959)
    Asteroid():setPosition(308378, 19619)
    Asteroid():setPosition(304576, 20126)
    Asteroid():setPosition(320546, 45728)
    Asteroid():setPosition(320292, 55614)
    Asteroid():setPosition(310406, 28491)
    Asteroid():setPosition(314462, 34575)
    Asteroid():setPosition(323080, 48770)
    Asteroid():setPosition(331192, 58909)
    Asteroid():setPosition(336515, 64486)
    Asteroid():setPosition(352738, 80963)
    Asteroid():setPosition(361357, 84258)
    Asteroid():setPosition(364905, 96172)
    Asteroid():setPosition(373017, 103016)
    Asteroid():setPosition(347162, 112648)
    Asteroid():setPosition(332459, 117211)
    Asteroid():setPosition(328911, 94651)
    Asteroid():setPosition(34867, -47554)
    Asteroid():setPosition(27770, -44513)
    Asteroid():setPosition(24221, -55159)
    Asteroid():setPosition(14335, -59975)
    Asteroid():setPosition(10279, -71889)
    Asteroid():setPosition(1154, -78733)
    Asteroid():setPosition(-13041, -83803)
    Asteroid():setPosition(-28757, -96224)
    Asteroid():setPosition(-34588, -97745)
    Asteroid():setPosition(-4423, -85324)
    Asteroid():setPosition(-5437, -74931)
    Asteroid():setPosition(7744, -66566)
    Asteroid():setPosition(21686, -61243)
    Asteroid():setPosition(36135, -54652)
    Asteroid():setPosition(30812, -46541)
    Asteroid():setPosition(30051, -40710)
    Asteroid():setPosition(12307, -58708)
    Asteroid():setPosition(-13802, -80001)
    Asteroid():setPosition(-21406, -89887)
    Asteroid():setPosition(-39911, -84310)
    Mine():setPosition(23207, 63472)
    Mine():setPosition(142092, 6691)
    Mine():setPosition(187719, -26769)
    Mine():setPosition(231572, -36655)
    Mine():setPosition(259962, 26717)
    Mine():setPosition(230305, 54093)
    Mine():setPosition(272890, 84258)
    Mine():setPosition(260469, 71584)
    Mine():setPosition(207998, 42433)
    Mine():setPosition(179101, 22407)
    Mine():setPosition(129671, -21952)
    Mine():setPosition(77706, 27477)
    Mine():setPosition(123841, 71077)
    Mine():setPosition(-2395, 33307)
    Mine():setPosition(-4930, 5931)
    Mine():setPosition(1914, -48315)
    Mine():setPosition(-27997, -65552)
    Mine():setPosition(-50050, -62510)
    Mine():setPosition(233347, -50850)
    Mine():setPosition(247542, -21952)
    Mine():setPosition(260723, -12827)
    Mine():setPosition(204449, -5476)
    Mine():setPosition(185438, -11560)
    Mine():setPosition(196084, 91609)
    Mine():setPosition(119025, -14601)
    Mine():setPosition(125108, 608)
    Mine():setPosition(141838, 1368)
    Nebula():setPosition(-64245, 11001)
    Nebula():setPosition(-77427, 13029)
    Nebula():setPosition(-86299, 5171)
    Nebula():setPosition(-69315, 18352)
    Nebula():setPosition(-72864, 12522)
    Nebula():setPosition(-78441, 608)
    Nebula():setPosition(-59683, 1622)
    Nebula():setPosition(283040, 26546)
end

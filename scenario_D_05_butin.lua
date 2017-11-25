--Name: C01-03B Station recherche
crewPosition = {"Helms", "Weapons", "Engineering", "Science", "Relay"};

nbPlayers = 3;

scenarioPart = "gettingTheData";

scenarioParts = {
    gettingTheData = {
        init = function() 
            sendCommToAll(station, "Nous avons identifié des maraudeurs qui auraient profité de l'Attaque du Duc pour voler le peuple, allez le chercher.");
            maraudeurBoss =  CpuShip():setFaction("Charognards"):setTemplate("Atlantis X23"):setCallSign("Seigneur Maraud"):setPosition(-4000, 0)
            maraudeurBoss.status = "idle";
            maraudeurBoss:setCommsFunction( function()
	            setCommsMessage("Qu'est-ce que vous voulez")
	            addCommsReply("On veut votre butin", function()
        	        setCommsMessage("Vous ne l'aurez pas si facilement. Il faut payer si vous la voulez")			
	                addCommsReply("D'accord, on va payer", function()
                        --takeReputationPoints
	                    setCommsMessage("Vous n'avez même pas la réputation nécessaire.")
                    end)
	                addCommsReply("Tant pis, oubliez ça", function()
	                    setCommsMessage("On reste ici si vous changez d'avis.")
                    end)
	                addCommsReply("On va la prendre de force alors", function()
	                    setCommsMessage("C'est la guerre que vous voulez.")
                        maraudeurBoss.status = "fighting";
                        maraudeurBoss:orderRoaming();
                    end)
	            end)
            end)
        end,
        update = function()
            if maraudeurBoss.status == "idle" then
                for i=1, maraudeurBoss:getShieldCount(), 1 do
                    if maraudeurBoss:getShieldLevel(i) < maraudeurBoss:getShieldMax(i) then
                        maraudeurBoss.status = "fighting";
                        maraudeurBoss:orderRoaming();
                        sendCommToAll(maraudeurBoss, "Vous m'avez provoqué, c'est la guerre.");
                    end
                end
            end

            if maraudeurBoss.status == "fighting" and maraudeurBoss:getHull() < 75 then
                sendCommToAll(maraudeurBoss, "Vous n'en valez pas la peine, je m'en vais.")
                maraudeurBoss.status = "fleeing";
                maraudeurBoss:orderFlyTowardsBlind(-28394, -25557);
            end
            
            if maraudeurBoss.status == "fleeing" then
                if maraudeurBoss:areEnemiesInRange(4500) and maraudeurBoss:getSectorName() == "D3" then
                    sendCommToAll(maraudeurBoss, "C'est bon, je vais vous le donner");
                    changePart("temple");
                end
            end
        end
    },
    temple = {
        init = function() 
        end,
        update = function()
            for i,player in pairs(players) do
                if player:isDocked(temple) and not player.messageSent then
                    temple:sendCommsMessage(player, "Vous récupérez le butin (voir l'organisation)");
                    player.messageSent = true;
                end
            end
        end
    },
    finalAttack = {
        init = function()
            generateMobs(10, "MT52 Hornet", "Loyalistes", 1000, 1000, 5000, function(mob) mob:orderDefendTarget(temple) end );
            countdown = 1800
            warningSent = false;
        end,
        update = function()
            if not warningSent then
                countdown = countdown - 1;
                if countdown <= 0 then
                    sendCommToAll(station, "Leurs renforts arrivent, revenez à la base.");
                    warningSent = true;
                end
            end
        end
    },
};

function init()
    for partName, partFunction in pairs(scenarioParts) do
        addGMFunction(partName, function() changePart(partName) end);
    end

    station = SpaceStation():setTemplate("Medium Station"):setFaction("Arianne"):setCallSign("Vini-3"):setPosition(21000, 85400);
    temple = SpaceStation():setTemplate("Medium Station"):setFaction("Independent"):setCallSign("Temple"):setPosition(1000, 1000);
    stationDuc = SpaceStation():setTemplate("Medium Station"):setFaction("Loyalistes"):setCallSign("Duchesse3"):setPosition(45500, -25000);
    templeDefence = generateMobs(10, "MT52 Hornet", "Loyalistes", 1000, 1000, 1000, function(mob) mob:orderDefendTarget(temple) end );
    
    players = { --PlayerSpaceship():setFaction("Arianne"):setTemplate("ACorvette"):setCallSign("ARI"):setPosition(-7640, 39663)
              PlayerSpaceship():setFaction("Arianne"):setTemplate("ACorvette"):setCallSign("SCHER"):setPosition(21000, 85400);
              --, PlayerSpaceship():setFaction("Merillon"):setTemplate("MCorvette"):setCallSign("MER"):setPosition(-7640, 39663)
              };

    scenarioParts[scenarioPart].init();

    addGMFunction("CleanShips", function()
        for i,player in pairs(players) do

            local emptyShip = true

            for i,position in pairs(crewPosition) do
                if  player:hasPlayerAtPosition(position) then
                    emptyShip = false
                end
            end

            if emptyShip then
               player:destroy()
            end
        end
    end)


    stationRebel = SpaceStation():setTemplate("Small Station"):setFaction("Rebelles"):setCallSign("Libérata-2"):setPosition(32786, 11737)
    CpuShip():setFaction("Rebelles"):setTemplate("Adder MK5"):setCallSign("CSS15"):setPosition(31988, 11610):orderDefendTarget(stationRebel):setWeaponStorage("HVLI", 3)
    CpuShip():setFaction("Rebelles"):setTemplate("Adder MK5"):setCallSign("S16"):setPosition(33019, 9065):orderDefendTarget(stationRebel):setWeaponStorage("HVLI", 3)
    CpuShip():setFaction("Rebelles"):setTemplate("Atlantis X23"):setCallSign("VS17"):setPosition(34403, 10193):orderDefendTarget(stationRebel):setWeaponStorage("Homing", 3)    CpuShip():setFaction("Rebelles"):setTemplate("MT52 Hornet"):setCallSign("VS18"):setPosition(32313, 10488):orderDefendTarget(stationRebel)
    CpuShip():setFaction("Rebelles"):setTemplate("MT52 Hornet"):setCallSign("NC19"):setPosition(33469, 11123):orderDefendTarget(stationRebel)
    CpuShip():setFaction("Rebelles"):setTemplate("MT52 Hornet"):setCallSign("VS20"):setPosition(33931, 12452):orderDefendTarget(stationRebel)
    Nebula():setPosition(10015, -11296)
    Nebula():setPosition(15295, -1455)
    Nebula():setPosition(22255, 7425)
    Nebula():setPosition(14575, 14866)
    Nebula():setPosition(19855, 20866)
    Nebula():setPosition(15295, 28066)
    Nebula():setPosition(21775, 30946)
    Nebula():setPosition(8335, -22576)
    Nebula():setPosition(-1266, -23536)
    Nebula():setPosition(1374, -34577)
    Nebula():setPosition(5695, -34577)
    Nebula():setPosition(31744, 36034)
    Nebula():setPosition(25827, 42322)
    Nebula():setPosition(42100, 43801)
    Nebula():setPosition(38772, 51938)
    Nebula():setPosition(33963, 57856)
    Nebula():setPosition(41730, 65993)
    Nebula():setPosition(38032, 76718)
    Nebula():setPosition(-16337, -31280)
    Nebula():setPosition(2526, -48293)
    Nebula():setPosition(-10789, -56060)
    Nebula():setPosition(-13008, -48293)
    Nebula():setPosition(-11899, -74183)
    Nebula():setPosition(-34090, -69745)
    Nebula():setPosition(-22994, -67526)
    Asteroid():setPosition(-19296, 8665)
    Asteroid():setPosition(-10789, 13103)
    Asteroid():setPosition(-24474, 17171)
    Asteroid():setPosition(-8200, 20130)
    Asteroid():setPosition(-24474, 33815)
    Asteroid():setPosition(-10789, 34185)
    Asteroid():setPosition(8813, 36404)
    Asteroid():setPosition(11032, 46020)
    Asteroid():setPosition(-9310, 50828)
    Asteroid():setPosition(-23364, 54527)
    Asteroid():setPosition(-7830, 60815)
    Asteroid():setPosition(6594, 60445)
    Asteroid():setPosition(5854, 46760)
    Asteroid():setPosition(1416, 29377)
    Asteroid():setPosition(-803, 8665)
    Asteroid():setPosition(-22625, -11677)
    Asteroid():setPosition(-15597, -1321)
    Asteroid():setPosition(-7460, -3541)
    Asteroid():setPosition(-3022, -10938)
    Asteroid():setPosition(-15597, -11308)
    Asteroid():setPosition(-1543, -18335)
    Asteroid():setPosition(13252, -40896)
    Asteroid():setPosition(26196, -46814)
    Asteroid():setPosition(14731, -25732)
    Asteroid():setPosition(-4502, -33129)
    Asteroid():setPosition(11772, -24622)
    Asteroid():setPosition(28785, -17595)
    Asteroid():setPosition(19909, -6130)
    Asteroid():setPosition(32854, -9828)
    Asteroid():setPosition(33594, -29061)
    Asteroid():setPosition(43950, -40156)
    Asteroid():setPosition(59853, -32020)
    Asteroid():setPosition(56155, -16855)
    Asteroid():setPosition(70209, -7609)
    Asteroid():setPosition(45799, 528)
    Asteroid():setPosition(50977, 7185)
    Asteroid():setPosition(65401, 10884)
    Asteroid():setPosition(36922, 24938)
    Asteroid():setPosition(23238, 36774)
    Asteroid():setPosition(37662, 48239)
    Asteroid():setPosition(57264, 51198)
    Asteroid():setPosition(25827, 76349)
    Asteroid():setPosition(43580, 82636)
    Asteroid():setPosition(63552, 59705)
    Asteroid():setPosition(57264, 36774)
    Asteroid():setPosition(41730, 42322)
    Asteroid():setPosition(25457, 30486)
    Asteroid():setPosition(19909, 21980)
    Asteroid():setPosition(14731, 10884)
    Asteroid():setPosition(5854, -3171)
    Asteroid():setPosition(11772, -19444)
    Asteroid():setPosition(-2282, -28321)
    Asteroid():setPosition(-23734, -32020)
    Asteroid():setPosition(-13378, -5390)
    Asteroid():setPosition(-433, -3910)
    Asteroid():setPosition(-8200, -13527)
    Asteroid():setPosition(-26323, -19075)
    Asteroid():setPosition(-31501, -14266)
    Asteroid():setPosition(-17077, -30540)
    Asteroid():setPosition(-14488, -49033)
    Asteroid():setPosition(-3022, -54951)
    Asteroid():setPosition(12882, -55320)
    Asteroid():setPosition(-4132, -37937)
    Asteroid():setPosition(-22994, -15376)
    Asteroid():setPosition(-29652, 7185)
    Asteroid():setPosition(-32241, 19391)
    Asteroid():setPosition(-2652, 13843)
    Asteroid():setPosition(7334, 22349)
    Asteroid():setPosition(-34460, 25678)
    Asteroid():setPosition(4375, 25678)
    Asteroid():setPosition(21388, 30116)
    Asteroid():setPosition(42100, 38253)
    Asteroid():setPosition(28416, 57486)
    Asteroid():setPosition(30635, 60815)
    Asteroid():setPosition(21018, 68582)
    Asteroid():setPosition(38772, 71171)
    Asteroid():setPosition(49128, 71171)
    Asteroid():setPosition(66881, 64513)
    Asteroid():setPosition(79086, 71910)
    Asteroid():setPosition(90182, 81157)
    Asteroid():setPosition(99428, 70801)
    Asteroid():setPosition(88332, 46390)
    Asteroid():setPosition(64292, 39733)
    Asteroid():setPosition(45799, 40842)
    Asteroid():setPosition(44319, 29007)
    Asteroid():setPosition(57264, 22719)
    Asteroid():setPosition(81675, 40472)
    Asteroid():setPosition(89442, 51568)
    Asteroid():setPosition(86853, 26418)
    Asteroid():setPosition(52086, 15322)
    Asteroid():setPosition(46908, 6446)
    Asteroid():setPosition(27676, 528)
    Asteroid():setPosition(33594, 5336)
    Asteroid():setPosition(37662, 13473)
    Asteroid():setPosition(40621, 16802)
    Asteroid():setPosition(32484, 21610)
    Asteroid():setPosition(29525, 13103)
    Asteroid():setPosition(42840, 3487)
    Asteroid():setPosition(36922, -3910)
    Asteroid():setPosition(22868, -582)
    Asteroid():setPosition(11772, 3487)
    Asteroid():setPosition(6224, -4650)
    Asteroid():setPosition(6224, -12417)
    Asteroid():setPosition(-4132, -18335)
    Asteroid():setPosition(-17816, -11308)
    Asteroid():setPosition(-36309, -22773)
    Asteroid():setPosition(-31131, -37567)
    Asteroid():setPosition(-20036, -53471)
    Asteroid():setPosition(-803, -38307)
    Asteroid():setPosition(-14858, -24992)
    Asteroid():setPosition(8813, -20554)
    Asteroid():setPosition(-803, -10938)
    Asteroid():setPosition(11402, -12047)
    Asteroid():setPosition(5854, -6869)
    Asteroid():setPosition(13621, -2061)
    Asteroid():setPosition(8074, 7925)
    Asteroid():setPosition(307, 17171)
    Asteroid():setPosition(7334, 21240)
    Asteroid():setPosition(14361, 21610)
    Asteroid():setPosition(3635, 34925)
    Asteroid():setPosition(12882, 36774)
    Asteroid():setPosition(11772, 46020)
    Asteroid():setPosition(5854, 51568)
    Asteroid():setPosition(25087, 54527)
    Asteroid():setPosition(26196, 69691)
    Nebula():setPosition(-52953, -1691)
    Nebula():setPosition(-71446, 28637)
    Nebula():setPosition(-48884, 46020)
    Nebula():setPosition(-81062, 66362)
    Nebula():setPosition(55785, -72704)
    Nebula():setPosition(76497, -43485)
    Nebula():setPosition(59484, -14636)
    Nebula():setPosition(78716, -7609)
    Nebula():setPosition(89812, 2747)
    Nebula():setPosition(84634, 34555)
    Mine():setPosition(28785, 3857)
    Mine():setPosition(39141, 4596)
    Mine():setPosition(43580, 14582)
    Mine():setPosition(36552, 22719)
    Mine():setPosition(24717, 21610)
    Mine():setPosition(22128, 11993)
    BlackHole():setPosition(-79583, -35348)

end

function update()
    scenarioParts[scenarioPart].update();
end

function changePart(partName)
    scenarioPart = partName;
    scenarioParts[scenarioPart].init();
end

function sendCommToAll(origin, comm)
    for i,player in pairs(players) do
        origin:sendCommsMessage(player, comm);
    end
end

function generateMobs(nb, template, faction, centerX, centerY, radius, fn)
    local mobs = {};

    for i=1, nb, 1 do
        local mob = CpuShip():setFaction(faction):setTemplate(template):setCallSign(srandom(irandom(2,3)) .. irandom(10,999)):setPosition(irandom(centerX - radius, centerX + radius), irandom(centerY - radius, centerY + radius))
        fn(mob);
        table.insert(mobs, mob);
    end

    return mobs;
end

charset = {}
-- QWERTYUIOPASDFGHJKL tZXCVBNM
for i = 65,  90 do table.insert(charset, string.char(i)) end

function srandom(length)
  if length > 0 then
    return srandom(length - 1) .. charset[irandom(1, #charset)]
  else
    return ""
  end
end

function map(array, func)
    local new_array = {}
    for i,v in ipairs(array) do
        new_array[i] = func(v)
    end
    return new_array
end

function allDead (...)
    local allDead = true;
    for i,mobs in ipairs({...}) do
        for i,mob in pairs(mobs) do
            if mob:isValid() then
                allDead = false;
            end
        end
    end
    return allDead;
end

function makeStationToLiberate(faction, x, y, nbDefender)
    local station = SpaceStation():setTemplate("Medium Station"):setFaction(faction):setCallSign(srandom(irandom(2,3)) .. irandom(10,999)):setPosition(x, y)
    return { station = station
           , faction = faction
           , defenders = generateMobs(nbDefender, "MT52 Hornet", faction, x, y, 1000, function(mob) mob:orderDefendTarget(station) end)
           , isConquered = false
           , conquered = function(self, faction)
                 self.faction = faction
                 self.station:setFaction(faction);
                 defenders = generateMobs(nbDefender, "MT52 Hornet", self.faction, x, y, 1000, function(mob) mob:orderDefendTarget(self.station) end)
                 self.isConquered = true;
             end
           }
end




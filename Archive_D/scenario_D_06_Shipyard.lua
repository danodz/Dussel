--Name: C01-05 Leviathan
systems = { "reactor","beamweapons","missilesystem","maneuver","impulse","warp","jumpdrive","frontshield","rearshield" };
crewPosition = {"Helms", "Weapons", "Engineering", "Science", "Relay"};

nbPlayers = 3;

scenarioPart = "main";

scenarioParts = {
    main = {
        init = function() 
            stations = { SpaceStation():setTemplate("Medium Station"):setFaction("Loyalistes"):setCallSign("DS13"):setPosition(-14094, -15695)
                       , SpaceStation():setTemplate("Medium Station"):setFaction("Loyalistes"):setCallSign("DS12"):setPosition(-5636, -17199)
                       , SpaceStation():setTemplate("Medium Station"):setFaction("Loyalistes"):setCallSign("DS11"):setPosition(-3098, -10808)
                       , SpaceStation():setTemplate("Medium Station"):setFaction("Loyalistes"):setCallSign("DS10"):setPosition(-9865, -10150)
                       , SpaceStation():setTemplate("Small Station"):setFaction("Loyalistes"):setCallSign("DS1871"):setPosition(-39807, 24159)
                       , SpaceStation():setTemplate("Small Station"):setFaction("Loyalistes"):setCallSign("DS1873"):setPosition(-4918, 21048)
                       , SpaceStation():setTemplate("Small Station"):setFaction("Loyalistes"):setCallSign("DS1872"):setPosition(27970, 12603)
                       };

            SpaceStation():setTemplate("Huge Station"):setFaction("Loyalistes"):setCallSign("DS1895"):setPosition(-23995, -45501)
            CpuShip():setFaction("Rebelles"):setTemplate("MU52 Hornet"):setCallSign("UTI34"):setPosition(-106958, -43348):orderFlyTowards(-18553, -20254)
            CpuShip():setFaction("Rebelles"):setTemplate("Adv. Striker"):setCallSign("CCN30"):setPosition(-106083, -39368):orderFlyTowards(-17665, -16254)
            CpuShip():setFaction("Rebelles"):setTemplate("MU52 Hornet"):setCallSign("VS37"):setPosition(-110737, -36717):orderFlyTowards(-22331, -13587)
            CpuShip():setFaction("Rebelles"):setTemplate("Adv. Striker"):setCallSign("NC28"):setPosition(-106972, -57371):orderFlyTowards(-18553, -34254)
            CpuShip():setFaction("Rebelles"):setTemplate("MU52 Hornet"):setCallSign("VS36"):setPosition(-110338, -62004):orderFlyTowards(-21887, -38920)
            CpuShip():setFaction("Rebelles"):setTemplate("Adv. Striker"):setCallSign("S27"):setPosition(-105878, -63784):orderFlyTowards(-17442, -40698)
            CpuShip():setFaction("Rebelles"):setTemplate("MU52 Hornet"):setCallSign("VS35"):setPosition(-110733, -52687):orderFlyTowards(-22331, -29587)
            CpuShip():setFaction("Rebelles"):setTemplate("Adv. Striker"):setCallSign("CSS29"):setPosition(-106773, -48005):orderFlyTowards(-18331, -24920)
            CpuShip():setFaction("Rebelles"):setTemplate("Atlantis X23"):setCallSign("VK40"):setPosition(-118119, -49454):orderFlyTowards(-28383, -28145)


            for i,station in pairs(stations) do
                station.spawnCountdown = 0;
                station:setCommsFunction(stationComms);
            end
            bigShip = CpuShip():setFaction("Loyalistes"):setTemplate("Dreadnought"):setCallSign("CSS4"):setPosition(-8455, -13346):setBeamWeapon(0, 28, 2, 1500, 10.4, 50.0):setBeamWeaponTurret(0, 0, 2, 0):setBeamWeapon(1, 0, -180, 0, 0.1, 0.1):setBeamWeaponTurret(1, 0, -180, 0):setBeamWeapon(2, 100, 300, 0, 0.1, 0.1):setBeamWeaponTurret(2, 0, 0, 0):setBeamWeapon(3, 100, 60, 0, 0.1, 0.1):setBeamWeaponTurret(3, 0, 0, 0):setBeamWeapon(4, 30, 0, 0, 0.1, 0.1):setBeamWeaponTurret(4, 0, 0, 0):setBeamWeapon(5, 100, 180, 0, 0.1, 0.1):setBeamWeaponTurret(5, 0, 0, 0)
        end,
        update = function()
            for i,station in pairs(stations) do
                if station.spawnCountdown <= 0 then
                    local x,y = station:getPosition();
                    if station:getFaction() == "Loyalistes" then
                        generateMobs(irandom(1,2), "MT52 Hornet", "Loyalistes", x, y, 500, function(mob) mob:orderDefendTarget(bigShip); end)
                        generateMobs(irandom(0,1), "Phobos T3", "Loyalistes", x, y, 500, function(mob) mob:orderDefendTarget(bigShip); end)
                        generateMobs(irandom(-10,1), "Atlantis X23", "Loyalistes", x, y, 500, function(mob) mob:orderDefendTarget(bigShip); end)
                    else
                        generateMobs(irandom(1,2), "MT52 Hornet", "Rebelles", x, y, 500, function(mob) mob:orderAttack(bigShip); end)
                    end
                    station.spawnCountdown = irandom(100 * 60,200 * 60);
                end
                station.spawnCountdown = station.spawnCountdown - 1;
            end

            local allSystemDown = true;
            for i,system in pairs(systems) do
                if bigShip:getSystemHealth(system) >= 0 then
                    allSystemDown = false;
                end
            end

            if not bigShip:isValid() or allSystemDown then
                victory("Vindh");
            end
        end
    },
};

function init()
    for partName, partFunction in pairs(scenarioParts) do
        addGMFunction(partName, function() changePart(partName) end);
    end

    station = SpaceStation():setTemplate("Medium Station"):setFaction("Vindh"):setCallSign("DS2207"):setPosition(-7600, 40079)

    
    players = { --PlayerSpaceship():setFaction("Arianne"):setTemplate("ACorvette"):setCallSign("ARI"):setPosition(-7640, 39663)
              PlayerSpaceship():setFaction("Vindh"):setTemplate("VCorvette"):setCallSign("Larth1"):setPosition(-7640, 39663):setWeaponStorage("Nuke", 0)
              , PlayerSpaceship():setFaction("Vindh"):setTemplate("VCorvette"):setCallSign("Vasserand"):setPosition(-7540, 39663):setWeaponStorage("Nuke", 1)
              , PlayerSpaceship():setFaction("Loyalistes"):setTemplate("VCorvette"):setCallSign("Ducal-2"):setPosition(-24068, -27131):setWeaponStorage("Nuke", 0)
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

    Nebula():setPosition(-33333, -8444)
    Nebula():setPosition(-27778, 4222)
    Nebula():setPosition(-13556, 8889)
    Nebula():setPosition(-4444, 8222)
    Nebula():setPosition(5778, 4444)
    Nebula():setPosition(18000, -2444)
    Nebula():setPosition(-43111, -6889)
    Nebula():setPosition(-45778, 2889)
    Nebula():setPosition(-57778, -9778)
    Nebula():setPosition(-42889, -19556)
    Nebula():setPosition(-68000, -12000)
    Nebula():setPosition(-82889, 4000)
    Nebula():setPosition(-111778, -36000)
    Nebula():setPosition(-117111, -49778)
    Nebula():setPosition(-117111, -64444)
    Nebula():setPosition(-106000, -62667)
    Nebula():setPosition(-107333, -54444)
    Nebula():setPosition(-97111, -31778)
    Nebula():setPosition(-91111, -20222)
    Nebula():setPosition(-87778, -11333)
    Nebula():setPosition(-70000, -8444)
    Nebula():setPosition(6000, 11333)
    Nebula():setPosition(15111, 22444)
    Nebula():setPosition(21778, 15556)
    Nebula():setPosition(32222, 22222)
    Nebula():setPosition(41556, 28000)
    Nebula():setPosition(58889, 19111)
    Nebula():setPosition(63778, 36222)
    Nebula():setPosition(71778, 41556)
    Nebula():setPosition(46444, 15556)
    Nebula():setPosition(38889, 20444)
    Nebula():setPosition(-20667, 38667)
    Nebula():setPosition(5556, 37778)
    Nebula():setPosition(15556, 52667)
    Nebula():setPosition(-60889, 26222)
    Nebula():setPosition(-69778, -26444)
    Nebula():setPosition(16000, -40667)
    Nebula():setPosition(63333, -19778)
    Nebula():setPosition(56444, 2000)
    Nebula():setPosition(-5111, -24667)
    Nebula():setPosition(-55778, -46667)
    Asteroid():setPosition(-34889, -48889)
    Asteroid():setPosition(-40889, -44222)
    Asteroid():setPosition(-37111, -42000)
    Asteroid():setPosition(-39111, -36000)
    Asteroid():setPosition(-44444, -34667)
    Asteroid():setPosition(-40000, -29778)
    Asteroid():setPosition(-53111, -26222)
    Asteroid():setPosition(-50667, -22000)
    Asteroid():setPosition(-56889, -17111)
    Asteroid():setPosition(-54889, -14667)
    Asteroid():setPosition(42667, -222)
    Asteroid():setPosition(33111, 6222)
    Asteroid():setPosition(29778, 10667)
    Asteroid():setPosition(18889, 8000)
    Asteroid():setPosition(16889, 11333)
    Asteroid():setPosition(22889, 14222)
    Asteroid():setPosition(23333, 15111)
    Asteroid():setPosition(15556, 20222)
    Asteroid():setPosition(18444, 21556)
    Asteroid():setPosition(12667, 25778)
    Asteroid():setPosition(11556, 26667)
    Asteroid():setPosition(-63778, 18889)
    Asteroid():setPosition(-55333, 24222)
    Asteroid():setPosition(-53111, 28000)
    Asteroid():setPosition(-43111, 31556)
    Asteroid():setPosition(-40444, 33556)
    Asteroid():setPosition(-54222, 16667)
    Asteroid():setPosition(-41333, 16222)
    Asteroid():setPosition(-33111, 23778)
    Asteroid():setPosition(-49333, 19778)
    Asteroid():setPosition(-46000, 26222)
    Asteroid():setPosition(-38889, 28667)
    Asteroid():setPosition(-30889, 29556)
    Asteroid():setPosition(-33333, 20222)
    Asteroid():setPosition(-33778, 21778)
    Asteroid():setPosition(-33111, 28222)
    Asteroid():setPosition(22889, 31111)
    Asteroid():setPosition(30667, 21111)
    Asteroid():setPosition(28444, 20000)
    Asteroid():setPosition(25333, 19333)
    Asteroid():setPosition(-59556, 37333)
    Asteroid():setPosition(-11333, 32667)
    Asteroid():setPosition(-1778, 30000)
    Asteroid():setPosition(9778, 35556)
    Asteroid():setPosition(-53111, -46667)
    Asteroid():setPosition(-9111, -61556)
    Asteroid():setPosition(3111, -51333)
    Asteroid():setPosition(37556, -13778)
    Mine():setPosition(-18616, -21314)
    Mine():setPosition(-14385, -22863)
    Mine():setPosition(-9563, -22748)
    Mine():setPosition(-5173, -22145)
    Mine():setPosition(-1384, -20596)
    Mine():setPosition(596, -18616)
    Mine():setPosition(4039, -15258)
    Mine():setPosition(5847, -12417)
    Mine():setPosition(5761, -8370)
    Mine():setPosition(4642, -4410)
    Mine():setPosition(2231, -1827)
    Mine():setPosition(-2504, -450)
    Mine():setPosition(-8272, -622)
    Mine():setPosition(-13179, -1053)
    Mine():setPosition(-16279, -2861)
    Mine():setPosition(-19550, -5271)
    Mine():setPosition(-21014, -7251)
    Mine():setPosition(-22822, -9748)
    Mine():setPosition(-23510, -11470)
    Mine():setPosition(-23510, -13622)
    Mine():setPosition(-22908, -16291)
    Mine():setPosition(-21314, -18552)
    Mine():setPosition(-21014, -12847)
    Mine():setPosition(-19034, -9662)
    Mine():setPosition(-15418, -6563)
    Mine():setPosition(-12146, -4066)
    Mine():setPosition(-8014, -3291)
    Mine():setPosition(-2848, -2947)
    Mine():setPosition(682, -4324)
    Mine():setPosition(3179, -7165)
    Mine():setPosition(-6033, -1225)
    Mine():setPosition(3781, -11125)
    Mine():setPosition(2490, -13708)
    Mine():setPosition(682, -16205)
    Mine():setPosition(-1901, -18185)
    Mine():setPosition(-4656, -20165)
    Mine():setPosition(-7583, -20940)
    Mine():setPosition(-11371, -20768)
    Mine():setPosition(-15762, -20251)
    Mine():setPosition(-18345, -18099)
    Mine():setPosition(-20325, -16033)
    Mine():setPosition(-44128, 23911)
    Mine():setPosition(-39773, 21566)
    Mine():setPosition(-38863, 26831)
    Mine():setPosition(-9614, 22333)
    Mine():setPosition(-5112, 16054)
    Mine():setPosition(574, 22926)
    Mine():setPosition(25399, 13088)
    Mine():setPosition(26893, 9688)
    Mine():setPosition(30499, 12753)
    Mine():setPosition(28464, 14969)
    Mine():setPosition(-4670, 23859)
    Mine():setPosition(-37169, 23739)
    Mine():setPosition(-28030, -44973)
    Mine():setPosition(-24654, -49047)
    Mine():setPosition(-19415, -45438)
    Mine():setPosition(-23257, -41829)
    BlackHole():setPosition(22998, -21793)
    Asteroid():setPosition(15887, -39793)
    Asteroid():setPosition(2109, -34015)
    Asteroid():setPosition(-5002, -41793)
    Asteroid():setPosition(26332, -5793)
    Asteroid():setPosition(52554, 5985)
    Asteroid():setPosition(-74780, 20652)
    Asteroid():setPosition(60776, 44652)

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

function stationComms()
    setCommsMessage("Convaincre les occupants de se rebeller.")
    addCommsReply("Rebellez vous!", function()
        if not comms_source:takeReputationPoints(50) then setCommsMessage("Pas assez de reputation."); return end
        setCommsMessage("Vous avez raison")
        comms_target:setFaction("Rebelles")
        comms_target:setCommsFunction(rebelSellingComms);
        addCommsReply("Je veux acheter des trucs", rebelSellingComms) 
    end)
end

function rebelSellingComms()
    setCommsMessage("De quoi as-tu besoin");
    sellStuffComm("Nuke", 1000);
    sellStuffComm("Homing", 10);
    sellStuffComm("HVLI", 10);
    sellStuffComm("EMP", 10);
    sellStuffComm("Mine", 10);
end

function sellStuffComm(weapon, price)
    addCommsReply("1 ".. weapon .." pour " .. price, function()
        if not comms_source:takeReputationPoints(price) then
            setCommsMessage("Pas assez de reputation.");
            addCommsReply("Je veux acheter autre chose.", rebelSellingComms) 
            return;
        end
        if comms_source:getWeaponStorage(weapon) == comms_source:getWeaponStorageMax(weapon) then
            setCommsMessage("Pas assez de place dans ton vaisseau");
            addCommsReply("Je veux acheter autre chose.", rebelSellingComms) 
            return
        end
        setCommsMessage("Merci");
        addCommsReply("Je veux acheter autre chose.", rebelSellingComms) 

        comms_source:setWeaponStorage(weapon, comms_source:getWeaponStorage(weapon) + 1);
    end)
end




--Name: C01-03A Révolte station
crewPosition = {"Helms", "Weapons", "Engineering", "Science", "Relay"};

nbPlayers = 3;

scenarioPart = "alert";

scenarioParts = {
    
-- Part 1
    alert = {
        init = function() 
            sendCommToAll(rebelStation, "Appel à l'aide ! Nous avons reconquis une base du Duc au secteur E2, mais les loyalistes sont revenus en force. Nous avons besoin d'aide !");
            rebels = generateMobs(5, "MT52 Hornet", "Rebelles", -40786, -7425, 1000, function(mob) mob:orderDefendTarget(rebelStation) end)
            attLoyalists = generateMobs(10, "MT52 Hornet", "Loyalistes", -50786, -7425, 2000, function(mob) mob:orderRoaming() end)
            stationLoyal:sendCommsMessage(players[3], "Capitaine du Ducal-2, la station en C6 est traitre au Duc et se dit rebelle. Montrez-leur la force du Duc.")

        end,
        update = function()
            -- if allDead(attloyalists) then
            --     changePart("explore");
            -- end
        end
    },

-- Part 2
    explore = {
        init = function() 
            sendCommToAll(rebelStation, "Merci de votre aide, venez nous voir en personne sur la base d'opération. Nous avons du bon équipement à bon prix et une offre à vous faire...")
        end,
        update = function()
            for i,player in pairs(players) do
                allDocked = true;
                if player:isDocked(rebelStation) then
                    station:sendCommsMessage(player, "Choisisez qui entrera dans la station et envoyez les à la console");
                    player.docked = true;
                end
                if not player.docked then
                    allDocked = false;
                end
            end
            if allDocked then
                changePart("liberation");
            end
        end
    },

-- Part 3
    liberation = {
        init = function() 
            sendCommToAll(rebelStation, "Aidez nous à libérer les autres stations en C4 et H5 !");
        end,
        update = function()
            local allLiberated = true;
            for i,station in pairs(stationsToLiberate) do
                if allDead(station.defenders) and not station.isConquered then
                    allLiberated = false;
                    station.station:setFaction("Independent");
                    for i,player in pairs(players) do
                        if player:isDocked(station.station) then
                            station:conquered("Rebelles");
                            station:sendCommsMessage(player, "Merci de nous avoir aidé, maintenant par le Céleste, aidez-nous à libérer une autre station.");
                        end
                    end
                end
            end
            if allLiberated then
                victory("Vindh")
            end
        end
    },
--     retour = {
--         init = function()
--             sendCommToAll(rebelStation, "Merci d'avoir libéré les environs. Revenez me voir");
--         end,
--         update = function()
            
--             for i,player in pairs(players) do
--                 allDocked = true;
--                 if player:isDocked(rebelStation) and not player.docked then
--                     station:sendCommsMessage(player, "Merci d'avoir libéré les environs. Revenez me voir");
--                     player.docked = true;
--                 end
--                 if not player.docked then
--                     allDocked = false;
--                 end
--             end
--         end
--     }
};

function init()

    miningStation = SpaceStation():setTemplate("Medium Station"):setFaction("Rebelles"):setCallSign("Station minière"):setPosition(-40692, -9680)
    rebelStation = SpaceStation():setTemplate("Large Station"):setFaction("Rebelles"):setCallSign("Base d'opération rebelle"):setPosition(-40786, -7425)
    
    stationsToLiberate = { makeStationToLiberate("Loyalistes", -11839, -42575, 10)
                         , makeStationToLiberate("Loyalistes", 11839, 42575, 10)
                         }

    for partName, partFunction in pairs(scenarioParts) do
        addGMFunction(partName, function() changePart(partName) end);
    end
    
    players = { --PlayerSpaceship():setFaction("Arianne"):setTemplate("ACorvette"):setCallSign("ARI"):setPosition(-7640, 39663)
              PlayerSpaceship():setFaction("Vindh"):setTemplate("VCorvette"):setCallSign("Larth1"):setPosition(-95000, 32500):setWeaponStorage("Nuke", 0)
              , PlayerSpaceship():setFaction("Vindh"):setTemplate("VCorvette"):setCallSign("Vasserand"):setPosition(-95000, 32500):setWeaponStorage("Nuke", 0)
              , PlayerSpaceship():setFaction("Loyalistes"):setTemplate("MCorvette"):setCallSign("Ducal-2"):setPosition(46000, -13500):setWeaponStorage("Nuke", 0):setReputationPoints(150):setShieldsMax(160, 160)
              --, PlayerSpaceship():setFaction("Merillon"):setTemplate("MCorvette"):setCallSign("MER"):setPosition(-7640, 39663)
              };
              
    station = SpaceStation():setTemplate("Medium Station"):setFaction("Vindh"):setPosition(-95000, 32500);
    stationLoyal = SpaceStation():setTemplate("Medium Station"):setFaction("Loyalistes"):setPosition(46000, -13500);


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

    Nebula():setPosition(41642, -11011)
    Nebula():setPosition(9913, -35315)
    Nebula():setPosition(24427, -24175)
    Nebula():setPosition(-10678, -27551)
    Nebula():setPosition(-23843, -49492)
    Nebula():setPosition(-39033, -25863)
    Nebula():setPosition(3837, 4179)
    Nebula():setPosition(38942, 16669)
    Nebula():setPosition(47718, 34559)
    Nebula():setPosition(40967, 52449)
    Nebula():setPosition(57170, 54474)
    Nebula():setPosition(-44433, -38690)
    Nebula():setPosition(-86290, -45104)
    Nebula():setPosition(-88315, -62319)
    Nebula():setPosition(-73463, -71770)
    Nebula():setPosition(-64687, -31601)
    Nebula():setPosition(-30931, 2829)
    Nebula():setPosition(-10678, 26458)
    Nebula():setPosition(10925, 19369)
    Nebula():setPosition(23415, 35572)
    Nebula():setPosition(20039, 65951)
    Nebula():setPosition(54470, 64601)
    Nebula():setPosition(71010, 32196)
    Mine():setPosition(11600, -8985)
    Mine():setPosition(7550, -1222)
    Mine():setPosition(1474, 6542)
    Mine():setPosition(-2914, 11268)
    Mine():setPosition(-6290, 17006)
    Mine():setPosition(-12366, 20719)
    Mine():setPosition(-19455, 29833)
    Mine():setPosition(-12703, 25445)
    Mine():setPosition(-7640, 21732)
    Mine():setPosition(-2577, 16331)
    Mine():setPosition(3499, 11943)
    Mine():setPosition(8900, 3504)
    Mine():setPosition(6537, 6880)
    Mine():setPosition(10588, -1897)
    Mine():setPosition(15988, -7298)
    Mine():setPosition(11938, -3922)
    Mine():setPosition(16326, -17762)
    Mine():setPosition(21052, -19450)
    Mine():setPosition(22740, -25863)
    Mine():setPosition(20039, -32277)
    Mine():setPosition(26790, -38352)
    Mine():setPosition(27128, -43753)
    Mine():setPosition(25102, -32952)
    Mine():setPosition(23077, -41390)
    Mine():setPosition(29828, -49829)
    Mine():setPosition(-19117, 36247)
    Mine():setPosition(-26206, 39960)
    Mine():setPosition(-24180, 34559)
    Mine():setPosition(-20467, 46036)
    Mine():setPosition(-30931, 50424)
    Mine():setPosition(-32619, 59200)
    Mine():setPosition(-29244, 58525)
    Mine():setPosition(-23505, 50424)
    Mine():setPosition(-29919, 42660)
    Mine():setPosition(-27218, 53799)
    Mine():setPosition(37592, -48142)
    Mine():setPosition(26115, -50167)
    Mine():setPosition(31178, -54217)
    Mine():setPosition(33879, -61644)
    Asteroid():setPosition(-65024, -13711)
    Asteroid():setPosition(-59623, -11348)
    Asteroid():setPosition(-63336, -4597)
    Asteroid():setPosition(-54222, -4935)
    Asteroid():setPosition(-54222, -5272)
    Asteroid():setPosition(-60636, 5192)
    Asteroid():setPosition(-53885, 7217)
    Asteroid():setPosition(-46796, 7892)
    Asteroid():setPosition(-45784, 14306)
    Asteroid():setPosition(-40720, 14981)
    Asteroid():setPosition(-39708, 9242)
    Asteroid():setPosition(-46796, 4179)
    Asteroid():setPosition(-45446, -1559)
    Asteroid():setPosition(-37682, -6285)
    Asteroid():setPosition(-34307, -209)
    Asteroid():setPosition(-27893, -9323)
    Asteroid():setPosition(-27556, -11011)
    Asteroid():setPosition(-37345, -21812)
    Asteroid():setPosition(-45446, -28563)
    Asteroid():setPosition(-57598, -27213)
    Asteroid():setPosition(-59623, -23838)
    Asteroid():setPosition(-48822, -23500)
    Asteroid():setPosition(-22830, 11268)
    Asteroid():setPosition(-13041, 13968)
    Asteroid():setPosition(-22493, 26458)
    Asteroid():setPosition(-16079, 25783)
    Asteroid():setPosition(-17092, 33209)
    Asteroid():setPosition(-7640, 36922)
    Asteroid():setPosition(-8653, 43673)
    Asteroid():setPosition(-2577, 34221)
    Asteroid():setPosition(-9666, 29496)
    Asteroid():setPosition(-1902, 30508)
    Asteroid():setPosition(-4602, 38947)
    Asteroid():setPosition(-214, 42323)
    Asteroid():setPosition(-1564, 49074)
    Asteroid():setPosition(5187, 50424)
    Asteroid():setPosition(13626, 54137)
    Asteroid():setPosition(8562, 59200)
    Asteroid():setPosition(17339, 50424)
    Asteroid():setPosition(21389, 48736)
    Asteroid():setPosition(10925, 44685)
    Asteroid():setPosition(12951, 36584)
    Asteroid():setPosition(20039, 38947)
    Asteroid():setPosition(21389, 47048)
    Asteroid():setPosition(27128, 52787)
    Asteroid():setPosition(19702, 58525)
    Asteroid():setPosition(25778, 56837)
    Asteroid():setPosition(15313, 61563)
    Asteroid():setPosition(20039, 53124)
    Asteroid():setPosition(24090, 59875)
    Asteroid():setPosition(26115, 66289)
    Asteroid():setPosition(31516, 65951)
    Asteroid():setPosition(37254, 79453)
    Asteroid():setPosition(-47134, 2829)
    Asteroid():setPosition(-41395, 2491)
    Asteroid():setPosition(-43083, -2234)
    Asteroid():setPosition(-52535, -9323)
    Asteroid():setPosition(-56923, -14049)
    Asteroid():setPosition(-57936, -17762)
    Asteroid():setPosition(-68737, -20125)
    Asteroid():setPosition(-68737, -22150)
    Asteroid():setPosition(-54560, -18437)
    Asteroid():setPosition(-61649, -21137)
    Asteroid():setPosition(-61649, -22150)
    Asteroid():setPosition(-51860, -26201)
    Asteroid():setPosition(-64012, -32614)
    Asteroid():setPosition(-69412, -24850)
    Asteroid():setPosition(-61311, -26876)
    Asteroid():setPosition(-64349, -31601)
    Asteroid():setPosition(-75151, -34302)
    Asteroid():setPosition(-75151, -39365)
    Asteroid():setPosition(-65699, -40715)
    Asteroid():setPosition(-73463, -31601)
    Asteroid():setPosition(-71438, -27888)
    Asteroid():setPosition(-66374, -31264)
    Asteroid():setPosition(-71438, -36665)
    Asteroid():setPosition(-73125, -41390)
    Asteroid():setPosition(-81902, -53542)
    Asteroid():setPosition(-90003, -52192)
    Asteroid():setPosition(-80552, -45441)
    Asteroid():setPosition(-63674, -45779)
    Asteroid():setPosition(-56585, -34302)
    WormHole():setPosition(-41058, -53205):setTargetPosition(7212, 70339)
    SupplyDrop():setFaction("Independent"):setPosition(4512, 3166):setEnergy(500):setWeaponStorage("Homing", 4):setWeaponStorage("Nuke", 1):setWeaponStorage("Mine", 2):setWeaponStorage("EMP", 1)
    SupplyDrop():setFaction("Independent"):setPosition(41642, 51437):setEnergy(500):setWeaponStorage("Homing", 4):setWeaponStorage("Nuke", 1):setWeaponStorage("Mine", 2):setWeaponStorage("EMP", 1)
    WarpJammer():setFaction("Independent"):setPosition(-39708, -48479)
    WarpJammer():setFaction("Independent"):setPosition(9913, 53799)

    stationRebel2 = SpaceStation():setTemplate("Medium Station"):setFaction("Rebelles"):setCallSign("Liberta-3"):setPosition(28268, -52829)

    CpuShip():setFaction("Rebelles"):setTemplate("MU52 Hornet"):setCallSign("BR42"):setPosition(29697, -53432):orderDefendTarget(stationRebel2)
    Mine():setPosition(31178, -54217)
    Mine():setPosition(35047, -46190)
    CpuShip():setFaction("Rebelles"):setTemplate("MU52 Hornet"):setCallSign("BR44"):setPosition(28188, -50369):orderDefendTarget(stationRebel2)
    Mine():setPosition(29828, -49829)
    Mine():setPosition(21396, -54488)
    CpuShip():setFaction("Rebelles"):setTemplate("MU52 Hornet"):setCallSign("CV39"):setPosition(25257, -52677):orderDefendTarget(stationRebel2)
    Mine():setPosition(26115, -50167)
    Mine():setPosition(22521, -46404)
    CpuShip():setFaction("Rebelles"):setTemplate("Atlantis X23"):setCallSign("Liberté-3"):setPosition(28498, -54497):orderDefendTarget(stationRebel2):setWeaponStorage("Homing", 6)
    CpuShip():setFaction("Rebelles"):setTemplate("MU52 Hornet"):setCallSign("SS40"):setPosition(26323, -54142):orderDefendTarget(stationRebel2)
    CpuShip():setFaction("Rebelles"):setTemplate("MU52 Hornet"):setCallSign("S41"):setPosition(28188, -56051):orderDefendTarget(stationRebel2)
    CpuShip():setFaction("Rebelles"):setTemplate("MU52 Hornet"):setCallSign("VK43"):setPosition(31562, -51745):orderDefendTarget(stationRebel2)
    Mine():setPosition(37592, -48142)



end

function update()
    scenarioParts[scenarioPart].update();

    if not stationRebel2:isValid() then
        stationLoyal:sendCommsMessage(players[3], "Capitaine du Ducal-2, félicitation pour cet effort. D'autres stations se sont rebellées dans le secteur. Détruisez-les, de même que les forces Vindh présentes...")
    end
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

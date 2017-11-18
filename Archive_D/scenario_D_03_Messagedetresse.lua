--Name: C01-02 Message de détresse
nbPlayers = 3;

scenarioPart = "alert";

scenarioParts = {
    
-- Part 1
    alert = {
        init = function() 
            maraudeursGuards = generateMobs(4 * nbPlayers, "MT52 Hornet", "Charognards", -50000, -30000, 5000, function(mob) mob:orderDefendTarget(epave) end);
            maraudeursBoss = generateMobs(1 * nbPlayers, "Atlantis X23", "Charognards", -50000, -30000, 5000, function(mob) mob:orderDefendTarget(epave) end);
            maraudeursTransport = generateMobs(1 * nbPlayers, "Transport2x3", "Charognards", -50000, -30000, 100, function(mob) mob:orderDock(epave) end);
            sendCommToAll(station, "Capitaines nous avons reçus un message de détresse provenant du secteur D2, suivie d'une importante puissance, un anomalie que vous devez investiguer.");
        end,
        update = function()
            for i,player in pairs(players) do
                local x, y = player:getPosition();
                if not player.menaced and player:getSectorName() == epave:getSectorName() then
                    player.menaced = true;
                    maraudeursBoss[1]:sendCommsMessage(player, "Vous aurez pas notre épaves, nos trouvailles! Niaha!");
                end
            end

            local allDead = true;
            for i,mob in pairs(maraudeursGuards) do
                if mob:isValid() then
                    allDead = false;
                end
            end
            for i,mob in pairs(maraudeursBoss) do
                if mob:isValid() then
                    allDead = false;
                end
            end
            if allDead then
                changePart("explore");
            end
        end
    },

-- Part 2
    explore = {
        init = function()
            sendCommToAll(station, "Le systeme de defense est trop puissant, vous devez le hacker avant de le detruire. Par la suite, l'intérieur du vaisseau surchauffe, détruisez le réacteur avant d'aborder.");
        end,
        update = function()
            if epave:getSystemHealth("Reactor") <= 0 then
                epave:setFaction("Epave");
            end
            for i,player in pairs(players) do
                if not player.exploringRP and player:isDocked(epave) then
                    player.exploringRP = true;
                    epave:sendCommsMessage(player, "Choisisez qui entrera dans le vaisseau et envoyez les à la console");
                end
            end
        end
    },

-- Part 3
    ambush = {
        init = function()
            ambush = generateMobs(4 * nbPlayers, "MT52 Hornet", "Charognards", -50000, -30000, 20000, function(mob) mob:orderDefendTarget(epave) end);
            ambushHeavy = generateMobs(1 * nbPlayers, "Atlantis X23", "Charognards", -50000, -30000, 20000, function(mob) mob:orderDefendTarget(epave) end);
        end,
        update = function()
            local allDead = true;
            for i,mob in pairs(ambush) do
                if mob:isValid() then
                    allDead = false;
                end
            end
            for i,mob in pairs(ambushHeavy) do
                if mob:isValid() then
                    allDead = false;
                end
            end
            if allDead then
                sendCommToAll(station, "Des renforts arrivent, capitaines revenez à la station !");
            end
        end

    }
};

function init()
    
    for partName, partFunction in pairs(scenarioParts) do
        addGMFunction(partName, function() changePart(partName) end);
    end
    
    players = { --PlayerSpaceship():setFaction("Arianne"):setTemplate("ACorvette"):setCallSign("ARI"):setPosition(-7640, 39663)
              PlayerSpaceship():setFaction("Vindh"):setTemplate("VCorvette"):setCallSign("Larth1"):setPosition(-7640, 39663):setWeaponStorage("Nuke", 0)
              , PlayerSpaceship():setFaction("Vindh"):setTemplate("VCorvette"):setCallSign("Vasserand"):setPosition(-7540, 39663):setWeaponStorage("Nuke", 0):setBeamWeaponTurret(2, 360, 0, 10)

              , PlayerSpaceship():setFaction("Loyalistes"):setTemplate("MCorvette"):setCallSign("Ducal-2"):setPosition(10850, -90000):setWeaponStorage("Nuke", 0)
              --, PlayerSpaceship():setFaction("Merillon"):setTemplate("MCorvette"):setCallSign("MER"):setPosition(-7640, 39663)
              };
              

    station = SpaceStation():setTemplate("Medium Station"):setFaction("Vindh"):setPosition(-7640, 39663);
    station = SpaceStation():setTemplate("Medium Station"):setFaction("Loyalistes"):setPosition(10950, -90100);

    epave =  CpuShip():setFaction("Epave defence"):setTemplate("epave"):setCallSign("Indomptable"):setPosition(-50000, -30000):orderRoaming();

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


    function decor()
        -- body

        BlackHole():setPosition(-78912, 21462)
        Asteroid():setPosition(-75369, 2960)
        Asteroid():setPosition(-70120, -2289)
        Asteroid():setPosition(-68283, 3485)
        Asteroid():setPosition(-67102, 4141)
        Asteroid():setPosition(-58835, 4666)
        Asteroid():setPosition(-55423, -1633)
        Asteroid():setPosition(-63296, -1501)
        Asteroid():setPosition(-60672, 3091)
        Asteroid():setPosition(-48600, 4141)
        Asteroid():setPosition(-44270, 7684)
        Asteroid():setPosition(-42957, 9652)
        Asteroid():setPosition(-32460, 4403)
        Asteroid():setPosition(-25243, 6503)
        Asteroid():setPosition(-21700, 9259)
        Asteroid():setPosition(-16320, 4010)
        Asteroid():setPosition(-10284, 6897)
        Asteroid():setPosition(-35347, 9259)
        Asteroid():setPosition(-44007, 6372)
        Asteroid():setPosition(-49387, 2566)
        Asteroid():setPosition(-57785, 3485)
        Asteroid():setPosition(-58179, 5584)
        Asteroid():setPosition(-52405, 6372)
        Asteroid():setPosition(-56604, 2304)
        Asteroid():setPosition(-58179, 1254)
        Asteroid():setPosition(-65002, -452)
        Asteroid():setPosition(-71038, 336)
        Asteroid():setPosition(-79305, -2158)
        Asteroid():setPosition(-84029, -4126)
        Asteroid():setPosition(-75631, -2289)
        Asteroid():setPosition(-76812, 2304)
        Asteroid():setPosition(-77337, 3616)
        Asteroid():setPosition(-66183, 4928)
        Asteroid():setPosition(-63953, 9390)
        Asteroid():setPosition(-50174, 7946)
        Asteroid():setPosition(-43220, 8078)
        Asteroid():setPosition(-38365, 1648)
        Asteroid():setPosition(-32985, 2041)
        Asteroid():setPosition(-32985, 6372)
        Asteroid():setPosition(-27867, 8602)
        Asteroid():setPosition(-22487, 3091)
        Asteroid():setPosition(-18682, 2304)
        Asteroid():setPosition(-16057, 8471)
        Asteroid():setPosition(-14220, 10571)
        Asteroid():setPosition(-9365, 4010)
        Asteroid():setPosition(-6872, 1123)
        Asteroid():setPosition(-180, 5978)
        Asteroid():setPosition(476, 10964)
        Asteroid():setPosition(-2017, 11752)
        Asteroid():setPosition(-3591, 9390)
        Asteroid():setPosition(-967, 5453)
        Asteroid():setPosition(345, 4403)
        Asteroid():setPosition(4938, 7421)
        Asteroid():setPosition(5988, 8734)
        Asteroid():setPosition(-967, 8734)
        Asteroid():setPosition(-7266, 5716)
        Asteroid():setPosition(-10940, 9521)
        Asteroid():setPosition(-2935, 9652)
        Asteroid():setPosition(-2673, 6372)
        Asteroid():setPosition(-1229, 1123)
        Asteroid():setPosition(2707, 336)
        Asteroid():setPosition(6775, 4666)
        Asteroid():setPosition(9268, 7815)
        Asteroid():setPosition(15436, 10177)
        Asteroid():setPosition(19635, 9783)
        Asteroid():setPosition(18322, 3222)
        Asteroid():setPosition(17404, 2960)
        Asteroid():setPosition(13205, 4010)
        Asteroid():setPosition(14779, 4928)
        Asteroid():setPosition(17666, 6240)
        Asteroid():setPosition(12811, 9783)
        Asteroid():setPosition(16616, 8734)
        Asteroid():setPosition(22390, 5978)
        Asteroid():setPosition(25146, 3091)
        Asteroid():setPosition(18847, 729)
        Asteroid():setPosition(-11465, 4272)
        Asteroid():setPosition(-2410, 3879)
        Asteroid():setPosition(-4641, 4535)
        Asteroid():setPosition(-7003, 10833)
        Asteroid():setPosition(-13695, 9521)
        Asteroid():setPosition(-14876, 5978)
        Asteroid():setPosition(-20256, 4666)
        Asteroid():setPosition(-24980, 4928)
        Asteroid():setPosition(-23143, 7684)
        Asteroid():setPosition(-33116, 7684)
        Asteroid():setPosition(-42433, 4272)
        Asteroid():setPosition(-38496, 12933)
        Asteroid():setPosition(-37971, 8078)
        Asteroid():setPosition(-37709, 6240)
        Asteroid():setPosition(-42826, 5453)
        Asteroid():setPosition(-51618, 3354)
        Asteroid():setPosition(-52012, 4928)
        Asteroid():setPosition(-58441, 8078)
        Asteroid():setPosition(-55292, 9127)
        Asteroid():setPosition(-48600, 7815)
        Asteroid():setPosition(-45975, 7684)
        Asteroid():setPosition(-45188, 2173)
        Asteroid():setPosition(-37446, 1648)
        Asteroid():setPosition(-24062, 5847)
        Asteroid():setPosition(-10546, 7421)
        Asteroid():setPosition(-967, 5453)
        Asteroid():setPosition(-23038, 6301)
        Nebula():setPosition(-64267, -26053)
        Nebula():setPosition(-60040, -48702)
        Nebula():setPosition(-43279, -47041)
        Nebula():setPosition(-15496, -38283)
        Nebula():setPosition(-26066, -17144)
        Nebula():setPosition(-56265, -25902)
        Nebula():setPosition(-43732, -24845)
        Nebula():setPosition(-48564, -29978)
        Nebula():setPosition(-42626, -15091)
        Nebula():setPosition(-35626, -19291)
        Nebula():setPosition(-25426, -7691)
        Nebula():setPosition(-30026, 1109)
        Nebula():setPosition(-24426, 4109)
        Nebula():setPosition(-18426, 10309)
        Nebula():setPosition(-30026, 12509)
        Nebula():setPosition(-24026, 14909)
        Nebula():setPosition(-23426, 18709)
        Nebula():setPosition(-31426, 24509)
        Nebula():setPosition(-24226, 34909)
        Nebula():setPosition(-32226, 45109)
        Nebula():setPosition(-30226, 51309)
        Nebula():setPosition(-36226, 37109)
        Nebula():setPosition(-83493, -51446)
        Nebula():setPosition(-45048, -72557)
        Nebula():setPosition(10729, -89446)
        Nebula():setPosition(-6382, -61446)
        Nebula():setPosition(-58604, 69220)
        Nebula():setPosition(-73493, 78331)
        Nebula():setPosition(-28826, 77220)
        Nebula():setPosition(-46604, 51887)
        Nebula():setPosition(-51493, 33220)
        Nebula():setPosition(-47271, 22554)
        Nebula():setPosition(8285, 83887)
    end

    decor()

    SupplyDrop():setFaction("Independent"):setPosition(-30604, 11665):setEnergy(500):setWeaponStorage("Homing", 4):setWeaponStorage("Nuke", 1):setWeaponStorage("Mine", 2):setWeaponStorage("EMP", 1)
    WarpJammer():setFaction("Independent"):setPosition(-57715, -25891)
    SpaceStation():setTemplate("Small Station"):setFaction("Charognards"):setCallSign("DS166"):setPosition(-82354, -49943)

end


crewPosition = {"Helms", "Weapons", "Engineering", "Science", "Relay"};

function update()
    scenarioParts[scenarioPart].update();

    if not players[1]:isValid() and not players[2]:isValid() then
        victory("Loyalistes");
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
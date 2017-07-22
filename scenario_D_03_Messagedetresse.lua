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
            sendCommToAll(station, "Message d'alerte du vaisseau. Rendez-vous en D2");
        end,
        update = function()
            for i,player in pairs(players) do
                local x, y = player:getPosition();
                if not player.menaced and player:getSectorName() == epave:getSectorName() then
                    player.menaced = true;
                    maraudeursBoss[1]:sendCommsMessage(player, "Vous aurez pas notre loot!");
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
            sendCommToAll(station, "Le systeme de defense est trop puissant, hackez le avant de le detruire. L'intérieur du vaisseau surchauffe, détruisez le réacteur avant d'aborder.");
        end,
        update = function()
            if epave:getSystemHealth("Reactor") <= 0 then
                epave:setFaction("Epave");
            end
            for i,player in pairs(players) do
                if not player.exploringRP and player:isDocked(epave) then
                    player.exploringRP = true;
                    epave:sendCommsMessage(player, "Exploration RP");
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
                sendCommToAll(station, "Des renforts arrivent, revenez.");
            end
        end
    }
};

function init()
    
    for partName, partFunction in pairs(scenarioParts) do
        addGMFunction(partName, function() changePart(partName) end);
    end
    
    players = { PlayerSpaceship():setFaction("Arianne"):setTemplate("AD-3"):setCallSign("ARI")
              , PlayerSpaceship():setFaction("Vindh"):setTemplate("AD-3"):setCallSign("VIN")
              , PlayerSpaceship():setFaction("Merillon"):setTemplate("AD-3"):setCallSign("MER")
              };
    station = SpaceStation():setTemplate("Medium Station"):setFaction("Dussel"):setPosition(0, 0);
    epave =  CpuShip():setFaction("Epave defence"):setTemplate("epave"):setCallSign("VK4"):setPosition(-50000, -30000):orderRoaming();

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
end


crewPosition = {"Helms", "Weapons", "Engineering", "Science", "Relay"};

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


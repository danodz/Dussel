--Name: Révoltes dans une station et sur la lune adjacente
crewPosition = {"Helms", "Weapons", "Engineering", "Science", "Relay"};

nbPlayers = 3;

scenarioPart = "alert";

scenarioParts = {
    
-- Part 1
    alert = {
        init = function() 
            sendCommToAll(rebelStation, "Nous avons reconquis la base, mais les loyalistes sont revenus en force. Nous avons besoin d'aide.");
            rebels = generateMobs(5, "MT52 Hornet", "Rebelles", -40786, -7425, 1000, function(mob) mob:orderDefendTarget(rebelStation) end)
            loyalists = generateMobs(10, "MT52 Hornet", "Loyalistes", -50786, -7425, 2000, function(mob) mob:orderRoaming() end)
        end,
        update = function()
            if allDead(loyalists) then
                changePart("explore");
            end
        end
    },

-- Part 2
    explore = {
        init = function() 
            sendCommToAll(rebelStation, "Merci de votre aide, venez nous voir sur la base d'opération. Nous avons du bon équipement à bon prix.")
        end,
        update = function()
            for i,player in pairs(players) do
                allDocked = true;
                if player:isDocked(rebelStation) then
                    station:sendCommsMessage(player, "Information sur les rebelles");
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
            sendCommToAll(rebelStation, "Aidez nous à libérer les autres stations.");
        end,
        update = function()
            local allLiberated = true;
            for i,station in pairs(stationsToLiberate) do
                if allDead(station.defenders) and not station.isConquered then
                    allLiberated = false;
                    station.station:setFaction("Aucune faction");
                    for i,player in pairs(players) do
                        if player:isDocked(station.station) then
                            station:conquered("Rebelles");
                            station:sendCommsMessage(player, "Merci de nous avoir aidé, maintenant va libérer une autre station.");
                        end
                    end
                end
            end
            if allLiberated then
                changePart(return);
            end
        end
    }
    return = {
        init = function()
            sendCommToAll(rebelStation, "Merci d'avoir libéré les environs. Revenez me voir");
        end,
        update = function()
            
            for i,player in pairs(players) do
                allDocked = true;
                if player:isDocked(rebelStation) and not player.docked then
                    station:sendCommsMessage(player, "Merci d'avoir libéré les environs. Revenez me voir");
                    player.docked = true;
                end
                if not player.docked then
                    allDocked = false;
                end
            end
        end
    }
};

function init()

    miningStation = SpaceStation():setTemplate("Medium Station"):setFaction("Rebelles"):setCallSign("Station minière"):setPosition(-40692, -9680)
    rebelStation = SpaceStation():setTemplate("Large Station"):setFaction("Rebelles"):setCallSign("Base d'opération"):setPosition(-40786, -7425)
    
    stationsToLiberate = { makeStationToLiberate("Loyalistes", -11839, -42575, 10)
                         , makeStationToLiberate("Loyalistes", 11839, 42575, 10)
                         }

    for partName, partFunction in pairs(scenarioParts) do
        addGMFunction(partName, function() changePart(partName) end);
    end
    
    players = { PlayerSpaceship():setFaction("Arianne"):setTemplate("AD-3"):setCallSign("ARI")
              , PlayerSpaceship():setFaction("Vindh"):setTemplate("AD-3"):setCallSign("VIN")
              , PlayerSpaceship():setFaction("Merillon"):setTemplate("AD-3"):setCallSign("MER")
              };
    station = SpaceStation():setTemplate("Medium Station"):setFaction("Dussel"):setPosition(0, 0);

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

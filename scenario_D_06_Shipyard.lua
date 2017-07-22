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
                       };
            for i,station in pairs(stations) do
                station.spawnCountdown = 0;
                station:setCommsFunction(stationComms);
            end
            bigShip = CpuShip():setFaction("Loyalistes"):setTemplate("Dreadnought"):setCallSign("CSS4"):setPosition(-8455, -13346)
        end,
        update = function()
            for i,station in pairs(stations) do
                if station.spawnCountdown <= 0 then
                    local x,y = station:getPosition();
                    if station:getFaction() == "Loyalistes" then
                        generateMobs(irandom(1,2), "MT52 Hornet", "Loyalistes", x, y, 500, function(mob) mob:orderDefendTarget(bigShip); end)
                        generateMobs(irandom(0,1), "Phobos T3", "Loyalistes", x, y, 500, function(mob) mob:orderDefendTarget(bigShip); end)
                        generateMobs(irandom(0,1), "Atlantis X23", "Loyalistes", x, y, 500, function(mob) mob:orderDefendTarget(bigShip); end)
                    else
                        generateMobs(irandom(1,2), "MT52 Hornet", "Rebelles", X, Y, 500, function(mob) mob:orderAttack(bigShip); end)
                    end
                    station.spawnCountdown = irandom(45 * 60,75 * 60);
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

    station = SpaceStation():setTemplate("Medium Station"):setFaction("Dussel"):setPosition(0, 0);
    
    players = { PlayerSpaceship():setFaction("Arianne"):setTemplate("ACorvette"):setCallSign("ARI"):setReputationPoints(1000)
              , PlayerSpaceship():setFaction("Vindh"):setTemplate("VCorvette"):setCallSign("VIN")
              , PlayerSpaceship():setFaction("Merillon"):setTemplate("MCorvette"):setCallSign("MER")
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
    if comms_source:isDocked(comms_target) then
	        setCommsMessage("Convaincre les occupants de se rebeller.")
            addCommsReply("Rebellez vous!", function()
                if not comms_source:takeReputationPoints(50) then setCommsMessage("Pas assez de reputation."); return end
                setCommsMessage("Vous avez raison")
                comms_target:setFaction("Rebelles")
                comms_target:setCommsFunction(rebelSellingComms);
                addCommsReply("Je veux acheter des trucs", rebelSellingComms) 
            end)
    end
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

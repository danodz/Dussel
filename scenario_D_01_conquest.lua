--Name: Conquete
printTimer = 0;

players = { PlayerSpaceship():setFaction("Vindh"):setTemplate("VCorvette"):setCallSign("Larth1"):setPosition(-7640, 39663):setWeaponStorage("Nuke", 0):setReputationPoints(1000)
          , PlayerSpaceship():setFaction("Merillon"):setTemplate("VCorvette"):setCallSign("Vasserand"):setPosition(-7540, 39663):setWeaponStorage("Nuke", 1):setReputationPoints(1000)
          };

function init()
    script = Script()
    addGMFunction("Update Ships", function() script:run("shipUpdate.lua") end);

    fuelStation = mkConquestStation("Vindh", "Fuel", 75080, 42370);
    ammoStation = mkConquestStation("Merillon", "Ammo", -9857, 37918);
    engiStation = mkConquestStation("Barons", "Engi", -5632, 39312);
    stations = {fuelStation, ammoStation, engiStation};
end

function update()
    printTimer = printTimer + 1;

    for i,station in pairs(stations) do
        station.station:setShields(1000,1000,1000);

        station.respawnTimer = station.respawnTimer + 1;
        station.pointTimer = station.pointTimer + 1;
        
        if station.pointTimer == 60 then
            station.points[station.station:getFaction()] = station.points[station.station:getFaction()] + 1;
            station.pointTimer = 0;
        end

        if printTimer > 60 * 5 then
            print(station.station:getCallSign());
            for faction,points in pairs(station.points) do
                print(faction, points)
            end
        end

        local hornets = countLivingAndDead(station.troops.hornets).living;
        local atlantis = countLivingAndDead(station.troops.atlantis).living;
        if station.respawnTimer >= 1000 then
            local x,y = station.station:getPosition();

            function addHornets()
                mobs = generateMobs(irandom(1,3), "MU52 Hornet", station.station:getFaction(), x, y, 1000, function(mob) mob:orderDefendTarget(station.station) end);
                for i,mob in pairs(mobs) do
                    table.insert(station.troops.hornets, mob);
                end
            end

            function addAtlantis()
                mobs = generateMobs(1, "Atlantis X23", station.station:getFaction(), x, y, 1000, function(mob) mob:orderDefendTarget(station.station) end);
                for i,mob in pairs(mobs) do
                    table.insert(station.troops.atlantis, mob);
                end
            end

            if hornets < 6 then
                addHornets();
                station.respawnTimer = 0;
            else if atlantis < 1 then
                addAtlantis();
                station.respawnTimer = 0;
            else if hornets < 12 then
                addHornets();
                station.respawnTimer = 0;
            else if atlantis < 2 then
                addAtlantis();
                station.respawnTimer = 0;
            else
                station.respawnTimer = 0;
            end end end end
        end
    end
    if printTimer > 60 * 5 then
        printTimer = 0;
    end
end

function mkConquestStation(faction, callSign, x, y)
    return { station = SpaceStation():setTemplate("Large Station"):setFaction(faction):setCallSign(callSign):setPosition(x, y):setCommsFunction(convertStationComms(100))
           , points = { Vindh = 0
                      , Arianne = 0
                      , Merillon = 0
                      , Barons = 0
                      }
           , troops = { hornets = {}
                      , atlantis = {}
                      }
           , respawnTimer = 750
           , pointTimer = 0
           };
end

function convertStationComms(price)
    return function()
            if comms_target:getFaction() == comms_source:getFaction() then
                setCommsMessage("De quoi as-tu besoin");
                sellStuffComm("Nuke", 1000);
                sellStuffComm("Homing", 10);
                sellStuffComm("HVLI", 10);
                sellStuffComm("EMP", 10);
                sellStuffComm("Mine", 10);
            else
                setCommsMessage("Obtenir la loyauté de la station pour sa faction (".. price .." crédits)")
                addCommsReply("J'ai les crédits", function()
                    if not comms_source:takeReputationPoints(price) then setCommsMessage("On ne s'allie pas à des pauvres"); return end
                    setCommsMessage("Vos arguments sont convaincants")
                    comms_target:setFaction(comms_source:getFaction())
                    addCommsReply("Acheter des trucs?", convertStationComms(0))
                end)
            end
    end
end

function sellStuffComm(weapon, price)
        addCommsReply("1 ".. weapon .." pour " .. price, function()
            if not comms_source:takeReputationPoints(price) then
                setCommsMessage("Pas assez de reputation.");
                addCommsReply("Je veux acheter autre chose.", convertStationComms(0)) 
                return;
            end
            if comms_source:getWeaponStorage(weapon) == comms_source:getWeaponStorageMax(weapon) then
                setCommsMessage("Pas assez de place dans ton vaisseau");
                addCommsReply("Je veux acheter autre chose.", convertStationComms(0)) 
                return
            end
            setCommsMessage("Merci");
            addCommsReply("Je veux acheter autre chose.", convertStationComms(0)) 
    
            comms_source:setWeaponStorage(weapon, comms_source:getWeaponStorage(weapon) + 1);
        end)
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

function countLivingAndDead(...)
    local status = { living = 0
                   , dead = 0
                   };
    for i,mobs in ipairs({...}) do
        for i,mob in pairs(mobs) do
            if mob:isValid() then
                status.living = status.living + 1;
            else
                status.dead = status.dead + 1;
            end
        end
    end
    return status;
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

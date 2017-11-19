--Name: Encan
printTimer = 0;

players = { PlayerSpaceship():setFaction("Vindh"):setTemplate("VCorvette"):setCallSign("Larth1"):setPosition(-7640, 39663):setWeaponStorage("Nuke", 0):setReputationPoints(1000)
          , PlayerSpaceship():setFaction("Merillon"):setTemplate("VCorvette"):setCallSign("Vasserand"):setPosition(-7540, 39663):setWeaponStorage("Nuke", 1):setReputationPoints(1000)
          };

function init()
    fuelStation = mkConquestStation("Vindh", "Fuel", 75080, 42370);
    ammoStation = mkConquestStation("Merillon", "Ammo", -9857, 37918);
    engiStation = mkConquestStation("Barons", "Engi", -5632, 39312);
    stations = {fuelStation, ammoStation, engiStation};
end

function update()
    printTimer = printTimer + 1;

    for i,station in pairs(stations) do
        station:setShields(1000,1000,1000);

        station.data.respawnTimer = station.data.respawnTimer + 1;
        
        if printTimer > 60 * 5 then
            print(station:getCallSign());
            for faction,points in pairs(station.data.points) do
                print(faction, points)
            end
        end

        local hornets = countLivingAndDead(station.data.troops.hornets).living;
        local atlantis = countLivingAndDead(station.data.troops.atlantis).living;
        if station.data.respawnTimer >= 1000 then
            local x,y = station:getPosition();

            function addHornets()
                mobs = generateMobs(irandom(1,3), "MU52 Hornet", station:getFaction(), x, y, 1000, function(mob) mob:orderDefendTarget(station) end);
                for i,mob in pairs(mobs) do
                    table.insert(station.data.troops.hornets, mob);
                end
            end

            function addAtlantis()
                mobs = generateMobs(1, "Atlantis X23", station:getFaction(), x, y, 1000, function(mob) mob:orderDefendTarget(station) end);
                for i,mob in pairs(mobs) do
                    table.insert(station.data.troops.atlantis, mob);
                end
            end

            if hornets < 6 then
                addHornets();
                station.data.respawnTimer = 0;
            else if atlantis < 1 then
                addAtlantis();
                station.data.respawnTimer = 0;
            else if hornets < 12 then
                addHornets();
                station.data.respawnTimer = 0;
            else if atlantis < 2 then
                addAtlantis();
                station.data.respawnTimer = 0;
            else
                station.data.respawnTimer = 0;
            end end end end
        end
    end
    if printTimer > 60 * 5 then
        printTimer = 0;
    end
end

function mkConquestStation(faction, callSign, x, y)
    local station = SpaceStation():setTemplate("Large Station"):setFaction(faction):setCallSign(callSign):setPosition(x, y):setCommsFunction(investOrSupplyComms);
    station.data = { points = { Vindh = 0
                              , Arianne = 0
                              , Merillon = 0
                              , Barons = 0
                              }
                   , troops = { hornets = {}
                              , atlantis = {}
                              }
                   , respawnTimer = 750
                   }
    return station;
end

function investOrSupplyComms()
    setCommsMessage("Etes vous ici pour acheter des munitions ou pour investir?")
    addCommsReply("Investir", investComms)
    addCommsReply("Acheter", supplyComms)
end

function investCommsReply(price)
    addCommsReply("Investir ".. price .." credits", function()
        if not comms_source:takeReputationPoints(price) then setCommsMessage("Vous ne les avez meme pas"); return end
        setCommsMessage("Merci, on ne l'oubliera pas")
        comms_target.data.points[comms_source:getFaction()] = comms_target.data.points[comms_source:getFaction()] + price
        addCommsReply("Faire autre chose", investOrSupplyComms) 
    end)
end

function investComms()
    setCommsMessage("Investir dans la station?")
    investCommsReply(50);
    investCommsReply(100);
    investCommsReply(150);
    investCommsReply(200);
    addCommsReply("Annuler", investOrSupplyComms) 
end

function supplyComms()
    setCommsMessage("De quoi as-tu besoin");
    sellStuffReply("Nuke", 1000);
    sellStuffReply("Homing", 10);
    sellStuffReply("HVLI", 10);
    sellStuffReply("EMP", 10);
    sellStuffReply("Mine", 10);
    addCommsReply("Annuler", investOrSupplyComms) 
end

function sellStuffReply(weapon, price)
        addCommsReply("1 ".. weapon .." pour " .. price, function()
            if not comms_source:takeReputationPoints(price) then
                setCommsMessage("Pas assez de reputation.");
                addCommsReply("Je veux acheter autre chose.", supplyComms) 
                return;
            end
            if comms_source:getWeaponStorage(weapon) == comms_source:getWeaponStorageMax(weapon) then
                setCommsMessage("Pas assez de place dans ton vaisseau");
                addCommsReply("Je veux acheter autre chose.", supplyComms) 
                return
            end
            setCommsMessage("Merci");
            addCommsReply("Je veux acheter autre chose.", supplyComms) 
    
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

function generateMobs(nb, template, faction, centerX, centerY, radius, fn)
    local mobs = {};
    
    for i=1, nb, 1 do
        local mob = CpuShip():setFaction(faction):setTemplate(template):setCallSign(srandom(irandom(2,3)) .. irandom(10,999)):setPosition(irandom(centerX - radius, centerX + radius), irandom(centerY - radius, centerY + radius))
        fn(mob);
        table.insert(mobs, mob);
    end
    
    return mobs;
end

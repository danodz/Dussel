--Name: Dussel_02
require("utils.lua");

players = {};
availableItems = { }
specterStationPairs = {};



--[[{{utils/dussel.lua}}]]--

--[[{{utils/trading.lua}}]]--

function init()
    --[[{{playership/vafJerrold.lua}}]]--
    --[[{{playership/succubiCherubim.lua}}]]--
    spawnVafJerrold(0, 0);
    spawnSuccubiCherubim(0, 0);

    dusselStation =  SpaceStation():setTemplate("Large Station"):setFaction("Dussel"):setCallSign("Dussel4"):setPosition(0, 0);

    mkSpecterStationPair(-20000, 0, "DS7", 20000, 0, "DS8")
    mkSpecterStationPair(0, -20000, "DS7", 0, 20000, "DS8")
end

function update()
    local allHacked = true;
    for i,pair in pairs(specterStationPairs) do
        if pair[1]:getFaction() == "Spectre" then
            allHacked = false;
            local bothHacked = true;
            for i,station in pairs(pair) do
                station.spawnWave = station.spawnWave + 1;
                if station.hackedCounter <= 0 then
                    station:setFaction("Spectre");
                    bothHacked = false;
                    if station.spawnWave >= 2 * 60 * 60 then
                        local x,y = station:getPosition();
                        mergeTables( station.specters, generateMobs(1, "Atlantis X23", "Spectre", x, y, 1000, function(mob) mob:orderDefendTarget(station) end));
                        generateMobs(1, "Atlantis X23", "Spectre", x, y, 1000, function(mob) mob:orderAttack(dusselStation) end);
                        station.spawnWave = 0;
                    end
                else
                    station.hackedCounter = station.hackedCounter - 1; 
                    print(station:getCallSign());
                end
            end
    
            if bothHacked then
                for i,station in pairs(pair) do
                    station:setFaction("Dussel");
                end
            end
        end
    end
    if allHacked then
        victory("Arianne");
    end
end

function mkSpecterStationPair(x,y, callSign, x2,y2, callSign2)
    station1 = mkSpecterStation(x,y,callSign);
    station1:setCommsFunction(specterStationCommsFn(callSign2));

    station2 = mkSpecterStation(x2,y2,callSign2);
    station2:setCommsFunction(specterStationCommsFn(callSign));
    table.insert(specterStationPairs, { station1, station2 });
end

function mkSpecterStation(x,y, callSign)
    local station = SpaceStation():setTemplate("Medium Station"):setFaction("Spectre"):setCallSign(callSign):setPosition(x, y)
    station.spawnWave = 1000000000;
    station.specters = {};
    station.hackedCounter = 0;
    return station
end

function specterStationCommsFn(pairedCallSign)
    return function()
        setCommsMessage("Bzzzzt");
        if allDead(comms_target.specters) and comms_target.hackedCounter <= 0 then
            addCommsReply("Hacker la station", function()
                setCommsMessage("Bzzzt"..pairedCallSign.."bzzzzt");
                comms_target.hackedCounter = 2 * 60 * 66;
            end);
        end
    end
end

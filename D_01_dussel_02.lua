--Name: Dussel_02
require("utils.lua");

players = {};
availableItems = { }
specterStations = {};
nbVulnerable = 3;



--[[{{utils/dussel.lua}}]]--

--[[{{utils/trading.lua}}]]--

function init()
    --[[{{playership/vafJerrold.lua}}]]--
    --[[{{playership/succubiCherubim.lua}}]]--
    spawnVafJerrold(187213, -88611);
    spawnSuccubiCherubim(187213, -88611);

    mkSpecterStation(-20000, 0, "DS7")
    mkSpecterStation(20000, 0, "DS8")
end

function update()
    local allHacked = true;
    for i,station in pairs(specterStations) do
        if station.hackedCounter <= 0 then
            allHacked = false;
            station.spawnWave = station.spawnWave + 1;
            if station.spawnWave >= 2 * 60 * 60 then
                local x,y = station:getPosition();
                mergeTables( station.specters, generateMobs(3, "Atlantis X23", "Spectre", x, y, 1000, function(mob) mob:orderDefendTarget(station) end));
                station.spawnWave = 0;
            end
        else
            station.hackedCounter = station.hackedCounter - 1; 
        end
    end

    if allHacked then
        victory("Arianne");
    end
end

function mkSpecterStation(x,y, callSign)
    local station = SpaceStation():setTemplate("Medium Station"):setFaction("Spectre"):setCallSign(callSign):setPosition(x, y)
    station.spawnWave = 1000000000;
    station.specters = {};
    station.hackedCounter = 0;
    station:setCommsFunction(function()
        setCommsMessage("Bzzzzt");
        if allDead(comms_target.specters) then
            addCommsReply("Hacker la station", function()
                setCommsMessage("Sauvez les autres station aussi");
                station.hackedCounter = 1 * 60 * 60;
            end);
        end
    end);
    table.insert(specterStations, station);
end

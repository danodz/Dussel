--Name: Combat de chasseurs

function init()
    localMothership = mkConquestMothership("Vindh","local",-5000,0);
    baronMothership = mkConquestMothership("Merillon","baron",5000,0);
    motherships = {localMothership, baronMothership};
    player = {};
    script = Script()
    addGMFunction("Update Ships", function() script:run("shipUpdate.lua") end);
end

function update()
    updateMothership(localMothership, baronMothership);
    updateMothership(baronMothership, localMothership);

end

function updateMothership(ship, enemy)
    ship.data.respawnTimer = ship.data.respawnTimer + 1;

    local hornets = countLivingAndDead(ship.data.troops.hornets).living;
    local atlantis = countLivingAndDead(ship.data.troops.atlantis).living;
    --if ship.data.respawnTimer >= 1000 then
    if ship.data.respawnTimer >= 10 then
        local x,y = ship:getPosition();
        local ex,ey = enemy:getPosition();

        function addHornets(fn)
            mobs = generateMobs(irandom(1,3), "MU52 Hornet", ship:getFaction(), x, y, 1000, fn);
            for i,mob in pairs(mobs) do
                table.insert(ship.data.troops.hornets, mob);
            end
        end

        function addAtlantis(fn)
            mobs = generateMobs(1, "Atlantis X23", ship:getFaction(), x, y, 1000, fn);
            for i,mob in pairs(mobs) do
                table.insert(ship.data.troops.atlantis, mob);
            end
        end

        if hornets < 6 then
            addHornets(function(mob) mob:orderDefendTarget(ship) end);
            ship.data.respawnTimer = 0;
        else if atlantis < 1 then
            addAtlantis(function(mob) mob:orderDefendTarget(ship) end);
            ship.data.respawnTimer = 0;
        else if hornets < 12 then
            addHornets(function(mob) mob:orderDefendTarget(ship) end);
            ship.data.respawnTimer = 0;
        else if atlantis < 2 then
            addAtlantis(function(mob) mob:orderDefendTarget(enemy) end);
            ship.data.respawnTimer = 0;
        if hornets < 18 then
            addHornets(function(mob) mob:orderFlyTowards(ex,ey) end);
            ship.data.respawnTimer = 0;
        else if atlantis < 3 then
            addAtlantis(function(mob) mob:orderFlyTowards(ex,ey) end);
            ship.data.respawnTimer = 0;
        else if hornets < 24 then
            addHornets(function(mob) mob:orderFlyTowards(ex,ey) end);
            ship.data.respawnTimer = 0;
        else if atlantis < 4 then
            addAtlantis(function(mob) mob:orderFlyTowards(ex,ey) end);
            ship.data.respawnTimer = 0;
        else
            ship.data.respawnTimer = 0;
        end end end end end end end end
    end
end

function mkConquestMothership(faction, callSign, x, y)
    local mothership = PlayerSpaceship():setTemplate("Mothership"):setFaction(faction):setCallSign(callSign):setPosition(x, y);
    mothership.data = { troops = { hornets = {}
                                 , atlantis = {}
                                 }
                      , respawnTimer = 750
                      }
    return mothership;
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

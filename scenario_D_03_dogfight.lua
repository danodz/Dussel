--Name: Combat de chasseurs
function init()
    localMothership = mkConquestMothership("Vindh","local",-5000,0);
    baronMothership = mkConquestMothership("Merillon","baron",5000,0);
    motherships = {localMothership, baronMothership};
    localPlayers = {};
    baronPlayers = {};

    for i=1,12,1 do
        table.insert(localPlayers, mkPlayer("Vindh", -5000, 0));
        table.insert(baronPlayers, mkPlayer("Merillon", 5000, 0));
    end

    script = Script()
end

function update()
    updateMothership(localMothership, baronMothership);
    updateMothership(baronMothership, localMothership);
    
    local lx,ly = localMothership:getPosition();
    for i,ship in pairs(localPlayers) do
        if not ship:isValid() then
            localPlayers[i] = mkPlayer("Vindh", lx,ly);
        end
    end

    local bx,by = baronMothership:getPosition();
    for i,ship in pairs(baronPlayers) do
        if not ship:isValid() then
            baronPlayers[i] = mkPlayer("Merillon", bx,by);
        end
    end
end

function updateMothership(ship, enemy)
    ship.data.respawnTimer = ship.data.respawnTimer + 1;

    local hornets = countLivingAndDead(ship.data.troops).living;
    if ship.data.respawnTimer >= 1000 then
        local x,y = ship:getPosition();
        local ex,ey = enemy:getPosition();

        function addHunters(fn)
            mobs = generateMobs(irandom(1,3), "Chasseur", ship:getFaction(), x, y, 1000, fn);
            for i,mob in pairs(mobs) do
                table.insert(ship.data.troops, mob);
            end
        end

        if hornets < 6 then
            addHunters(function(mob) mob:orderDefendTarget(ship) end);
            ship.data.respawnTimer = 0;
        else if hornets < 12 then
            addHunters(function(mob) mob:orderFlyTowards(ex,ey) end);
            ship.data.respawnTimer = 0;
        else if hornets < 18 then
            addHunters(function(mob) mob:orderAttack(enemy) end);
            ship.data.respawnTimer = 0;
        else
            ship.data.respawnTimer = 0;
        end end end
    end
end

function mkConquestMothership(faction, callSign, x, y)
    local mothership = PlayerSpaceship():setTemplate("Mothership"):setFaction(faction):setCallSign(callSign):setPosition(x, y);
    mothership.data = { troops = {}
                      , respawnTimer = 750
                      }
    return mothership;
end

function mkPlayer(faction, x, y)
    return PlayerSpaceship():setTemplate("Chasseur"):setFaction(faction):setCallSign(srandom(irandom(2,3)) .. irandom(10,999)):setPosition(x, y)
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
        local mob = CpuShip():setFaction(faction):setTemplate(template):setCallSign(srandom(irandom(2,3)) .. irandom(10,999)):setPosition(irandom(math.floor(centerX - radius), math.floor(centerX + radius)), irandom(math.floor(centerY - radius), math.floor(centerY + radius)
))
        fn(mob);
        table.insert(mobs, mob);
    end
    
    return mobs;
end

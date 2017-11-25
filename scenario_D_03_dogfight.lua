--Name: Combat de chasseur
function init()
    drawMap();
    localMothership = mkConquestMothership("Loyalistes","local",-63000,-50000);
    baronMothership = mkConquestMothership("Rebels","baron",0,-66000);
    motherships = {localMothership, baronMothership};
    localPlayers = {};
    baronPlayers = {};

    for i=1,6,1 do
        table.insert(localPlayers, mkPlayer("Loyalistes", -63000, -50000));
    end
    for i=1,6,1 do
        table.insert(baronPlayers, mkPlayer("Rebels", 0, -66000));
    end

    generateMobs(2, "Atlantis X23", "Loyalistes", -63000,-50000, 1000, function(mob) mob:orderDefendTarget(localMothership) end);
    generateMobs(2, "Atlantis X23", "Rebels", 0, -66000, 1000, function(mob) mob:orderDefendTarget(baronMothership) end);

    script = Script()
end

function update()
    updateMothership(localMothership, baronMothership);
    updateMothership(baronMothership, localMothership);
    
    local lx,ly = localMothership:getPosition();
    for i,ship in pairs(localPlayers) do
        if not ship:isValid() then
            localPlayers[i] = mkPlayer("Loyalistes", lx,ly);
        end
    end

    local bx,by = baronMothership:getPosition();
    for i,ship in pairs(baronPlayers) do
        if not ship:isValid() then
            baronPlayers[i] = mkPlayer("Rebels", bx,by);
        end
    end
end

function updateMothership(ship, enemy)
    if not ship:isValid() then
        victory(enemy:getFaction());
    end

    ship.data.respawnTimer = ship.data.respawnTimer + 1;

    local hunters = countLivingAndDead(ship.data.troops).living;
    if ship.data.respawnTimer >= 60 * 15 then
        local x,y = ship:getPosition();
        local ex,ey = enemy:getPosition();

        function addHunters(fn)
            mobs = generateMobs(irandom(1,3), "Chasseur", ship:getFaction(), x, y, 1000, fn);
            for i,mob in pairs(mobs) do
                mob:setScannedByFaction(ship:getFaction(), true);
                table.insert(ship.data.troops, mob);
            end
        end

        if hunters < 6 then
            addHunters(function(mob) mob:orderDefendTarget(ship) end);
            ship.data.respawnTimer = 0;
        else if hunters < 18 then
            addHunters(function(mob) mob:orderAttack(enemy) end);
            ship.data.respawnTimer = 0;
        else
            ship.data.respawnTimer = 0;
        end end
    end
end

function mkConquestMothership(faction, callSign, x, y)
    local mothership = PlayerSpaceship():setTemplate("Mothership"):setFaction(faction):setCallSign(callSign):setPosition(x, y):setScanned(false):setScannedByFaction(faction,true);
    mothership.data = { troops = {}
                      , respawnTimer = 750
                      }
    return mothership;
end

function mkPlayer(faction, x, y)
    return PlayerSpaceship():setTemplate("Chasseur"):setFaction(faction):setCallSign(srandom(irandom(2,3)) .. irandom(10,999)):setPosition(x, y):setScanned(false):setScannedByFaction(faction,true);
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

function drawMap()
    Nebula():setPosition(-56153, -69401)
    Nebula():setPosition(-65137, -59245)
    Nebula():setPosition(-56283, -57943)
    Nebula():setPosition(-29720, -14323)
    Nebula():setPosition(-26335, -22526)
    Nebula():setPosition(-15528, -21875)
    Nebula():setPosition(-5762, -26172)
    Nebula():setPosition(14030, -67969)
    Nebula():setPosition(-5762, -59505)
    Nebula():setPosition(17936, -53255)
    Nebula():setPosition(10644, -60417)
    Asteroid():setPosition(-34668, -51562)
    Asteroid():setPosition(-34668, -48047)
    Asteroid():setPosition(-37663, -46745)
    Asteroid():setPosition(-37403, -46745)
    Asteroid():setPosition(-28809, -42839)
    Asteroid():setPosition(-30372, -48568)
    Asteroid():setPosition(-36622, -47786)
    Asteroid():setPosition(-36882, -45443)
    Asteroid():setPosition(-30632, -50130)
    Asteroid():setPosition(-31023, -50651)
    Asteroid():setPosition(-57455, -45964)
    Asteroid():setPosition(-69825, -52214)
    Asteroid():setPosition(-65267, -44141)
    Asteroid():setPosition(-62793, -50521)
    Asteroid():setPosition(-66439, -48958)
    Asteroid():setPosition(-63575, -38542)
    Asteroid():setPosition(-76465, -47266)
    Asteroid():setPosition(-66439, -30469)
    Asteroid():setPosition(-63444, -44010)
    Asteroid():setPosition(-65528, -46224)
    Asteroid():setPosition(-66700, -44792)
    Asteroid():setPosition(-75293, -45573)
    Asteroid():setPosition(-77377, -39453)
    Asteroid():setPosition(-60059, -39323)
    Asteroid():setPosition(1139, -73698)
    Asteroid():setPosition(-4200, -75911)
    Asteroid():setPosition(1920, -76302)
    Asteroid():setPosition(2181, -72396)
    Asteroid():setPosition(-1856, -66667)
    Asteroid():setPosition(5306, -74870)
    Asteroid():setPosition(8691, -74219)
    Asteroid():setPosition(16373, -74219)
    Asteroid():setPosition(20019, -76562)
    Asteroid():setPosition(12597, -65234)
    Asteroid():setPosition(6217, -64062)
    Asteroid():setPosition(4785, -82422)
    Asteroid():setPosition(-9929, -83854)
    Asteroid():setPosition(10774, -77995)
    Asteroid():setPosition(8431, -77995)
    Asteroid():setPosition(-6543, -73437)
    Asteroid():setPosition(4134, -48828)
    Asteroid():setPosition(-33, -42057)
    Asteroid():setPosition(5306, -30729)
    Asteroid():setPosition(2441, -29036)
    Asteroid():setPosition(-1986, -32161)
    Asteroid():setPosition(5826, -36719)
    Asteroid():setPosition(7910, -41276)
    Asteroid():setPosition(13378, -49609)
    Asteroid():setPosition(-51726, -71094)
    Asteroid():setPosition(-66569, -77734)
    Asteroid():setPosition(-73991, -71094)
    Asteroid():setPosition(-53809, -77995)
    Asteroid():setPosition(-74642, -91667)
    Asteroid():setPosition(-62403, -75391)
    Asteroid():setPosition(-68262, -75391)
    Asteroid():setPosition(-65398, -77083)
    Asteroid():setPosition(-63705, -77604)
    Asteroid():setPosition(-67220, -85026)
    Asteroid():setPosition(-37403, -78516)
    Asteroid():setPosition(-42220, -76042)
    Asteroid():setPosition(-54851, -64844)
    Asteroid():setPosition(-35970, -25260)
    Asteroid():setPosition(-46257, -16016)
    Asteroid():setPosition(-50684, -16667)
    Asteroid():setPosition(-36231, -15104)
    Asteroid():setPosition(-33236, -15104)
    Asteroid():setPosition(-46778, -18099)
    Asteroid():setPosition(-24642, -18229)
    Asteroid():setPosition(-7064, -13672)
    Asteroid():setPosition(7649, -16927)
    Asteroid():setPosition(4785, -21224)
    BlackHole():setPosition(-18132, -80339)
    Mine():setPosition(-79257, -80879)
    Mine():setPosition(-25761, -62832)
    Mine():setPosition(-57343, -54711)
    Mine():setPosition(-19960, -74949)
    Mine():setPosition(9431, -48910)
    Mine():setPosition(-70878, -44270)
    Mine():setPosition(10591, -79332)
    Mine():setPosition(30056, -46461)
    Mine():setPosition(31216, -99055)
    Mine():setPosition(-84542, -13203)
    Mine():setPosition(-54764, -32410)
    Mine():setPosition(-47159, -33957)
    Mine():setPosition(-9389, -43754)
end

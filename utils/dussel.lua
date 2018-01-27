function cleanShips()
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
    
function allDead(...)
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
    
function convertStationComms(price)
    return function()
        setCommsMessage("Obtenir la loyauté de la station pour sa faction (".. price .." crédits)")
        addCommsReply("Rebellez vous!", function()
            if not comms_source:takeReputationPoints(price) then setCommsMessage("On ne s'allie pas à des pauvres"); return end
            setCommsMessage("Vos arguments sont convaincants")
            comms_target:setFaction(comms_source:getFaction())
            comms_target:setCommsFunction(rebelSellingComms);
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

function deepCopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepCopy(orig_key)] = deepCopy(orig_value)
        end
        setmetatable(copy, deepCopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function randomFromObject(obj)
    local keyset = {}
    for k in pairs(obj) do
        table.insert(keyset, k)
    end
    -- now you can reliably return a random key
    return obj[keyset[math.random(#keyset)]]
end

function kokoro(x, y)
 
Asteroid():setPosition(-9259 + x, -10451 + y)
Mine():setPosition(-9259 + x, -7066 + y)
Mine():setPosition(-8087 + x, -7717 + y)
Mine():setPosition(-6524 + x, -7587 + y)
Asteroid():setPosition(-5743 + x, -10321 + y)
Asteroid():setPosition(-13035 + x, -10451 + y)
Asteroid():setPosition(-11993 + x, -10191 + y)
Asteroid():setPosition(-10821 + x, -10581 + y)
Asteroid():setPosition(-12644 + x, -8889 + y)
Asteroid():setPosition(-13426 + x, -9019 + y)
Asteroid():setPosition(-12905 + x, -6936 + y)
Asteroid():setPosition(-13165 + x, -7326 + y)
Asteroid():setPosition(-13426 + x, -7196 + y)
Asteroid():setPosition(-13165 + x, -7326 + y)
Mine():setPosition(-9649 + x, -3160 + y)
Asteroid():setPosition(-7696 + x, -2639 + y)
Asteroid():setPosition(-13426 + x, -3941 + y)
Asteroid():setPosition(-13035 + x, -3290 + y)
Asteroid():setPosition(-13426 + x, -2118 + y)
Asteroid():setPosition(-12254 + x, -686 + y)
Asteroid():setPosition(-7176 + x, -946 + y)
Mine():setPosition(-8738 + x, -425 + y)
Asteroid():setPosition(-9519 + x, 1658 + y)
Mine():setPosition(-7696 + x, 1268 + y)
Asteroid():setPosition(-6004 + x, 356 + y)
Asteroid():setPosition(-14207 + x, -6545 + y)
Asteroid():setPosition(-14077 + x, -4331 + y)
Asteroid():setPosition(-13035 + x, -4722 + y)
Asteroid():setPosition(-13426 + x, -5113 + y)
Asteroid():setPosition(-7306 + x, -6154 + y)
Asteroid():setPosition(-6524 + x, -6284 + y)
Asteroid():setPosition(-5873 + x, -6284 + y)
Asteroid():setPosition(-8217 + x, -5503 + y)
Mine():setPosition(-9910 + x, -5113 + y)
Asteroid():setPosition(-8608 + x, -4592 + y)
Asteroid():setPosition(-4832 + x, 2179 + y)
Mine():setPosition(-5353 + x, 3351 + y)
Asteroid():setPosition(-4441 + x, 2700 + y)
Mine():setPosition(-6004 + x, 2830 + y)
Asteroid():setPosition(-7176 + x, 3481 + y)
Asteroid():setPosition(-4441 + x, 5695 + y)
Mine():setPosition(-4702 + x, 4393 + y)
Asteroid():setPosition(-2228 + x, 5434 + y)
Asteroid():setPosition(-2748 + x, 4653 + y)
Mine():setPosition(3371 + x, 6997 + y)
Asteroid():setPosition(3111 + x, 5564 + y)
Asteroid():setPosition(3762 + x, 4783 + y)
Asteroid():setPosition(1418 + x, 6867 + y)
Asteroid():setPosition(1939 + x, 6476 + y)
Asteroid():setPosition(1158 + x, 7648 + y)
Mine():setPosition(-3009 + x, 7908 + y)
Mine():setPosition(-1707 + x, 7257 + y)
Asteroid():setPosition(-274 + x, 7257 + y)
Asteroid():setPosition(-2748 + x, 6997 + y)
Mine():setPosition(-2488 + x, 6085 + y)
Mine():setPosition(2460 + x, 7908 + y)
Asteroid():setPosition(2720 + x, 8038 + y)
BlackHole():setPosition(246 + x, 226 + y)
Asteroid():setPosition(4934 + x, 3090 + y)
Asteroid():setPosition(4283 + x, 4002 + y)
Asteroid():setPosition(4153 + x, 6606 + y)
Asteroid():setPosition(3111 + x, -4852 + y)
Asteroid():setPosition(-2228 + x, -4722 + y)
Mine():setPosition(2720 + x, -5894 + y)
Asteroid():setPosition(3241 + x, -5633 + y)
Asteroid():setPosition(5064 + x, -6024 + y)
Asteroid():setPosition(4022 + x, -5503 + y)
Asteroid():setPosition(4543 + x, -5894 + y)
Mine():setPosition(3632 + x, -5764 + y)
Asteroid():setPosition(1028 + x, -7066 + y)
Asteroid():setPosition(507 + x, -6675 + y)
Mine():setPosition(1679 + x, -5503 + y)
Mine():setPosition(2851 + x, -6545 + y)
Asteroid():setPosition(3502 + x, -8758 + y)
Asteroid():setPosition(-1707 + x, -7847 + y)
Asteroid():setPosition(-1056 + x, -7196 + y)
Asteroid():setPosition(-1967 + x, -6415 + y)
Mine():setPosition(-2358 + x, -6284 + y)
Mine():setPosition(-1056 + x, -5894 + y)
Asteroid():setPosition(-2748 + x, -5113 + y)
Mine():setPosition(-4051 + x, -6936 + y)
Asteroid():setPosition(-4571 + x, -6284 + y)
Asteroid():setPosition(-3920 + x, -5894 + y)
Asteroid():setPosition(-3139 + x, -8758 + y)
Asteroid():setPosition(-4441 + x, -9800 + y)
Asteroid():setPosition(7668 + x, -14357 + y)
Asteroid():setPosition(4804 + x, -15790 + y)
Asteroid():setPosition(7668 + x, -10061 + y)
Asteroid():setPosition(9361 + x, -9670 + y)
Asteroid():setPosition(5455 + x, -9670 + y)
Mine():setPosition(7278 + x, -7977 + y)
Mine():setPosition(6236 + x, -7977 + y)
Asteroid():setPosition(5585 + x, -6415 + y)
Mine():setPosition(8970 + x, -7587 + y)
Asteroid():setPosition(11314 + x, -8107 + y)
Asteroid():setPosition(12746 + x, -6284 + y)
Mine():setPosition(10272 + x, -6545 + y)
Mine():setPosition(11054 + x, -3290 + y)
Mine():setPosition(11054 + x, -2248 + y)
Mine():setPosition(10793 + x, -5373 + y)
Mine():setPosition(9491 + x, -165 + y)
Asteroid():setPosition(10923 + x, 356 + y)
Mine():setPosition(9882 + x, -946 + y)
Asteroid():setPosition(12616 + x, -2248 + y)
Asteroid():setPosition(13267 + x, -4071 + y)
Asteroid():setPosition(7798 + x, -2118 + y)
Asteroid():setPosition(8189 + x, -3160 + y)
Asteroid():setPosition(7278 + x, -946 + y)
Asteroid():setPosition(8319 + x, -3941 + y)
Asteroid():setPosition(6627 + x, -5764 + y)
Asteroid():setPosition(7278 + x, -4852 + y)
Mine():setPosition(8319 + x, 1528 + y)
Asteroid():setPosition(6496 + x, 356 + y)
Asteroid():setPosition(5455 + x, 2439 + y)
Asteroid():setPosition(5845 + x, 1788 + y)
Mine():setPosition(7538 + x, 2570 + y)
Asteroid():setPosition(6627 + x, 5044 + y)
Mine():setPosition(6366 + x, 4002 + y)
Asteroid():setPosition(8189 + x, 3221 + y)
Mine():setPosition(-1056 + x, 8950 + y)
Mine():setPosition(-274 + x, 8950 + y)
Asteroid():setPosition(637 + x, 10122 + y)
Asteroid():setPosition(637 + x, 10122 + y)
Asteroid():setPosition(-665 + x, 9471 + y)
Asteroid():setPosition(-274 + x, 9861 + y)
Mine():setPosition(-2097 + x, -12795 + y)
Mine():setPosition(5064 + x, -7456 + y)
Asteroid():setPosition(1548 + x, 9210 + y)
Mine():setPosition(1939 + x, 8429 + y)
Mine():setPosition(5455 + x, 4783 + y)
end

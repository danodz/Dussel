-- Name: VAF-Jerrold_01
-- Description: Premier scenario VAF-Jerrold. Les marchands doivent porter une marchandise sans être découverts...
-- Type: Basic

require("utils.lua")
require("util_random_transports.lua")

players = {};
availableItems = {};
merillonShips = {};
patrolling = {};
packageDropped = false;
spotted = false;

--Warning : Calling the save function will crash the script
-- Run it in a standalone script
function save()
    toWrite = "";
    for i,player in pairs(players) do
        toWrite = toWrite .. "Inventory : " .. getInventoryStr(player);
        toWrite = toWrite .. "Homing : " .. player:getWeaponStorage("Homing");
        toWrite = toWrite .. "\nHVLI : " .. player:getWeaponStorage("HVLI");
        toWrite = toWrite .. "\nMine : " .. player:getWeaponStorage("Mine");
        toWrite = toWrite .. "\nNuke : " .. player:getWeaponStorage("Nuke");
        toWrite = toWrite .. "\nEMP : " .. player:getWeaponStorage("EMP");
    end
    print(toWrite);
    error(toWrite);
end

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


function makeInventory(override)
    local inv = {};
    for name,value in pairs(availableItems) do
        if override[name] then
            inv[name] = deepCopy(override[name]);
        else
            inv[name] = deepCopy(value);
        end
    end
    return inv
end

function getInventoryStr(player)
    local inv = "Kredits : " .. player.kredits .. "\n";
    for name,item in pairs(player.inventory) do
        if item.amount ~= 0 then
            inv = inv .. name .. " : " .. item.amount .. "\n";
        end
    end
    return inv
end

function tradeBuyComm()
    addCommsReply("Acheter", stationTradeBuyList);
end
function tradeSellComm()
    addCommsReply("Vendre", stationTradeSellList);
end

function stationTradeBuyList()
    setCommsMessage("Que voulez-vous acheter?");
    for name,item in pairs(comms_target.inventory) do
        if not (item.amount == 0) then
            addCommsReply("nous avons " .. item.amount .. " " .. name .. " pour " .. item.value .. " Kredits", stationTradeBuyItem(name, item) );
        end
    end
end

function stationTradeBuyItem(name, item)
    return function()
        if comms_source.kredits < item.value then
            setCommsMessage("Vous n'avez pas les kredits pour l'acheter");
        else
    
            if item.amount == 0 then
                setCommsMessage("Il semblerait que nous n'en avons plus.");
            else
                if isInventoryFull(comms_source) then
                    setCommsMessage("Allez faire de la place dans votre cargo");
                else
                    setCommsMessage("Merci");
                    item.amount = item.amount - 1;
    
                    if comms_source.inventory[name].amount then
                        comms_source.inventory[name].amount = comms_source.inventory[name].amount + 1;
                    else
                        comms_source.inventory[name].amount = 1;
                    end
    
                    comms_source.kredits = comms_source.kredits - item.value;
                    addCommsReply("Acheter un autre", stationTradeBuyItem(name, item));
                end
            end
        end

        addCommsReply("Acheter autre chose", stationTradeBuyList);
    end
end

function stationTradeSellList()
    setCommsMessage("Que voulez-vous vendre?");
    for name,item in pairs(comms_source.inventory) do
        if item.amount ~= 0 then
            addCommsReply("Vendre un des " .. item.amount .. " " .. name .. " pour " .. getSaleValue(comms_target, name), stationTradeSellItem(name, item));
        end
    end
end

function stationTradeSellItem(name, item)
    return function()
        if item.amount == 0 then
            setCommsMessage("Vous êtes à sec");
        else
            item.amount = item.amount - 1;
            comms_source.kredits = comms_source.kredits + getSaleValue(comms_target, name);
            comms_target.inventory[name].amount = comms_target.inventory[name].amount + 1;
    
            setCommsMessage("Merci");
            addCommsReply("Vendre un autre", stationTradeSellItem(name, item));
        end
        addCommsReply("Vendre autre chose", stationTradeSellList);
    end
end

function countInventory(player)
    local total = 0;

    for i,item in pairs(player.inventory) do
        total = total + item.amount;
    end

    return total;
end

function isInventoryFull(player)
    return countInventory(player) == player.inventorySpace;
end

function getSaleValue(buyer, name)
    if buyer.inventory[name] then
        return math.ceil( buyer.inventory[name].value / 2 );
    else
        return math.ceil( defaultValues[name] / 2 );
    end
end


function init()
    function spawnVafJerrold(x,y)
    vafJerrold = PlayerSpaceship():setFaction("Arianne"):setTemplate("C-Camelot"):setCallSign("JVAF"):setPosition(x,y);
    
    vafJerrold.inventory = makeInventory({});
    vafJerrold.kredits = 0;
    vafJerrold.inventorySpace = 20;
    
    vafJerrold:addCustomButton("relay", "displayInventory", "Afficher l'inventaire", function() 
        vafJerrold:addCustomMessage("relay", "displayInventoryMsg", getInventoryStr(vafJerrold));
    end);
    table.insert(players, vafJerrold);
end
addGMFunction("VAF-Jerrold", function() spawnVafJerrold(0,0) end);


    decors()

    -- Créer le vaisseau du joueur
    spawnVafJerrold(-70741, 10321);
    vafJerrold:setWeaponStorage("EMP", 1):setWeaponStorage("HVLI", 3)
    
    -- Station de départ
    SpaceStation():setTemplate("Small Station"):setFaction("Arianne"):setCallSign("krief logos"):setPosition(-69829, 10626)

    -- Station objectif (endroit où aller porter la cargaison)
    objectiveStation = SpaceStation():setTemplate("Large Station"):setFaction("Dussel"):setCallSign("arnemak 3"):setPosition(270715, 30108)

    -- Stations de ravitaillement
    endGameA = SpaceStation():setTemplate("Small Station"):setFaction("Arianne"):setCallSign("DS12937"):setPosition(70335, 50348)
    endGameB = SpaceStation():setTemplate("Small Station"):setFaction("Arianne"):setCallSign("DS12938"):setPosition(190765, -28083)

    -- Troupes de chasseurs Merillons
    mkPatrollingShip(26326, -12034,8072, -42310)
    mkPatrollingShip(7913, 47667,34238, 37022)
    mkPatrollingShip(81964, 8129,36187, 82951)
    mkPatrollingShip(97460, -18978,67363, 51218)
    mkPatrollingShip(142321, -13989,133890, 45929)
    mkPatrollingShip(110828, 52034,33960, 37578)
    mkPatrollingShip(151315, 34692,128045, 98260)
    mkPatrollingShip(154249, 94710,127766, 100487)
    mkPatrollingShip(184930, 97692,203758, 24495)
    mkPatrollingShip(201810, 69598,172582, 44816)
    mkPatrollingShip(189578, 11666,117745, -53166)
    mkPatrollingShip(254569, 1549,274182, 86848)
    mkPatrollingShip(311834, 13284,276425, 85141)
    mkPatrollingShip(188167, -43402,265275, -6402)
    mkPatrollingShip(83423, -55055,-51496, -58177)
    mkPatrollingShip(-16942, -26149,-22269, 47878)
    mkPatrollingShip(-61812, 72440,-37022, 35073)
    mkPatrollingShip(7871, 92222,81837, 85177)

    table.insert(merillonShips, CpuShip():setFaction("Merillon"):setTemplate("Adv. Striker"):setCallSign("SS13"):setPosition(191993, 40906):orderRoaming());
    table.insert(merillonShips, CpuShip():setFaction("Merillon"):setTemplate("Adv. Striker"):setCallSign("CV15"):setPosition(216476, -18269):orderRoaming());


    -- Ajouter pour chaque "F-Camarade" 4x Adder MK5 en formation (à 500,0 / 0,500 / -500,0 / 0,-500)
        --  :orderFlyFormation(P<SpaceObject> object, sf::Vector2f offset)

    mkFormation(28686, 13603)
    mkFormation(217134, 68718)
    mkFormation(135576, -36501)
    mkFormation(100224, 92100)
    mkFormation(143091, 149998)
    mkFormation(152277, -116112)
    mkFormation(267239, -82709)
    mkFormation(285610, 112142)
    mkFormation(-114668, 97667)
    mkFormation(-75698, -76585)

    -- stations merillon (surtout pour random transport et pour la narration)
    -- p-e mettre que ceux-ci produisent des troupes (voir code du Grosvernor ou des scénarios de contrôles de stations)
    SpaceStation():setTemplate("Medium Station"):setFaction("Merillon"):setCallSign("DS13206"):setPosition(88583, -14337)
    SpaceStation():setTemplate("Medium Station"):setFaction("Merillon"):setCallSign("DS13207"):setPosition(206707, -18646)
    SpaceStation():setTemplate("Medium Station"):setFaction("Merillon"):setCallSign("DS13208"):setPosition(316213, 80720)

    -- supplydrop pour aider les joueurs, mais aussi les mettre à découvert
    SupplyDrop():setFaction("Arianne"):setPosition(110075, -10161):setEnergy(500):setWeaponStorage("Homing", 4):setWeaponStorage("Nuke", 1):setWeaponStorage("Mine", 2):setWeaponStorage("EMP", 1)
    SupplyDrop():setFaction("Arianne"):setPosition(212736, 19497):setEnergy(500):setWeaponStorage("Homing", 4):setWeaponStorage("Nuke", 1):setWeaponStorage("Mine", 2):setWeaponStorage("EMP", 1)

    -- warpjammer pour le décors    
    WarpJammer():setFaction("Merillon"):setPosition(218820, 14934)
    WarpJammer():setFaction("Merillon"):setPosition(51791, 6177)
    WarpJammer():setFaction("Dussel"):setPosition(264435, 29955)
    WarpJammer():setFaction("Dussel"):setPosition(271227, 24246)
    WarpJammer():setFaction("Dussel"):setPosition(277953, 31101)
    WarpJammer():setFaction("Dussel"):setPosition(270152, 37440)
end

function update()
    local notSpotted = false;
    for i,ship in pairs(merillonShips) do
        if ship:getTarget() == vafJerrold then
            notSpotted = true;
            if not spotted then
                ship:sendCommsMessage(vafJerrold, "Que faites vous dans ce secteur ?? Intrus !\nNous devons vérifier votre cargo.")
                spotted = true;
            end
        end
    end
    spotted = notSpotted;

    for i,ship in pairs(patrolling) do
        local x,y = ship:getPosition();
        local targetX = ship.patrolStatus.positions[ship.patrolStatus.targetIndex].x;
        local targetY = ship.patrolStatus.positions[ship.patrolStatus.targetIndex].y;
        if distance(ship, targetX, targetY) <= 1000 then
            if ship.patrolStatus.positions[ship.patrolStatus.targetIndex + 1] then
                ship.patrolStatus.targetIndex = ship.patrolStatus.targetIndex + 1;
            else
                ship.patrolStatus.targetIndex = 1;
            end
            local targetX = ship.patrolStatus.positions[ship.patrolStatus.targetIndex].x;
            local targetY = ship.patrolStatus.positions[ship.patrolStatus.targetIndex].y;
            ship:orderFlyTowards(targetX, targetY);
        end
    end

    if vafJerrold:isDocked(objectiveStation) and not packageDropped then
        -- Vaisseaux du vindh à faire apparaître en embuscade une fois que le joueur a porté la marchandise
        -- Voir s'il faut changer les order "roaming" au profit d'un "attack target" en ciblant le joueur.
        V1 = CpuShip():setFaction("Vindh"):setTemplate("F-Camarade"):setCallSign("BR28"):setPosition(266244, 23956):orderAttack(vafJerrold):setWeaponStorage("EMP", 0)
        CpuShip():setFaction("Vindh"):setTemplate("C-Ouvrier"):setCallSign("VK38"):setPosition(267336, 24442):orderDefendTarget(V1):setWeaponStorage("Homing", 1)
        CpuShip():setFaction("Vindh"):setTemplate("C-Ouvrier"):setCallSign("BR39"):setPosition(265335, 24018):orderDefendTarget(V1):setWeaponStorage("Homing", 1)
    
        V2 = CpuShip():setFaction("Vindh"):setTemplate("F-Camarade"):setCallSign("VS29"):setPosition(278499, 24019):orderAttack(vafJerrold):setWeaponStorage("EMP", 0)
        CpuShip():setFaction("Vindh"):setTemplate("C-Ouvrier"):setCallSign("NC36"):setPosition(279226, 25476):orderDefendTarget(V2):setWeaponStorage("Homing", 1)
        CpuShip():setFaction("Vindh"):setTemplate("C-Ouvrier"):setCallSign("VK37"):setPosition(277951, 22807):orderDefendTarget(V2):setWeaponStorage("Homing", 1)
        
        V3 = CpuShip():setFaction("Vindh"):setTemplate("F-Camarade"):setCallSign("CSS30"):setPosition(277466, 37969):orderAttack(vafJerrold):setWeaponStorage("EMP", 0)
        CpuShip():setFaction("Vindh"):setTemplate("C-Ouvrier"):setCallSign("CSS34"):setPosition(276615, 38942):orderDefendTarget(V3):setWeaponStorage("Homing", 1)
        CpuShip():setFaction("Vindh"):setTemplate("C-Ouvrier"):setCallSign("SS35"):setPosition(278497, 37546):orderDefendTarget(V3):setWeaponStorage("Homing", 1)
        
        V4 = CpuShip():setFaction("Vindh"):setTemplate("F-Camarade"):setCallSign("VK31"):setPosition(263030, 36575):orderAttack(vafJerrold):setWeaponStorage("EMP", 0)
        CpuShip():setFaction("Vindh"):setTemplate("C-Ouvrier"):setCallSign("CV32"):setPosition(262665, 35605):orderDefendTarget(V4):setWeaponStorage("Homing", 1)
        CpuShip():setFaction("Vindh"):setTemplate("C-Ouvrier"):setCallSign("CV33"):setPosition(263878, 37912):orderDefendTarget(V4):setWeaponStorage("Homing", 1)
        
        endGameA:sendCommsMessage(vafJerrold, "Viens te réfugier chez nous dans le secteur ".. endGameA:getSectorName() .."ou chez notre homologue qui se trouve au secteur " .. endGameB:getSectorName());
        packageDropped = true;
    end
    if packageDropped and (vafJerrold:isDocked(endGameA) or vafJerrold:isDocked(endGameB)) then
        victory("Arianne");
    end

end

function mkPatrollingShip(x1,y1,x2,y2)
    local ship = CpuShip():setFaction("Merillon"):setTemplate("Adv. Striker"):setCallSign("NC22"):setPosition(x1, y1)
    table.insert(merillonShips, ship);
    patrol(ship, {{x = x1, y = y1},{x = x2, y = y2}});
end

function mkFormation(x,y)
    local ship = CpuShip():setFaction("Merillon"):setTemplate("F-Camarade"):setCallSign("S39"):setPosition(x, y):orderStandGround():setWeaponStorage("EMP", 1):setWeaponStorage("Nuke", 0)
    CpuShip():setFaction("Merillon"):setTemplate("Adder MK5"):setCallSign("SS32"):setPosition(x+500, y):setWeaponStorage("HVLI", 3):orderDefendLocation(x,y);
    CpuShip():setFaction("Merillon"):setTemplate("Adder MK5"):setCallSign("SS32"):setPosition(x-500, y):setWeaponStorage("HVLI", 3):orderDefendLocation(x,y);
    CpuShip():setFaction("Merillon"):setTemplate("Adder MK5"):setCallSign("SS32"):setPosition(x, y+500):setWeaponStorage("HVLI", 3):orderDefendLocation(x,y);
    CpuShip():setFaction("Merillon"):setTemplate("Adder MK5"):setCallSign("SS32"):setPosition(x, y-500):setWeaponStorage("HVLI", 3):orderDefendLocation(x,y);
    table.insert(merillonShips, ship);
end

function patrol(ship, positions)
    table.insert( patrolling, ship);
    ship.patrolStatus = { positions = positions
                        , targetIndex = 1
                        };
    local targetX = ship.patrolStatus.positions[ship.patrolStatus.targetIndex].x;
    local targetY = ship.patrolStatus.positions[ship.patrolStatus.targetIndex].y;
    ship:orderFlyTowards(targetX, targetY);
end

function decors ()
    Nebula():setPosition(-69277, 6411)
    Nebula():setPosition(-63504, -16192)
    Nebula():setPosition(-46047, 11132)
    Nebula():setPosition(-55408, 32891)
    Nebula():setPosition(-6325, 5566)
    Nebula():setPosition(-15939, 28084)
    Nebula():setPosition(-36939, 35674)
    Nebula():setPosition(-22264, 46806)
    Nebula():setPosition(23529, 61986)
    Nebula():setPosition(32638, 37445)
    Nebula():setPosition(54396, 4301)
    Nebula():setPosition(54143, 50601)
    Nebula():setPosition(70841, 61227)
    Nebula():setPosition(66793, 51613)
    Nebula():setPosition(186464, -26312)
    Nebula():setPosition(161164, -31626)
    Nebula():setPosition(117900, -17457)
    Nebula():setPosition(140164, 7590)
    Nebula():setPosition(86022, 20240)
    Nebula():setPosition(65275, 24794)
    Nebula():setPosition(132574, 47059)
    Nebula():setPosition(143201, 59203)
    Nebula():setPosition(173055, 43264)
    Nebula():setPosition(201392, 23782)
    Nebula():setPosition(217584, 11132)
    Nebula():setPosition(237318, -6831)
    Nebula():setPosition(263631, -5819)
    Nebula():setPosition(206705, 1771)
    Nebula():setPosition(228210, -1771)
    Nebula():setPosition(238077, 11132)
    Nebula():setPosition(233523, 27072)
    Nebula():setPosition(230234, 53384)
    Nebula():setPosition(256294, 55408)
    Nebula():setPosition(300063, 18722)
    Nebula():setPosition(283112, 37951)
    Nebula():setPosition(260342, 27325)
    Nebula():setPosition(59456, -6072)
    Nebula():setPosition(12903, -18975)
    Nebula():setPosition(-135104, -14927)
    Nebula():setPosition(-51613, -62239)
    Nebula():setPosition(9614, -75142)
    Nebula():setPosition(6072, -44276)
    Nebula():setPosition(62745, -64516)
    Nebula():setPosition(112587, -95130)
    Nebula():setPosition(57179, -108792)
    Nebula():setPosition(120430, -68817)
    Nebula():setPosition(118153, -55155)
    Nebula():setPosition(180645, -79949)
    Nebula():setPosition(210247, -44782)
    Nebula():setPosition(229981, -53637)
    Nebula():setPosition(232258, -37192)
    Nebula():setPosition(259836, -38457)
    Nebula():setPosition(312208, -26312)
    Nebula():setPosition(319292, -2530)
    Nebula():setPosition(332635, 32425)
    Nebula():setPosition(323003, 65631)
    Nebula():setPosition(274080, 85403)
    Nebula():setPosition(208427, 97824)
    Nebula():setPosition(184092, 68166)
    Nebula():setPosition(125537, 99852)
    Nebula():setPosition(79403, 84896)
    Nebula():setPosition(34790, 105175)
    Nebula():setPosition(-3233, 119370)
    Nebula():setPosition(-28328, 89459)
    Nebula():setPosition(14764, 77798)
    Nebula():setPosition(-68632, 97570)
    Nebula():setPosition(-83081, 68673)
    Nebula():setPosition(-130483, 76531)
    Nebula():setPosition(-166224, 65378)
    Nebula():setPosition(-131497, 41550)
    Nebula():setPosition(-120343, 61068)
    Nebula():setPosition(-101839, 90726)
    Nebula():setPosition(-105388, 111259)
    Nebula():setPosition(-25286, 137621)
    Nebula():setPosition(-27821, 159928)
    Nebula():setPosition(45183, 130777)
    Nebula():setPosition(-183968, 22539)
    Nebula():setPosition(-132764, -38551)
    Nebula():setPosition(-93474, -49198)
    Nebula():setPosition(-87897, -30693)
    Nebula():setPosition(-33651, -110034)
    Nebula():setPosition(-15401, -66688)
    BlackHole():setPosition(166856, 64871)
        Asteroid():setPosition(40444, -47301)
    Asteroid():setPosition(51091, -42485)
    Asteroid():setPosition(45260, -36655)
    Asteroid():setPosition(56160, -32092)
    Asteroid():setPosition(51344, -23727)
    Asteroid():setPosition(59963, -18911)
    Asteroid():setPosition(59202, -12827)
    Asteroid():setPosition(54893, -25248)
    Asteroid():setPosition(50837, -30571)
    Asteroid():setPosition(45260, -36401)
    Asteroid():setPosition(70609, -3195)
    Asteroid():setPosition(59709, 2889)
    Asteroid():setPosition(66300, 4664)
    Asteroid():setPosition(64018, 15817)
    Asteroid():setPosition(73397, 17338)
    Asteroid():setPosition(70355, 24689)
    Asteroid():setPosition(75172, 26717)
    Asteroid():setPosition(69342, 34321)
    Asteroid():setPosition(75172, 36096)
    Asteroid():setPosition(69848, 47249)
    Asteroid():setPosition(81255, 50291)
    Asteroid():setPosition(78467, 60430)
    Asteroid():setPosition(72890, 61698)
    Asteroid():setPosition(73651, 69556)
    Asteroid():setPosition(82523, 70063)
    Asteroid():setPosition(75932, 45982)
    Asteroid():setPosition(73144, 54600)
    Asteroid():setPosition(85058, 83244)
    Asteroid():setPosition(94437, 82737)
    Asteroid():setPosition(88353, 88821)
    Asteroid():setPosition(94183, 96932)
    Asteroid():setPosition(205717, 608)
    Asteroid():setPosition(222447, 2636)
    Asteroid():setPosition(223207, 8719)
    Asteroid():setPosition(232840, 4157)
    Asteroid():setPosition(240191, 9480)
    Asteroid():setPosition(243486, 13789)
    Asteroid():setPosition(251344, 13029)
    Asteroid():setPosition(257428, 9480)
    Asteroid():setPosition(243232, 6945)
    Asteroid():setPosition(225489, 5424)
    Asteroid():setPosition(215096, -913)
    Asteroid():setPosition(211800, -3702)
    Asteroid():setPosition(202675, -8011)
    Asteroid():setPosition(190001, -8771)
    Asteroid():setPosition(178847, -10799)
    Asteroid():setPosition(172510, -16376)
    Asteroid():setPosition(168961, -18150)
    Asteroid():setPosition(171750, -6743)
    Asteroid():setPosition(191015, -5729)
    Asteroid():setPosition(199126, 2636)
    Asteroid():setPosition(206477, -1927)
    Asteroid():setPosition(192282, -17136)
    Asteroid():setPosition(187719, -13334)
    Asteroid():setPosition(185945, -2181)
    Asteroid():setPosition(203942, -1420)
    Asteroid():setPosition(109139, -70368)
    Asteroid():setPosition(127643, -62764)
    Asteroid():setPosition(136008, -60989)
    Asteroid():setPosition(139810, -50850)
    Asteroid():setPosition(125108, -61496)
    Asteroid():setPosition(116490, -67833)
    Asteroid():setPosition(112688, -62003)
    Asteroid():setPosition(139303, -59468)
    Asteroid():setPosition(152992, -51103)
    Asteroid():setPosition(166680, -48315)
    Asteroid():setPosition(165412, 104283)
    Asteroid():setPosition(173017, 91356)
    Asteroid():setPosition(175045, 77160)
    Asteroid():setPosition(190001, 83497)
    Asteroid():setPosition(194056, 87046)
    Asteroid():setPosition(215349, 91609)
    Asteroid():setPosition(205210, 102255)
    Asteroid():setPosition(196845, 98960)
    Asteroid():setPosition(207745, 93890)
    Asteroid():setPosition(211800, 86793)
    Asteroid():setPosition(221940, 82230)
    Asteroid():setPosition(227009, 79188)
    Asteroid():setPosition(314462, 18859)
    Asteroid():setPosition(294944, 17084)
    Asteroid():setPosition(293930, 7959)
    Asteroid():setPosition(308378, 19619)
    Asteroid():setPosition(304576, 20126)
    Asteroid():setPosition(320546, 45728)
    Asteroid():setPosition(320292, 55614)
    Asteroid():setPosition(310406, 28491)
    Asteroid():setPosition(314462, 34575)
    Asteroid():setPosition(323080, 48770)
    Asteroid():setPosition(331192, 58909)
    Asteroid():setPosition(336515, 64486)
    Asteroid():setPosition(352738, 80963)
    Asteroid():setPosition(361357, 84258)
    Asteroid():setPosition(364905, 96172)
    Asteroid():setPosition(373017, 103016)
    Asteroid():setPosition(347162, 112648)
    Asteroid():setPosition(332459, 117211)
    Asteroid():setPosition(328911, 94651)
    Asteroid():setPosition(34867, -47554)
    Asteroid():setPosition(27770, -44513)
    Asteroid():setPosition(24221, -55159)
    Asteroid():setPosition(14335, -59975)
    Asteroid():setPosition(10279, -71889)
    Asteroid():setPosition(1154, -78733)
    Asteroid():setPosition(-13041, -83803)
    Asteroid():setPosition(-28757, -96224)
    Asteroid():setPosition(-34588, -97745)
    Asteroid():setPosition(-4423, -85324)
    Asteroid():setPosition(-5437, -74931)
    Asteroid():setPosition(7744, -66566)
    Asteroid():setPosition(21686, -61243)
    Asteroid():setPosition(36135, -54652)
    Asteroid():setPosition(30812, -46541)
    Asteroid():setPosition(30051, -40710)
    Asteroid():setPosition(12307, -58708)
    Asteroid():setPosition(-13802, -80001)
    Asteroid():setPosition(-21406, -89887)
    Asteroid():setPosition(-39911, -84310)
    Mine():setPosition(23207, 63472)
    Mine():setPosition(142092, 6691)
    Mine():setPosition(187719, -26769)
    Mine():setPosition(231572, -36655)
    Mine():setPosition(259962, 26717)
    Mine():setPosition(230305, 54093)
    Mine():setPosition(272890, 84258)
    Mine():setPosition(260469, 71584)
    Mine():setPosition(207998, 42433)
    Mine():setPosition(179101, 22407)
    Mine():setPosition(129671, -21952)
    Mine():setPosition(77706, 27477)
    Mine():setPosition(123841, 71077)
    Mine():setPosition(-2395, 33307)
    Mine():setPosition(-4930, 5931)
    Mine():setPosition(1914, -48315)
    Mine():setPosition(-27997, -65552)
    Mine():setPosition(-50050, -62510)
    Mine():setPosition(233347, -50850)
    Mine():setPosition(247542, -21952)
    Mine():setPosition(260723, -12827)
    Mine():setPosition(204449, -5476)
    Mine():setPosition(185438, -11560)
    Mine():setPosition(196084, 91609)
    Mine():setPosition(119025, -14601)
    Mine():setPosition(125108, 608)
    Mine():setPosition(141838, 1368)
    Nebula():setPosition(-64245, 11001)
    Nebula():setPosition(-77427, 13029)
    Nebula():setPosition(-86299, 5171)
    Nebula():setPosition(-69315, 18352)
    Nebula():setPosition(-72864, 12522)
    Nebula():setPosition(-78441, 608)
    Nebula():setPosition(-59683, 1622)
end

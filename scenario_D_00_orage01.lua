-- Name: Orage_01
-- Description: Premier scenario Orage. On remarque des troubles au chantier de construction d'un temple Merillon...
-- Type: Basic
require("utils.lua");
players = {};
ambushIsOn = true;
messageToCaptureIsOn = true;
availableItems = {};

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


function init ()
    function spawnOrage(x,y)
    orage = PlayerSpaceship():setFaction("Merillon"):setTemplate("C-Citoyen"):setCallSign("LOM71"):setPosition(x,y);
    
    orage.inventory = makeInventory({});
    orage.kredits = 0;
    orage.inventorySpace = 20;
    
    orage:addCustomButton("relay", "displayInventory", "Afficher l'inventaire", function() 
        orage:addCustomMessage("relay", "displayInventoryMsg", getInventoryStr(orage));
    end);
    table.insert(players, orage);
end
addGMFunction("Orage", function() spawnOrage(0,0) end);


    -- appeller les fonctions du décor
    planets()
    decors()

    -- ajouter le player
    spawnOrage(60405, 98345);
    
    -- station de départ
    SpaceStation():setTemplate("Small Station"):setFaction("Merillon"):setCallSign("s.a.m.33k"):setPosition(61477, 97868)
    
    -- station du chantier
    chantier = SpaceStation():setTemplate("Medium Station"):setFaction("Merillon"):setCallSign("Chantier_01"):setPosition(120953, 781)

    -- station minière
    miningStation = SpaceStation():setTemplate("Small Station"):setFaction("Independent"):setCallSign("DS1123"):setPosition(202971, -38780)

    -- station charognard
    charogneStation = SpaceStation():setTemplate("Medium Station"):setFaction("Charognards"):setCallSign("DS11306"):setPosition(82305, -141571)

    -- supply drop pour aider les joueurs
    SupplyDrop():setFaction("Merillon"):setPosition(199691, -42051):setEnergy(500):setWeaponStorage("Homing", 4):setWeaponStorage("Nuke", 0):setWeaponStorage("Mine", 2):setWeaponStorage("EMP", 1)
    SupplyDrop():setFaction("Merillon"):setPosition(220013, -37345):setEnergy(500):setWeaponStorage("Homing", 4):setWeaponStorage("Nuke", 0):setWeaponStorage("Mine", 2):setWeaponStorage("EMP", 1)

    -- supply drop leurre (embuscade)
    SupplyDrop():setFaction("Merillon"):setPosition(134426, -86808):setEnergy(500):setWeaponStorage("Homing", 4):setWeaponStorage("Nuke", 0):setWeaponStorage("Mine", 2):setWeaponStorage("EMP", 1)
  
    -- transports (patrouillent entre DS1123 et Chantier_01)
    transports = { CpuShip():setFaction("Independent"):setTemplate("Transport1x3"):setCallSign("SS3"):setPosition(154686, -14472):orderRoaming()
                 , CpuShip():setFaction("Independent"):setTemplate("Transport1x3"):setCallSign("CV4"):setPosition(157368, -16616):orderRoaming()
                 , CpuShip():setFaction("Independent"):setTemplate("Transport1x3"):setCallSign("NC5"):setPosition(161657, -15759):orderRoaming()
                 , CpuShip():setFaction("Independent"):setTemplate("Transport2x1"):setCallSign("UTI6"):setPosition(157797, -14257):orderRoaming()
                 , CpuShip():setFaction("Independent"):setTemplate("Transport2x1"):setCallSign("CCN7"):setPosition(160370, -17689):orderRoaming()
                 , CpuShip():setFaction("Independent"):setTemplate("Transport3x1"):setCallSign("S8"):setPosition(169915, -21657):orderRoaming()
                 , CpuShip():setFaction("Independent"):setTemplate("Transport3x1"):setCallSign("BR9"):setPosition(177744, -23158):orderRoaming()
                 , CpuShip():setFaction("Independent"):setTemplate("Transport4x3"):setCallSign("NC10"):setPosition(170575, -18830):orderRoaming()
                 , CpuShip():setFaction("Independent"):setTemplate("Transport4x3"):setCallSign("VS11"):setPosition(147086, -11403):orderRoaming()
                 , CpuShip():setFaction("Independent"):setTemplate("Transport5x2"):setCallSign("UTI13"):setPosition(184579, -25765):orderRoaming()
                 , CpuShip():setFaction("Independent"):setTemplate("Transport5x2"):setCallSign("SS14"):setPosition(191794, -30204):orderRoaming()
                 , CpuShip():setFaction("Independent"):setTemplate("Transport4x2"):setCallSign("UTI15"):setPosition(188450, -26819):orderRoaming()
                 , CpuShip():setFaction("Independent"):setTemplate("Transport1x2"):setCallSign("SS16"):setPosition(166020, -18809):orderRoaming()
                 , CpuShip():setFaction("Independent"):setTemplate("Transport1x2"):setCallSign("S17"):setPosition(196024, -33373):orderRoaming()
                 };
    -- transport infiltré contenant les esclaves
    undercoverTransport = CpuShip():setFaction("Independent"):setTemplate("Transport4x3"):setCallSign("CSS12"):setPosition(132577, -6222)
    table.insert(transports, undercoverTransport);

    for i,ship in pairs(transports) do
        if irandom(1,2) == 1 then
            ship:orderDock(miningStation);
        else
            ship:orderDock(chantier);
        end
    end

    -- protection du chantier
    
    CpuShip():setFaction("Independent"):setTemplate("Adder MK5"):setCallSign("CV18"):setPosition(114850, -4108):setWeaponStorage("HVLI", 3)
    CpuShip():setFaction("Independent"):setTemplate("Adder MK5"):setCallSign("BR19"):setPosition(119172, -9048):setWeaponStorage("HVLI", 3)
    CpuShip():setFaction("Independent"):setTemplate("Adder MK5"):setCallSign("VK20"):setPosition(115673, 1450):setWeaponStorage("HVLI", 3)
    CpuShip():setFaction("Independent"):setTemplate("Adder MK5"):setCallSign("CCN21"):setPosition(119275, 5875):setWeaponStorage("HVLI", 3)
    CpuShip():setFaction("Independent"):setTemplate("Adder MK5"):setCallSign("CSS22"):setPosition(126170, 3817):setWeaponStorage("HVLI", 3)
    CpuShip():setFaction("Independent"):setTemplate("Adder MK5"):setCallSign("S23"):setPosition(126067, -506):setWeaponStorage("HVLI", 3)

    -- protection du chantier qui embusque le joueur après qu'il ait prit connaissance du trouble (embuscade!!) (deviennent charognard)
    turncoats = { CpuShip():setFaction("Independent"):setTemplate("Adder MK5"):setCallSign("CV24"):setPosition(105690, -11517):setWeaponStorage("HVLI", 3):setWeaponStorage("Homing", 2)
                , CpuShip():setFaction("Independent"):setTemplate("Adder MK5"):setCallSign("VS25"):setPosition(121745, -20265):setWeaponStorage("HVLI", 3):setWeaponStorage("Homing", 2)
                , CpuShip():setFaction("Independent"):setTemplate("Adder MK5"):setCallSign("CCN26"):setPosition(138108, -2564):setWeaponStorage("HVLI", 3):setWeaponStorage("Homing", 1)
                , CpuShip():setFaction("Independent"):setTemplate("Adder MK5"):setCallSign("CCN27"):setPosition(131316, 12564):setWeaponStorage("HVLI", 3):setWeaponStorage("Homing", 1)
                , CpuShip():setFaction("Independent"):setTemplate("Adder MK5"):setCallSign("CCN28"):setPosition(121024, 16064):setWeaponStorage("HVLI", 3):setWeaponStorage("Homing", 1)
                , CpuShip():setFaction("Independent"):setTemplate("Adder MK5"):setCallSign("VK29"):setPosition(107954, 10300):setWeaponStorage("HVLI", 3)
                };

    -- petite troupe charognard entre le point de départ et le chantier (premier défi aléatoire, non relié à une mission)
    CpuShip():setFaction("Charognards"):setTemplate("Adder MK6"):setCallSign("BR30"):setPosition(98007, 47764):orderDefendLocation(98007, 47764):setWeaponStorage("HVLI", 7)
    CpuShip():setFaction("Charognards"):setTemplate("Adder MK6"):setCallSign("S31"):setPosition(97269, 52188):orderDefendLocation(97269, 52188):setWeaponStorage("HVLI", 7)
    CpuShip():setFaction("Charognards"):setTemplate("Adder MK6"):setCallSign("CSS32"):setPosition(103316, 50860):orderDefendLocation(103316, 50860):setWeaponStorage("HVLI", 7)

    -- protection du secteur charognard
    CpuShip():setFaction("Charognards"):setTemplate("Adder MK6"):setCallSign("CCN33"):setPosition(76352, -145813):orderDefendLocation(76352, -145813):setWeaponStorage("HVLI", 7)
    CpuShip():setFaction("Charognards"):setTemplate("Adder MK6"):setCallSign("UTI34"):setPosition(86464, -146570):orderDefendLocation(86464, -146570):setWeaponStorage("HVLI", 7)
    CpuShip():setFaction("Charognards"):setTemplate("Adder MK6"):setCallSign("CV35"):setPosition(88249, -140676):orderDefendLocation(88249, -140676):setWeaponStorage("HVLI", 7)
    CpuShip():setFaction("Charognards"):setTemplate("Adder MK6"):setCallSign("SS36"):setPosition(86410, -136296):orderDefendLocation(86410, -136296):setWeaponStorage("HVLI", 7)
    CpuShip():setFaction("Charognards"):setTemplate("Adder MK6"):setCallSign("VK37"):setPosition(79921, -137648):orderDefendLocation(79921, -137648):setWeaponStorage("HVLI", 7)
    CpuShip():setFaction("Charognards"):setTemplate("Adder MK6"):setCallSign("CSS38"):setPosition(78299, -139487):orderDefendLocation(78299, -139487):setWeaponStorage("HVLI", 7)
    CpuShip():setFaction("Charognards"):setTemplate("Adder MK6"):setCallSign("UTI39"):setPosition(90953, -134620):orderDefendLocation(90953, -134620):setWeaponStorage("HVLI", 7)
    CpuShip():setFaction("Charognards"):setTemplate("Adder MK6"):setCallSign("CCN40"):setPosition(82463, -132673):orderDefendLocation(82463, -132673):setWeaponStorage("HVLI", 7)
    CpuShip():setFaction("Charognards"):setTemplate("Adder MK6"):setCallSign("VS41"):setPosition(71215, -117802):orderDefendLocation(71215, -117802):setWeaponStorage("HVLI", 7)
    CpuShip():setFaction("Charognards"):setTemplate("Adder MK6"):setCallSign("VS42"):setPosition(88141, -119208):orderDefendLocation(88141, -119208):setWeaponStorage("HVLI", 7)
    CpuShip():setFaction("Charognards"):setTemplate("Adder MK6"):setCallSign("CV43"):setPosition(68728, -108556):orderDefendLocation(68728, -108556):setWeaponStorage("HVLI", 7)
    CpuShip():setFaction("Charognards"):setTemplate("Adder MK6"):setCallSign("CCN44"):setPosition(90087, -111259):orderDefendLocation(90087, -111259):setWeaponStorage("HVLI", 7)
    CpuShip():setFaction("Charognards"):setTemplate("Adder MK6"):setCallSign("VK45"):setPosition(56290, -120128):orderDefendLocation(56290, -120128):setWeaponStorage("HVLI", 7)
    CpuShip():setFaction("Charognards"):setTemplate("Adder MK6"):setCallSign("UTI46"):setPosition(51153, -133592):orderDefendLocation(51153, -133592):setWeaponStorage("HVLI", 7)
    CpuShip():setFaction("Charognards"):setTemplate("Adder MK6"):setCallSign("UTI47"):setPosition(42555, -122777):orderDefendLocation(42555, -122777):setWeaponStorage("HVLI", 7)
    CpuShip():setFaction("Charognards"):setTemplate("Adder MK6"):setCallSign("SS48"):setPosition(40338, -125265):orderDefendLocation(40338, -125265):setWeaponStorage("HVLI", 7)
    CpuShip():setFaction("Charognards"):setTemplate("Adder MK6"):setCallSign("VS49"):setPosition(42988, -125481):orderDefendLocation(42988, -125481):setWeaponStorage("HVLI", 7)
    CpuShip():setFaction("Charognards"):setTemplate("Adder MK6"):setCallSign("NC50"):setPosition(32964, -142110):orderDefendLocation(32964, -142110):setWeaponStorage("HVLI", 7)

    -- dirigeant du groupe charognard (doit être capturé)
    charognardBoss = CpuShip():setFaction("Charognards"):setTemplate("C-Camelot"):setCallSign("Charogne4"):setPosition(81899, -142838):orderDefendLocation(81899, -142838):setWeaponStorage("EMP", 1):setWeaponStorage("HVLI", 3)


    -- warp jammer pour nuire aux les joueurs
    WarpJammer():setFaction("Charognards"):setPosition(80630, -140834)
    WarpJammer():setFaction("Charognards"):setPosition(39379, -122391)
    WarpJammer():setFaction("Charognards"):setPosition(98279, 49913)
end

function update()
    if orage:isDocked(chantier) then
        for i,ship in pairs(turncoats) do
            ship:setFaction("Charognards");
            ship:orderAttack(orage);
        end
    end

    for i,ship in pairs(transports) do
        if ship:isDocked(chantier) then
            ship:orderDock(miningStation);
        else if ship:isDocked(miningStation) then
            ship:orderDock(chantier);
        end end
    end

    if ambushIsOn and orage:getSectorName() == "A11" then
        local x,y = orage:getPosition();
        generateMobs(4, "MU52 Hornet", "Charognards", math.floor(x), math.floor(y), 5000, function(mob) mob:orderAttack(orage); end)
        generateMobs(4, "Adder MK5", "Charognards", math.floor(x), math.floor(y), 5000, function(mob) mob:orderAttack(orage); end)
        generateMobs(1, "Atlantis X23", "Charognards", math.floor(x), math.floor(y), 5000, function(mob) mob:orderAttack(orage); end)
        ambushIsOn = false;
    end

    if undercoverTransport:isScannedBy(orage) then
        undercoverTransport:setFaction("Charognards");
        undercoverTransport:orderFlyTowardsBlind(charogneStation:getPosition());
    end

    local orageSector = orage:getSectorName();
    print(orageSector);
    if messageToCaptureIsOn and (orageSector == "zx8" or orageSector == "zx9" or orageSector == "zy8" or orageSector == "zy9") then
        messageToCaptureIsOn = false;
        chantier:sendCommsMessage(orage, "Capturez le chef, ne le tuez pas. Il est dans le vaisseau Charogne4, si vous l'immobilisez (impulse et jump) les bonnes gens à bord pourront le jeter dehors.");
    end
    
    if theBossDrop then
        if not theBossDrop:isValid() then
            chantier:setCommsFunction(chantierEndGameComms);
        end
    else
        if charognardBoss:getSystemHealth("impulse") <= 0 and charognardBoss:getSystemHealth("jumpdrive") <= 0 then
            local x,y = charognardBoss:getPosition();
            charognardBoss:setFaction("Independent");
            theBossDrop = SupplyDrop():setFaction("Merillon"):setPosition(x, y):setEnergy(0):setWeaponStorage("Homing", 0):setWeaponStorage("Nuke", 0):setWeaponStorage("Mine", 0):setWeaponStorage("EMP", 0):setWeaponStorage("HVLI", 0)
        end
    end
    
end

function chantierEndGameComms()
    if comms_source:isDocked(comms_target) then
        setCommsMessage("Bravo!");
        addCommsReply("Exécuter le chef", function() end);
        addCommsReply("Rendre l'esclave citoyen", function() end);
    else
        setCommsMessage("Venez nous voir en personne");
    end
end

-- fonction d'une planète (chantier)
function planets ()
    planet1 = Planet():setPosition(121065, -1128):setCallSign("P1"):setPlanetRadius(637):setDistanceFromMovementPlane(-3000):setPlanetSurfaceTexture("planets/planet-1.png"):setPlanetCloudTexture("planets/clouds-1.png"):setPlanetAtmosphereTexture("planets/atmosphere.png"):setAxialRotationTime(-240.0):setPlanetAtmosphereColor(0.2,0.1,0.0)
    moon1 = Planet():setPosition(131049, 1783):setCallSign("Moon1"):setPlanetRadius(170):setDistanceFromMovementPlane(-2800):setPlanetSurfaceTexture("planets/moon-1.png")
    moon1:setOrbit(planet1, 200)
end

-- fonction mines, asteroides, nébuleuses
function decors ()
    Asteroid():setPosition(140318, 10700)
    Asteroid():setPosition(143967, -10575)
    Asteroid():setPosition(142985, -2282)
    Asteroid():setPosition(132697, 18664)
    Asteroid():setPosition(127381, -23405)
    Asteroid():setPosition(106030, -18874)
    Asteroid():setPosition(128662, -25057)
    Asteroid():setPosition(105945, 12851)
    Asteroid():setPosition(100753, 20)
    Asteroid():setPosition(133878, 14130)
    Asteroid():setPosition(130436, 19685)
    Asteroid():setPosition(122775, -24000)
    Asteroid():setPosition(101726, -10846)
    Asteroid():setPosition(100554, 6499)
    Asteroid():setPosition(103378, 12128)
    Asteroid():setPosition(102065, 6846)
    Asteroid():setPosition(140868, -15072)
    Asteroid():setPosition(114249, -21313)
    Asteroid():setPosition(139960, -12427)
    Asteroid():setPosition(145038, -7098)
    Asteroid():setPosition(135306, 12676)
    Asteroid():setPosition(137070, -14492)
    Asteroid():setPosition(106305, 14043)
    Asteroid():setPosition(117252, 22135)
    Asteroid():setPosition(120625, 20504)
    Asteroid():setPosition(134461, 17392)
    Asteroid():setPosition(116636, -23189)
    Asteroid():setPosition(117417, 22230)
    Asteroid():setPosition(140088, 12252)
    Asteroid():setPosition(106299, 12539)
    Asteroid():setPosition(112153, 17589)
    Asteroid():setPosition(99332, -6809)
    Asteroid():setPosition(100516, 8782)
    Asteroid():setPosition(143203, -6898)
    Asteroid():setPosition(105297, -20626)
    Asteroid():setPosition(104084, -18396)
    Asteroid():setPosition(141425, -2577)
    Asteroid():setPosition(100198, 5656)
    Asteroid():setPosition(97192, 4972)
    Asteroid():setPosition(136104, -16945)
    Asteroid():setPosition(142123, 3455)
    Asteroid():setPosition(125549, -21394)
    Asteroid():setPosition(135384, 13891)
    Asteroid():setPosition(137268, -17912)
    Asteroid():setPosition(100733, -8609)
    Asteroid():setPosition(97214, 3598)
    Asteroid():setPosition(141727, -14023)
    Asteroid():setPosition(127799, -25718)
    Asteroid():setPosition(101847, 7284)
    Asteroid():setPosition(111409, -23385)
    Asteroid():setPosition(132812, 15268)
    Asteroid():setPosition(96864, 439)
    Asteroid():setPosition(128194, -24228)
    Asteroid():setPosition(97535, 3798)
    Asteroid():setPosition(103675, -15411)
    Asteroid():setPosition(132657, 17799)
    Asteroid():setPosition(99707, 3343)
    Asteroid():setPosition(102036, 6064)
    Asteroid():setPosition(110415, 19627)
    Asteroid():setPosition(111586, -20285)
    Asteroid():setPosition(138364, -14695)
    Asteroid():setPosition(119550, -24886)
    Asteroid():setPosition(105037, -14121)
    Asteroid():setPosition(110465, -19064)
    Asteroid():setPosition(101753, -7330)
    Asteroid():setPosition(114747, -20756)
    Asteroid():setPosition(106466, -20686)
    Asteroid():setPosition(110288, 16610)
    Asteroid():setPosition(112011, -23800)
    Asteroid():setPosition(139711, 11595)
    Asteroid():setPosition(125064, 18167)
    Asteroid():setPosition(103293, -12344)
    Asteroid():setPosition(106740, -17052)
    Asteroid():setPosition(111319, -20020)
    Asteroid():setPosition(111871, -23812)
    Asteroid():setPosition(145379, -3269)
    Asteroid():setPosition(101667, 5718)
    Asteroid():setPosition(108739, 16647)
    Asteroid():setPosition(135119, 17185)
    Asteroid():setPosition(97984, -9548)
    Asteroid():setPosition(142780, -8337)
    Asteroid():setPosition(144864, -38)
    Asteroid():setPosition(103209, -13121)
    Asteroid():setPosition(116015, 19033)
    Asteroid():setPosition(102916, -10546)
    Asteroid():setPosition(101568, -9574)
    Asteroid():setPosition(140725, -10575)
    Asteroid():setPosition(107544, 14247)
    Asteroid():setPosition(112754, -22287)
    Asteroid():setPosition(142249, 1794)
    Asteroid():setPosition(114552, 18180)
    Asteroid():setPosition(142316, -540)
    Asteroid():setPosition(121902, 22493)
    Asteroid():setPosition(97380, 3507)
    Asteroid():setPosition(140930, -12355)
    Asteroid():setPosition(100324, 9644)
    Asteroid():setPosition(121606, 19853)
    Asteroid():setPosition(120923, -23871)
    Asteroid():setPosition(140596, -10305)
    Asteroid():setPosition(111266, 18939)
    Nebula():setPosition(78155, 98494)
    Nebula():setPosition(39445, 78783)
    Nebula():setPosition(40625, 86239)
    Nebula():setPosition(60209, 124783)
    Nebula():setPosition(100295, 51056)
    Nebula():setPosition(59680, 66110)
    Nebula():setPosition(61273, 121054)
    Nebula():setPosition(55953, 68449)
    Nebula():setPosition(38624, 65914)
    Nebula():setPosition(85620, 115048)
    Nebula():setPosition(62370, 88445)
    Nebula():setPosition(65486, 84553)
    Nebula():setPosition(53477, 99204)
    Nebula():setPosition(72127, 85357)
    Nebula():setPosition(96120, 98383)
    Nebula():setPosition(59600, 105884)
    Nebula():setPosition(30296, 73856)
    Nebula():setPosition(69098, 98546)
    Nebula():setPosition(38780, 126314)
    Nebula():setPosition(65562, 114719)
    Nebula():setPosition(71940, -100202)
    Nebula():setPosition(78812, -67576)
    Nebula():setPosition(42924, -122613)
    Nebula():setPosition(93239, -80457)
    Nebula():setPosition(33417, -142821)
    Nebula():setPosition(75869, -147277)
    Nebula():setPosition(52628, -134265)
    Nebula():setPosition(35362, -73250)
    Nebula():setPosition(55282, -119683)
    Nebula():setPosition(89097, -110349)
    Nebula():setPosition(79752, -126808)
    Nebula():setPosition(88028, -146316)
    Nebula():setPosition(70696, -119142)
    Nebula():setPosition(76948, -54032)
    Nebula():setPosition(71932, -108330)
    Nebula():setPosition(52691, 44223)
    Nebula():setPosition(55619, -80197)
    Nebula():setPosition(89845, -135024)
    Nebula():setPosition(77877, -137437)
    Nebula():setPosition(41575, -103258)
    Nebula():setPosition(85646, -136022)
    Nebula():setPosition(69944, -109762)
    Nebula():setPosition(42292, 44399)
    Nebula():setPosition(80180, -60574)
    Nebula():setPosition(41338, -71616)
    Nebula():setPosition(52058, 48732)
    Nebula():setPosition(81921, -89078)
    Nebula():setPosition(73161, -88500)
    Nebula():setPosition(38979, -124413)
    Nebula():setPosition(28880, -127172)
    Nebula():setPosition(48527, -76867)
    Nebula():setPosition(92833, -134303)
    Nebula():setPosition(86394, -128466)
    Nebula():setPosition(39998, 54104)
    Nebula():setPosition(27643, -125981)
    Nebula():setPosition(90822, -119510)
    Nebula():setPosition(92380, -135890)
    Nebula():setPosition(48634, 62280)
    Nebula():setPosition(62724, 42620)
    Asteroid():setPosition(186438, -46488)
    Asteroid():setPosition(191433, -51760)
    Asteroid():setPosition(196983, -43713)
    Asteroid():setPosition(190323, -38718)
    Asteroid():setPosition(191433, -34278)
    Asteroid():setPosition(202810, -31781)
    Asteroid():setPosition(205585, -36776)
    Asteroid():setPosition(201423, -44268)
    Asteroid():setPosition(200590, -33168)
    Asteroid():setPosition(194486, -35388)
    Asteroid():setPosition(195873, -42048)
    Asteroid():setPosition(191988, -46765)
    Asteroid():setPosition(200868, -52315)
    Asteroid():setPosition(204753, -42325)
    Asteroid():setPosition(210580, -38163)
    Asteroid():setPosition(218627, -37608)
    Asteroid():setPosition(203920, -34001)
    Asteroid():setPosition(200035, -40938)
    Asteroid():setPosition(209470, -33723)
    Asteroid():setPosition(213910, -26786)
    Asteroid():setPosition(218627, -29561)
    Asteroid():setPosition(214742, -41216)
    Asteroid():setPosition(207528, -46210)
    Asteroid():setPosition(203088, -52315)
    Asteroid():setPosition(194208, -50095)
    Asteroid():setPosition(203920, -45100)
    Asteroid():setPosition(209470, -38718)
    Asteroid():setPosition(203920, -36498)
    Asteroid():setPosition(198648, -38163)
    Asteroid():setPosition(212800, -43158)
    Asteroid():setPosition(213077, -50928)
    Asteroid():setPosition(196983, -52038)
    Asteroid():setPosition(194763, -49540)
    Asteroid():setPosition(208083, -43990)
    Asteroid():setPosition(215020, -35111)
    Asteroid():setPosition(214465, -27896)
    Asteroid():setPosition(223899, -24011)
    Asteroid():setPosition(227784, -21514)
    Asteroid():setPosition(229172, -15687)
    Asteroid():setPosition(234999, -13189)
    Asteroid():setPosition(242491, -3477)
    Asteroid():setPosition(246376, -980)
    Asteroid():setPosition(244989, 3738)
    Asteroid():setPosition(225287, -14022)
    Asteroid():setPosition(221680, -24289)
    Asteroid():setPosition(206140, -19016)
    Asteroid():setPosition(194486, -27064)
    Asteroid():setPosition(176171, -29838)
    Asteroid():setPosition(171454, -37608)
    Asteroid():setPosition(183386, -68964)
    Asteroid():setPosition(167014, -81174)
    Asteroid():setPosition(143428, -81729)
    Asteroid():setPosition(157302, -64247)
    Asteroid():setPosition(195873, -47320)
    Asteroid():setPosition(212800, -19849)
    Asteroid():setPosition(223344, -2645)
    Asteroid():setPosition(233612, 25659)
    Asteroid():setPosition(227784, 41754)
    Asteroid():setPosition(238051, 22884)
    Asteroid():setPosition(226952, 25659)
    Asteroid():setPosition(222235, 38979)
    Asteroid():setPosition(220847, 60623)
    Asteroid():setPosition(207528, 72277)
    Asteroid():setPosition(199758, 68948)
    Asteroid():setPosition(176449, 92534)
    Asteroid():setPosition(168957, 104189)
    Asteroid():setPosition(147313, 98084)
    Asteroid():setPosition(174229, 88927)
    Asteroid():setPosition(178946, 98916)
    Asteroid():setPosition(188103, 90314)
    Asteroid():setPosition(170067, 92534)
    Asteroid():setPosition(164794, 95309)
    Asteroid():setPosition(191711, 87539)
    Asteroid():setPosition(201423, 77550)
    Asteroid():setPosition(215575, 59235)
    Asteroid():setPosition(216685, 50356)
    Asteroid():setPosition(225842, 43141)
    Asteroid():setPosition(131773, 96696)
    Asteroid():setPosition(118454, 98639)
    Asteroid():setPosition(110407, 89204)
    Asteroid():setPosition(96532, 82544)
    Asteroid():setPosition(89040, 86429)
    Asteroid():setPosition(80160, 78660)
    Asteroid():setPosition(75165, 72555)
    Asteroid():setPosition(59071, 69780)
    Asteroid():setPosition(62124, 60900)
    Asteroid():setPosition(52689, 48691)
    Asteroid():setPosition(36040, 38146)
    Asteroid():setPosition(33542, 22052)
    Asteroid():setPosition(19668, 19832)
    Asteroid():setPosition(39647, 36481)
    Asteroid():setPosition(39924, 25382)
    Asteroid():setPosition(23275, 23717)
    Asteroid():setPosition(25495, 11507)
    Asteroid():setPosition(29380, 5125)
    Asteroid():setPosition(19945, -5142)
    Asteroid():setPosition(28825, -13467)
    Asteroid():setPosition(24663, -20126)
    Asteroid():setPosition(30212, -22346)
    Asteroid():setPosition(31045, -4587)
    Asteroid():setPosition(25495, -10137)
    Asteroid():setPosition(34652, -23734)
    Asteroid():setPosition(27437, -36221)
    Asteroid():setPosition(41312, -38163)
    Asteroid():setPosition(47694, -31503)
    Asteroid():setPosition(36317, -31781)
    Asteroid():setPosition(36317, -36776)
    Asteroid():setPosition(44364, -45933)
    Asteroid():setPosition(59349, -40938)
    Asteroid():setPosition(52689, -44823)
    Asteroid():setPosition(59349, -62027)
    Asteroid():setPosition(69061, -53703)
    Asteroid():setPosition(72946, -62027)
    Asteroid():setPosition(69338, -65912)
    Asteroid():setPosition(91537, -70074)
    Asteroid():setPosition(81270, -80896)
    Asteroid():setPosition(100417, -74514)
    Asteroid():setPosition(105689, -84226)
    Asteroid():setPosition(115401, -89776)
    Asteroid():setPosition(102082, -90886)
    Asteroid():setPosition(104302, -82006)
    Asteroid():setPosition(122616, -77844)
    Asteroid():setPosition(126223, -95048)
    Asteroid():setPosition(127333, -83671)
    Asteroid():setPosition(134271, -82284)
    Asteroid():setPosition(135381, -72572)
    Asteroid():setPosition(143705, -76734)
    Asteroid():setPosition(139265, -90886)
    Asteroid():setPosition(145925, -89221)
    Asteroid():setPosition(144260, -76457)
    Asteroid():setPosition(163684, -73127)
    Asteroid():setPosition(153140, -62027)
    Asteroid():setPosition(153972, -75624)
    Asteroid():setPosition(163962, -86724)
    Asteroid():setPosition(165627, -70352)
    Asteroid():setPosition(177281, -64525)
    Asteroid():setPosition(190046, -63415)
    Asteroid():setPosition(185328, -50650)
    Asteroid():setPosition(190323, -49818)
    Asteroid():setPosition(226952, 1518)
    Asteroid():setPosition(231947, 9842)
    Asteroid():setPosition(230837, 17612)
    Asteroid():setPosition(231392, 23439)
    Asteroid():setPosition(234167, 34816)
    Asteroid():setPosition(217795, 47581)
    Asteroid():setPosition(215297, 66173)
    Asteroid():setPosition(199758, 68947)
    Asteroid():setPosition(186993, 81157)
    Asteroid():setPosition(174506, 89482)
    Asteroid():setPosition(153417, 98916)
    Asteroid():setPosition(138155, 109183)
    Asteroid():setPosition(124558, 104466)
    Asteroid():setPosition(111794, 99194)
    Asteroid():setPosition(104857, 92257)
    Asteroid():setPosition(91815, 91979)
    Asteroid():setPosition(73223, 83099)
    Asteroid():setPosition(66841, 67283)
    Asteroid():setPosition(34097, 71167)
    Asteroid():setPosition(24385, 57848)
    Asteroid():setPosition(29380, 44528)
    Asteroid():setPosition(16338, 34261)
    Asteroid():setPosition(15228, 24549)
    Asteroid():setPosition(9123, 1518)
    Asteroid():setPosition(22998, -22346)
    Asteroid():setPosition(19390, -31226)
    Asteroid():setPosition(56851, -57587)
    Asteroid():setPosition(79605, -58697)
    Asteroid():setPosition(164239, -88389)
    Asteroid():setPosition(167569, -69797)
    Asteroid():setPosition(192821, -69797)
    Asteroid():setPosition(169234, -43158)
    Asteroid():setPosition(173951, -71184)
    Asteroid():setPosition(188658, -70074)
    Asteroid():setPosition(196428, -52593)
    Asteroid():setPosition(216962, -54812)
    Asteroid():setPosition(215575, -45378)
    Nebula():setPosition(198061, -41558)
    Nebula():setPosition(198917, -26605)
    Nebula():setPosition(208355, -60937)
    Nebula():setPosition(234838, -32596)
    Mine():setPosition(87340, -134476)
    Mine():setPosition(81390, -128754)
    Mine():setPosition(86883, -130357)
    Mine():setPosition(91918, -117769)
    Mine():setPosition(90087, -107012)
    Mine():setPosition(73151, -108157)
    Mine():setPosition(69947, -120515)
    Mine():setPosition(52095, -136307)
    Mine():setPosition(54384, -118227)
    Mine():setPosition(72464, -101748)
    Mine():setPosition(81619, -88703)
    Mine():setPosition(96495, -80006)
    Mine():setPosition(77763, -137565)
    Mine():setPosition(77365, -150306)
    Mine():setPosition(89974, -146192)
    Mine():setPosition(36619, -123629)
    Mine():setPosition(42990, -121638)
    Mine():setPosition(27196, -125753)
    Mine():setPosition(34496, -145396)
    Mine():setPosition(71779, -87312)
    Mine():setPosition(55962, -80097)
    Mine():setPosition(83994, -100064)
    Mine():setPosition(57892, -107880)
    Mine():setPosition(104492, -125133)
    Mine():setPosition(112898, -140175)
    Mine():setPosition(65413, -131770)
    Mine():setPosition(62906, -152120)
    Mine():setPosition(85173, -166277)
    Mine():setPosition(88713, -153300)
    Mine():setPosition(100363, -156692)
end


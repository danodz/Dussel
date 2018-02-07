-- Name: VafJerrold_02
-- Description: Premiere mission du nexus 01. Établir des radars pour trianguler un signal de détection de reliques...
-- Type: Basic

require("utils.lua")
-- For this scenario, utils.lua provides:
--   vectorFromAngle(angle, length)
--      Returns a relative vector (x, y coordinates)
--   setCirclePos(obj, x, y, angle, distance)
--      Returns the object with its position set to the resulting coordinates.

players = {};
availableItems = { plutonium = {amount = 0, value = 0}
                 }
plutonium = 0;
radarCount = 0;
atWarWithResistance = false;


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

    spawnVafJerrold(187213, -88611);
    planets()
    decors()

    -- station de départ
    dusselStation = SpaceStation():setTemplate("Medium Station"):setFaction("Dussel"):setCallSign("Dussel-3b"):setPosition(188672, -88430)
    dusselStation:setCommsFunction(function()
        if radarCount == 3 then
            setCommsMessage("Êtes vous prêts à activer les radars?");
            addCommsReply("Activer!", function()
                setCommsMessage("");
                victory("Merillon");
            end);
        else
            setCommsMessage("Changez les trois stations en radar");
        end
    end);
    -- discussion donne la localisation des 3 stations à convertir en radars
    -- lorsque les 3 sont convertis, donne une nouvelle option de "lancer le signal" = victoire Merillon.

    -- options pour ramasser du plutonium : parler avec la résistance locale pour des missions ou détruire les épaves dans le champs d'astéroides.

    -- stations à transformer en radar
    stationToRadar(143141, -181406,"Dussel_r2" )
    stationToRadar(110295, -68671,"Dussel_r1" )
    stationToRadar(270629, -107641,"Dussel_r3" )
    -- ajouter une communication permettant de payer un nombre de plutonium pour les transformer en radar fonctionnel. Concrètement ça les transforme en station moyenne (détruire et créer une nouvelle station au même emplacement ?)

    
    -- // épaves 
    -- ATTENTION voir ou ajuster le nom de la faction!! "Épave"

    -- quête : chaque épave détruire rapporte un nombre de plutonium pour la construction des radars (+10 plutonium par épave détruite)

    wrecks = { CpuShip():setFaction("Épave"):setTemplate("Adv. Gunship"):setCallSign("CSS2"):setPosition(216928, -212081):orderStandGround():setWeaponStorage("Homing", 2)
             , CpuShip():setFaction("Épave"):setTemplate("Adv. Gunship"):setCallSign("NC3"):setPosition(231721, -204093):orderStandGround():setImpulseMaxSpeed(0.0):setWeaponStorage("Homing", 2)
             , CpuShip():setFaction("Épave"):setTemplate("Adder MK5"):setCallSign("UTI4"):setPosition(224061, -211870):orderStandGround():setShieldsMax(0.00):setShields(0.00):setWeaponTubeCount(0):setWeaponStorageMax("HVLI", 0):setWeaponStorage("HVLI", 0):setBeamWeapon(0, 34, 0, 800, 5.0, 2.0):setBeamWeaponTurret(0, 0, 0, 0)
             , CpuShip():setFaction("Épave"):setTemplate("Adder MK5"):setCallSign("UTI5"):setPosition(226937, -212589):orderStandGround():setWeaponStorage("HVLI", 3)
             , CpuShip():setFaction("Épave"):setTemplate("Adder MK5"):setCallSign("NC6"):setPosition(231849, -196293):orderStandGround():setWeaponStorage("HVLI", 3)
             , CpuShip():setFaction("Épave"):setTemplate("Adder MK5"):setCallSign("SS7"):setPosition(239997, -194855):orderStandGround():setWeaponStorage("HVLI", 3)
             , CpuShip():setFaction("Épave"):setTemplate("Adder MK5"):setCallSign("S8"):setPosition(214115, -221935):orderStandGround():setWeaponStorage("HVLI", 3)
             , CpuShip():setFaction("Épave"):setTemplate("Adder MK5"):setCallSign("BR9"):setPosition(244191, -185389):orderStandGround():setWeaponStorage("HVLI", 3)
             , CpuShip():setFaction("Épave"):setTemplate("Adder MK4"):setCallSign("UTI11"):setPosition(222743, -216064):orderStandGround():setWeaponStorage("HVLI", 1)
             , CpuShip():setFaction("Épave"):setTemplate("Adder MK4"):setCallSign("VS12"):setPosition(216033, -226368):orderStandGround():setWeaponStorage("HVLI", 1)
             , CpuShip():setFaction("Épave"):setTemplate("Adder MK4"):setCallSign("NC13"):setPosition(244071, -191380):orderStandGround():setWeaponStorage("HVLI", 1)
             };

    -- épave qui, lorsque proche du vaisseau joueur, devient de faction "charognard" et attaque le joueur. 
    -- alternative facile : faction charognard depuis le début. Les joueurs devront juste le scanner pour s'en rendre compte
    notRealWreck = CpuShip():setFaction("Épave"):setTemplate("Atlantis X23"):setCallSign("CSS10xxx"):setPosition(239398, -190421):orderStandGround():setWeaponStorage("Homing", 4)
    WarpJammer():setFaction("Épave"):setPosition(236327, -196159)
    -- +25 plutonium si détruit

    -- station baron à "libérer" pour une quête de la résistance. Lorsque unités et defense plateforms sont détruites, la station devient de faction "resistance". voir si ça vaut la peine de mettre un nom spécial à la station
    toFree = SpaceStation():setTemplate("Medium Station"):setFaction("Barons"):setCallSign("DS188"):setPosition(71598, -110405)

    -- les unités à détruire pour changer la faction de la station
    
    toFreeUnits = { CpuShip():setFaction("Barons"):setTemplate("Adv. Striker"):setCallSign("UTI14"):setPosition(68290, -109314):orderDefendLocation(68290, -109314)
                  , CpuShip():setFaction("Barons"):setTemplate("Adv. Striker"):setCallSign("S15"):setPosition(70076, -113041):orderDefendLocation(70076, -113041)
                  , CpuShip():setFaction("Barons"):setTemplate("Adv. Striker"):setCallSign("SS16"):setPosition(74268, -107217):orderDefendLocation(74268, -107217)
                  , CpuShip():setFaction("Barons"):setTemplate("Adder MK4"):setCallSign("S17"):setPosition(69138, -111328):orderDefendLocation(69138, -111328):setWeaponStorage("HVLI", 1)
                  , CpuShip():setFaction("Barons"):setTemplate("Adder MK4"):setCallSign("SS18"):setPosition(68321, -106736):orderDefendLocation(68321, -106736):setWeaponStorage("HVLI", 1)
                  , CpuShip():setFaction("Barons"):setTemplate("Adder MK4"):setCallSign("CV19"):setPosition(71151, -106422):orderDefendLocation(71151, -106422):setWeaponStorage("HVLI", 1)
                  , CpuShip():setFaction("Barons"):setTemplate("Adder MK4"):setCallSign("CSS20"):setPosition(74358, -110007):orderDefendLocation(74358, -110007):setWeaponStorage("HVLI", 1)
                  , CpuShip():setFaction("Barons"):setTemplate("Adder MK4"):setCallSign("NC21"):setPosition(72346, -113403):orderDefendLocation(72346, -113403):setWeaponStorage("HVLI", 1)
                  , CpuShip():setFaction("Barons"):setTemplate("Blockade Runner"):setCallSign("SS22"):setPosition(73730, -111453):orderDefendLocation(73730, -111453)
                  , CpuShip():setFaction("Barons"):setTemplate("Defense platform"):setCallSign("SS23"):setPosition(67976, -112448):orderDefendLocation(67976, -112448)
                  , CpuShip():setFaction("Barons"):setTemplate("Defense platform"):setCallSign("NC24"):setPosition(72761, -107228):orderDefendLocation(72761, -107228)
                  }

    -- supplydrop pour aider les joueurs
    SupplyDrop():setFaction("Merillon"):setPosition(227712, -209925):setEnergy(500):setWeaponStorage("Homing", 4):setWeaponStorage("Nuke", 1):setWeaponStorage("Mine", 2):setWeaponStorage("EMP", 1)
    SupplyDrop():setFaction("Merillon"):setPosition(146124, -88255):setEnergy(500):setWeaponStorage("Homing", 4):setWeaponStorage("Nuke", 1):setWeaponStorage("Mine", 2):setWeaponStorage("EMP", 1)

    freeStationIsOn = true;
    emergencyIsOn = true;
    -- //résistance
    -- station de la résistance avec laquelle les joueurs pourront avoir des missions. 
    resistance = SpaceStation():setTemplate("Small Station"):setFaction("Resistance"):setCallSign("DS245"):setPosition(149490, -27739)
    resistance:setCommsFunction(function()
        setCommsMessage("On a des quest pour vous");

        if freeStationIsOn then
            if toFree:getFaction() == "Barons" then
                addCommsReply("Liberer une station", function()
                    setCommsMessage("Va en ZZ8");
                end);
            else
                addCommsReply("On l'a libéré", function()
                    setCommsMessage("Bravo, voici votre plutonium");
                    plutonium = plutonium + 100;
                    freeStationIsOn = false;
                end);
            end
        end

        if emergencyIsOn then
            addCommsReply("defendre d'urgence", function()
                setCommsMessage("Va en C18");
                for i,ship in pairs(surpriseAttack) do
                    ship:orderAttack(toDefendResistance);
                end
            end);
        end

        addCommsReply("prendre le plutonium par la force", function()
            setCommsMessage("Alors c'est la guerre");
            for i,ship in pairs(resistanceShips) do
                ship:setFaction("Charognards");
                resistance:setCommsFunction(function()
                    setCommsMessage("");
                end);
                toDefendResistance:setCommsFunction(function()
                    setCommsMessage("");
                end);
            end
        end);
    end)

    -- missions données en échange de plutonium : 
        -- a. libérer la station baron (détruire les unités et plateformes de défense)  +100 plutonium
        -- b. défendre en urgence la station DS246 avant qu'elle ne soit détruite (faire attaquer les barons qui sont juste à côté) +100 plutonium
        -- c. option d'attaquer la résistance pour voler leur plutonium (les 2 stations et toutes les unités de la résistance deviennent "charognard" et chacune rapportent un nombre de plutonium lorsque détruits. (unités 5, station 100))

    resistanceShips = { CpuShip():setFaction("Resistance"):setTemplate("Defense platform"):setCallSign("NC25"):setPosition(146600, -27964):orderDefendLocation(146600, -27964)
                      , CpuShip():setFaction("Resistance"):setTemplate("Defense platform"):setCallSign("CV27"):setPosition(151057, -30420):orderDefendLocation(151057, -30420)
                      , CpuShip():setFaction("Resistance"):setTemplate("Defense platform"):setCallSign("VK28"):setPosition(151572, -25963):orderDefendLocation(151572, -25963)
                      , CpuShip():setFaction("Resistance"):setTemplate("Adder MK5"):setCallSign("SS30"):setPosition(148325, -29654):orderDefendLocation(148325, -29654):setWeaponStorage("HVLI", 3)
                      , CpuShip():setFaction("Resistance"):setTemplate("Adder MK5"):setCallSign("CSS31"):setPosition(147222, -26515):orderDefendLocation(147222, -26515):setWeaponStorage("HVLI", 3)
                      , CpuShip():setFaction("Resistance"):setTemplate("Adder MK5"):setCallSign("CSS32"):setPosition(148792, -24578):orderDefendLocation(148792, -24578):setWeaponStorage("HVLI", 3)
                      , CpuShip():setFaction("Resistance"):setTemplate("Adder MK5"):setCallSign("S33"):setPosition(151898, -27350):orderDefendLocation(151898, -27350):setWeaponStorage("HVLI", 3)
                      , CpuShip():setFaction("Resistance"):setTemplate("Adder MK5"):setCallSign("NC34"):setPosition(151063, -24511):orderDefendLocation(151063, -24511):setWeaponStorage("HVLI", 3)
                      , CpuShip():setFaction("Resistance"):setTemplate("Adder MK5"):setCallSign("CV35"):setPosition(149961, -31558):orderDefendLocation(149961, -31558):setWeaponStorage("HVLI", 3)
                      , CpuShip():setFaction("Resistance"):setTemplate("Adder MK5"):setCallSign("CCN36"):setPosition(144417, -26415):orderDefendLocation(144417, -26415):setWeaponStorage("HVLI", 3)
                      --Defend toDefendResistance
                      , CpuShip():setFaction("Resistance"):setTemplate("Defense platform"):setCallSign("CV37"):setPosition(265835, -51635):orderDefendLocation(265835, -51635)
                      , CpuShip():setFaction("Resistance"):setTemplate("Defense platform"):setCallSign("UTI38"):setPosition(268941, -54465):orderDefendLocation(268941, -54465)
                      , CpuShip():setFaction("Resistance"):setTemplate("Adv. Gunship"):setCallSign("CSS39"):setPosition(266663, -54258):orderDefendLocation(266663, -54258):setWeaponStorage("Homing", 2)
                      , CpuShip():setFaction("Resistance"):setTemplate("Adder MK5"):setCallSign("SS41"):setPosition(263627, -53291):orderDefendLocation(263627, -53291):setWeaponStorage("HVLI", 3)
                      , CpuShip():setFaction("Resistance"):setTemplate("Adder MK5"):setCallSign("NC42"):setPosition(266180, -57570):orderDefendLocation(266180, -57570):setWeaponStorage("HVLI", 3)
                      , CpuShip():setFaction("Resistance"):setTemplate("Adder MK5"):setCallSign("VK43"):setPosition(273151, -54465):orderDefendLocation(273151, -54465):setWeaponStorage("HVLI", 3)
                      , CpuShip():setFaction("Resistance"):setTemplate("Adder MK5"):setCallSign("BR44"):setPosition(272806, -50392):orderDefendLocation(272806, -50392):setWeaponStorage("HVLI", 3)
                      };
        
    -- station à défendre
    toDefendResistance = SpaceStation():setTemplate("Medium Station"):setFaction("Resistance"):setCallSign("DS246"):setPosition(269300, -52516)
    toDefendResistance:setCommsFunction(function()
        if allDead(surpriseAttack) then
            setCommsMessage("Merci vous nous avez sauvé. Voici 100 plutonium");
            plutonium = plutonium + 100;
            toDefendResistance:setCommsFunction(function()
                setCommsMessage("");
            end);
        else
            setCommsMessage("");
        end
    end);
   
    -- unités barons qui attaquent la station lorsque la mission est lancée. 
    surpriseAttack = { CpuShip():setFaction("Barons"):setTemplate("Adv. Striker"):setCallSign("CCN45"):setPosition(306422, -33995):orderDefendLocation(306422, -33995)
                     , CpuShip():setFaction("Barons"):setTemplate("Adv. Striker"):setCallSign("CV46"):setPosition(306008, -32081):orderDefendLocation(306008, -32081)
                     , CpuShip():setFaction("Barons"):setTemplate("Adv. Striker"):setCallSign("NC47"):setPosition(308337, -33731):orderDefendLocation(308337, -33731)
                     , CpuShip():setFaction("Barons"):setTemplate("Adv. Striker"):setCallSign("NC48"):setPosition(308434, -29072):orderDefendLocation(308434, -29072)
                     , CpuShip():setFaction("Barons"):setTemplate("Adv. Striker"):setCallSign("SS49"):setPosition(310569, -30042):orderDefendLocation(310569, -30042)
                     , CpuShip():setFaction("Barons"):setTemplate("Atlantis X23"):setCallSign("UTI50"):setPosition(308756, -30923):orderDefendLocation(308756, -30923):setWeaponStorage("Homing", 0)
                     , CpuShip():setFaction("Barons"):setTemplate("Adder MK6"):setCallSign("NC51"):setPosition(306866, -29645):orderDefendLocation(306866, -29645):setWeaponStorage("HVLI", 7)
                     , CpuShip():setFaction("Barons"):setTemplate("Adder MK6"):setCallSign("VS52"):setPosition(306556, -30514):orderDefendLocation(306556, -30514):setWeaponStorage("HVLI", 7)
                     , CpuShip():setFaction("Barons"):setTemplate("Adder MK6"):setCallSign("VK53"):setPosition(309630, -34242):orderDefendLocation(308290, -35273):setWeaponStorage("HVLI", 7)
                     , CpuShip():setFaction("Barons"):setTemplate("Adder MK6"):setCallSign("VK54"):setPosition(310799, -32357):orderDefendLocation(310799, -32357):setWeaponStorage("HVLI", 7)
                     };
    WarpJammer():setFaction("Barons"):setPosition(307852, -31569)

end

function update()
    for i,ship in pairs(wrecks) do
        if not ship:isValid() then
            plutonium = plutonium + 10
            table.remove(wrecks,i);
        end
    end

    if atWarWithResistance then
        for i,ship in pairs(resistanceShips) do
            if not ship:isValid() then
                plutonium = plutonium + 5
                table.remove(resistanceShips,i);
            end
        end

        if resistance ~= nil and not resistance:isValid() then
            plutonium = plutonium + 100;
            resistance = nil;
        end

        if toDefendResistance ~= nil and not toDefendResistance:isValid() then
            plutonium = plutonium + 100;
            toDefendResistance = nil;
        end
    end

    if notRealWreck ~= nil then
        if not notRealWreck:isValid() then
            plutonium = plutonium + 25;
            notRealWreck = nil;
        else
            if distance(notRealWreck, vafJerrold) <= 4000 then
                notRealWreck:setFaction("Charognards");
                notRealWreck:orderDefendLocation(239398, -190421)
            end
        end
    end

    if allDead(toFreeUnits) then
        toFree:setFaction("Resistance");
    end
end

function stationToRadar(x,y,callSign)
    local station = SpaceStation():setTemplate("Small Station"):setFaction("Dussel"):setCallSign(callSign):setPosition(x, y)
    station:setCommsFunction(function()
        if not comms_source:isDocked(comms_target) then
            setCommsMessage("Venez nous voir en personne.")
        else
            setCommsMessage("Convertir la station en radar pour 100 plutonium")
            addCommsReply("Le faire", function()
                if plutonium <= 100 then
                    plutonium = plutonium - 100;
                    radarCount = radarCount + 1;
                    SpaceStation():setTemplate("Medium Station"):setFaction("Dussel"):setCallSign(callSign):setPosition(x, y);
                    station:destroy();
                end
            end);
        end
    end);
end

function planets()
    Planet():setPosition(192226, -81113)
    Planet():setPosition(195712, -84697)
    Planet():setPosition(190215, -90908)
end

function decors()
    BlackHole():setPosition(118067, -152369)
    Nebula():setPosition(123356, -134833)
    Nebula():setPosition(105819, -121472)
    Nebula():setPosition(92458, -107275)
    Nebula():setPosition(98582, -86120)
    Nebula():setPosition(80767, -65800)
    Nebula():setPosition(92180, -52717)
    Nebula():setPosition(111386, -41583)
    Nebula():setPosition(128923, -54666)
    Nebula():setPosition(81602, -101708)
    Nebula():setPosition(73808, -120080)
    Nebula():setPosition(108603, -140957)
    Nebula():setPosition(118067, -158493)
    Nebula():setPosition(131150, -192731)
    Nebula():setPosition(155924, -198298)
    Nebula():setPosition(175687, -194123)
    Nebula():setPosition(222173, -170184)
    Nebula():setPosition(250009, -187721)
    Nebula():setPosition(258916, -201082)
    Nebula():setPosition(155924, -169906)
    Nebula():setPosition(161212, -167122)
    Nebula():setPosition(225791, -155710)
    Nebula():setPosition(269494, -143462)
    Nebula():setPosition(296773, -137616)
    Nebula():setPosition(285360, -117018)
    Nebula():setPosition(300670, -110059)
    Nebula():setPosition(312639, -102543)
    Nebula():setPosition(299278, -82223)
    Nebula():setPosition(309577, -67749)
    Nebula():setPosition(308185, -31840)
    Nebula():setPosition(282298, -7902)
    Nebula():setPosition(243050, -8737)
    Nebula():setPosition(211874, -19036)
    Nebula():setPosition(192667, 727)
    Nebula():setPosition(144789, -11799)
    Nebula():setPosition(128366, -14304)
    Nebula():setPosition(92180, 4903)
    Nebula():setPosition(-21947, -33232)
    Nebula():setPosition(-31689, -47985)
    Nebula():setPosition(-8029, -85285)
    Nebula():setPosition(-19720, -96141)
    Nebula():setPosition(147016, -90296)
    Nebula():setPosition(201853, -128431)
    Nebula():setPosition(224678, -97811)
    Nebula():setPosition(167893, -41026)
    Nebula():setPosition(212987, -44645)
    Nebula():setPosition(237761, -62181)
    Nebula():setPosition(263926, -72759)
    Nebula():setPosition(253349, -95306)
    Nebula():setPosition(172347, -117296)
    Nebula():setPosition(315701, -189948)
    Nebula():setPosition(250844, -225299)
    Nebula():setPosition(231637, -240330)
    Nebula():setPosition(206028, -231701)
    Nebula():setPosition(201296, -215835)
    Nebula():setPosition(111665, -225577)
    Nebula():setPosition(61282, -215835)
    Nebula():setPosition(39292, -182710)
    Nebula():setPosition(34281, -147080)
    Nebula():setPosition(88004, -196350)
    Nebula():setPosition(59890, -144297)
    Nebula():setPosition(30106, -74708)
    Nebula():setPosition(36508, -36294)
    Nebula():setPosition(65736, 32739)
    Nebula():setPosition(92458, 46935)
    Nebula():setPosition(154254, 38306)
    Nebula():setPosition(30663, -2613)
    Nebula():setPosition(120851, 46656)
    Nebula():setPosition(142841, 74214)
    Nebula():setPosition(238039, 49718)
    Nebula():setPosition(286752, 53059)
    Nebula():setPosition(271999, 60574)
    Nebula():setPosition(218833, 55007)
    Nebula():setPosition(226070, 23831)
    Nebula():setPosition(277288, 9357)
    Nebula():setPosition(347990, -16809)
    Nebula():setPosition(268937, -44645)
    Nebula():setPosition(351888, -58563)
    Nebula():setPosition(357733, -99760)
    Nebula():setPosition(337691, -130379)
    Nebula():setPosition(357733, -159607)
    Nebula():setPosition(301505, -167957)
    Nebula():setPosition(297329, -242836)
    Nebula():setPosition(348826, -213330)
    Nebula():setPosition(341588, -251186)
    Nebula():setPosition(295659, -318827)
    Nebula():setPosition(227462, -292940)
    Nebula():setPosition(197677, -263156)
    Nebula():setPosition(143398, -236155)
    Nebula():setPosition(126696, -269558)
    Asteroid():setPosition(198512, -222794)
    Asteroid():setPosition(208255, -217505)
    Asteroid():setPosition(206863, -209711)
    Asteroid():setPosition(224678, -223629)
    Asteroid():setPosition(216049, -216670)
    Asteroid():setPosition(217162, -208319)
    Asteroid():setPosition(223008, -206092)
    Asteroid():setPosition(221059, -200247)
    Asteroid():setPosition(230524, -213886)
    Asteroid():setPosition(217441, -196906)
    Asteroid():setPosition(230245, -189112)
    Asteroid():setPosition(243050, -206092)
    Asteroid():setPosition(233585, -199690)
    Asteroid():setPosition(227183, -191618)
    Asteroid():setPosition(249174, -190226)
    Asteroid():setPosition(237482, -175195)
    Asteroid():setPosition(246947, -173246)
    Asteroid():setPosition(257803, -173524)
    Asteroid():setPosition(269494, -187721)
    Asteroid():setPosition(251957, -188277)
    Asteroid():setPosition(238039, -185215)
    Asteroid():setPosition(239709, -196350)
    Asteroid():setPosition(238874, -206649)
    Asteroid():setPosition(232472, -213330)
    Asteroid():setPosition(226070, -207484)
    Asteroid():setPosition(233029, -226969)
    Asteroid():setPosition(221059, -230588)
    Asteroid():setPosition(208812, -234763)
    Asteroid():setPosition(200183, -243949)
    Asteroid():setPosition(185151, -243114)
    Asteroid():setPosition(171512, -249794)
    Asteroid():setPosition(177636, -260372)
    Asteroid():setPosition(147851, -273176)
    Asteroid():setPosition(255576, -193845)
    Asteroid():setPosition(264483, -177700)
    Asteroid():setPosition(273669, -165452)
    Asteroid():setPosition(277566, -156823)
    Asteroid():setPosition(285917, -149586)
    Asteroid():setPosition(272277, -145132)
    Asteroid():setPosition(255297, -176586)
    Asteroid():setPosition(280628, -160720)
    Asteroid():setPosition(285360, -159328)
    Asteroid():setPosition(265318, -167401)
    Asteroid():setPosition(263091, -166566)
    Asteroid():setPosition(280350, -173524)
    Asteroid():setPosition(282298, -156823)
    Asteroid():setPosition(290927, -143183)
    Asteroid():setPosition(248060, -193010)
    Asteroid():setPosition(262813, -185494)
    Asteroid():setPosition(247782, -183545)
    Asteroid():setPosition(242493, -186607)
    Asteroid():setPosition(236926, -194680)
    Asteroid():setPosition(226070, -199133)
    Asteroid():setPosition(233029, -211381)
    Asteroid():setPosition(216884, -221124)
    Asteroid():setPosition(203523, -234763)
    Asteroid():setPosition(189605, -253135)
    Asteroid():setPosition(171233, -265939)
    Asteroid():setPosition(159264, -272063)
    Asteroid():setPosition(164553, -267331)
    Asteroid():setPosition(179306, -252856)
    Asteroid():setPosition(293432, -146802)
    Asteroid():setPosition(307350, -136503)
    Asteroid():setPosition(319041, -127039)
    Asteroid():setPosition(323217, -118966)
    Asteroid():setPosition(329340, -104213)
    Asteroid():setPosition(345207, -98368)
    Asteroid():setPosition(359125, -82223)
    Asteroid():setPosition(147295, -288486)
    Asteroid():setPosition(127253, -304909)
    Asteroid():setPosition(124469, -313538)
    Asteroid():setPosition(373321, -63573)
    Asteroid():setPosition(386126, -56893)
    Asteroid():setPosition(390579, -41583)
    Asteroid():setPosition(113057, -337756)
    Asteroid():setPosition(92458, -339982)

    Mine():setPosition(219128, -215660)
    Mine():setPosition(211899, -225740)
    Mine():setPosition(227171, -219427)
    Mine():setPosition(219128, -201914)
    Mine():setPosition(238779, -204765)
    Mine():setPosition(227171, -195703)
    Mine():setPosition(242586, -195623)
    Mine():setPosition(252524, -186438)
    Mine():setPosition(250590, -200896)
    Mine():setPosition(250997, -179412)
    Mine():setPosition(258022, -177987)
    Mine():setPosition(273397, -166583)
    Mine():setPosition(259652, -160779)
    Mine():setPosition(269121, -176867)
    Mine():setPosition(206909, -214132)
    Mine():setPosition(199884, -224212)
    Mine():setPosition(189702, -239384)
    Mine():setPosition(220859, -205274)
    Mine():setPosition(227579, -205274)
    Mine():setPosition(226413, -183084)
    Mine():setPosition(205030, -194077)
    Mine():setPosition(211957, -191366)
    Mine():setPosition(242376, -163658)
    Mine():setPosition(252164, -159743)
    Mine():setPosition(246442, -218623)
    Mine():setPosition(235298, -224947)
    Mine():setPosition(267072, -208985)
    Mine():setPosition(274752, -195583)
        Asteroid():setPosition(181286, -100553)
    Asteroid():setPosition(177628, -94893)
    Asteroid():setPosition(172244, -89786)
    Asteroid():setPosition(175005, -88198)
    Asteroid():setPosition(170243, -81228)
    Asteroid():setPosition(169277, -75637)
    Asteroid():setPosition(172796, -73912)
    Asteroid():setPosition(170795, -69701)
    Asteroid():setPosition(173901, -69080)
    Asteroid():setPosition(175695, -67148)
    Asteroid():setPosition(179491, -67562)
    Asteroid():setPosition(182942, -65284)
    Asteroid():setPosition(186048, -67079)
    Asteroid():setPosition(191017, -64456)
    Asteroid():setPosition(195089, -67217)
    Asteroid():setPosition(201439, -66527)
    Asteroid():setPosition(206892, -71910)
    Asteroid():setPosition(209583, -76879)
    Asteroid():setPosition(210550, -81780)
    Asteroid():setPosition(208617, -86059)
    Asteroid():setPosition(208962, -91649)
    Asteroid():setPosition(212137, -97033)
    Asteroid():setPosition(207168, -99655)
    Asteroid():setPosition(201784, -103659)
    Asteroid():setPosition(198678, -107662)
    Asteroid():setPosition(193157, -111251)
    Asteroid():setPosition(187359, -106626)
    Asteroid():setPosition(182459, -104625)
    Asteroid():setPosition(177352, -102485)
    Asteroid():setPosition(173625, -100001)
    Asteroid():setPosition(168862, -92478)
    Asteroid():setPosition(163065, -86818)
    Asteroid():setPosition(163893, -84886)
    Asteroid():setPosition(167275, -96481)
    Asteroid():setPosition(174453, -102347)
    Asteroid():setPosition(179284, -104556)
    Asteroid():setPosition(166930, -90752)
    Asteroid():setPosition(162858, -85438)
    Asteroid():setPosition(166585, -79709)
    Asteroid():setPosition(165411, -73705)
    Asteroid():setPosition(166861, -66734)
    Asteroid():setPosition(174177, -60867)
    Asteroid():setPosition(184737, -57278)
    Asteroid():setPosition(194054, -53896)
    Asteroid():setPosition(201477, -59618)
    Asteroid():setPosition(210382, -62063)
    Asteroid():setPosition(215970, -74809)
    Asteroid():setPosition(215097, -87032)
    Asteroid():setPosition(210033, -94541)
    Asteroid():setPosition(202001, -99081)
    Asteroid():setPosition(193445, -103097)
    Asteroid():setPosition(190302, -111304)
    Asteroid():setPosition(182095, -116018)
    Asteroid():setPosition(174063, -120209)
    Asteroid():setPosition(224875, -98732)
    Asteroid():setPosition(230812, -88779)
    Asteroid():setPosition(232733, -72190)
    Asteroid():setPosition(236400, -66253)
    Asteroid():setPosition(224352, -88953)
    Asteroid():setPosition(218938, -84413)
    Asteroid():setPosition(213002, -47395)
    Asteroid():setPosition(196064, -48792)
    Asteroid():setPosition(183492, -47395)
    Asteroid():setPosition(160093, -40585)
    Asteroid():setPosition(156950, -62936)
    Asteroid():setPosition(151013, -76206)
    Asteroid():setPosition(152061, -88080)
    Asteroid():setPosition(148569, -92446)
    Asteroid():setPosition(156601, -105716)
    Asteroid():setPosition(190127, -127019)
    Asteroid():setPosition(203747, -129115)
    Asteroid():setPosition(212478, -120384)
    Asteroid():setPosition(225399, -109558)
    Asteroid():setPosition(238495, -99430)
    Asteroid():setPosition(236400, -68698)
    Asteroid():setPosition(225748, -54554)
    Mine():setPosition(166729, -42680)
    Mine():setPosition(102407, -73484)
    Mine():setPosition(98021, -69975)
    Mine():setPosition(93811, -67519)
    Mine():setPosition(89951, -64186)
    Mine():setPosition(84864, -59976)
    Mine():setPosition(80302, -56116)
    Mine():setPosition(76618, -53134)
    Mine():setPosition(80829, -52081)
    Mine():setPosition(83987, -55941)
    Mine():setPosition(89601, -60502)
    Mine():setPosition(93811, -64011)
    Mine():setPosition(97670, -66291)
    Mine():setPosition(102232, -68923)
    Mine():setPosition(107144, -71905)
    Mine():setPosition(107846, -77344)
    Mine():setPosition(112056, -75765)
    Mine():setPosition(110828, -80501)
    Mine():setPosition(115740, -79624)
    Mine():setPosition(113810, -84185)
    Mine():setPosition(118898, -83835)
    Mine():setPosition(128086, -145738)
    Mine():setPosition(130591, -152140)
    Mine():setPosition(135324, -146573)
    Mine():setPosition(133375, -141006)
    Mine():setPosition(110271, -170512)
    Mine():setPosition(104704, -169676)
    Mine():setPosition(101364, -177749)
    Mine():setPosition(94405, -180811)
    Mine():setPosition(138942, -140449)
end




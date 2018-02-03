--Name: Trading academy
--Description: Sert a tester des feature
players = {};
stations = {};
crewPositions = { "helms","weapons","engineering","science","relay" };

availableItems = { carburant = { amount = 0, value = 5 }
                 , bouffe = { amount = 0, value = 5 }
                 , minerais = { amount = 0, value = 5 }
                 }
stationCargoLoad = 30;
nbStation = 0;
mobs = {};
genMobCooldown = 0;

function init()
    addGMFunction("all_playership", playerShipFn("all_playership"));
addGMFunction("nexusVoid", playerShipFn("nexusVoid"));
addGMFunction("succubiCherubim", playerShipFn("succubiCherubim"));
addGMFunction("vasserand", playerShipFn("vasserand"));
addGMFunction("viceImperiumDoleo", playerShipFn("viceImperiumDoleo"));

    addGMFunction("save", function() error("test") end); 

    trader = PlayerSpaceship():setTemplate("ACorvette"):setPosition(-83, 678):setFaction("Gentil");
    trader.inventory = makeInventory ( {});
    trader.kredits = 40;
    trader.inventorySpace = 20;
    
    trader:addCustomButton("relay", "displayInventory", "Afficher l'inventaire", function() 
        trader:addCustomMessage("relay", "displayInventoryMsg", getInventoryStr(trader));
    end);
    
    map();

    mkStation(-30000,-8500, "carburant");
    mkStation(30000,-30000, "bouffe");
    mkStation(10000,30000, "minerais");

end

function mkStation(x, y, needing)
    local station = SpaceStation():setTemplate("Large Station"):setFaction("Gentil"):setCallSign(needing):setPosition(x,y);
    station.inventory = makeInventory ({ carburant = { amount = stationCargoLoad, value = 5 }
                                       , bouffe = { amount = stationCargoLoad, value = 5 }
                                       , minerais = { amount = stationCargoLoad, value = 5 }
                                       });
    station.inventory[needing].amount = 0;
    station.inventory[needing].value = 18;

    station:setCommsFunction(function()
        if comms_source:isDocked(comms_target) then
            setCommsMessage("Que voulez vous?");
            tradeBuyComm();
            tradeSellComm();
        else
            setCommsMessage("Fuck you");
        end
    end);

    nbStation = nbStation + 1;
    stations[needing] = station;
end

function update()
    local won = true;
    for need,station in pairs(stations) do
        if station.inventory[need].amount ~= stationCargoLoad * nbStation then
            won = false;
        end
    end
    if won then
        victory("Gentil");
    end

    if genMobCooldown >= 2 * 60 * 60 then
        generateMobs(5, "MU52 Hornet", "Michant", 10000, 0, 50000, attackRandomStation)
        genMobCooldown = 0;
        if irandom(1,5) == 1 then
            generateMobs(1, "Atlantis X23", "Michant", 10000, 0, 50000, attackRandomStation)
        end
    end
    genMobCooldown = genMobCooldown + 1;

    if allDead(stations) or not trader:isValid() then
        victory("Michant");
    end
end

function attackRandomStation(mob)
    mob:orderFlyTowards(randomFromObject(stations):getPosition());
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
        if comms_source.kredits <= item.value then
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


function playerShipFn(name)
    return function()
        Script():run("playership/"..name..".lua");
        updatePlayersList();
    end
end

function printShips()
    for i,player in pairs(players) do
        print(player:getCallSign());
    end
end

function updatePlayersList()
    players = {};
    for i=1,50,1 do
        player = getPlayerShip(i);
        if(player) then
            table.insert(players, player);
        end
    end
end


function map()
    Mine():setPosition(-14689, 11725)
    Nebula():setPosition(33465, -3759)
    Nebula():setPosition(20307, -10150)
    Nebula():setPosition(31962, 12594)
    Nebula():setPosition(43240, 28947)
    Nebula():setPosition(56586, 14474)
    Nebula():setPosition(42676, 11466)
    Nebula():setPosition(45119, 2820)
    Nebula():setPosition(21999, 11090)

    kokoro(-15000,15000);
    
    Mine():setPosition(-23642, -20527)
    Mine():setPosition(-24542, -20206)
    Mine():setPosition(-26579, -19759)
    Mine():setPosition(-22635, -20575)
    Mine():setPosition(-22449, -19587)
    Mine():setPosition(-20604, -21164)
    Mine():setPosition(-21556, -20971)
    Mine():setPosition(-21355, -19846)
    Mine():setPosition(-21277, -18955)
    Mine():setPosition(-25471, -20062)
    Mine():setPosition(-25282, -18986)
    Mine():setPosition(-16584, -20988)
    Mine():setPosition(-17228, -19847)
    Mine():setPosition(-18267, -19609)
    Mine():setPosition(-17713, -21702)
    Mine():setPosition(-18769, -21589)
    Mine():setPosition(-19759, -21363)
    Mine():setPosition(-17479, -20774)
    Mine():setPosition(-18411, -20597)
    Mine():setPosition(-23213, -18399)
    Mine():setPosition(-24153, -18182)
    Mine():setPosition(-25095, -17986)
    Mine():setPosition(-26229, -18877)
    Mine():setPosition(-26170, -17885)
    Mine():setPosition(-23389, -19368)
    Mine():setPosition(-24313, -19309)
    Mine():setPosition(-20437, -20174)
    Mine():setPosition(-20292, -19196)
    Mine():setPosition(-22217, -18796)
    
     VisualAsteroid():setPosition(-26927, -29667)VisualAsteroid():setPosition(-30702, -27163)Asteroid():setPosition(-26507, -18943)VisualAsteroid():setPosition(-26281, -18619)VisualAsteroid():setPosition(-30116, -18833)VisualAsteroid():setPosition(-30844, -17886)Asteroid():setPosition(-30160, -18768)Asteroid():setPosition(-31903, -19687)Asteroid():setPosition(-27014, -26302)VisualAsteroid():setPosition(-28544, -26243)Asteroid():setPosition(-28042, -26880)Asteroid():setPosition(-26673, -26341)Asteroid():setPosition(-26195, -26384)VisualAsteroid():setPosition(-31676, -28420)VisualAsteroid():setPosition(-30566, -32476)VisualAsteroid():setPosition(-31305, -29716)VisualAsteroid():setPosition(-32392, -30327)Asteroid():setPosition(-32412, -23052)Asteroid():setPosition(-32174, -26556)VisualAsteroid():setPosition(-28512, -32602)Asteroid():setPosition(-28033, -34104)VisualAsteroid():setPosition(-12933, -26224)VisualAsteroid():setPosition(-13695, -24976)VisualAsteroid():setPosition(-14720, -21016)VisualAsteroid():setPosition(-14848, -20913)Asteroid():setPosition(-10727, -26006)Asteroid():setPosition(-12537, -22354)VisualAsteroid():setPosition(-18123, -18420)Asteroid():setPosition(-19152, -18576)Asteroid():setPosition(-19064, -17607)VisualAsteroid():setPosition(-22999, -19038)VisualAsteroid():setPosition(-22526, -24062)VisualAsteroid():setPosition(-23550, -24429)VisualAsteroid():setPosition(-11702, -17426)VisualAsteroid():setPosition(-12061, -20402)VisualAsteroid():setPosition(-10582, -18867)Asteroid():setPosition(-11862, -24053)VisualAsteroid():setPosition(-19490, -23979)VisualAsteroid():setPosition(-19993, -24090)Asteroid():setPosition(-21186, -25271)Asteroid():setPosition(-21938, -23635)Asteroid():setPosition(-21588, -27692)Asteroid():setPosition(-16325, -21546)Asteroid():setPosition(-15366, -23071)Asteroid():setPosition(-24386, -17860)VisualAsteroid():setPosition(-25076, -19239)Asteroid():setPosition(-23638, -30393)VisualAsteroid():setPosition(-23069, -30461)Asteroid():setPosition(-22256, -30516)VisualAsteroid():setPosition(-25382, -33464)VisualAsteroid():setPosition(-25738, -31437)VisualAsteroid():setPosition(-22817, -31627)Asteroid():setPosition(-19049, -32366)VisualAsteroid():setPosition(-17822, -29738)Asteroid():setPosition(-15347, -30591)VisualAsteroid():setPosition(-14450, -29769)Asteroid():setPosition(-11929, -31940)Asteroid():setPosition(-11683, -30710)VisualAsteroid():setPosition(-12018, -30268)Asteroid():setPosition(-10838, -29992)VisualAsteroid():setPosition(-13391, -27457)Asteroid():setPosition(-14523, -28666)VisualAsteroid():setPosition(-17677, -27828)Asteroid():setPosition(-17076, -27704)VisualAsteroid():setPosition(-16140, -29640)Asteroid():setPosition(-16151, -28318)Asteroid():setPosition(-14557, -19395)Asteroid():setPosition(-15758, -18650)Asteroid():setPosition(-17305, -18408)VisualAsteroid():setPosition(-18523, -18990)VisualAsteroid():setPosition(-17838, -19059)Asteroid():setPosition(-17418, -18901)VisualAsteroid():setPosition(-20805, -18035)Asteroid():setPosition(-19448, -17494)Asteroid():setPosition(-27710, -25443)VisualAsteroid():setPosition(-29190, -25958)Asteroid():setPosition(-29111, -24618)VisualAsteroid():setPosition(-7596, -22622)VisualAsteroid():setPosition(-8979, -32007)Asteroid():setPosition(-7791, -32129)Asteroid():setPosition(-10021, -30753)VisualAsteroid():setPosition(-4308, -33334)Asteroid():setPosition(-5764, -31965)VisualAsteroid():setPosition(-2243, -28977)VisualAsteroid():setPosition(-2151, -29624)VisualAsteroid():setPosition(-6335, -29234)Asteroid():setPosition(-6803, -27901)VisualAsteroid():setPosition(-5713, -27987)Mine():setPosition(-19759, -21363)Mine():setPosition(-20604, -21164)Mine():setPosition(-21556, -20971)Mine():setPosition(-18769, -21589)Mine():setPosition(-18411, -20597)Mine():setPosition(-17479, -20774)Mine():setPosition(-17713, -21702)VisualAsteroid():setPosition(-9240, -21843)Asteroid():setPosition(-10280, -21532)Asteroid():setPosition(-9345, -26367)Mine():setPosition(-16584, -20988)VisualAsteroid():setPosition(-6684, -19126)VisualAsteroid():setPosition(-9095, -17081)Mine():setPosition(-26170, -17885)Mine():setPosition(-26229, -18877)Mine():setPosition(-24313, -19309)Mine():setPosition(-23389, -19368)Mine():setPosition(-26579, -19759)Mine():setPosition(-23642, -20527)Mine():setPosition(-25095, -17986)Mine():setPosition(-24153, -18182)Mine():setPosition(-23213, -18399)Mine():setPosition(-22635, -20575)Mine():setPosition(-24542, -20206)Mine():setPosition(-25282, -18986)Mine():setPosition(-25471, -20062)Mine():setPosition(-20292, -19196)Mine():setPosition(-20437, -20174)Mine():setPosition(-18267, -19609)Mine():setPosition(-17228, -19847)Mine():setPosition(-21355, -19846)Mine():setPosition(-21277, -18955)Mine():setPosition(-22217, -18796)Mine():setPosition(-22449, -19587)VisualAsteroid():setPosition(2916, -30960)VisualAsteroid():setPosition(24943, -27861)VisualAsteroid():setPosition(26450, -29949)Asteroid():setPosition(24392, -22321)Asteroid():setPosition(24742, -24498)VisualAsteroid():setPosition(23964, -23404)Asteroid():setPosition(23885, -31051)Asteroid():setPosition(23162, -29908)VisualAsteroid():setPosition(23737, -33016)VisualAsteroid():setPosition(25863, -18460)Asteroid():setPosition(25517, -20130)Asteroid():setPosition(24917, -21941)Asteroid():setPosition(24975, -23263)VisualAsteroid():setPosition(11438, -27119)VisualAsteroid():setPosition(11973, -27913)VisualAsteroid():setPosition(11555, -22761)Asteroid():setPosition(11878, -29534)Asteroid():setPosition(11108, -28997)VisualAsteroid():setPosition(12519, -29956)VisualAsteroid():setPosition(14358, -27719)Asteroid():setPosition(17282, -28342)VisualAsteroid():setPosition(19320, -21389)Asteroid():setPosition(17814, -23044)VisualAsteroid():setPosition(21245, -25217)VisualAsteroid():setPosition(19005, -27286)Asteroid():setPosition(21666, -26822)VisualAsteroid():setPosition(11133, -20976)Asteroid():setPosition(10401, -20949)Asteroid():setPosition(19776, -21366)Asteroid():setPosition(13362, -21308)Asteroid():setPosition(16105, -21488)Asteroid():setPosition(10918, -22803)Asteroid():setPosition(11488, -22857)VisualAsteroid():setPosition(17619, -33752)VisualAsteroid():setPosition(12873, -33205)VisualAsteroid():setPosition(14814, -32614)VisualAsteroid():setPosition(16849, -32882)VisualAsteroid():setPosition(13876, -30981)VisualAsteroid():setPosition(11092, -31660)Asteroid():setPosition(10267, -31041)VisualAsteroid():setPosition(11241, -32216)Asteroid():setPosition(11306, -32644)Asteroid():setPosition(10548, -33792)Asteroid():setPosition(9807, -33972)VisualAsteroid():setPosition(5738, -32131)VisualAsteroid():setPosition(6899, -30699)Asteroid():setPosition(9135, -28585)Asteroid():setPosition(7778, -30595)Asteroid():setPosition(8180, -30863)VisualAsteroid():setPosition(10046, -26365)Asteroid():setPosition(9981, -24146)Asteroid():setPosition(7465, -24652)Asteroid():setPosition(4683, -24015)Asteroid():setPosition(3858, -25062)Asteroid():setPosition(5017, -22679)VisualAsteroid():setPosition(618, -26244)Asteroid():setPosition(3018, -26286)VisualAsteroid():setPosition(4259, -22689)VisualAsteroid():setPosition(6397, -19237)VisualAsteroid():setPosition(4887, -18981)Asteroid():setPosition(3620, -20049)VisualAsteroid():setPosition(1238, -21049)Asteroid():setPosition(1127, -18336)Asteroid():setPosition(-2, -17856)Asteroid():setPosition(4914, -33691)Asteroid():setPosition(6193, -29753)VisualAsteroid():setPosition(-65, -29591)VisualAsteroid():setPosition(1976, -30627)Asteroid():setPosition(18766, -30776)VisualAsteroid():setPosition(4707, -31383)Asteroid():setPosition(4681, -28665)VisualAsteroid():setPosition(6207, -27329)VisualAsteroid():setPosition(-1658, -30625)VisualAsteroid():setPosition(-475, -29432)VisualAsteroid():setPosition(-314, -30561)Asteroid():setPosition(-4909, -24957)Asteroid():setPosition(-4053, -23593)Asteroid():setPosition(-3176, -28370)Asteroid():setPosition(-3091, -25348)Asteroid():setPosition(-4040, -20321)VisualAsteroid():setPosition(-1437, -18726)Asteroid():setPosition(-1930, -17772)Asteroid():setPosition(-1447, -18089)VisualAsteroid():setPosition(-1789, -17825)VisualAsteroid():setPosition(-687, -23718)Asteroid():setPosition(218, -25046)Asteroid():setPosition(16624, -33762)Asteroid():setPosition(14875, -32058)Asteroid():setPosition(16196, -16969)VisualAsteroid():setPosition(230, -33851)VisualAsteroid():setPosition(-4724, -33599)Asteroid():setPosition(-4393, -20234)VisualAsteroid():setPosition(-4730, -17710)VisualAsteroid():setPosition(-3258, -17326)Asteroid():setPosition(233, -17372)VisualAsteroid():setPosition(2243, -16935)VisualAsteroid():setPosition(8374, -17732)VisualAsteroid():setPosition(8452, -17786)VisualAsteroid():setPosition(6465, -17813)Asteroid():setPosition(13839, -17632)VisualAsteroid():setPosition(16828, -18208)VisualAsteroid():setPosition(18006, -17496)VisualAsteroid():setPosition(23217, -17292)Asteroid():setPosition(24278, -18359)

     Mine():setPosition(16724, -26504)Asteroid():setPosition(18666, -28441)Mine():setPosition(18407, -27883)Mine():setPosition(16580, -27492)Mine():setPosition(17512, -27669)VisualAsteroid():setPosition(20143, -27808)VisualAsteroid():setPosition(20271, -27911)Mine():setPosition(14699, -26091)Mine():setPosition(14554, -27069)Mine():setPosition(14387, -28059)Mine():setPosition(13435, -27866)Mine():setPosition(15232, -28258)VisualAsteroid():setPosition(16868, -25315)Mine():setPosition(17278, -28597)Asteroid():setPosition(15927, -24502)Asteroid():setPosition(15839, -25471)Mine():setPosition(16222, -28484)Mine():setPosition(17763, -26742)Asteroid():setPosition(10605, -24755)VisualAsteroid():setPosition(11992, -25933)Mine():setPosition(12774, -25691)Mine():setPosition(10449, -27101)VisualAsteroid():setPosition(8710, -25514)Asteroid():setPosition(8484, -25838)VisualAsteroid():setPosition(9915, -26134)Mine():setPosition(9520, -26957)Mine():setPosition(11349, -27422)Mine():setPosition(17763, -26742)Mine():setPosition(18407, -27883)Mine():setPosition(10449, -27101)Mine():setPosition(12542, -26482)Mine():setPosition(12356, -27470)Mine():setPosition(16724, -26504)Mine():setPosition(13636, -26741)Mine():setPosition(14554, -27069)Mine():setPosition(11602, -26263)Mine():setPosition(10678, -26204)Mine():setPosition(11349, -27422)Mine():setPosition(9520, -26957)Mine():setPosition(8412, -26654)Mine():setPosition(11778, -25294)Mine():setPosition(10838, -25077)Mine():setPosition(9896, -24881)Mine():setPosition(12774, -25691)Mine():setPosition(13714, -25850)Mine():setPosition(14699, -26091)Mine():setPosition(8821, -24780)Mine():setPosition(9709, -25881)Mine():setPosition(8762, -25772)Mine():setPosition(17278, -28597)Mine():setPosition(17512, -27669)Mine():setPosition(16580, -27492)Mine():setPosition(16222, -28484)Mine():setPosition(14387, -28059)Mine():setPosition(13435, -27866)Mine():setPosition(15232, -28258)Mine():setPosition(8762, -25772)Mine():setPosition(9709, -25881)Mine():setPosition(8412, -26654)Mine():setPosition(10678, -26204)Mine():setPosition(9896, -24881)Mine():setPosition(8821, -24780)Mine():setPosition(10838, -25077)VisualAsteroid():setPosition(14186, -24930)Mine():setPosition(13714, -25850)Mine():setPosition(13636, -26741)Mine():setPosition(11602, -26263)Mine():setPosition(11778, -25294)Mine():setPosition(12542, -26482)Mine():setPosition(12356, -27470)Asteroid():setPosition(17573, -25796)VisualAsteroid():setPosition(17153, -25954)Asteroid():setPosition(15543, -24389)VisualAsteroid():setPosition(16468, -25885)Asteroid():setPosition(17686, -25303)Asteroid():setPosition(19233, -25545)Asteroid():setPosition(20434, -26290)

     Asteroid():setPosition(-23140, -10801)VisualAsteroid():setPosition(-24211, -12972)Asteroid():setPosition(-22005, -12754)Asteroid():setPosition(-11060, -11794)VisualAsteroid():setPosition(-11965, -10466)Asteroid():setPosition(-14369, -12096)Asteroid():setPosition(-16187, -11705)Asteroid():setPosition(-15331, -10341)VisualAsteroid():setPosition(-10660, -12992)VisualAsteroid():setPosition(-16991, -14735)Asteroid():setPosition(-18081, -14649)VisualAsteroid():setPosition(-17613, -15982)VisualAsteroid():setPosition(-11592, -17309)VisualAsteroid():setPosition(-11343, -16339)VisualAsteroid():setPosition(-11753, -16180)VisualAsteroid():setPosition(-12936, -17373)VisualAsteroid():setPosition(-13429, -16372)Asteroid():setPosition(-14454, -15118)VisualAsteroid():setPosition(-13521, -15725)Asteroid():setPosition(-20623, -13115)Asteroid():setPosition(-19069, -18877)VisualAsteroid():setPosition(-20257, -18755)Asteroid():setPosition(-21299, -17501)Asteroid():setPosition(-22116, -16740)VisualAsteroid():setPosition(-23296, -17016)VisualAsteroid():setPosition(-24669, -14205)Asteroid():setPosition(-22961, -17458)Asteroid():setPosition(-23207, -18688)VisualAsteroid():setPosition(-16002, -20347)VisualAsteroid():setPosition(-15586, -20082)Asteroid():setPosition(-17042, -18713)VisualAsteroid():setPosition(-11048, -20599)

     VisualAsteroid():setPosition(12526, -11966)VisualAsteroid():setPosition(9993, -11938)VisualAsteroid():setPosition(8969, -12305)VisualAsteroid():setPosition(13029, -11855)Asteroid():setPosition(3408, -12494)VisualAsteroid():setPosition(3329, -13834)Asteroid():setPosition(4809, -13319)VisualAsteroid():setPosition(18824, -12852)Asteroid():setPosition(10581, -11511)Asteroid():setPosition(11333, -13147)VisualAsteroid():setPosition(1953, -20352)Asteroid():setPosition(15443, -15580)VisualAsteroid():setPosition(14842, -15704)Asteroid():setPosition(16368, -16194)VisualAsteroid():setPosition(16379, -17516)VisualAsteroid():setPosition(18069, -17645)Asteroid():setPosition(17172, -18467)Asteroid():setPosition(17996, -16542)VisualAsteroid():setPosition(9702, -19503)VisualAsteroid():setPosition(6781, -19313)VisualAsteroid():setPosition(14697, -17614)Asteroid():setPosition(13470, -20242)Asteroid():setPosition(8881, -18269)Asteroid():setPosition(10931, -15568)Asteroid():setPosition(10263, -18392)VisualAsteroid():setPosition(9450, -18337)VisualAsteroid():setPosition(127, -18203)VisualAsteroid():setPosition(1214, -17592)VisualAsteroid():setPosition(7137, -21340)VisualAsteroid():setPosition(4007, -20478)VisualAsteroid():setPosition(843, -16296)Asteroid():setPosition(345, -14432)VisualAsteroid():setPosition(1817, -15039)Asteroid():setPosition(6324, -14260)Asteroid():setPosition(5846, -14217)VisualAsteroid():setPosition(5592, -17543)Asteroid():setPosition(4477, -14756)VisualAsteroid():setPosition(3975, -14119)Asteroid():setPosition(5505, -14178)

     SpaceStation():setTemplate("Medium Station"):setFaction("Independent"):setCallSign("DS2768"):setPosition(45895, 3355)
     SpaceStation():setTemplate("Medium Station"):setFaction("Independent"):setCallSign("DS2769"):setPosition(220, 108)
     SpaceStation():setTemplate("Medium Station"):setFaction("Independent"):setCallSign("DS2771"):setPosition(-9304, 10823)
     SpaceStation():setTemplate("Medium Station"):setFaction("Independent"):setCallSign("DS2770"):setPosition(4, -21863)

end

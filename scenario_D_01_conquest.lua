--Name: Conquete

printTimer = 0;

function init()
    fuelStation = mkConquestStation("Loyal Barons", "Fuel",-9305, 492);
    ammoStation = mkConquestStation("Loyal Barons", "Ammo",40622, -70410);
    engiStation = mkConquestStation("Loyal Barons", "Engi",-59380, -68638);
    stations = {fuelStation, ammoStation, engiStation};
    drawMap();

    SpaceStation():setTemplate("Large Station"):setPosition(-54970, -25095):setFaction("Rebels"):setCallSign("Supply");
    SpaceStation():setTemplate("Large Station"):setPosition(36027, -27490):setFaction("Rebels"):setCallSign("Supply");
    SpaceStation():setTemplate("Large Station"):setPosition(-11129, -85331):setFaction("Rebels"):setCallSign("Supply");
    SpaceStation():setTemplate("Large Station"):setPosition(-10945, -38542):setFaction("Rebels"):setCallSign("Supply");
    
    playerShipsGM();
end

function playerShipsGM()
    addGMFunction("all_playership", function() Script():run("playership/all_playership.lua"); end);
    addGMFunction("nexusVoid", function() Script():run("playership/nexusVoid.lua"); end);
    addGMFunction("succubiCherubim", function() Script():run("playership/succubiCherubim.lua"); end);
    addGMFunction("vasserand", function() Script():run("playership/vasserand.lua"); end);
    addGMFunction("viceImperiumDoleo", function() Script():run("playership/viceImperiumDoleo.lua"); end);
end

function update()
    printTimer = printTimer + 1;

    for i,station in pairs(stations) do
        local faction = split(station:getFaction(), " ")[2];
        station:setShields(1000,1000,1000);

        station.data.respawnTimer = station.data.respawnTimer + 1;
        station.data.pointTimer = station.data.pointTimer + 1;
        
        if station.data.pointTimer == 60 then
            station.data.points[faction] = station.data.points[faction] + 1;
            station.data.pointTimer = 0;
        end

        if printTimer > 60 * 5 then
            print(station:getCallSign());
            for fac,points in pairs(station.data.points) do
                print(fac, points)
            end
        end

        local hornets = countLivingAndDead(station.data.troops.hornets).living;
        local atlantis = countLivingAndDead(station.data.troops.atlantis).living;
        if station.data.respawnTimer >= 1000 then
            local x,y = station:getPosition();

            function addHornets()
                mobs = generateMobs(irandom(1,3), "MU52 Hornet", faction, x, y, 1000, function(mob) mob:orderDefendTarget(station) end);
                for i,mob in pairs(mobs) do
                    table.insert(station.data.troops.hornets, mob);
                    mob:setScannedByFaction(faction, true);
                end
            end

            function addAtlantis()
                mobs = generateMobs(1, "Atlantis X23", faction, x, y, 1000, function(mob) mob:orderDefendTarget(station) end);
                for i,mob in pairs(mobs) do
                    table.insert(station.data.troops.atlantis, mob);
                    mob:setScannedByFaction(faction, true);
                end
            end

            if hornets < 6 then
                addHornets();
                station.data.respawnTimer = 0;
            else if atlantis < 1 then
                addAtlantis();
                station.data.respawnTimer = 0;
            else if hornets < 12 then
                addHornets();
                station.data.respawnTimer = 0;
            else if atlantis < 2 then
                addAtlantis();
                station.data.respawnTimer = 0;
            else
                station.data.respawnTimer = 0;
            end end end end
        end
    end
    if printTimer > 60 * 5 then
        printTimer = 0;
    end
end

function mkConquestStation(faction, callSign, x, y)
    local station = SpaceStation():setTemplate("Large Station"):setFaction(faction):setCallSign(callSign):setPosition(x, y):setCommsFunction(stationComms(100));
    station.data = { points = { Vindh = 0
                              , Arianne = 0
                              , Merillon = 0
                              , Barons = 0
                              }
                   , troops = { hornets = {}
                              , atlantis = {}
                              }
                   , respawnTimer = 750
                   , pointTimer = 0
                   };
    return station;
end

function stationComms(price)
    return function()
    local points = comms_target.data.points;
        local commsMessage = "Statut de la station : \nVindh : " .. points.Vindh .. "\nMerillon : " .. points.Merillon .. "\nArianne : " .. points.Arianne;
    
        if comms_source:isDocked(comms_target) then
            if split(comms_target:getFaction(), " ")[2] == comms_source:getFaction() then
                commsMessage = commsMessage .. "\n\nAcheter";
                addCommsReply("yes", supplyComms);
            else
                commsMessage = commsMessage .. "\n\nConvertir?";
                addCommsReply("oui", convertStationComms(price));
            end
        else
            commsMessage = commsMessage .. "\n\nPas dock";
        end
        setCommsMessage(commsMessage);
    end
end

function convertStationComms(price)
    return function()
        setCommsMessage("Obtenir la loyauté de la station pour sa faction (".. price .." crédits)")
        addCommsReply("J'ai les crédits", function()
            if not comms_source:takeReputationPoints(price) then setCommsMessage("On ne s'allie pas à des pauvres"); return end
            setCommsMessage("Vos arguments sont convaincants")
            comms_target:setFaction("Loyal " .. comms_source:getFaction())
            addCommsReply("Acheter des trucs?", supplyComms)
        end)
    end
end

function supplyComms()
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
                addCommsReply("Je veux acheter autre chose.", supplyComms) 
                return;
            end
            if comms_source:getWeaponStorage(weapon) == comms_source:getWeaponStorageMax(weapon) then
                setCommsMessage("Pas assez de place dans ton vaisseau");
                addCommsReply("Je veux acheter autre chose.", supplyComms) 
                return
            end
            setCommsMessage("Merci");
            addCommsReply("Je veux acheter autre chose.", supplyComms) 
    
            comms_source:setWeaponStorage(weapon, comms_source:getWeaponStorage(weapon) + 1);
        end)
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

function split(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end

function drawMap()
    Nebula():setPosition(-55176, -75492)
    Nebula():setPosition(-46884, -76138)
    Nebula():setPosition(-50976, -64831)
    Nebula():setPosition(-40854, -68923)
    Nebula():setPosition(-42685, -61709)
    Nebula():setPosition(-50653, -55140)
    Nebula():setPosition(-42254, -52663)
    Nebula():setPosition(-33316, -63001)
    Nebula():setPosition(-32670, -56432)
    Nebula():setPosition(21926, -35326)
    Nebula():setPosition(28817, -35972)
    Nebula():setPosition(34632, -38880)
    Nebula():setPosition(27525, -44264)
    Nebula():setPosition(18587, -43187)
    Nebula():setPosition(12988, -35972)
    Nebula():setPosition(25587, -27358)
    Nebula():setPosition(15895, -26819)
    Nebula():setPosition(21495, -18420)
    Nebula():setPosition(11157, -18635)
    Nebula():setPosition(5773, -26388)
    Nebula():setPosition(1250, -17235)
    Nebula():setPosition(6204, -10774)
    Nebula():setPosition(42708, -36295)
    Nebula():setPosition(-46669, -17343)
    Nebula():setPosition(-50761, -10667)
    Nebula():setPosition(-42792, -9913)
    Nebula():setPosition(-28040, -32419)
    Nebula():setPosition(-23302, -27681)
    Nebula():setPosition(-25778, -21112)
    Nebula():setPosition(-65837, -37803)
    Nebula():setPosition(-71759, -42110)
    Nebula():setPosition(-73590, -31234)
    Asteroid():setPosition(8706, -78490)
    Asteroid():setPosition(7790, -78547)
    Asteroid():setPosition(6803, -81790)
    Asteroid():setPosition(6017, -80379)
    Asteroid():setPosition(6963, -79404)
    Asteroid():setPosition(6948, -78095)
    Asteroid():setPosition(6046, -78197)
    Asteroid():setPosition(6003, -77920)
    Asteroid():setPosition(6366, -77528)
    Asteroid():setPosition(7850, -77047)
    Asteroid():setPosition(8301, -78357)
    Asteroid():setPosition(9116, -78633)
    Asteroid():setPosition(8025, -79695)
    Asteroid():setPosition(7574, -80495)
    Asteroid():setPosition(8432, -80160)
    Asteroid():setPosition(9203, -77513)
    Asteroid():setPosition(9392, -77266)
    Asteroid():setPosition(9683, -78138)
    Asteroid():setPosition(9625, -79055)
    Asteroid():setPosition(11225, -77978)
    Asteroid():setPosition(10643, -78371)
    Asteroid():setPosition(11719, -78648)
    Asteroid():setPosition(13378, -78298)
    Asteroid():setPosition(12665, -77644)
    Asteroid():setPosition(8548, -80917)
    Asteroid():setPosition(10483, -80771)
    Asteroid():setPosition(12272, -78298)
    Asteroid():setPosition(12607, -81062)
    Asteroid():setPosition(15982, -77149)
    Asteroid():setPosition(14032, -81528)
    Asteroid():setPosition(14003, -77702)
    Asteroid():setPosition(21337, -71643)
    Asteroid():setPosition(6369, -76970)
    Asteroid():setPosition(7455, -76411)
    Asteroid():setPosition(10030, -76101)
    Asteroid():setPosition(15026, -75915)
    Asteroid():setPosition(16236, -76008)
    Asteroid():setPosition(7672, -75573)
    Asteroid():setPosition(5345, -76194)
    Asteroid():setPosition(4569, -76628)
    Asteroid():setPosition(13382, -73960)
    Asteroid():setPosition(13878, -73680)
    Asteroid():setPosition(5345, -72656)
    Asteroid():setPosition(13723, -72967)
    Asteroid():setPosition(7517, -72874)
    Asteroid():setPosition(4507, -74084)
    Asteroid():setPosition(14747, -72625)
    Asteroid():setPosition(13071, -72998)
    Asteroid():setPosition(20270, -72222)
    Asteroid():setPosition(18191, -73339)
    Asteroid():setPosition(17229, -72812)
    Asteroid():setPosition(15150, -79514)
    Asteroid():setPosition(18005, -79452)
    Asteroid():setPosition(19184, -74953)
    Asteroid():setPosition(19308, -73029)
    Asteroid():setPosition(17509, -78149)
    Asteroid():setPosition(18067, -81717)
    Asteroid():setPosition(20798, -76380)
    Asteroid():setPosition(21543, -70701)
    Asteroid():setPosition(24832, -71850)
    Asteroid():setPosition(25266, -76752)
    Asteroid():setPosition(16485, -82865)
    Asteroid():setPosition(26632, -76752)
    Asteroid():setPosition(24025, -72284)
    Asteroid():setPosition(27221, -76287)
    Asteroid():setPosition(8603, -70081)
    Asteroid():setPosition(14312, -70360)
    Asteroid():setPosition(21574, -67536)
    Asteroid():setPosition(-8237, -63075)
    Asteroid():setPosition(-7886, -63225)
    Asteroid():setPosition(-7904, -60619)
    Asteroid():setPosition(-14216, -60125)
    Asteroid():setPosition(-6477, -59576)
    Asteroid():setPosition(-14875, -61936)
    Asteroid():setPosition(-12130, -66053)
    Asteroid():setPosition(-14655, -61826)
    Asteroid():setPosition(-11636, -59740)
    Asteroid():setPosition(-10813, -59850)
    Asteroid():setPosition(-10209, -66218)
    Asteroid():setPosition(-10593, -60454)
    Asteroid():setPosition(-9166, -64242)
    Asteroid():setPosition(-7629, -62046)
    Asteroid():setPosition(-5928, -55404)
    Asteroid():setPosition(-11033, -59027)
    Asteroid():setPosition(-10099, -56502)
    Asteroid():setPosition(-5928, -54745)
    Asteroid():setPosition(-8068, -57710)
    Asteroid():setPosition(-6916, -56502)
    Asteroid():setPosition(-6422, -55788)
    Asteroid():setPosition(-6477, -55349)
    Asteroid():setPosition(-6257, -58698)
    Asteroid():setPosition(-7520, -54196)
    Asteroid():setPosition(-5494, -55040)
    Asteroid():setPosition(-1529, -54968)
    Asteroid():setPosition(-2827, -53094)
    Asteroid():setPosition(-4629, -56770)
    Asteroid():setPosition(-5566, -64771)
    Asteroid():setPosition(-6719, -67222)
    Asteroid():setPosition(-2034, -58500)
    Asteroid():setPosition(1642, -52084)
    Asteroid():setPosition(-3908, -55112)
    Asteroid():setPosition(-6647, -53310)
    Asteroid():setPosition(2651, -54247)
    Asteroid():setPosition(-2034, -56626)
    Asteroid():setPosition(-3980, -59797)
    Asteroid():setPosition(-13783, -59076)
    Asteroid():setPosition(-8305, -55544)
    Asteroid():setPosition(-1385, -52517)
    Asteroid():setPosition(4526, -51003)
    Asteroid():setPosition(4093, -49562)
    Asteroid():setPosition(3733, -48480)
    Asteroid():setPosition(7193, -46678)
    Asteroid():setPosition(2507, -48552)
    Asteroid():setPosition(777, -51508)
    Asteroid():setPosition(-3836, -51292)
    Asteroid():setPosition(-376, -49562)
    Asteroid():setPosition(4742, -47039)
    Asteroid():setPosition(-5710, -58644)
    Asteroid():setPosition(417, -53814)
    Asteroid():setPosition(1354, -52949)
    Asteroid():setPosition(1210, -55544)
    Asteroid():setPosition(1210, -54031)
    Asteroid():setPosition(3516, -51364)
    Asteroid():setPosition(-1890, -60734)
    Asteroid():setPosition(-4052, -62680)
    Asteroid():setPosition(-9386, -68519)
    Asteroid():setPosition(2291, -55040)
    Asteroid():setPosition(2724, -57418)
    Asteroid():setPosition(4237, -52805)
    Asteroid():setPosition(8058, -48697)
    Asteroid():setPosition(8995, -48841)
    Asteroid():setPosition(5174, -54463)
    Asteroid():setPosition(9571, -49345)
    Asteroid():setPosition(5967, -47183)
    Asteroid():setPosition(2796, -43939)
    Asteroid():setPosition(-3331, -43363)
    Asteroid():setPosition(-6287, -46390)
    Asteroid():setPosition(-3908, -48336)
    Asteroid():setPosition(777, -45381)
    Asteroid():setPosition(3805, -46678)
    Asteroid():setPosition(3012, -45309)
    Asteroid():setPosition(-3187, -44876)
    Asteroid():setPosition(-808, -44588)
    Asteroid():setPosition(-376, -42858)
    Asteroid():setPosition(-3548, -51292)
    Asteroid():setPosition(-7440, -52949)
    Asteroid():setPosition(-6215, -51219)
    Asteroid():setPosition(4165, -43867)
    Asteroid():setPosition(7337, -42137)
    Asteroid():setPosition(6472, -43002)
    Asteroid():setPosition(5318, -45092)
    Asteroid():setPosition(4670, -43146)
    Asteroid():setPosition(9715, -46534)
    Asteroid():setPosition(2363, -41705)
    Asteroid():setPosition(-41462, -44948)
    Asteroid():setPosition(-36993, -41128)
    Asteroid():setPosition(-36993, -44083)
    Asteroid():setPosition(-39877, -42714)
    Asteroid():setPosition(-39660, -40768)
    Asteroid():setPosition(-43048, -42714)
    Asteroid():setPosition(-42327, -48048)
    Asteroid():setPosition(-44274, -42209)
    Asteroid():setPosition(-43337, -46318)
    Asteroid():setPosition(-41246, -39542)
    Asteroid():setPosition(-40742, -39831)
    Asteroid():setPosition(-40886, -42642)
    Asteroid():setPosition(-40381, -40984)
    Asteroid():setPosition(-41030, -40768)
    Asteroid():setPosition(-39300, -47832)
    Asteroid():setPosition(-38579, -42570)
    Asteroid():setPosition(-39949, -46895)
    Asteroid():setPosition(-38579, -45092)
    Asteroid():setPosition(-39084, -40840)
    Asteroid():setPosition(-30636, -13882)
    Asteroid():setPosition(-34467, -10864)
    Asteroid():setPosition(-28663, -14811)
    Asteroid():setPosition(-33538, -11445)
    Asteroid():setPosition(-32377, -11909)
    Asteroid():setPosition(-32958, -18410)
    Asteroid():setPosition(-34235, -13186)
    Asteroid():setPosition(-33770, -15043)
    Asteroid():setPosition(-37485, -21080)
    Asteroid():setPosition(-32261, -22241)
    Asteroid():setPosition(-36789, -17365)
    Asteroid():setPosition(-34699, -15740)
    Asteroid():setPosition(-29243, -16669)
    Asteroid():setPosition(-62096, -51147)
    Asteroid():setPosition(-64766, -46851)
    Asteroid():setPosition(-61399, -44414)
    Asteroid():setPosition(-64766, -49173)
    Asteroid():setPosition(-67320, -46619)
    Asteroid():setPosition(-68713, -51031)
    Asteroid():setPosition(-58845, -43949)
    Asteroid():setPosition(-62096, -41163)
    Asteroid():setPosition(-63489, -39770)
    Asteroid():setPosition(-68248, -46619)
    Asteroid():setPosition(-62444, -43137)
    Asteroid():setPosition(-64534, -42556)
    Asteroid():setPosition(-13041, -101268)
    Asteroid():setPosition(-7701, -99874)
    Asteroid():setPosition(-11880, -96740)
    Asteroid():setPosition(-15131, -97088)
    Asteroid():setPosition(-16176, -90936)
    Asteroid():setPosition(-11532, -90936)
    Asteroid():setPosition(-10487, -88382)
    Asteroid():setPosition(-11532, -88614)
    Asteroid():setPosition(13013, -11793)
    Asteroid():setPosition(12433, -9355)
    Asteroid():setPosition(15103, -11096)
    Asteroid():setPosition(15451, -9819)
    Asteroid():setPosition(13710, -8078)
    Asteroid():setPosition(14638, -9819)
    Asteroid():setPosition(14638, -5988)
    Asteroid():setPosition(9530, -8775)
    Asteroid():setPosition(8486, -7149)
    Asteroid():setPosition(10575, -9703)
    Asteroid():setPosition(8253, -11793)
    Asteroid():setPosition(5700, -7149)
    Asteroid():setPosition(4887, -5292)
    Asteroid():setPosition(9879, -11096)
    Asteroid():setPosition(9879, -9935)
    Asteroid():setPosition(5351, -8658)
    Asteroid():setPosition(18121, -3202)
    Asteroid():setPosition(40526, -76222)
    Asteroid():setPosition(37392, -75873)
    Asteroid():setPosition(41106, -79472)
    Asteroid():setPosition(45402, -76686)
    Asteroid():setPosition(41338, -76106)
    Asteroid():setPosition(41803, -78892)
    Asteroid():setPosition(41803, -78892)
    Asteroid():setPosition(-5329, -85393)
    Asteroid():setPosition(-9276, -81329)
    Asteroid():setPosition(-4516, -83535)
    Asteroid():setPosition(-5213, -86437)
    Asteroid():setPosition(-6141, -83071)
    Asteroid():setPosition(-7186, -80981)
    Asteroid():setPosition(-9276, -80517)
    Asteroid():setPosition(-7999, -81446)
    Asteroid():setPosition(-9972, -81213)
    Asteroid():setPosition(-6954, -83883)
    Asteroid():setPosition(-6838, -81329)
    Asteroid():setPosition(-7651, -78543)
    Asteroid():setPosition(-3471, -85044)
    Asteroid():setPosition(-3588, -88875)
    Asteroid():setPosition(-1962, -84928)
    Asteroid():setPosition(-3355, -88527)
    Asteroid():setPosition(-2543, -85044)
    Asteroid():setPosition(-4168, -92822)
    Asteroid():setPosition(-5677, -90152)
    Asteroid():setPosition(-6258, -87830)
    Asteroid():setPosition(-5213, -89572)
    Asteroid():setPosition(-6954, -88875)
    Asteroid():setPosition(-6954, -87018)
    Asteroid():setPosition(-5097, -85044)
    Asteroid():setPosition(-4400, -90384)
    Asteroid():setPosition(-3239, -86902)
    Asteroid():setPosition(-3007, -90965)
    Asteroid():setPosition(-1730, -88179)
    Asteroid():setPosition(-6360, -80182)
    Asteroid():setPosition(-6910, -79133)
    Asteroid():setPosition(-8059, -79183)
    Asteroid():setPosition(-3911, -83031)
    Asteroid():setPosition(-4061, -84130)
    Asteroid():setPosition(-4561, -90677)
    Asteroid():setPosition(-7060, -90776)
    Asteroid():setPosition(-7060, -89027)
    Asteroid():setPosition(-7060, -88328)
    Asteroid():setPosition(-6860, -83431)
    Asteroid():setPosition(-6810, -82681)
    Asteroid():setPosition(-7459, -82481)
    Asteroid():setPosition(-5960, -81282)
    Asteroid():setPosition(-5560, -81132)
end

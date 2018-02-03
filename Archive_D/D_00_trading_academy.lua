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
    --[[{{utils/allShips.lua}}]]--
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

--[[{{utils/dussel.lua}}]]--

--[[{{utils/trading.lua}}]]--

--[[{{utils/shipUpdate.lua}}]]--

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

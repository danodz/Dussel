--Name: Succubi Cherubim quest
--Description: Quest personalisée du Succubi Cherubim
--https://www.youtube.com/watch?v=9ETFPdNIeYg
require("utils.lua");
players = {};
availableItems = { technologie = {amount = 0, value = 5}
                 , matiere_premiere = {amount = 0, value = 5}
                 , produit_chimique = {amount = 0, value = 5}
                 , travailleur = {amount = 0, value = 5}
                 , drogue = {amount = 0, value = 5}
                 }
function init()
    --[[{{playership/succubiCherubim.lua}}]]--
    addGMFunction("save", save);
    spawnSuccubiCherubim(-57620, 40847);
    succubiCherubim.inventory.produit_chimique.amount = 10;
    succubiCherubim.inventory.drogue.amount = 30;

    SpaceStation():setTemplate("Medium Station"):setFaction("Independent"):setCallSign("nissan petrol"):setPosition(901, -13681)
    SpaceStation():setTemplate("Medium Station"):setFaction("Independent"):setCallSign("caravan petrol"):setPosition(6431, 30917)


    --LABO
    labo = SpaceStation():setTemplate("Small Station"):setFaction("Independent"):setCallSign("labo"):setPosition(-28093, 42285)
    labo.inventory = makeInventory( { technologie = {amount = 0, value = 0}
                                    , matiere_premiere = {amount = 0, value = 0}
                                    , produit_chimique = {amount = 0, value = 0}
                                    , travailleur = {amount = 0, value = 0}
                                    , drogue = {amount = 0, value = 0}
                                    });
    labo:setCommsFunction(function()
        if comms_source:isDocked(comms_target) then
            setCommsMessage("Yo étranger. J’ai entendu dire que vous seriez interessé à vous installer dans la région pour transmettre la \"bonne nouvelle\". Si tu nous fournis 25 ressource de tecnologie, 35 matières premières, 10 produit chimique et 15 travailleurs, on pourra transformer ce trou en labo qui fait du bon stock.");
            tradeSellComm();
        else
            setCommsMessage("Venez nous voir sur place.");
        end
    end);

    --La bande des fassmasha
    fassmashaIsOn = true;
    hellPit = SpaceStation():setTemplate("Small Station"):setFaction("Charognards"):setCallSign("hell pitt"):setPosition(29781, 48526)
    hellPit:setCommsFunction(function()
        setCommsMessage("j’vai vous chrusher la fass.");
    end);
    fassmashaGangs = { fassmashaGang(), fassmashaGang(), fassmashaGang()}

    --Le sherif
    lawIsOn = true;
    lawSpawn = 0;
    blockadeSpawn = 0;
    lawbringer = CpuShip():setFaction("Gentil"):setTemplate("Destroyer"):setCallSign("Lawbringer"):setPosition(-52572, 2450):orderRoaming():setHullMax(200):setHull(200):setShieldsMax(100.00, 102.00):setShields(100.00, 102.00):setWeaponStorage("Nuke", 0):setWeaponStorage("EMP", 0):setWeaponStorageMax("HVLI", 50):setWeaponStorage("HVLI", 50):setBeamWeapon(5, 121, -180, 2000, 7.9, 11.8):setBeamWeaponTurret(5, 0, 0, 0)
    lawbringer:setCommsFunction(function()
        setCommsMessage("Étranger, vous êtes dans le comté de hustaston et j’en suis son protecteur. Je sais que vous êtes ici pour répandre votre fléau et je ne peux le tolérer. Mais je suis un homme de raison, si vous me prouvez que vous êtes des être de bonne volonté, je saurai me montrer magnanime.")
        addCommsReply("Se montrer magnanime (50 kredits et 20 drogues)", function()
            if comms_source.kredits >= 50 and comms_source.inventory.drogue.amount >= 20 then
                comms_source.kredits = comms_source.kredits - 50
                comms_source.inventory.drogue.amount = comms_source.inventory.drogue.amount - 20
                lawIsOn = false;
                setCommsMessage("Voila un bel exemple de bonne volonté. Moi et mes hommes sauront vous laisser tranquille.")
            else
                setCommsMessage("Il semblerait que vous n'ayez pas suffisament de bonne volonté dans votre soute.")
            end
        end);
    end);

    --Les Merillons
    merillonFalcons = generateMobs(10, "Flavia Falcon", "Merillon", 0, 10000, 60000, function(mob) mob:orderRoaming() end);
    merillonCruisers = generateMobs(2, "Missile Cruiser", "Merillon", 0, 10000, 60000, function(mob) mob:orderRoaming() end);
    merillonFrigates = generateMobs(2, "Frigate", "Merillon", 0, 10000, 60000, function(mob) mob:orderRoaming() end);
    merillonRespawn = 0;

    --Usine de produits chimiques
    beltochen = SpaceStation():setTemplate("Medium Station"):setFaction("Independent"):setCallSign("beltochem corp"):setPosition(29029, -18414)
    beltochen.inventory = makeInventory({ produit_chimique = {amount = 70, value = 3}
                                        });
    beltochen:setCommsFunction(function()
        if comms_source:isDocked(comms_target) then
            setCommsMessage("Bienvenue chez beltochem corp, comment pouvons nous vous être utile?");
            tradeSellComm();
            tradeBuyComm();
        else
            setCommsMessage("Venez nous voir sur place.");
        end
    end);

    --Grosse ville qui achete de la drogue
    derichbourg = SpaceStation():setTemplate("Large Station"):setFaction("Human Navy"):setCallSign("derichbourg"):setPosition(-49757, 2131)
    derichbourg.inventory = makeInventory({ drogue = {amount = 0, value = 16}
                                          });
    derichbourg:setCommsFunction(function()
        if comms_source:isDocked(comms_target) then
            setCommsMessage("ta tu dla poude??");
            tradeSellComm();
            tradeBuyComm();
        else
            setCommsMessage("Venez nous voir sur place.");
        end
    end);

    --Chantier naval: vend de la tech, des matiere premiere et des travailleurs. Achete drogue
    sanAntonio = SpaceStation():setTemplate("Medium Station"):setFaction("Independent"):setCallSign("san antonio"):setPosition(-4491, 476)
    sanAntonio.inventory = makeInventory( { technologie = {amount = 15, value = 5}
                                          , matiere_premiere = {amount = 25, value = 3}
                                          , travailleur = {amount = 10, value = 8}
                                          , drogue = {amount = 0, value = 10}
                                          });
    sanAntonio:setCommsFunction(function()
        if comms_source:isDocked(comms_target) then
            setCommsMessage("Salutation voyageur, bienvenue au chantier naval de San Antonio. Pour l'instant, nous servons comme entrepôt de matière première, mais avec les grande puissance qui viennent dans le secteur, le travail risque de ne pas manquer. \n\nMessage d'intéret général. Le premier lieutnant de facecrusha: nosebleeda se serait retourné contre son chef de gang. Un histoire de poudre refusé on aurait entendu dire. Reste que nosebleeda rôde dans le secteur à la recherche de travail ou de fourniseur plus agréable que son ancien patron. Il serait caché près de la station de ravitaillement caravane petrol.");
            tradeSellComm();
            tradeBuyComm();
        else
            setCommsMessage("Venez nous voir sur place.");
        end
    end);

    --Zone industriel 354: vend de la tech, des matiere premiere et des travailleurs. Achete drogue
    zoneIndustriel = SpaceStation():setTemplate("Medium Station"):setFaction("Independent"):setCallSign("zone 354"):setPosition(-23939, -14650)
    zoneIndustriel.inventory = makeInventory( { technologie = {amount = 25, value = 3}
                                              , matiere_premiere = {amount = 15, value = 8}
                                              , travailleur = {amount = 20, value = 5}
                                              , drogue = {amount = 0, value = 12}
                                              });
    zoneIndustriel:setCommsFunction(function()
        if comms_source:isDocked(comms_target) then
            setCommsMessage("Bienvenue a la zone industrielle 354. Le meilleur fournisseur de technologie du secteur 87. \n\nIl paraît qu'il y a un grand navire mercenaire qui a fait mouillage dans le secteur I5: le Sébastopol. On dit qu’ils sont puissants et respectent leurs contrats.");
            tradeSellComm();
            tradeBuyComm();
        else
            setCommsMessage("Venez nous voir sur place.");
        end
    end);
    
    --Sebastopol: mercenaire achetable pour aider la defense
    sebastopol = CpuShip():setFaction("Independent"):setTemplate("Dreadnought"):setCallSign("Sebastopol"):setPosition(4607, 69495):orderRoaming():setHullMax(200):setHull(200):setShieldsMax(300.00, 300.00, 300.00, 0.00, 0.00):setShields(300.00, 300.00, 300.00, 0.00, 0.00):setWeaponTubeCount(2):setWeaponStorageMax("Homing", 20):setWeaponStorageMax("HVLI", 50):setBeamWeapon(0, 90, 335, 1500, 6.0, 14.9):setBeamWeaponTurret(0, 0, 0, 0):setBeamWeapon(1, 90, 25, 1500, 6.0, 16.2):setBeamWeaponTurret(1, 0, 0, 0):setBeamWeapon(2, 100, 300, 1000, 6.0, 16.2):setBeamWeaponTurret(2, 0, 0, 0):setBeamWeapon(3, 100, 60, 1000, 6.0, 15.7):setBeamWeaponTurret(3, 0, 0, 0):setBeamWeapon(4, 32, 0, 2000, 6.0, 19.6):setBeamWeaponTurret(4, 0, 0, 0):setBeamWeapon(5, 105, 180, 1200, 6.0, 16.2):setBeamWeaponTurret(5, 0, 0, 0)

    sebastopol:setCommsFunction(function()
        setCommsMessage("Salutation rusé représentant d’Arianne. Je suis le lord commander nataniel du Sébastopol. Nous sommes les protecteurs vertueux des marchant qui savent se montrer généreux. Nous sommes à la recherche d'un mécène prêt à investir 30 credit et 10 matiere premières pour nous voir pratiquer notre art. Interessé?");
        addCommsReply("Être noble et investir dans l'art local.", function()
            if comms_source.kredits >= 30 and comms_source.inventory.matiere_premiere.amount >= 10 then
                comms_source.kredits = comms_source.kredits - 30;
                comms_source.inventory.matiere_premiere.amount = comms_source.inventory.matiere_premiere.amount - 10;
                sebastopol:orderDefendTarget(labo);
                setCommsMessage("On vois que vous êtes des gens de culture. Nous allons de ce pas nous poster près de votre labo afin d'y pratiquer notre art.")
            else
                setCommsMessage("Vous ne semblez pas avoir les fonds nécessaire pour supporter notre oeuvre.")
            end
        end);
    end);

    --Sniftheline: mercenaire achetable pour aider la defense aussi possible de l'attaquer
    sniftheline = CpuShip():setFaction("Independent"):setTemplate("Tug"):setCallSign("sniftheline"):setPosition(1117, 17960):orderRoaming():setImpulseMaxSpeed(109.6):setRotationMaxSpeed(14.6):setJumpDrive(true):setShieldsMax(212.00):setShields(212.00):setBeamWeapon(0, 360, 0, 1000, 3.0, 13.1):setBeamWeaponTurret(0, 0, 0, 0):setBeamWeapon(1, 271, 88, 1800, 3.6, 14.0):setBeamWeaponTurret(1, 0, 0, 0):setBeamWeapon(2, 83, -180, 2600, 4.0, 18.6):setBeamWeaponTurret(2, 0, 0, 0):setBeamWeapon(3, 3, -78, 5000, 4.2, 24.8):setBeamWeaponTurret(3, 0, 0, 0)

    sniftheline:setCommsFunction(function()
        setCommsMessage("té tu la pou ‘me propser d’quoi d’bon pour moé ou pour krever");
        addCommsReply("Offrir 100 Kredits", function()
            if comms_source.kredits >= 100 then
                comms_source.kredits = comms_source.kredits - 100;
                sniftheline:orderDefendTarget(labo);
                setCommsMessage("m'en va checker l'stock")
            else
                setCommsMessage("t'a rien d'bon pour moé")
            end
        end);
        addCommsReply("Offrir 20 drogue", function()
            if comms_source.inventory.matiere_premiere.amount >= 20 then
                comms_source.inventory.drogue.amount = comms_source.inventory.drogue.amount - 20;
                sniftheline:orderDefendTarget(labo);
                setCommsMessage("m'en va checker l'stock")
            else
                setCommsMessage("t'a rien d'bon pour moé")
            end
        end);
        addCommsReply("Ta mère est grosse", function()
            setCommsMessage("Fak té là pour krever");
            sniftheline:setFaction("Charognards");
        end);
    end);
    
end

function update()
    --Labo
    if labo:getFaction() ~= "Arianne" then
        if labo.inventory.technologie.amount >= 25 and labo.inventory.matiere_premiere.amount >= 35 and labo.inventory.produit_chimique.amount >= 10 and labo.inventory.travailleur.amount >= 15 then

            labo.inventory.technologie.amount = labo.inventory.technologie.amount - 25 
            labo.inventory.matiere_premiere.amount = labo.inventory.matiere_premiere.amount - 35 
            labo.inventory.produit_chimique.amount = labo.inventory.produit_chimique.amount - 10 
            labo.inventory.travailleur.amount = labo.inventory.travailleur.amount - 15

            labo:setFaction("Arianne");
            labo:setCommsFunction(function()
                if comms_source:isDocked(comms_target) then
                    setCommsMessage("Yo boss, vous savez ce qu'on fait ici c'est puissant!! Sans doute que les coincé du cul de la station Derichbourg vont vouloir l'acheter à haut prix. Mais le chien de garde aimerait pas trop ca. J'ai entendu dire qu’il était \"flattable\" si on avait un bon os.");
                    labo.inventory.drogue.amount = labo.inventory.drogue.amount + labo.inventory.produit_chimique.amount;
                    labo.inventory.produit_chimique.amount = 0;
                    tradeSellComm();
                    tradeBuyComm();
                else
                    setCommsMessage("Venez nous voir sur place.");
                end
            end);
        end
    end
    
    --fassmasha gang
    if fassmashaIsOn then
        if not hellPit:isValid() then
            fassmashaIsOn = false;
            CpuShip():setFaction("Charognards"):setTemplate("Starhammer II"):setCallSign("y'ur d8"):setPosition(31185, 49509):orderFlyTowards(33515, 52990):setHullMax(300):setHull(300):setImpulseMaxSpeed(56.6):setRotationMaxSpeed(10.1):setJumpDrive(false):setWarpDrive(true):setShieldsMax(23.00, 0.00, 0.00, 0.00, 0.00):setShields(23.00, 0.00, 0.00, 0.00, 0.00):setWeaponTubeCount(6):setWeaponTubeDirection(5, -180):setWeaponStorage("Homing", 0):setWeaponStorage("EMP", 0):setWeaponStorageMax("HVLI", 50):setWeaponStorage("HVLI", 50)
        end
        
        for i,gang in pairs(fassmashaGangs) do
            if allDead(gang.mobs[1], gang.mobs[2]) then
                gang.respawn = gang.respawn + 1;
                if gang.respawn >= 3 * 60 * 60 then
                    fassmashaGangs[i] = fassmashaGang();
                end
            end
        end
    end

    --Le sherif. Kill it or buy it
    if lawIsOn then
        if not lawbringer:isValid() then
            lawIsOn = false;
        end

        if lawSpawn >= 6 * 60 * 60 then
            blockadeSpawn = blockadeSpawn + 1;
            local toAttack = attackLabOrPlayer();

            if blockadeSpawn >= 5 then
                generateMobs(1, "Blockade Runner", "Gentil", -47000, 5500, 1500, function(mob) mob:orderAttack(toAttack) end);
                blockadeSpawn = 0;
            else
                generateMobs(4, "Adder MK4", "Gentil", -47000, 5500, 1500, function(mob) mob:orderAttack(toAttack) end);
                generateMobs(1, "Piranha F8", "Gentil", -47000, 5500, 1500, function(mob) mob:orderAttack(toAttack) end);
            end

            lawSpawn = 0;
        else
            lawSpawn = lawSpawn + 1;
        end
        
    end
    
    --Les Merillons
    if merillonRespawn >= 3 * 60 * 60 then
        for i,merillonShip in pairs(merillonFalcons) do
            if not merillonShip:isValid() then
                merillonFalcons[i] = generateMobs(1, "Flavia Falcon", "Merillon", 0, 10000, 60000, function(mob) mob:orderRoaming() end)[1];
            end
        end
        for i,merillonShip in pairs(merillonCruisers) do
            if not merillonShip:isValid() then
                merillonCruisers[i] = generateMobs(2, "Missile Cruiser", "Merillon", 0, 10000, 60000, function(mob) mob:orderRoaming() end)[1];
            end
        end
        for i,merillonShip in pairs(merillonFrigates) do
            if not merillonShip:isValid() then
                merillonFrigates[i] = generateMobs(2, "Frigate", "Merillon", 0, 10000, 60000, function(mob) mob:orderRoaming() end)[1];
            end
        end
        merillonRespawn = 0;
    else
        merillonRespawn = merillonRespawn + 1;
    end
end

function fassmashaGang()
    local toAttack = attackLabOrPlayer();
    local mobs = { generateMobs(3, "Adder MK6", "Charognards", 29700, 48500, 1500, function(mob) mob:orderAttack(toAttack) end)
                 , generateMobs(1, "Phobos M3", "Charognards", 29700, 48500, 1500, function(mob) mob:orderAttack(toAttack) end)
                 };
    return { mobs = mobs
           , respawn = 0;
           };
end

function attackLabOrPlayer()
    if labo:getFaction() == "Arianne" then
        if irandom(1,2) == 1 then
            return succubiCherubim;
        else
            return labo;
        end
    else
        return succubiCherubim;
    end
end

--[[{{utils/dussel.lua}}]]--

--[[{{utils/trading.lua}}]]--

    Nebula():setPosition(2195, 16676)
    Nebula():setPosition(22611, -17137)
    Nebula():setPosition(-21975, 45415)
    Nebula():setPosition(-31361, -14594)
    Nebula():setPosition(-21691, 36683)
    Nebula():setPosition(-36447, 36960)
    CpuShip():setFaction("Vindh"):setTemplate("Nirvana R5"):setCallSign("CSS2"):setPosition(36933, 29339):orderRoaming()
    Asteroid():setPosition(5843, 13657)
    Asteroid():setPosition(-1926, -3094)
    Asteroid():setPosition(1026, 10965)
    Asteroid():setPosition(-532, -4494)
    Asteroid():setPosition(-1420, -6208)
    Asteroid():setPosition(4967, 16117)
    Asteroid():setPosition(-3990, -5812)
    Asteroid():setPosition(-1583, -1831)
    Asteroid():setPosition(1175, 9557)
    Asteroid():setPosition(-4253, -5764)
    Asteroid():setPosition(-361, 6454)
    Asteroid():setPosition(-963, 3726)
    Asteroid():setPosition(-26, 5061)
    Asteroid():setPosition(-143, -5670)
    Asteroid():setPosition(-4490, -6814)
    Asteroid():setPosition(6254, 17022)
    Asteroid():setPosition(4115, 18502)
    Asteroid():setPosition(6676, 14604)
    Asteroid():setPosition(6914, 14041)
    Asteroid():setPosition(-3687, -6137)
    Asteroid():setPosition(-2101, -8595)
    Asteroid():setPosition(5412, 19472)
    Asteroid():setPosition(-222, 274)
    Asteroid():setPosition(-2128, -2699)
    Asteroid():setPosition(-2000, -790)
    Asteroid():setPosition(-3606, -8228)
    Asteroid():setPosition(1336, 9517)
    Asteroid():setPosition(-3511, -6438)
    Asteroid():setPosition(735, 3638)
    Asteroid():setPosition(5169, 19550)
    Asteroid():setPosition(-684, 4206)
    Asteroid():setPosition(-4147, -6517)
    Asteroid():setPosition(6872, 14917)
    Asteroid():setPosition(-731, 1624)
    Asteroid():setPosition(360, 4469)
    Asteroid():setPosition(-507, 10455)
    Asteroid():setPosition(213, 2971)
    Asteroid():setPosition(-1916, 7773)
    Asteroid():setPosition(-23, -6084)
    Asteroid():setPosition(-2882, -8933)
    Asteroid():setPosition(-2981, -9856)
    Asteroid():setPosition(-1127, -11576)
    Asteroid():setPosition(-2564, -8383)
    Asteroid():setPosition(1205, 10127)
    Asteroid():setPosition(939, 13226)
    Asteroid():setPosition(-1079, -11323)
    Asteroid():setPosition(-2203, -8792)
    Asteroid():setPosition(-3921, -10177)
    Asteroid():setPosition(4484, 17012)
    Asteroid():setPosition(-1714, -4264)
    VisualAsteroid():setPosition(-5609, -9470)
    VisualAsteroid():setPosition(564, -2204)
    VisualAsteroid():setPosition(-1936, 3056)
    VisualAsteroid():setPosition(-2022, -215)
    VisualAsteroid():setPosition(-1632, 7468)
    VisualAsteroid():setPosition(-4041, 7618)
    VisualAsteroid():setPosition(-110, 13429)
    VisualAsteroid():setPosition(-4862, 2391)
    VisualAsteroid():setPosition(-3614, 5735)
    VisualAsteroid():setPosition(2949, -12354)
    VisualAsteroid():setPosition(1371, 10618)
    VisualAsteroid():setPosition(29862, 3737)
    VisualAsteroid():setPosition(-3164, -2932)
    VisualAsteroid():setPosition(29602, 347)
    VisualAsteroid():setPosition(-2549, -4283)
    VisualAsteroid():setPosition(7408, 16431)
    VisualAsteroid():setPosition(-1421, 4157)
    VisualAsteroid():setPosition(30105, 2372)
    VisualAsteroid():setPosition(28123, 902)
    VisualAsteroid():setPosition(28812, 1663)
    VisualAsteroid():setPosition(1670, 12441)
    VisualAsteroid():setPosition(-1061, 3169)
    VisualAsteroid():setPosition(-3227, 306)
    VisualAsteroid():setPosition(-4792, -8732)
    VisualAsteroid():setPosition(-2070, 10154)
    VisualAsteroid():setPosition(-1002, 8930)
    VisualAsteroid():setPosition(-4532, -8246)
    VisualAsteroid():setPosition(-2268, -6239)
    VisualAsteroid():setPosition(-4184, -11613)
    VisualAsteroid():setPosition(-3833, -10783)
    VisualAsteroid():setPosition(5723, 13431)
    VisualAsteroid():setPosition(-5195, -10008)
    VisualAsteroid():setPosition(-3145, -9472)
    VisualAsteroid():setPosition(29934, 1400)
    VisualAsteroid():setPosition(358, 13264)
    VisualAsteroid():setPosition(-1638, -3773)
    VisualAsteroid():setPosition(-1688, -6455)
    VisualAsteroid():setPosition(-1714, 6704)
    VisualAsteroid():setPosition(30204, -321)
    VisualAsteroid():setPosition(3673, 12223)
    VisualAsteroid():setPosition(-3253, -9890)
    VisualAsteroid():setPosition(-2520, 2511)
    VisualAsteroid():setPosition(-1809, -13033)
    VisualAsteroid():setPosition(-4530, -5897)
    VisualAsteroid():setPosition(1392, -9964)
    VisualAsteroid():setPosition(-4359, -9271)
    VisualAsteroid():setPosition(-3454, 11807)
    VisualAsteroid():setPosition(-4705, -8003)
    VisualAsteroid():setPosition(7, -2452)
    VisualAsteroid():setPosition(-1196, 9294)
    VisualAsteroid():setPosition(-1942, 3204)
    VisualAsteroid():setPosition(-4172, -11675)
    VisualAsteroid():setPosition(-229, -1985)
    VisualAsteroid():setPosition(-2720, -11721)
    VisualAsteroid():setPosition(1756, 12498)
    VisualAsteroid():setPosition(-2426, 5727)
    VisualAsteroid():setPosition(-3619, -9410)
    VisualAsteroid():setPosition(-2225, -4712)
    VisualAsteroid():setPosition(-562, -771)
    VisualAsteroid():setPosition(30883, 661)
    VisualAsteroid():setPosition(27926, 602)
    VisualAsteroid():setPosition(-2387, -11166)
    VisualAsteroid():setPosition(-3887, -6679)
    VisualAsteroid():setPosition(1724, 12085)
    VisualAsteroid():setPosition(518, -4084)
    VisualAsteroid():setPosition(-2688, 461)
    VisualAsteroid():setPosition(29332, 2127)
    VisualAsteroid():setPosition(-1406, 6248)
    VisualAsteroid():setPosition(-6385, -6207)
    VisualAsteroid():setPosition(-1012, 3212)
    VisualAsteroid():setPosition(-3078, 1823)
    VisualAsteroid():setPosition(-1462, 9102)
    VisualAsteroid():setPosition(-3899, -7129)
    VisualAsteroid():setPosition(1758, 13668)
    VisualAsteroid():setPosition(1584, -7075)
    VisualAsteroid():setPosition(-2273, 402)
    VisualAsteroid():setPosition(29803, 900)
    VisualAsteroid():setPosition(-696, -1070)
    VisualAsteroid():setPosition(-52, 10731)
    VisualAsteroid():setPosition(1816, -12846)
    VisualAsteroid():setPosition(-3758, 6039)
    VisualAsteroid():setPosition(-686, 9470)
    VisualAsteroid():setPosition(-245, -1234)
    VisualAsteroid():setPosition(29079, 615)
    VisualAsteroid():setPosition(-3066, -2534)
    VisualAsteroid():setPosition(-2552, 1773)
    VisualAsteroid():setPosition(2540, -13356)
    VisualAsteroid():setPosition(5650, 14489)
    VisualAsteroid():setPosition(-5577, -7360)
    VisualAsteroid():setPosition(28535, 3370)
    VisualAsteroid():setPosition(-2923, -6482)
    VisualAsteroid():setPosition(423, 13374)
    VisualAsteroid():setPosition(-3882, -9782)
    VisualAsteroid():setPosition(1092, 12739)
    VisualAsteroid():setPosition(-913, 3658)
    VisualAsteroid():setPosition(-2762, 1267)
    VisualAsteroid():setPosition(-1781, 974)
    VisualAsteroid():setPosition(-4032, 7370)
    VisualAsteroid():setPosition(-1061, 585)
    VisualAsteroid():setPosition(27561, 2008)
    Asteroid():setPosition(-39165, -17974)
    Asteroid():setPosition(-37768, -18480)
    Asteroid():setPosition(-33250, -18742)
    Asteroid():setPosition(-35546, -17422)
    Asteroid():setPosition(-30766, -17051)
    Asteroid():setPosition(-29548, -17769)
    Asteroid():setPosition(-33181, -18490)
    Asteroid():setPosition(-39619, -19229)
    Asteroid():setPosition(-33356, -17664)
    Asteroid():setPosition(-32261, -18743)
    Asteroid():setPosition(-28685, -17201)
    Asteroid():setPosition(-30085, -16907)
    Asteroid():setPosition(-35310, -18871)
    Asteroid():setPosition(-37972, -19015)
    Asteroid():setPosition(-27807, -16314)
    Asteroid():setPosition(-38433, -19085)
    Asteroid():setPosition(-36291, -17525)
    VisualAsteroid():setPosition(-35688, -13491)
    VisualAsteroid():setPosition(-28364, -13583)
    VisualAsteroid():setPosition(-34260, -12862)
    VisualAsteroid():setPosition(-38720, -15285)
    VisualAsteroid():setPosition(-35051, -12079)
    VisualAsteroid():setPosition(-38097, -12791)
    VisualAsteroid():setPosition(32472, 42233)
    VisualAsteroid():setPosition(-27559, -12823)
    VisualAsteroid():setPosition(-27283, -13414)
    VisualAsteroid():setPosition(-29521, -13549)
    VisualAsteroid():setPosition(-26947, -11566)
    VisualAsteroid():setPosition(-34797, -13636)
    VisualAsteroid():setPosition(-31896, -13602)
    VisualAsteroid():setPosition(-33409, -12476)
    VisualAsteroid():setPosition(-39436, -13763)
    VisualAsteroid():setPosition(-38180, -15172)
    VisualAsteroid():setPosition(-32033, -14018)
    VisualAsteroid():setPosition(-26965, -11366)
    VisualAsteroid():setPosition(-29411, -11509)
    VisualAsteroid():setPosition(-31178, -13540)
    VisualAsteroid():setPosition(-28884, -13042)
    VisualAsteroid():setPosition(-34035, -13628)
    VisualAsteroid():setPosition(-33714, -13309)
    VisualAsteroid():setPosition(-34374, -14278)
    VisualAsteroid():setPosition(-29624, -13708)
    VisualAsteroid():setPosition(-37991, -14913)
    VisualAsteroid():setPosition(-34936, -13427)
    VisualAsteroid():setPosition(-27998, -12292)
    VisualAsteroid():setPosition(-29001, -13390)
    VisualAsteroid():setPosition(-36386, -14076)
    Asteroid():setPosition(-28803, -18951)
    Asteroid():setPosition(-29339, -18280)
    Asteroid():setPosition(-29419, -19724)
    Asteroid():setPosition(-28126, -18852)
    Asteroid():setPosition(-32582, -20344)
    Asteroid():setPosition(-29888, -19263)
    Asteroid():setPosition(-32882, -21142)
    Asteroid():setPosition(-33050, -21536)
    Asteroid():setPosition(-32275, -21437)
    Asteroid():setPosition(-28311, -18059)
    Asteroid():setPosition(-31133, -19786)
    VisualAsteroid():setPosition(-765, -24700)
    VisualAsteroid():setPosition(-4045, -23866)
    VisualAsteroid():setPosition(-31460, -37638)
    VisualAsteroid():setPosition(-3658, -24364)
    VisualAsteroid():setPosition(-28539, -35661)
    VisualAsteroid():setPosition(-1114, -22826)
    VisualAsteroid():setPosition(46, -23718)
    VisualAsteroid():setPosition(-31721, -37685)
    VisualAsteroid():setPosition(-26599, -37547)
    VisualAsteroid():setPosition(-30780, -38790)
    VisualAsteroid():setPosition(-33555, -37967)
    VisualAsteroid():setPosition(-27490, -36734)
    VisualAsteroid():setPosition(-2501, -24795)
    VisualAsteroid():setPosition(-29686, -36187)
    VisualAsteroid():setPosition(-32886, -39797)
    VisualAsteroid():setPosition(-1362, -23562)
    VisualAsteroid():setPosition(-2469, -23982)
    VisualAsteroid():setPosition(-3309, -22927)
    VisualAsteroid():setPosition(-5990, -27018)
    VisualAsteroid():setPosition(-33069, -38865)
    VisualAsteroid():setPosition(-27769, -37894)
    VisualAsteroid():setPosition(-6559, -24424)
    VisualAsteroid():setPosition(-27485, -36883)
    VisualAsteroid():setPosition(-27763, -37279)
    VisualAsteroid():setPosition(-2257, -23597)
    VisualAsteroid():setPosition(-32625, -39390)
    VisualAsteroid():setPosition(-28260, -35457)
    VisualAsteroid():setPosition(-29659, -38356)
    VisualAsteroid():setPosition(-3831, -25312)
    VisualAsteroid():setPosition(-3342, -24660)
    VisualAsteroid():setPosition(-4681, -26527)
    VisualAsteroid():setPosition(-4082, -24798)
    VisualAsteroid():setPosition(-1109, -24067)
    VisualAsteroid():setPosition(-5441, -26684)
    VisualAsteroid():setPosition(2073, -22839)
    VisualAsteroid():setPosition(-30397, -38747)
    VisualAsteroid():setPosition(-2582, -23341)
    VisualAsteroid():setPosition(-6309, -25219)
    VisualAsteroid():setPosition(-28593, -38096)
    VisualAsteroid():setPosition(-32171, -39606)
    VisualAsteroid():setPosition(-5862, -26237)
    VisualAsteroid():setPosition(-1966, -22810)
    VisualAsteroid():setPosition(-30144, -36291)
    Asteroid():setPosition(26002, 51653)
    Asteroid():setPosition(33917, 50721)
    Asteroid():setPosition(35098, 48630)
    Asteroid():setPosition(30082, 43740)
    Asteroid():setPosition(31522, 42293)
    Asteroid():setPosition(33564, 51587)
    Asteroid():setPosition(25103, 46955)
    Asteroid():setPosition(24899, 48943)
    Asteroid():setPosition(25046, 51920)
    Asteroid():setPosition(31383, 44295)
    Asteroid():setPosition(31604, 44802)
    Asteroid():setPosition(33535, 49744)
    Asteroid():setPosition(34119, 49531)
    Asteroid():setPosition(33540, 51722)
    Asteroid():setPosition(33701, 48674)
    Asteroid():setPosition(26061, 48159)
    Asteroid():setPosition(25035, 46754)
    Asteroid():setPosition(26092, 46972)
    Asteroid():setPosition(34156, 49044)
    VisualAsteroid():setPosition(29397, 44810)
    VisualAsteroid():setPosition(-20653, 2063)
    VisualAsteroid():setPosition(-19743, 1881)
    VisualAsteroid():setPosition(33814, 51233)
    VisualAsteroid():setPosition(-22397, 5266)
    VisualAsteroid():setPosition(25642, 51649)
    VisualAsteroid():setPosition(32545, 49388)
    VisualAsteroid():setPosition(-40257, -13987)
    VisualAsteroid():setPosition(25445, 51416)
    VisualAsteroid():setPosition(25404, 47488)
    VisualAsteroid():setPosition(32484, 50581)
    VisualAsteroid():setPosition(25032, 53387)
    VisualAsteroid():setPosition(33301, 50530)
    VisualAsteroid():setPosition(24156, 52104)
    VisualAsteroid():setPosition(25806, 54296)
    VisualAsteroid():setPosition(32690, 51291)
    VisualAsteroid():setPosition(25165, 51521)
    VisualAsteroid():setPosition(32504, 51206)
    VisualAsteroid():setPosition(31506, 45729)
    VisualAsteroid():setPosition(30402, 44024)
    VisualAsteroid():setPosition(-40297, -15558)
    VisualAsteroid():setPosition(24797, 52497)
    VisualAsteroid():setPosition(33802, 49546)
    VisualAsteroid():setPosition(-40025, -15015)
    VisualAsteroid():setPosition(26381, 50524)
    VisualAsteroid():setPosition(-40830, -20747)
    VisualAsteroid():setPosition(-38916, -19383)
    VisualAsteroid():setPosition(-22078, 10247)
    VisualAsteroid():setPosition(26431, 53961)
    VisualAsteroid():setPosition(26086, 47361)
    VisualAsteroid():setPosition(-40161, -17734)
    VisualAsteroid():setPosition(23685, 47716)
    VisualAsteroid():setPosition(30627, 41802)
    VisualAsteroid():setPosition(24505, 46997)
    VisualAsteroid():setPosition(-20149, 2550)
    VisualAsteroid():setPosition(24593, 47303)
    VisualAsteroid():setPosition(26376, 50426)
    VisualAsteroid():setPosition(-40202, -15600)
    VisualAsteroid():setPosition(-22210, 5851)
    VisualAsteroid():setPosition(26536, 51697)
    VisualAsteroid():setPosition(-39179, -14439)
    VisualAsteroid():setPosition(26577, 52358)
    VisualAsteroid():setPosition(26188, 46849)
    VisualAsteroid():setPosition(25564, 54398)
    VisualAsteroid():setPosition(34520, 49871)
    VisualAsteroid():setPosition(30118, 42955)
    VisualAsteroid():setPosition(-39215, -17706)
    VisualAsteroid():setPosition(24333, 52616)
    BlackHole():setPosition(23285, -25780)
    WarpJammer():setFaction("Independent"):setPosition(30029, 47540)
    CpuShip():setFaction("Loyal Loyalistes"):setTemplate("Chasseur"):setCallSign("CSS24"):setPosition(30236, -21086):orderDefendLocation(30236, -21086):setWeaponStorage("Homing", 1)
    CpuShip():setFaction("Loyal Loyalistes"):setTemplate("Chasseur"):setCallSign("CCN25"):setPosition(30865, -20205):orderDefendLocation(30865, -20205):setWeaponStorage("Homing", 1)
    CpuShip():setFaction("Loyal Loyalistes"):setTemplate("Chasseur"):setCallSign("S26"):setPosition(31117, -21254):orderDefendLocation(31117, -21254):setWeaponStorage("Homing", 1)
    CpuShip():setFaction("Loyal Loyalistes"):setTemplate("Chasseur"):setCallSign("CCN27"):setPosition(31831, -18399):orderDefendLocation(31831, -18399):setWeaponStorage("Homing", 1)
    CpuShip():setFaction("Loyal Loyalistes"):setTemplate("Chasseur"):setCallSign("VK28"):setPosition(32965, -17224):orderDefendLocation(32965, -17224):setWeaponStorage("Homing", 1)
    CpuShip():setFaction("Loyal Loyalistes"):setTemplate("Chasseur"):setCallSign("CV29"):setPosition(31705, -17140):orderDefendLocation(31705, -17140):setWeaponStorage("Homing", 1)
    CpuShip():setFaction("Loyal Loyalistes"):setTemplate("Chasseur"):setCallSign("UTI30"):setPosition(31075, -19407):orderDefendLocation(31075, -19407):setWeaponStorage("Homing", 1)
    CpuShip():setFaction("Loyal Loyalistes"):setTemplate("Chasseur"):setCallSign("CCN31"):setPosition(32839, -20624):orderDefendLocation(32839, -20624):setWeaponStorage("Homing", 1)
    CpuShip():setFaction("Loyal Loyalistes"):setTemplate("Chasseur"):setCallSign("CV32"):setPosition(33216, -18651):orderDefendLocation(33216, -18651):setWeaponStorage("Homing", 1)
    CpuShip():setFaction("Loyal Loyalistes"):setTemplate("Defense platform"):setCallSign("NC34"):setPosition(29433, -21813):orderDefendLocation(41755, -18678):setHullMax(79):setHull(79):setShieldsMax(28.00, 39.00, 32.00, 37.00, 39.00, 46.00):setShields(28.00, 39.00, 32.00, 37.00, 39.00, 46.00):setBeamWeapon(0, 30, 0, 4000, 7.7, 7.7):setBeamWeaponTurret(0, 0, 0, 0):setBeamWeapon(1, 30, 60, 4000, 7.7, 8.4):setBeamWeaponTurret(1, 0, 0, 0):setBeamWeapon(2, 30, 120, 4000, 7.9, 7.7):setBeamWeaponTurret(2, 0, 0, 0):setBeamWeapon(3, 30, 180, 4000, 7.8, 7.7):setBeamWeaponTurret(3, 0, 0, 0):setBeamWeapon(4, 30, 240, 4000, 7.5, 7.5):setBeamWeaponTurret(4, 0, 0, 0):setBeamWeapon(5, 30, 300, 4000, 7.8, 7.5):setBeamWeaponTurret(5, 0, 0, 0)
    CpuShip():setFaction("Loyal Loyalistes"):setTemplate("Weapons platform"):setCallSign("SS35"):setPosition(26103, -17095):orderRoaming():setShieldsMax(37.00, 39.00, 50.00, 46.00, 34.00, 28.00):setShields(37.00, 39.00, 50.00, 46.00, 34.00, 28.00):setBeamWeapon(0, 30, 0, 4000, 7.8, 9.2):setBeamWeaponTurret(0, 0, 0, 0):setBeamWeapon(1, 30, 60, 4000, 7.8, 8.4):setBeamWeaponTurret(1, 0, 0, 0):setBeamWeapon(2, 30, 120, 4000, 7.6, 7.9):setBeamWeaponTurret(2, 0, 0, 0):setBeamWeapon(3, 30, 180, 4000, 7.7, 7.9):setBeamWeaponTurret(3, 0, 0, 0):setBeamWeapon(4, 30, 240, 4000, 8.1, 7.7):setBeamWeaponTurret(4, 0, 0, 0):setBeamWeapon(5, 30, 300, 4000, 8.3, 7.9):setBeamWeaponTurret(5, 0, 0, 0)
    CpuShip():setFaction("Loyal Loyalistes"):setTemplate("Weapons platform"):setCallSign("UTI36"):setPosition(31379, -16404):orderRoaming():setShieldsMax(19.00, 32.00, 30.00, 32.00, 41.00, 34.00):setShields(19.00, 32.00, 30.00, 23.00, 41.00, 34.00):setBeamWeapon(0, 30, 0, 4000, 7.5, 8.4):setBeamWeaponTurret(0, 0, 0, 0):setBeamWeapon(1, 30, 60, 4000, 7.7, 7.9):setBeamWeaponTurret(1, 0, 0, 0):setBeamWeapon(2, 30, 120, 4000, 8.0, 7.7):setBeamWeaponTurret(2, 0, 0, 0):setBeamWeapon(3, 30, 180, 4000, 7.8, 8.4):setBeamWeaponTurret(3, 0, 0, 0):setBeamWeapon(4, 30, 240, 4000, 7.6, 8.4):setBeamWeaponTurret(4, 0, 0, 0):setBeamWeapon(5, 30, 300, 4000, 7.6, 7.7):setBeamWeaponTurret(5, 0, 0, 0)

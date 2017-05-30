--Name: Examen Extérieur

nbPlayers = 2;
scenarioStatus = 1;
bigAttack = {};

fleetComms = { "Alerte rouge!!! Aidez nous"
             , "On transporte des civils, il y a des familles et des enfants à bord."
             , "Venez nous aider, on peut les repousser."
             , "Nous sommes en difficulté, notre réacteur est en feux. Venez nous chercher."
             , "Allez tous chier, nous on se pousse."
             , "Par pitié, arrêtez de nous attaquer. On se rend."
             , "Nous n'avons pas d'armes! Épargnez nous!."
             , "Nous sommes un simple vaisseau de transport. Laissez nous passer, les enfants ont besoin de nos médicaments."
             , "Sauvez nos vies, elles valent plus que la votre."
             , "Nous sommes touchés, nous demandons de l'aide pour évacuer."
             , "Allez-y soldats, mourrez pour votre patrie."
             , "POUR LA CONFÉDÉRATION!!!!!!!"
             , "On les retiens, profitez-en pour aider quelqu'un d'autre."
             , "AAAAAAAAAAAAAAAAAAAAAAHHHHHHHHHHHHHHHHHHHHHHHHHHHH"
             , "Nous sommes condamnés. Dites à ma famille que je l'aime.\n - Capitaine softheart"
             , "On a plus l'énergie pour lancer les pod d'évacuation. Venez nous booster."
             , "Il y a une brèche dans la coque. On a que 2 minutes d'oxygène."
             , "Oubliez ça, c'est finit."
             , "Survivez pour notre mémoire."
             , "Au revoir camarade, que le seigneur te protège.\n Que la vierge te montre le ch"
             , "C'est un beau jour pour mourrir."
             }

scenarioSteps = {
    {--1
        init = function()
            for index,player in pairs(players) do
                player:setWeaponStorage("Homing", 12)
                player:setWeaponStorage("HVLI", 20)
                player:setWeaponStorage("Nuke", 0)
                player:setWeaponStorage("Mine", 0)
                player:setWeaponStorage("EMP", 0)
            end
        end,
        update = function()
            nbDestroyedDrones = 0;
            for i,drone in pairs(drones) do
                if not drone:isValid() then
                    nbDestroyedDrones = nbDestroyedDrones + 1;
                end
            end
            if nbDestroyedDrones > 20 then
                nextStep();
            end
            for index,transport in pairs(transports) do
                if not transport.dockTarget or transport:isDocked(transport.dockTarget) then
                    local station = stations[irandom(1,20)];
                    transport.dockTarget = station;
                    transport:orderDock(station);
                end
            end
        end
    },
    {--2
        init = function()
            for index,player in pairs(players) do
                academie:sendCommsMessage(player, "Nous sommes attaqué, encore ces satanés reblles. Revenez a l'academie pour qu'on vous donnes des munitions");
            end
            for i=1,40,1 do
                local shipNb = irandom(1,7);
                local ship = "";
                if shipNb == 1 then
                    ship = "Unknown";
                else
                    if shipNb < 5 then
                        ship = "Atlantis X23";
                    else
                        ship = "MT52 Hornet";
                    end
                end
                table.insert(bigAttack, CpuShip():setFaction("Unknown"):setTemplate(ship):setCallSign("BR57"):setPosition(irandom(-5000,35000),irandom(-25000,25000)):orderRoaming():setScanningParameters(3,3));
            end
            for i=1,30,1 do
                local shipNb = irandom(1,7);
                local ship = "";
                if shipNb < 5 then
                    ship = "Atlantis X23";
                else
                    ship = "MT52 Hornet";
                end
                CpuShip():setFaction("Confederation"):setTemplate(ship):setCallSign("BR57"):setPosition(irandom(-5000,35000),irandom(-25000,25000)):orderRoaming():setScanned(true);
            end
        end,
        update = function()
            bigAttackDeadCount = 0;
            for i,ship in pairs(bigAttack) do
                if not ship:isValid() then
                    bigAttackDeadCount = bigAttackDeadCount + 1;
                end
            end
            if bigAttackDeadCount > 10 then
                nextStep();
            end

            for index,player in pairs(players) do
                if player:isDocked(academie) then
                    player:setWeaponStorage("Homing", 12)
                    player:setWeaponStorage("HVLI", 20)
                    player:setWeaponStorage("Nuke", 4)
                    player:setWeaponStorage("Mine", 8)
                    player:setWeaponStorage("EMP", 6)
                end
            end
        end
    },
    {--3
        init = function()
            for index,player in pairs(players) do
                academie:sendCommsMessage(player, "Ce n'étaient pas les rebelles. Ils sont trop nombreux, FUYEZ!!!");
            end
            waveTimer = 30 * 60;
            commTimer = 10;
            nextCommTime = 20;

            fleetComm = SpaceStation():setTemplate("Small Station"):setFaction("Independent"):setCallSign("Fleet Channel"):setPosition(-150000, -150000)
        end,
        update = function()
            allDeadOrAway = true;
            for index,player in pairs(players) do
                local x,y = player:getPosition();
                if player:isValid() then
                    distance = math.sqrt(math.pow(x,2) + math.pow(y,2));
                    if distance < 175000 then
                        allDeadOrAway = false;
                    end
                end
                
            end
            if allDeadOrAway then
                shutdownGame()
            end

            waveTimer = waveTimer + 1;
            if waveTimer > 30 * 60 then
                waveTimer = 0;
                bigAttackWave(40);
            end

            commTimer = commTimer + 1;
            if commTimer > nextCommTime * 60 then
                commTimer = 0;
                nextCommTime = irandom(30,75);
                for index,player in pairs(players) do
                    fleetComm:sendCommsMessage(player, fleetComms[irandom(1,21)]);
                end
            end
            
        end
    }
}

function init()
    academie = SpaceStation():setTemplate("Huge Station"):setFaction("Confederation"):setCallSign("ACADEMIE")
    addGMFunction("Next Step", nextStep);

    players = {};
    positions = { { x = -1200, y = 0, heading = 270 }
                , { x = 1200, y = 0, heading = 90 }
                , { x = 0, y = -1100, heading = 0 }
                , { x = 0, y = 1100, heading = 180 }
                };
    for i=1,nbPlayers,1 do
        table.insert(players, PlayerSpaceship():setFaction("Confederation"):setTemplate("Atlantis"):setCallSign(i):setReputationPoints(100):commandDock(academie));
        local pos = positions[i];
        players[i]:setPosition(pos.x,pos.y):setHeading(pos.heading);
    end
    makeMap();

    scenarioSteps[scenarioStatus].init();
end

function update()
    scenarioSteps[scenarioStatus].update()
end

function makeMap()
    stations = { SpaceStation():setTemplate("Large Station"):setFaction("Confederation"):setCallSign("DS111"):setPosition(12339, -19829)
               , SpaceStation():setTemplate("Small Station"):setFaction("Confederation"):setCallSign("DS121"):setPosition(9438, -1727)
               , SpaceStation():setTemplate("Small Station"):setFaction("Confederation"):setCallSign("DS137"):setPosition(9230, -12851)
               , SpaceStation():setTemplate("Small Station"):setFaction("Confederation"):setCallSign("DS119"):setPosition(3703, -15061)
               , SpaceStation():setTemplate("Small Station"):setFaction("Confederation"):setCallSign("DS128"):setPosition(24430, -11883)
               , SpaceStation():setTemplate("Medium Station"):setFaction("Confederation"):setCallSign("DS114"):setPosition(18972, -9327)
               , SpaceStation():setTemplate("Small Station"):setFaction("Confederation"):setCallSign("DS130"):setPosition(18143, -16098)
               , SpaceStation():setTemplate("Medium Station"):setFaction("Confederation"):setCallSign("DS113"):setPosition(13997, -9396)
               , SpaceStation():setTemplate("Medium Station"):setFaction("Confederation"):setCallSign("DS118"):setPosition(19525, 11331)
               , SpaceStation():setTemplate("Small Station"):setFaction("Confederation"):setCallSign("DS125"):setPosition(16761, 8982)
               , SpaceStation():setTemplate("Medium Station"):setFaction("Confederation"):setCallSign("DS116"):setPosition(12754, 8498)
               , SpaceStation():setTemplate("Small Station"):setFaction("Confederation"):setCallSign("DS122"):setPosition(9438, 7462)
               , SpaceStation():setTemplate("Large Station"):setFaction("Confederation"):setCallSign("DS110"):setPosition(29957, 69)
               , SpaceStation():setTemplate("Small Station"):setFaction("Confederation"):setCallSign("DS127"):setPosition(24223, -4905)
               , SpaceStation():setTemplate("Small Station"):setFaction("Confederation"):setCallSign("DS132"):setPosition(15932, -3040)
               , SpaceStation():setTemplate("Small Station"):setFaction("Confederation"):setCallSign("DS135"):setPosition(23670, 10985)
               , SpaceStation():setTemplate("Medium Station"):setFaction("Confederation"):setCallSign("DS117"):setPosition(17037, 2280)
               , SpaceStation():setTemplate("Small Station"):setFaction("Confederation"):setCallSign("DS126"):setPosition(21805, -2211)
               , SpaceStation():setTemplate("Medium Station"):setFaction("Confederation"):setCallSign("DS115"):setPosition(21528, 3731)
               , SpaceStation():setTemplate("Small Station"):setFaction("Confederation"):setCallSign("DS123"):setPosition(8263, 16098)
               , SpaceStation():setTemplate("Large Station"):setFaction("Confederation"):setCallSign("DS112"):setPosition(12547, 19967)
               };

    transports = { CpuShip():setFaction("Confederation"):setTemplate("Transport1x1"):setCallSign("VK47"):setPosition(10602, -15283):orderIdle():setScanned(true)
                 , CpuShip():setFaction("Confederation"):setTemplate("Transport1x1"):setCallSign("SS54"):setPosition(12021, -4981):orderIdle():setScanned(true)
                 , CpuShip():setFaction("Confederation"):setTemplate("Transport1x1"):setCallSign("VK51"):setPosition(8139, 7338):orderIdle():setScanned(true)
                 , CpuShip():setFaction("Confederation"):setTemplate("Transport1x1"):setCallSign("BR55"):setPosition(14186, 18014):orderIdle():setScanned(true)
                 , CpuShip():setFaction("Confederation"):setTemplate("Transport1x1"):setCallSign("CV56"):setPosition(22996, 7861):orderIdle():setScanned(true)
                 , CpuShip():setFaction("Confederation"):setTemplate("Transport1x1"):setCallSign("SS53"):setPosition(18143, 6069):orderIdle():setScanned(true)
                 , CpuShip():setFaction("Confederation"):setTemplate("Transport1x1"):setCallSign("UTI52"):setPosition(14709, 5173):orderIdle():setScanned(true)
                 , CpuShip():setFaction("Confederation"):setTemplate("Transport1x1"):setCallSign("CV50"):setPosition(23593, 693):orderIdle():setScanned(true)
                 , CpuShip():setFaction("Confederation"):setTemplate("Transport1x1"):setCallSign("VK49"):setPosition(23593, -7146):orderIdle():setScanned(true)
                 , CpuShip():setFaction("Confederation"):setTemplate("Transport1x1"):setCallSign("CV48"):setPosition(16575, -7519):orderIdle():setScanned(true)
                 }

    drones = { CpuShip():setFaction("Rebelle"):setTemplate("TestDrone"):setCallSign("CCN37"):setPosition(-40292, -5162):orderRoaming()
             , CpuShip():setFaction("Rebelle"):setTemplate("TestDrone"):setCallSign("CCN36"):setPosition(-41177, -7448):orderRoaming()
             , CpuShip():setFaction("Rebelle"):setTemplate("TestDrone"):setCallSign("UTI5"):setPosition(-39961, 69):orderRoaming()
             , CpuShip():setFaction("Rebelle"):setTemplate("TestDrone"):setCallSign("VS20"):setPosition(-43168, -6342):orderRoaming()
             , CpuShip():setFaction("Rebelle"):setTemplate("TestDrone"):setCallSign("CCN12"):setPosition(-43623, 760):orderRoaming()
             , CpuShip():setFaction("Rebelle"):setTemplate("TestDrone"):setCallSign("NC40"):setPosition(-47592, -12757):orderRoaming()
             , CpuShip():setFaction("Rebelle"):setTemplate("TestDrone"):setCallSign("CSS35"):setPosition(-44274, -11504):orderRoaming()
             , CpuShip():setFaction("Rebelle"):setTemplate("TestDrone"):setCallSign("BR22"):setPosition(-46118, -7743):orderRoaming()
             , CpuShip():setFaction("Rebelle"):setTemplate("TestDrone"):setCallSign("NC21"):setPosition(-43979, -4130):orderRoaming()
             , CpuShip():setFaction("Rebelle"):setTemplate("TestDrone"):setCallSign("VK11"):setPosition(-47492, -1658):orderRoaming()
             , CpuShip():setFaction("Rebelle"):setTemplate("TestDrone"):setCallSign("S10"):setPosition(-49496, -5389):orderRoaming()
             , CpuShip():setFaction("Rebelle"):setTemplate("TestDrone"):setCallSign("CSS33"):setPosition(-59538, -8112):orderRoaming()
             , CpuShip():setFaction("Rebelle"):setTemplate("TestDrone"):setCallSign("NC31"):setPosition(-58801, -13495):orderRoaming()
             , CpuShip():setFaction("Rebelle"):setTemplate("TestDrone"):setCallSign("CCN38"):setPosition(-50616, -13200):orderRoaming()
             , CpuShip():setFaction("Rebelle"):setTemplate("TestDrone"):setCallSign("UTI7"):setPosition(-49979, -9949):orderRoaming()
             , CpuShip():setFaction("Rebelle"):setTemplate("TestDrone"):setCallSign("CV34"):setPosition(-59538, -5531):orderRoaming()
             , CpuShip():setFaction("Rebelle"):setTemplate("TestDrone"):setCallSign("CSS30"):setPosition(-57179, -3245):orderRoaming()
             , CpuShip():setFaction("Rebelle"):setTemplate("TestDrone"):setCallSign("CV9"):setPosition(-53019, -3524):orderRoaming()
             , CpuShip():setFaction("Rebelle"):setTemplate("TestDrone"):setCallSign("SS39"):setPosition(-56368, -15264):orderRoaming()
             , CpuShip():setFaction("Rebelle"):setTemplate("TestDrone"):setCallSign("CSS32"):setPosition(-53934, -10987):orderRoaming()
             , CpuShip():setFaction("Rebelle"):setTemplate("TestDrone"):setCallSign("SS19"):setPosition(-55925, -7153):orderRoaming()
             , CpuShip():setFaction("Rebelle"):setTemplate("TestDrone"):setCallSign("VS42"):setPosition(-56663, 12167):orderRoaming()
             , CpuShip():setFaction("Rebelle"):setTemplate("TestDrone"):setCallSign("VS27"):setPosition(-55630, 10103):orderRoaming()
             , CpuShip():setFaction("Rebelle"):setTemplate("TestDrone"):setCallSign("CSS8"):setPosition(-49979, 9880):orderRoaming()
             , CpuShip():setFaction("Rebelle"):setTemplate("TestDrone"):setCallSign("UTI41"):setPosition(-51058, 13200):orderRoaming()
             , CpuShip():setFaction("Rebelle"):setTemplate("TestDrone"):setCallSign("BR26"):setPosition(-51427, 11282):orderRoaming()
             , CpuShip():setFaction("Rebelle"):setTemplate("TestDrone"):setCallSign("VS23"):setPosition(-44495, 6858):orderRoaming()
             , CpuShip():setFaction("Rebelle"):setTemplate("TestDrone"):setCallSign("CSS25"):setPosition(-45970, 10766):orderRoaming()
             , CpuShip():setFaction("Rebelle"):setTemplate("TestDrone"):setCallSign("SS18"):setPosition(-50739, 6494):orderRoaming()
             , CpuShip():setFaction("Rebelle"):setTemplate("TestDrone"):setCallSign("CSS28"):setPosition(-56368, 7227):orderRoaming()
             , CpuShip():setFaction("Rebelle"):setTemplate("TestDrone"):setCallSign("CCN17"):setPosition(-53710, 5873):orderRoaming()
             , CpuShip():setFaction("Rebelle"):setTemplate("TestDrone"):setCallSign("S46"):setPosition(-41914, 10987):orderRoaming()
             , CpuShip():setFaction("Rebelle"):setTemplate("TestDrone"):setCallSign("CSS45"):setPosition(-41472, 7522):orderRoaming()
             , CpuShip():setFaction("Rebelle"):setTemplate("TestDrone"):setCallSign("CV24"):setPosition(-41472, 3392):orderRoaming()
             , CpuShip():setFaction("Rebelle"):setTemplate("TestDrone"):setCallSign("VS15"):setPosition(-46870, 4076):orderRoaming()
             , CpuShip():setFaction("Rebelle"):setTemplate("TestDrone"):setCallSign("CSS44"):setPosition(-62046, 7079):orderRoaming()
             , CpuShip():setFaction("Rebelle"):setTemplate("TestDrone"):setCallSign("NC43"):setPosition(-59686, 8701):orderRoaming()
             , CpuShip():setFaction("Rebelle"):setTemplate("TestDrone"):setCallSign("SS29"):setPosition(-59244, 4203):orderRoaming()
             , CpuShip():setFaction("Rebelle"):setTemplate("TestDrone"):setCallSign("CV14"):setPosition(-50946, 276):orderRoaming()
             , CpuShip():setFaction("Rebelle"):setTemplate("TestDrone"):setCallSign("CV13"):setPosition(-52121, 2694):orderRoaming()
             , CpuShip():setFaction("Rebelle"):setTemplate("TestDrone"):setCallSign("VK16"):setPosition(-56681, 1727):orderRoaming()
             , CpuShip():setFaction("Rebelle"):setTemplate("TestDrone"):setCallSign("UTI6"):setPosition(-60135, -69):orderRoaming()
             };
end

function bigAttackWave(nb)
    for i=1,nb,1 do
        local x;
        local y;
        if i % 2 == 0 then
            x = irandom(-40000, 60000);
            if x > -20000 and x < 40000 then
                if irandom(1,2) == 1 then
                    y = irandom(-40000,-20000);
                else
                    y = irandom(20000,40000);
                end
            else
                y = irandom(-40000,40000);
            end
        else
            y = irandom(-40000, 40000);
            if y > -20000 and y < 40000 then
                if irandom(1,2) == 1 then
                    x = irandom(-40000,-20000);
                else
                    x = irandom(40000,60000);
                end
            else
                x = irandom(-40000,60000);
            end
        end
        local shipNb = irandom(1,7);
        local ship = "";
        if shipNb == 1 then
            ship = "Unknown";
        else
            if shipNb < 5 then
                ship = "Atlantis X23";
            else
                ship = "MT52 Hornet";
            end
        end

        CpuShip():setFaction("Unknown"):setTemplate(ship):setCallSign("BR57"):setPosition(x,y):orderRoaming();
    end
end

function nextStep() 
    scenarioStatus = scenarioStatus + 1;
    scenarioSteps[scenarioStatus].init();
end

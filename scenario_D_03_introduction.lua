--Name: introduction
--Description: Permet d'introduire les nouveaux joueurs
--Type: Mission

scenarioStatus = 1; --Fuck Lua (1 based index)

function nextStep() 
    scenarioStatus = scenarioStatus + 1; --Fuck Lua (no +=)
    scenarioSteps[scenarioStatus].init();
end

scenarioSteps = {
    {--1
        init = function()
            drone = idleDrone(500, -3000);
        end,
        update = function()
            if not drone:isValid() then
                drone = nil;
                nextStep();
            end
        end
    },
    {--2
        init = function()
            station:sendCommsMessage(player, "Revenez à la base, pour procéder.");
        end,
        update = function()
                if player:isDocked(station) then
                    nextStep();
                end
        end
    },
    {--3
        init = function()
            player:setWeaponTubeCount(1)
            player:setWeaponStorageMax("Homing", 5)
            player:setWeaponStorage("Homing", 5)

            player:setBeamWeapon(0,0, 0, 0.0, 00, 0)
            player:setBeamWeapon(1,0, 0, 0.0, 00, 0)

            drone = idleDrone(-2000, -4000)
            station:sendCommsMessage(player, "Nous vous avons équipé de missile de type : Homing. Utilisez les pour détruire le drone.");
        end,
        update = function()
            if not drone:isValid() then
                drone = nil;
                nextStep();
            end
        end
    },
    {--4
        init = function()
            station:sendCommsMessage(player, "Revenez à la base, pour procéder.");
        end,
        update = function()
                if player:isDocked(station) then
                    nextStep();
                end
        end
    },
    {--5
        init = function()
            player:setBeamWeapon(0,90, 25, 1000.0, 6.0, 0.75)
            player:setBeamWeapon(1,90, -25, 1000.0, 6.0, 0.75)
            player:setWeaponStorageMax("Homing", 0)
            player:setWeaponStorage("Homing", 0)

            player:setWeaponTubeCount(2)
            player:setWeaponStorageMax("HVLI", 20)
            player:setWeaponStorage("HVLI", 20)
            station:sendCommsMessage(player, "Vous êtes maintenant équipé de beam et missile de type : HVLI. Commencez par l'immobiliser en utilisant les beam, puis détruisez le avec les HVLI");
            drone = CpuShip():setTemplate("TestDrone"):setFaction("Rebelle"):setPosition(-0, -3000):orderFlyTowardsBlind(-50000, -100000)
            commSent = false;
            timer = 0;
        end,
        update = function()

            if timer >= 500 then
                drone:orderFlyTowardsBlind(-5000, -3000);
            else
                drone:orderFlyTowardsBlind(5000, -3000);
            end
            
            if timer >= 1000 then
                timer = 0;
            end
            
            timer = timer + 1;

            if not commSent and drone:getSystemHealth("Impulse") <= 0.3 then
                station:sendCommsMessage(player, "Le drone est immobilisé, utilisez les HVLI pour le détruire.");
                commSent = true;
            end
            if not drone:isValid() then
                drone = nil;
                nextStep();
            end
        end
    },
    {--6
        init = function()
            station:sendCommsMessage(player, "Revenez à la base, pour procéder.");
        end,
        update = function()
                if player:isDocked(station) then
                    nextStep();
                end
        end
    },
    {--7
        init = function()
            station:sendCommsMessage(player, "Vous avez deux drones devant vous. L'un est allié, l'autre ennemi. Détruisez le bon.");
            drone = idleDrone(1500, -2000);
            fakeDrone = idleDrone(-1500, -2000):setFaction("Confederation");
        end,
        update = function()
            if not drone:isValid() then
                drone = nil;
                nextStep();
            end
        end
    },
    {--8
        init = function()
            station:sendCommsMessage(player, "Vous devez maintenant vous rendre au secteur D3. Par contre, il est remplis de mines et d'astéroide, sondez le pour trouver un point ou il est sécuritaire de sauter.");
        end,
        update = function()
            if player:getSectorName() == "D3" then
                nextStep();
            end
        end
    },
    {--9
        init = function()
            station:sendCommsMessage(player, "Félicitation, il vous faut maintenant vous rendre au secteur C3 sans utiliser le saut.");
        end,
        update = function()
            if player:getSectorName() == "C3" then
                nextStep();
            end
        end
    },
    {--10
        init = function()
            station:sendCommsMessage(player, "Allez rejoindre la base du secteur C3.");
        end,
        update = function()
            if player:isDocked(toDefend) then
                nextStep();
            end
        end
    },
    {--11
        init = function()
            player:setReputationPoints(300);
            player:setBeamWeapon(0,90, 25, 1000.0, 6.0, 0.75)
            player:setBeamWeapon(1,90, -25, 1000.0, 6.0, 0.75)

            player:setWeaponTubeCount(4)
            player:setWeaponStorageMax("HVLI", 20)
            player:setWeaponStorage("HVLI", 20)
            player:setWeaponStorageMax("Homing", 15)
            player:setWeaponStorage("Homing", 15)
            player:setWeaponStorageMax("Nuke", 2)
            player:setWeaponStorage("Nuke", 2)
            player:setWeaponStorageMax("EMP", 4)
            player:setWeaponStorage("EMP", 4)
            player:setWeaponStorageMax("Mine", 6)
            player:setWeaponStorage("Mine", 6)

            player:setWeaponTubeDirection(0, 0)
            player:setWeaponTubeDirection(1, -90)
            player:setWeaponTubeDirection(2,  90)
            player:setWeaponTubeDirection(3,  180)
            player:weaponTubeDisallowMissle(0, "Mine")
            player:weaponTubeDisallowMissle(1, "Mine")
            player:weaponTubeDisallowMissle(2, "Mine")
            player:setWeaponTubeExclusiveFor(3, "Mine")
            station:sendCommsMessage(player, "Nous sommes attaqué, prenez cet équipement et protégez nous. Attention, certains peuvent se cacher dans les nébuleuses.\n\nIl y a une base cachée dans une nébuleuse dans le coin inférieur gauche du secteur C4. Demandez leurs des renforts et des munitions.");
        end,
        update = function()
            if not player:isDocked(toDefend) then
                nextStep();
            end
        end
    },

    {--12
        init = function()
            swarm = { CpuShip():setFaction("Rebelle"):setTemplate("MU52 Hornet"):setCallSign("vk7"):setPosition(-39198, -54900):orderAttack(player)
                    , CpuShip():setFaction("Rebelle"):setTemplate("MU52 Hornet"):setCallSign("adr4"):setPosition(-39192, -55274):orderAttack(player)
                    , CpuShip():setFaction("Rebelle"):setTemplate("MU52 Hornet"):setCallSign("cs12"):setPosition(-39491, -55035):orderAttack(player)
                    , CpuShip():setFaction("Rebelle"):setTemplate("MU52 Hornet"):setCallSign("gh57"):setPosition(-39890, -54966):orderAttack(player)
                    , CpuShip():setFaction("Rebelle"):setTemplate("MU52 Hornet"):setCallSign("lpo1"):setPosition(-39477, -55476):orderAttack(player)
                    , CpuShip():setFaction("Rebelle"):setTemplate("MU52 Hornet"):setCallSign("asd12"):setPosition(-39688, -54642):orderAttack(player)
                    }
            
            enemyReinforcements = { CpuShip():setFaction("Rebelle"):setTemplate("MT52 Hornet"):setCallSign("VK11"):setPosition(-63605, -82374):orderAttack(player)
                                  , CpuShip():setFaction("Rebelle"):setTemplate("MT52 Hornet"):setCallSign("pk12"):setPosition(-62467, -82438):orderAttack(player)
                                  , CpuShip():setFaction("Rebelle"):setTemplate("MT52 Hornet"):setCallSign("ik13"):setPosition(-61339, -82332):orderAttack(player)
                                  }

            boss = CpuShip():setFaction("Rebelle"):setTemplate("Atlantis X23"):setCallSign("bss57"):orderAttack(player)
            boss:setHeading(221);
            boss:setJumpDrive(false);
            boss:setPosition(-22794, -57237);
            boss:setShieldsMax(200.00, 200.00):setShields(200.00, 200.00)
            boss:setWeaponStorageMax("Homing", 50):setWeaponStorage("Homing", 50)
            boss:setWeaponStorageMax("Mine", 4):setWeaponStorage("Mine", 4)
            boss:setWeaponStorageMax("EMP", 4):setWeaponStorage("EMP", 4)
            boss:setWeaponStorageMax("HVLI", 50):setWeaponStorage("HVLI", 50)
        end,
        update = function()
            allKilled = true;
            for i,j in pairs(swarm) do
                if j:isValid() then
                    allKilled = false;
                end
            end

            for i,j in pairs(enemyReinforcements) do
                if j:isValid() then
                    allKilled = false;
                end
            end

            if boss:isValid() then
                allKilled = false;
            end
            
            if allKilled then
                victory("Confederation");
            end

            if not player:isValid() then
                victory("Rebelle");
            end
            
        end
    },
}

function init()

    station = SpaceStation():setTemplate("Small Station"):setFaction("Confederation"):setPosition(0, 0);
    toDefend = SpaceStation():setTemplate("Large Station"):setFaction("Confederation"):setCallSign("DS312"):setPosition(-29962, -49906)
    supply = SpaceStation():setTemplate("Small Station"):setFaction("Confederation"):setCallSign("DS321"):setPosition(-17392, -44371)


    player = PlayerSpaceship():setFaction("Confederation"):setTemplate("Exercice"):setCallSign("862");
    player:setWeaponTubeCount(0)
    player:setWeaponStorageMax("Mine", 0)
    player:setWeaponStorageMax("Homing", 0)
    player:setHeading(360);
    player:commandDock(station);
    scenarioSteps[scenarioStatus].init();

    station:sendCommsMessage(player, "Bonjour cadets, \n ceci est un exercice guidé. Vous devrez remplir votre rôle en suivant les ordres de votre capitaine instructeur. À travers cette simulation, vous serez confronté a diverses situations qui vous feront travailler plusieurs aspects de vos rôles.\n Bonne chance!\n\nVotre premier exercice sera de détruire le drone avec vos beam.");

    Nebula():setPosition(-42814, -45403)
    Nebula():setPosition(-42251, -55629)
    Nebula():setPosition(-20300, -59850)
    Nebula():setPosition(-38218, -70638)
    Nebula():setPosition(-18612, -45122)
    BlackHole():setPosition(-30901, -60694)

    asteroidAndMines();
end

function update(delta)
    scenarioSteps[scenarioStatus].update()
end

function idleDrone(x, y)
    return CpuShip():setTemplate("TestDrone"):setPosition(x,y):setFaction("Rebelle"):orderIdle();
end

function tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

function asteroidAndMines()
    Asteroid():setPosition(-28471, -37601)
    Mine():setPosition(-28835, -36389)
    Asteroid():setPosition(-20678, -36430)
    Asteroid():setPosition(-30127, -38852)
    Mine():setPosition(-23868, -37964)
    Asteroid():setPosition(-22697, -36470)
    Asteroid():setPosition(-24837, -36430)
    Mine():setPosition(-26694, -38933)
    Asteroid():setPosition(-25241, -38772)
    Mine():setPosition(-22010, -38085)
    Asteroid():setPosition(-31258, -37116)
    Asteroid():setPosition(-32832, -37964)
    Asteroid():setPosition(-32429, -36187)
    Mine():setPosition(-31742, -38327)
    Asteroid():setPosition(-37517, -29363)
    Asteroid():setPosition(-37678, -30170)
    Mine():setPosition(-38042, -32432)
    Mine():setPosition(-38042, -27828)
    Mine():setPosition(-37961, -35057)
    Asteroid():setPosition(-38405, -35016)
    Mine():setPosition(-37961, -38166)
    Asteroid():setPosition(-36371, -34385)
    Asteroid():setPosition(-35255, -30816)
    Asteroid():setPosition(-34569, -31261)
    Asteroid():setPosition(-35538, -33280)
    Mine():setPosition(-36103, -31099)
    Asteroid():setPosition(-33882, -31059)
    Asteroid():setPosition(-33438, -30897)
    Asteroid():setPosition(-33357, -32068)
    Mine():setPosition(-34367, -31584)
    Asteroid():setPosition(-36628, -28838)
    Asteroid():setPosition(-36871, -27384)
    Asteroid():setPosition(-34569, -28151)
    Mine():setPosition(-36669, -36672)
    Asteroid():setPosition(-35296, -38004)
    Asteroid():setPosition(-35296, -37964)
    Asteroid():setPosition(-33923, -36066)
    Asteroid():setPosition(-32671, -33724)
    Mine():setPosition(-34973, -35258)
    Mine():setPosition(-34529, -28757)
    Asteroid():setPosition(-34327, -31947)
    Asteroid():setPosition(-34407, -39620)
    Asteroid():setPosition(-37234, -39216)
    Mine():setPosition(-36830, -29040)
    Asteroid():setPosition(-37355, -31341)
    Asteroid():setPosition(-37355, -32391)
    Mine():setPosition(-38526, -25446)
    Asteroid():setPosition(-38203, -25203)
    Asteroid():setPosition(-38082, -23306)
    Asteroid():setPosition(-25968, -36510)
    Asteroid():setPosition(-26856, -36672)
    Asteroid():setPosition(-26937, -36106)
    Asteroid():setPosition(-32469, -32755)
    Asteroid():setPosition(-37436, -23629)
    Mine():setPosition(-37880, -21085)
    Mine():setPosition(-27543, -33966)
    Mine():setPosition(-24554, -32916)
    Asteroid():setPosition(-23626, -30938)
    Mine():setPosition(-28229, -31826)
    Asteroid():setPosition(-29602, -33199)
    Mine():setPosition(-23424, -35864)
    Mine():setPosition(-21849, -35864)
    Asteroid():setPosition(-22777, -35137)
    Mine():setPosition(-25604, -35783)
    Asteroid():setPosition(-25927, -34491)
    Mine():setPosition(-21041, -30695)
    Asteroid():setPosition(-21687, -29928)
    Asteroid():setPosition(-21364, -35218)
    Asteroid():setPosition(-21606, -36026)
    Mine():setPosition(-31863, -29363)
    Asteroid():setPosition(-30935, -28596)
    Mine():setPosition(-29077, -25284)
    Mine():setPosition(-34125, -25486)
    Mine():setPosition(-31621, -31988)
    Mine():setPosition(-30692, -34895)
    Asteroid():setPosition(-30813, -35016)
    Mine():setPosition(-32873, -23063)
    Mine():setPosition(-36750, -23507)
    Asteroid():setPosition(-36951, -21892)
    Mine():setPosition(-24958, -25365)
    Mine():setPosition(-24070, -27303)
    Mine():setPosition(-23302, -29403)
    Asteroid():setPosition(-21728, -28353)
    Asteroid():setPosition(-21324, -31664)
    Mine():setPosition(-31904, -24154)
    Asteroid():setPosition(-32954, -24436)
    Asteroid():setPosition(-36225, -25042)
    Mine():setPosition(-35861, -24557)
    Asteroid():setPosition(-34650, -23548)
    Asteroid():setPosition(-24110, -25405)
    Mine():setPosition(-24554, -22296)
    Mine():setPosition(-23747, -23427)
    Mine():setPosition(-21162, -25163)
    Mine():setPosition(-21728, -22458)
    Mine():setPosition(-27300, -22942)
    Asteroid():setPosition(-27381, -24315)
    Asteroid():setPosition(-26452, -25284)
    Asteroid():setPosition(-28512, -24396)
    Asteroid():setPosition(-23262, -26617)
    Asteroid():setPosition(-24474, -27223)
    Asteroid():setPosition(-30612, -26536)
    Mine():setPosition(-31863, -26294)
    Mine():setPosition(-31136, -22336)
    Asteroid():setPosition(-29844, -21731)
    Mine():setPosition(-26371, -21408)
    Mine():setPosition(-28067, -21408)
    Mine():setPosition(-34650, -21569)
    Asteroid():setPosition(-33519, -21408)
end

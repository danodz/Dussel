--Name : Examen Team
nbPlayers = 2;
scenarioStatus = 1;

function nextStep() 
    scenarioStatus = scenarioStatus + 1;
    scenarioSteps[scenarioStatus].init();
end

scenarioSteps = {
    {--1
        init = function()
            firstWave = {};
            positions = { { x = -28000, y = 1000 }
                        , { x = 25000, y = 1000 }
                        , { x = -1000, y = -25000 }
                        , { x = -1000, y = 28000 }
                        };
            for i=1, nbPlayers,1 do
                local pos = positions[i];
                table.insert(firstWave, generateMobTeam(5, pos.x, pos.y, "Rebelle", function(ship) ship:orderAttack(station) end));
            end
        end,
        update = function()
            allKilled = true;
            for i,team in pairs(firstWave) do
                for j,ship in pairs(team) do
                    if ship:isValid() then
                        allKilled = false;
                    end
                end 
            end
            if allKilled then
                nextStep();
            end
        end
    },
    {--2
        init = function()
            enemyStation = SpaceStation():setTemplate("Medium Station"):setFaction("Rebelle"):setCallSign("DS40"):setPosition(-40000, -40000);
            escort = CpuShip():setFaction("Confederation"):setTemplate("EscortMe"):setCallSign("VS25"):setPosition(-600, -700):orderFlyTowardsBlind(-37000,-37000)
            
            generateMobTeam(5, -30000, -30000, "Rebelle", function(ship) ship:orderStandGround() end);
            generateMobTeam(5, -20000,-20000, "Rebelle", function(ship) ship:orderStandGround() end);
            generateMobTeam(5, -10000,-10000, "Rebelle", function(ship) ship:orderStandGround() end);
            wave = 0;
        end,
        update = function()
            escortDamage = escortDamage + damageOverride(escort);
            local escortX = escort:getPosition();
            if escortX < -10000 and wave == 0 then
                wave = 1;
                generateMobTeam(5, 0, -20000, "Rebelle", function(ship) ship:orderAttack(station) end);
                generateMobTeam(5, -20000, 0, "Rebelle", function(ship) ship:orderAttack(escort) end);
            end
            if escortX < -20000 and wave == 1 then
                wave = 2;
                generateMobTeam(5, 20000, -20000, "Rebelle", function(ship) ship:orderAttack(station) end);
                generateMobTeam(5, -20000, -30000, "Rebelle", function(ship) ship:orderAttack(escort) end);
            end
            if escortX < -30000 and wave == 2 then
                wave = 3;
                generateMobTeam(5, 20000, 0, "Rebelle", function(ship) ship:orderAttack(station) end);
                generateMobTeam(5, -40000, -30000, "Rebelle", function(ship) ship:orderAttack(escort) end);
            end
            if escortX < -37000 and wave == 2 then
                nextStep();
            end
        end
    },
    {--3
        init = function()
            enemySpawnTimer = 0;
            spawnPoints = { {x = -40000, y = -75000}
                          , {x = -14000, y = -65000}
                          , {x = -5000, y = -40000}
                          , {x = -14000, y = -14000}
                          , {x = -40000, y = -5000}
                          , {x = -65000, y = -5000}
                          , {x = -75000, y = -40000}
                          , {x = -65000, y = -65000}
                          }
            generateMobTeam(5, spawnPoints[1].x, spawnPoints[1].y, "Rebelle", function(ship) ship:orderDefendTarget(enemyStation) end);
            generateMobTeam(5, spawnPoints[2].x, spawnPoints[2].y, "Rebelle", function(ship) ship:orderDefendTarget(enemyStation) end);
            generateMobTeam(5, spawnPoints[3].x, spawnPoints[3].y, "Rebelle", function(ship) ship:orderDefendTarget(enemyStation) end);
            generateMobTeam(5, spawnPoints[4].x, spawnPoints[4].y, "Rebelle", function(ship) ship:orderDefendTarget(enemyStation) end);
            gameOver = false;
        end,
        update = function()
            if not enemyStation:isValid() and not gameOver then
                gameOver = true;
                for i=1,nbPlayers,1 do
                    station:sendCommsMessage(players[i].ship, "C'est terminé, voici votre bilan: \n Station : " .. stationDamage .. "\nEscort : " .. escortDamage .. "\nVotre vaisseau : " .. players[i].damage);
                end
            end
            enemySpawnTimer = enemySpawnTimer + 1;

            if enemySpawnTimer > 60*30 then
                enemySpawnTimer = 0;
                local spawnPos = spawnPoints[irandom(1,8)];
                generateMobTeam(5, spawnPos.x, spawnPos.y, "Rebelle", function(ship) ship:orderDefendTarget(enemyStation) end);
            end
        end
    }
}

function init()
    addGMFunction("Next Step", nextStep);
    station = SpaceStation():setTemplate("Medium Station"):setFaction("Confederation"):setCallSign("Academie")
    enemyStation = SpaceStation():setTemplate("Large Station"):setFaction("Rebelle"):setCallSign("DS40"):setPosition(-40000, -40000);

    stationDamage = 0
    escortDamage = 0

    players = {};
    positions = { { x = -800, y = 0, heading = 270 }
                , { x = 800, y = 0, heading = 90 }
                , { x = 0, y = -700, heading = 0 }
                , { x = 0, y = 700, heading = 180 }
                };
    for i=1,nbPlayers,1 do
        table.insert(players,
            { ship = PlayerSpaceship():setFaction("Confederation"):setTemplate("Atlantis"):setCallSign(i):setReputationPoints(100):commandDock(station)
            , damage = 0
            , score = 0
            }
        );
        local pos = positions[i];
        players[i].ship:setPosition(pos.x,pos.y):setHeading(pos.heading);
    end

    scenarioSteps[scenarioStatus].init();
end

function update(delta)
    scenarioSteps[scenarioStatus].update()
    
    for index,player in pairs(players) do
        updatePlayer(player);
    end
    
    stationDamage = stationDamage + damageOverride(station);
end

function updatePlayer(player)
    player.damage = player.damage + damageOverride(player.ship);
end

function generateMobTeam(amount, x, y, faction, fn)
    local ships = {};

    for i=1,amount - 1,1 do
        ships[i] = CpuShip():setFaction(faction):setTemplate("MT52 Hornet"):setCallSign(srandom(irandom(2,3)) .. irandom(10,999)):setPosition(irandom(x - 1000, x + 1000), irandom(y - 1000, y + 1000))
        fn(ships[i]);
    end
    ships[amount] = CpuShip():setFaction(faction):setTemplate("Atlantis X23"):setCallSign(srandom(irandom(2,3)) .. irandom(10,999)):setPosition(irandom(x - 1000, x + 1000), irandom(y - 1000, y + 1000))
    fn(ships[amount]);

    return ships;
end

charset = {}
-- QWERTYUIOPASDFGHJKLZXCVBNM
for i = 65,  90 do table.insert(charset, string.char(i)) end

function srandom(length)
  if length > 0 then
    return srandom(length - 1) .. charset[irandom(1, #charset)]
  else
    return ""
  end
end

function damageOverride(ship)
    local damage = ship:getHullMax() - ship:getHull();
    ship:setHull(ship:getHullMax());
    return damage;
end

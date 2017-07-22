--Name: C01-03B Station recherche
crewPosition = {"Helms", "Weapons", "Engineering", "Science", "Relay"};

nbPlayers = 3;

scenarioPart = "gettingTheData";

scenarioParts = {
    gettingTheData = {
        init = function() 
            sendCommToAll(station, "Nous avons identifié des maraudeurs qui auraient de l'information sur le temple, allez chercher l'info.");
            maraudeurBoss =  CpuShip():setFaction("Charognards"):setTemplate("Atlantis X23"):setCallSign("S1"):setPosition(-4000, 0)
            maraudeurBoss.status = "idle";
            maraudeurBoss:setCommsFunction( function()
	            setCommsMessage("Qu'est-ce que vous voulez")
	            addCommsReply("On veux l'info", function()
        	        setCommsMessage("Vous ne l'aurez pas si facilement. Il faut payer si vous la voulez")			
	                addCommsReply("D'accord, on va payer", function()
                        --takeReputationPoints
	                    setCommsMessage("Vous n'avez même pas la réputation nécessaire.")
                    end)
	                addCommsReply("Tant pis, oubliez ça", function()
	                    setCommsMessage("On reste ici si vous changez d'avis.")
                    end)
	                addCommsReply("On va la prendre de force alors", function()
	                    setCommsMessage("C'est la guerre que vous voulez.")
                        maraudeurBoss.status = "fighting";
                        maraudeurBoss:orderRoaming();
                    end)
	            end)
            end)
        end,
        update = function()
            if maraudeurBoss.status == "idle" then
                for i=1, maraudeurBoss:getShieldCount(), 1 do
                    if maraudeurBoss:getShieldLevel(i) < maraudeurBoss:getShieldMax(i) then
                        maraudeurBoss.status = "fighting";
                        maraudeurBoss:orderRoaming();
                        sendCommToAll(maraudeurBoss, "Vous m'avez provoqué, c'est la guerre.");
                    end
                end
            end

            if maraudeurBoss.status == "fighting" and maraudeurBoss:getHull() < 75 then
                sendCommToAll(maraudeurBoss, "Vous n'en valez pas la peine, je m'en vais.")
                maraudeurBoss.status = "fleeing";
                maraudeurBoss:orderFlyTowardsBlind(-28394, -25557);
            end
            
            if maraudeurBoss.status == "fleeing" then
                if maraudeurBoss:areEnemiesInRange(4500) and maraudeurBoss:getSectorName() == "D3" then
                    sendCommToAll(maraudeurBoss, "C'est bon, je vais vous le dire.");
                    changePart("temple");
                end
            end
        end
    },
    temple = {
        init = function() 
        end,
        update = function()
            for i,player in pairs(players) do
                if player:isDocked(temple) and not player.messageSent then
                    temple:sendCommsMessage(player, "Exploration RP");
                    player.messageSent = true;
                end
            end
        end
    },
    finalAttack = {
        init = function()
            generateMobs(10, "MT52 Hornet", "Loyalistes", 1000, 1000, 5000, function(mob) mob:orderDefendTarget(temple) end );
            countdown = 1800
            warningSent = false;
        end,
        update = function()
            if not warningSent then
                countdown = countdown - 1;
                if countdown <= 0 then
                    sendCommToAll(station, "Leurs renforts arrivent, revenez à la base.");
                    warningSent = true;
                end
            end
        end
    },
};

function init()
    for partName, partFunction in pairs(scenarioParts) do
        addGMFunction(partName, function() changePart(partName) end);
    end

    station = SpaceStation():setTemplate("Medium Station"):setFaction("Dussel"):setPosition(0, 0);
    temple = SpaceStation():setTemplate("Medium Station"):setFaction("Aucune faction"):setPosition(1000, 1000);
    templeDefence = generateMobs(10, "MT52 Hornet", "Loyalistes", 1000, 1000, 1000, function(mob) mob:orderDefendTarget(temple) end );
    
    players = { --PlayerSpaceship():setFaction("Arianne"):setTemplate("ACorvette"):setCallSign("ARI"):setPosition(-7640, 39663)
              PlayerSpaceship():setFaction("Vindh"):setTemplate("VCorvette"):setCallSign("Larth1"):setPosition(-7640, 39663):setWeaponStorage("Nuke", 0)
              , PlayerSpaceship():setFaction("Vindh"):setTemplate("VCorvette"):setCallSign("Vasserand"):setPosition(-7540, 39663):setWeaponStorage("Nuke", 0)
              , PlayerSpaceship():setFaction("Loyalistes"):setTemplate("MCorvette"):setCallSign("Ducal-2"):setPosition(-7540, 39663):setWeaponStorage("Nuke", 0)
              --, PlayerSpaceship():setFaction("Merillon"):setTemplate("MCorvette"):setCallSign("MER"):setPosition(-7640, 39663)
              };

    scenarioParts[scenarioPart].init();

    addGMFunction("CleanShips", function()
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
    end)
end

function update()
    scenarioParts[scenarioPart].update();
end

function changePart(partName)
    scenarioPart = partName;
    scenarioParts[scenarioPart].init();
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

function allDead (...)
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

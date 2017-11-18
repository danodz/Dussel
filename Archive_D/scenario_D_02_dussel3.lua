-- Name: Dussel 3
-- Description: Scenario 3 pour le beta de Dussel-3
-- Variation[Empty]: Places no enemies. Recommended for GM-controlled scenarios and rookie crew orientation. The scenario continues until the GM declares victory or all Human Navy craft are destroyed.
-- Variation[Easy]: Places fewer enemies. Recommended for inexperienced crews.
-- Variation[Hard]: Places more enemies. Recommended if you have multiple player-controlled ships.
-- Variation[Extreme]: Places many enemies. You're pretty surely overwhelmed.


-- Phase 1 : Les joueurs partent tous de dussels et reçoivent le signal que leur station est en train d'être attaquée. Ils doivent donc la défendre et résiter à une série d'attaques. 
-- Phase 2 : Jump vers la sources des alien et son ambusqués en chemin, voir sc.02)
-- Phase 3 : point de rendez-vous et direction vers wormhole. Prendre le hole. Arriver dans un endroit entouré d'ennemis (prendre sc.Ambush)
-- Fin du jeu.

-- centre cible de l'Attaque : 37000, -55000


function vectorFromAngle(angle, length)
	return math.cos(angle / 180 * math.pi) * length, math.sin(angle / 180 * math.pi) * length
end

function setCirclePos(obj, x, y, angle, distance)
	dx, dy = vectorFromAngle(angle, distance)
	return obj:setPosition(x + dx, y + dy)
end


-- Add an enemy wave.
-- enemyList: A table containing enemy ship objects.
-- type: A number; at each integer, determines a different wave of ships to add
--       to the enemyList. Any number is valid, but only 0.99-9.0 are meaningful.
-- a: The spawned wave's heading relative to the players' spawn point.
-- d: The spawned wave's distance from the players' spawn point.
function addWave(enemyList,type,a,d)
	if type < 1.0 then
		table.insert(enemyList, setCirclePos(CpuShip():setTemplate('Ktlitan Scout'):setFaction("Namorites"):setRotation(a + 180):orderRoaming(), 37000, -55000, a, d))
	elseif type < 2.0 then
		leader = setCirclePos(CpuShip():setTemplate('Ktlitan Breaker'):setFaction("Namorites"):setRotation(a + 180):orderRoaming(), 37000, -55000, a + random(-1, 1), d + random(-100, 100))
		table.insert(enemyList, leader)
		table.insert(enemyList, setCirclePos(CpuShip():setTemplate('Ktlitan Drone'):setFaction("Namorites"):setRotation(a + 180):orderFlyFormation(leader,-400, 0), 37000, -55000, a + random(-1, 1), d + random(-100, 100)))
		table.insert(enemyList, setCirclePos(CpuShip():setTemplate('Ktlitan Drone'):setFaction("Namorites"):setRotation(a + 180):orderFlyFormation(leader, 400, 0), 37000, -55000, a + random(-1, 1), d + random(-100, 100)))
		table.insert(enemyList, setCirclePos(CpuShip():setTemplate('Ktlitan Drone'):setFaction("Namorites"):setRotation(a + 180):orderFlyFormation(leader,-400, 400), 37000, -55000, a + random(-1, 1), d + random(-100, 100)))
		table.insert(enemyList, setCirclePos(CpuShip():setTemplate('Ktlitan Drone'):setFaction("Namorites"):setRotation(a + 180):orderFlyFormation(leader, 400, 400), 37000, -55000, a + random(-1, 1), d + random(-100, 100)))
	elseif type < 3.0 then
		table.insert(enemyList, setCirclePos(CpuShip():setTemplate('Ktlitan Fighter'):setFaction("Namorites"):setRotation(a + 180):orderRoaming(), 37000, -55000, a + random(-5, 5), d + random(-100, 100)))
		table.insert(enemyList, setCirclePos(CpuShip():setTemplate('Ktlitan Fighter'):setFaction("Namorites"):setRotation(a + 180):orderRoaming(), 37000, -55000, a + random(-5, 5), d + random(-100, 100)))
	elseif type < 4.0 then
		table.insert(enemyList, setCirclePos(CpuShip():setTemplate('Ktlitan Breaker'):setFaction("Namorites"):setRotation(a + 180):orderRoaming(), 37000, -55000, a + random(-5, 5), d + random(-100, 100)))
		table.insert(enemyList, setCirclePos(CpuShip():setTemplate('Ktlitan Breaker'):setFaction("Namorites"):setRotation(a + 180):orderRoaming(), 37000, -55000, a + random(-5, 5), d + random(-100, 100)))
		table.insert(enemyList, setCirclePos(CpuShip():setTemplate('Ktlitan Breaker'):setFaction("Namorites"):setRotation(a + 180):orderRoaming(), 37000, -55000, a + random(-5, 5), d + random(-100, 100)))
	elseif type < 5.0 then
		table.insert(enemyList, setCirclePos(CpuShip():setTemplate('Ktlitan Feeder'):setFaction("Namorites"):setRotation(a + 180):orderRoaming(), 37000, -55000, a + random(-5, 5), d + random(-100, 100)))
	elseif type < 6.0 then
		leader = setCirclePos(CpuShip():setTemplate('Ktlitan Feeder'):setFaction("Namorites"):setRotation(a + 180):orderRoaming(), 37000, -55000, a + random(-5, 5), d + random(-100, 100))
		table.insert(enemyList, leader)
		table.insert(enemyList, setCirclePos(CpuShip():setTemplate('Ktlitan Drone'):setFaction("Namorites"):setRotation(a + 180):orderFlyFormation(leader,-1500, 400), 37000, -55000, a + random(-1, 1), d + random(-100, 100)))
		table.insert(enemyList, setCirclePos(CpuShip():setTemplate('Ktlitan Drone'):setFaction("Namorites"):setRotation(a + 180):orderFlyFormation(leader, 1500, 400), 37000, -55000, a + random(-1, 1), d + random(-100, 100)))
	elseif type < 7.0 then
		table.insert(enemyList, setCirclePos(CpuShip():setTemplate('Ktlitan Breaker'):setFaction("Namorites"):setRotation(a + 180):orderRoaming(), 37000, -55000, a + random(-5, 5), d + random(-100, 100)))
		table.insert(enemyList, setCirclePos(CpuShip():setTemplate('Ktlitan Breaker'):setFaction("Namorites"):setRotation(a + 180):orderRoaming(), 37000, -55000, a + random(-5, 5), d + random(-100, 100)))
	elseif type < 8.0 then
		table.insert(enemyList, setCirclePos(CpuShip():setTemplate('Ktlitan Feeder'):setFaction("Namorites"):setRotation(a + 180):orderRoaming(), 37000, -55000, a + random(-5, 5), d + random(-100, 100)))
	elseif type < 9.0 then
		table.insert(enemyList, setCirclePos(CpuShip():setTemplate('Ktlitan Drone'):setFaction("Namorites"):setRotation(a + 180):orderRoaming(), 37000, -55000, a + random(-5, 5), d + random(-100, 100)))
	else
		table.insert(enemyList, setCirclePos(CpuShip():setTemplate('Ktlitan Fighter'):setFaction("Namorites"):setRotation(a + 180):orderRoaming(), 37000, -55000, a + random(-5, 5), d + random(-100, 100)))
		table.insert(enemyList, setCirclePos(CpuShip():setTemplate('Ktlitan Fighter'):setFaction("Namorites"):setRotation(a + 180):orderRoaming(), 37000, -55000, a + random(-5, 5), d + random(-100, 100)))
	end
end

-- Returns a semi-random heading.
-- cnt: A counter, generally between 1 and the number of enemy groups.
-- enemy_group_count: A number of enemy groups, generally set by the scenario type.
function setWaveAngle(cnt,enemy_group_count)
	return cnt * 360/enemy_group_count + random(-60, 60)
end

-- Returns a semi-random distance.
-- enemy_group_count: A number of enemy groups, generally set by the scenario type.
function setWaveDistance(enemy_group_count)
	return random(35000, 40000 + enemy_group_count * 3000)
end

function init()

	-- appelle carte dussel
	require("dussel/map_dussel.lua")
	-- appelle vaisseaux joueurs dussel
	require("dussel/playership_dussel.lua")

	vindhteamList = {}
	arianneteamList = {}
	merillonteamList = {}

	enemyList = {}
	friendlyList = {}

	-- arianne
	table.insert(arianneteamList, ToisondOr:setPosition(-32500, -25000))
	table.insert(arianneteamList, CigogneIV:setPosition(-35000, -30000))
	table.insert(arianneteamList, GuerrillaRadio:setPosition(-30000, -25000))
	-- merillon
	table.insert(merillonteamList, Excommunicateur:setPosition(-30000, -35000))
	table.insert(merillonteamList, NexusVoid:setPosition(-30000, -32500))
	-- vindh
	table.insert(vindhteamList, DIVX:setPosition(-25000, -30000))
	table.insert(vindhteamList, Korosheg:setPosition(-22500, -30000))

	dussel_3 = SpaceStation():setTemplate("Huge Station"):setFaction("Dussel"):setCallSign("D-3"):setPosition(-30012, -30015)

	-- create faction stations
	mstation_A4 = table.insert(friendlyList, SpaceStation():setTemplate("Medium Station"):setFaction("Merillon"):setCallSign("DS-A4"):setPosition(-17505, -92912):setScanned(true))
  	mstation_C6 = table.insert(friendlyList, SpaceStation():setTemplate("Medium Station"):setFaction("Arianne"):setCallSign("DS-C6"):setPosition(36639, -55983):setScanned(true))
	mstation_E7 = table.insert(friendlyList, SpaceStation():setTemplate("Medium Station"):setFaction("Vindh"):setCallSign("DS-E7"):setPosition(46110, -10221):setScanned(true))
	

	-- create ennemy station
	stationnamori = SpaceStation():setTemplate("Medium Station"):setFaction("Namorites"):setCallSign("NAA4"):setPosition(80000, -145000)

	-- create scavenging stations
    table.insert(friendlyList, SpaceStation():setTemplate("Small Station"):setFaction("Arianne"):setCallSign("DS01"):setPosition(10612, -76123):setCommsFunction(commsStationLoot))
    table.insert(friendlyList, SpaceStation():setTemplate("Small Station"):setFaction("Arianne"):setCallSign("DS02"):setPosition(37364, -33386):setCommsFunction(commsStationLoot))
	table.insert(friendlyList, SpaceStation():setTemplate("Small Station"):setFaction("Vindh"):setCallSign("DS03"):setPosition(70970, -7267):setCommsFunction(commsStationLoot))
    table.insert(friendlyList, SpaceStation():setTemplate("Small Station"):setFaction("Merillon"):setCallSign("DS04"):setPosition(-42805, -86606):setCommsFunction(commsStationLoot))
    table.insert(friendlyList, SpaceStation():setTemplate("Small Station"):setFaction("Arianne"):setCallSign("DS05"):setPosition(43325, -64885):setCommsFunction(commsStationLoot))
	
	-- Start the players with 300 reputation.
	-- friendlyList[1]:addReputationPoints(50.0)
	vindhteamList[1]:addReputationPoints(150.0)
	arianneteamList[1]:addReputationPoints(150.0)
	merillonteamList[1]:addReputationPoints(150.0)

	
	addGMFunction ("Respawn playership", function()
	
			--CpuShip():setTemplate('Fighter'):setFaction("Vindh"):setPosition(531000, -38700):setCallSign("Korog3")
			--PlayerSpaceship():setFaction("Vindh"):setTemplate("Artheurge"):setCallSign("KoroG3")setPosition(531000, -38500)
			
			if not Korosheg:isValid() then 
				Korosheg = New PlayerSpaceship():setFaction("Vindh"):setTemplate("Artheurge"):setTypeName("Camarade DIVX"):setCallSign("Korog2"):setPosition(-22500, -30000)
			end
		
			if not DIVX:isValid() then
				DIVX = New PlayerSpaceship():setFaction("Vindh"):setTemplate("Artheurge"):setTypeName("Camarade DIVX"):setCallSign("DIVX2"):setPosition(-25000, -30000)
			end
		
			if not ToisondOr:isValid() then
				ToisondOr = New PlayerSpaceship()PlayerSpaceship():setFaction("Arianne"):setTemplate("Marchand"):setCallSign("LTO2"):setTypeName("LaToisondOr"):setPosition(-32500, -25000)
			end
			
			if not CigogneIV:isValid() then	
				CigogneIV = New PlayerSpaceship():setFaction("Arianne"):setTemplate("Marchand"):setCallSign("CigIV"):setTypeName("CigogneIV"):setPosition(-35000, -30000)
			end
			
			if not GuerrillaRadio:isValid() then	
				GuerrillaRadio = New PlayerSpaceship():setFaction("Arianne"):setTemplate("Camelot"):setTypeName("GuerrillaRadio"):setCallSign("TGR"):setPosition(-30000, -25000)
			end
			
			if not Excommunicateur:isValid() then
				Excommunicateur = New PlayerSpaceship():setFaction("Merillon"):setTemplate("Celesien"):setCallSign("FEE"):setTypeName("Excommunicateur"):setCallSign("FEE")setPosition(-30000, -35000)
			end
			
			if not NexusVoid:isValid() then
				NexusVoid = New PlayerSpaceship():setFaction("Merillon"):setTemplate("Celesien"):setCallSign("NV"):setTypeName("NexusVoid"):setCallSign("NV"):setPosition(-30000, -32500)
			end
	end)


	-- GM functions to manually trigger enemy waves.
	addGMFunction("Strikeship wave", function()
		addWave(enemyList,0,setWaveAngle(math.random(20), math.random(20)),setWaveDistance(math.random(5)))
	end)

	addGMFunction("Fighter wave", function()
		addWave(enemyList,1,setWaveAngle(math.random(20), math.random(20)),setWaveDistance(math.random(5)))
	end)

	addGMFunction("Gunship wave", function()
		addWave(enemyList,2,setWaveAngle(math.random(20), math.random(20)),setWaveDistance(math.random(5)))
	end)

	addGMFunction("Dreadnought", function()
		addWave(enemyList,4,setWaveAngle(math.random(20), math.random(20)),setWaveDistance(math.random(5)))
	end)

	addGMFunction("Missile cruiser wave", function()
		addWave(enemyList,5,setWaveAngle(math.random(20), math.random(20)),setWaveDistance(math.random(5)))
	end)

	addGMFunction("Cruiser wave", function()
		addWave(enemyList,6,setWaveAngle(math.random(20), math.random(20)),setWaveDistance(math.random(5)))
	end)

	addGMFunction("Adv. striker wave", function()
		addWave(enemyList,9,setWaveAngle(math.random(20), math.random(20)),setWaveDistance(math.random(5)))
	end)

	-- Let the GM spawn a random enemy wave.
	addGMFunction("Random wave", function()
		a = setWaveAngle(math.random(20), math.random(20))
		d = setWaveDistance(math.random(20))
		type = random(0, 10)
		addWave(enemyList,type,a,d)
	end)

	-- Let the GM spawn random reinforcements. Their distance from the
	-- players' spawn point is about half that of enemy waves.
	addGMFunction("Random friendly", function()
		a = setWaveAngle(math.random(20), math.random(20))
		d = random(15000, 20000 + math.random(20) * 1500)
		friendlyShip = {'Phobos T3','MU52 Hornet','Piranha F12'}
		friendlyShipIndex = math.random(#friendlyShip)
		table.insert(friendlyList, setCirclePos(CpuShip():setTemplate(friendlyShip[friendlyShipIndex]):setRotation(a):setFaction("Dussel"):orderRoaming(), -30000, -30000, a + random(-5, 5), d + random(-100, 100)))
	end)

	-- Envoyer un message de fin à tous 
	addGMFunction("Fin partie", function()
		globalMessage("Fin de la partie");
	end)


	-- Envoyer un message de fin à tous 
	addGMFunction("Texte Dussel", function()

		message = [[ Bonjour à vous. Nous vous avons offert notre hospitalité légendaire avec grand plaisir, et sachez que vous ne nous devez rien du tout. Il nous a fait grand plaisir de faire votre connaissance.

Néanmoins, comme vous le savez peut-être, nous sommes actuellement sous attaque. Il semblerait que les premières forces de ces créatures étranges aient été repoussées, mais nous ne pouvons nous arrêter en si bon chemin. Nous avons détecté une activité forte dans l’amas de nébuleuse aux alentours du cadran XX9. Vous pourriez vous y rendre, si cela vous ferait plaisir, et nous pourrions vous récompenser amplement.]]

		dussel_3:sendCommsMessage(ToisondOr, message)
		dussel_3:sendCommsMessage(CigogneIV, message)
		dussel_3:sendCommsMessage(GuerrillaRadio, message)
		
		dussel_3:sendCommsMessage(Excommunicateur, message)
		dussel_3:sendCommsMessage(NexusVoid, message)
		
		dussel_3:sendCommsMessage(DIVX, message)
		dussel_3:sendCommsMessage(Korosheg, message)
	end)

	addGMFunction("Final ending", function()
		table.insert(enemyList, setCirclePos(CpuShip():setTemplate('Ktlitan Scout'):setFaction("Namorites"):setRotation(a + 180):orderRoaming(), 110000, -350000, a, d))

		leader = setCirclePos(CpuShip():setTemplate('Ktlitan Breaker'):setFaction("Namorites"):setRotation(a + 180):orderRoaming(), 110000, -350000, a + random(-1, 1), d + random(-100, 100))
		table.insert(enemyList, leader)
		table.insert(enemyList, setCirclePos(CpuShip():setTemplate('Ktlitan Drone'):setFaction("Namorites"):setRotation(a + 180):orderFlyFormation(leader,-400, 0), 110000, -350000, a + random(-1, 1), d + random(-100, 100)))
		table.insert(enemyList, setCirclePos(CpuShip():setTemplate('Ktlitan Drone'):setFaction("Namorites"):setRotation(a + 180):orderFlyFormation(leader, 400, 0), 110000, -350000, a + random(-1, 1), d + random(-100, 100)))
		table.insert(enemyList, setCirclePos(CpuShip():setTemplate('Ktlitan Drone'):setFaction("Namorites"):setRotation(a + 180):orderFlyFormation(leader,-400, 400), 110000, -350000, a + random(-1, 1), d + random(-100, 100)))
		table.insert(enemyList, setCirclePos(CpuShip():setTemplate('Ktlitan Drone'):setFaction("Namorites"):setRotation(a + 180):orderFlyFormation(leader, 400, 400), 110000, -350000, a + random(-1, 1), d + random(-100, 100)))

		table.insert(enemyList, setCirclePos(CpuShip():setTemplate('Ktlitan Fighter'):setFaction("Namorites"):setRotation(a + 180):orderRoaming(), 110000, -350000, a + random(-5, 5), d + random(-100, 100)))
		table.insert(enemyList, setCirclePos(CpuShip():setTemplate('Ktlitan Fighter'):setFaction("Namorites"):setRotation(a + 180):orderRoaming(), 110000, -350000, a + random(-5, 5), d + random(-100, 100)))

		table.insert(enemyList, setCirclePos(CpuShip():setTemplate('Ktlitan Breaker'):setFaction("Namorites"):setRotation(a + 180):orderRoaming(), 110000, -350000, a + random(-5, 5), d + random(-100, 100)))
		table.insert(enemyList, setCirclePos(CpuShip():setTemplate('Ktlitan Breaker'):setFaction("Namorites"):setRotation(a + 180):orderRoaming(), 110000, -350000, a + random(-5, 5), d + random(-100, 100)))
		table.insert(enemyList, setCirclePos(CpuShip():setTemplate('Ktlitan Breaker'):setFaction("Namorites"):setRotation(a + 180):orderRoaming(), 110000, -350000, a + random(-5, 5), d + random(-100, 100)))
	
		table.insert(enemyList, setCirclePos(CpuShip():setTemplate('Ktlitan Feeder'):setFaction("Namorites"):setRotation(a + 180):orderRoaming(), 110000, -350000, a + random(-5, 5), d + random(-100, 100)))
	
		leader = setCirclePos(CpuShip():setTemplate('Ktlitan Feeder'):setFaction("Namorites"):setRotation(a + 180):orderRoaming(), 110000, -350000, a + random(-5, 5), d + random(-100, 100))
		table.insert(enemyList, leader)
		table.insert(enemyList, setCirclePos(CpuShip():setTemplate('Ktlitan Drone'):setFaction("Namorites"):setRotation(a + 180):orderFlyFormation(leader,-1500, 400), 110000, -350000, a + random(-1, 1), d + random(-100, 100)))
		table.insert(enemyList, setCirclePos(CpuShip():setTemplate('Ktlitan Drone'):setFaction("Namorites"):setRotation(a + 180):orderFlyFormation(leader, 1500, 400), 110000, -350000, a + random(-1, 1), d + random(-100, 100)))
	
		table.insert(enemyList, setCirclePos(CpuShip():setTemplate('Ktlitan Breaker'):setFaction("Namorites"):setRotation(a + 180):orderRoaming(), 110000, -350000, a + random(-5, 5), d + random(-100, 100)))
		table.insert(enemyList, setCirclePos(CpuShip():setTemplate('Ktlitan Breaker'):setFaction("Namorites"):setRotation(a + 180):orderRoaming(), 110000, -350000, a + random(-5, 5), d + random(-100, 100)))

		table.insert(enemyList, setCirclePos(CpuShip():setTemplate('Ktlitan Feeder'):setFaction("Namorites"):setRotation(a + 180):orderRoaming(), 110000, -350000, a + random(-5, 5), d + random(-100, 100)))

		table.insert(enemyList, setCirclePos(CpuShip():setTemplate('Ktlitan Drone'):setFaction("Namorites"):setRotation(a + 180):orderRoaming(), 110000, -350000, a + random(-5, 5), d + random(-100, 100)))

		table.insert(enemyList, setCirclePos(CpuShip():setTemplate('Ktlitan Fighter'):setFaction("Namorites"):setRotation(a + 180):orderRoaming(), 110000, -350000, a + random(-5, 5), d + random(-100, 100)))
		table.insert(enemyList, setCirclePos(CpuShip():setTemplate('Ktlitan Fighter'):setFaction("Namorites"):setRotation(a + 180):orderRoaming(), 110000, -350000, a + random(-5, 5), d + random(-100, 100)))
	end)





	-- Set the number of enemy waves based on the scenario variation.
	if getScenarioVariation() == "Extreme" then
		enemy_group_count = 20
	elseif getScenarioVariation() == "Hard" then
		enemy_group_count = 8
	elseif getScenarioVariation() == "Easy" then
		enemy_group_count = 3
	elseif getScenarioVariation() == "Empty" then
		enemy_group_count = 0
	else
		enemy_group_count = 5
	end

	-- If not in the Empty variation, spawn the corresponding number of random
	-- enemy waves at distributed random headings and semi-random distances
	-- relative to the players' spawn point.
	if enemy_group_count > 0 then
		for cnt=1,enemy_group_count do
			a = setWaveAngle(cnt, enemy_group_count)
			d = setWaveDistance(enemy_group_count)
			type = random(0, 10)
			addWave(enemyList, type, a, d)
		end
	end

	-- create namorite hideout

	WormHole():setPosition(94400, -152750):setTargetPosition(110000, -350000)


	CpuShip():setFaction("Namorites"):setTemplate("Ktlitan Fighter"):setCallSign("CV8"):setPosition(77092, -145267):orderDefendTarget(stationnamori)
    CpuShip():setFaction("Namorites"):setTemplate("Ktlitan Fighter"):setCallSign("CSS9"):setPosition(81481, -148285):orderDefendTarget(stationnamori)
    CpuShip():setFaction("Namorites"):setTemplate("Ktlitan Fighter"):setCallSign("CCN10"):setPosition(86420, -138957):orderDefendTarget(stationnamori)
    CpuShip():setFaction("Namorites"):setTemplate("Ktlitan Fighter"):setCallSign("UTI11"):setPosition(64746, -145267):orderDefendTarget(stationnamori)
    CpuShip():setFaction("Namorites"):setTemplate("Ktlitan Queen"):setCallSign("CCN12"):setPosition(74623, -154595):orderDefendTarget(stationnamori):setWeaponStorage("EMP", 3)
    CpuShip():setFaction("Namorites"):setTemplate("Ktlitan Scout"):setCallSign("VK13"):setPosition(70508, -132922):orderDefendTarget(stationnamori)
    CpuShip():setFaction("Namorites"):setTemplate("Ktlitan Scout"):setCallSign("UTI14"):setPosition(46365, -147188):orderDefendTarget(stationnamori)
    CpuShip():setFaction("Namorites"):setTemplate("Ktlitan Drone"):setCallSign("CV15"):setPosition(65844, -151852):orderDefendTarget(stationnamori)
    CpuShip():setFaction("Namorites"):setTemplate("Ktlitan Drone"):setCallSign("BR16"):setPosition(93553, -151577):orderDefendTarget(stationnamori)
    CpuShip():setFaction("Namorites"):setTemplate("Ktlitan Drone"):setCallSign("BR17"):setPosition(94101, -140055):orderDefendTarget(stationnamori)
    CpuShip():setFaction("Namorites"):setTemplate("Ktlitan Drone"):setCallSign("CSS18"):setPosition(76269, -136214):orderDefendTarget(stationnamori)

    -- defend namorite hideout
  	Mine():setPosition(55693, -155418)
    Mine():setPosition(55693, -143073)
    Mine():setPosition(73800, -139506)
    Mine():setPosition(82853, -129630)
    Mine():setPosition(103704, -143073)
    Mine():setPosition(90261, -157613)
    Mine():setPosition(75720, -173525)
    Mine():setPosition(66667, -161728)

    -- hideout nebula
    Nebula():setPosition(48560, -156241)
    Nebula():setPosition(60631, -169136)
    Nebula():setPosition(102606, -167764)
    Nebula():setPosition(106173, -150206)
    Nebula():setPosition(97394, -129904)
    Nebula():setPosition(75994, -121674)
    Nebula():setPosition(50206, -134842)
    Nebula():setPosition(83676, -165295)
    Nebula():setPosition(62826, -136214)

	-- set faction comm
	arianne_comm = SpaceStation():setCallSign("Le Postier")
	merillon_comm = SpaceStation():setCallSign("Marquis Asimov")
	vindh_comm = SpaceStation():setCallSign("Camarade Zimine")


	-- send player first comm 
	arianne_comm:sendCommsMessage(ToisondOr, [[Ouais bien c’est bien beau faire la fête, mais nos stations sont attaquées. Fait que ce serait le temps de retourner dans vos vaisseaux puis de repartir, non? Dépêchez-vous, on ne peut pas se permettre de perdre une mine potentielle aussi riche en mercassium. Bottez-vous le cul et travaillez, pour une fois.]])
	arianne_comm:sendCommsMessage(CigogneIV, [[Ouais bien c’est bien beau faire la fête, mais nos stations sont attaquées. Fait que ce serait le temps de retourner dans vos vaisseaux puis de repartir, non? Dépêchez-vous, on ne peut pas se permettre de perdre une mine potentielle aussi riche en mercassium. Bottez-vous le cul et travaillez, pour une fois.]])
	arianne_comm:sendCommsMessage(GuerrillaRadio, [[Ouais bien c’est bien beau faire la fête, mais nos stations sont attaquées. Fait que ce serait le temps de retourner dans vos vaisseaux puis de repartir, non? Dépêchez-vous, on ne peut pas se permettre de perdre une mine potentielle aussi riche en mercassium. Bottez-vous le cul et travaillez, pour une fois.]])
	
	merillon_comm:sendCommsMessage(Excommunicateur, [[Capitaine, nous avons reçu des nouvelles de notre nouvel avant-poste. Il aurait détecté des créatures non identifiées sur la bordure, qui seraient en chemin vers notre station. Rendez-vous sur place et tentez de comprendre ce qu’ils sont. S’il le faut, n’hésitez pas à utiliser les armes.]])
	merillon_comm:sendCommsMessage(NexusVoid, [[Capitaine, nous avons reçu des nouvelles de notre nouvel avant-poste. Il aurait détecté des créatures non identifiées sur la bordure, qui seraient en chemin vers notre station. Rendez-vous sur place et tentez de comprendre ce qu’ils sont. S’il le faut, n’hésitez pas à utiliser les armes.]])
	
	vindh_comm:sendCommsMessage(DIVX, [[Camarade, nos stations sont attaquées par des créatures inconnues. Il est vital de défendre ce point si nous souhaitons en savoir plus sur eux. Rendez-vous rapidement sur place et combattez les, il n’est plus le temps de flâner.]])
	vindh_comm:sendCommsMessage(Korosheg, [[Camarade, nos stations sont attaquées par des créatures inconnues. Il est vital de défendre ce point si nous souhaitons en savoir plus sur eux. Rendez-vous rapidement sur place et combattez les, il n’est plus le temps de flâner.]])
end




function update(delta)
	enemy_count = 0
	friendly_count = 0
	vindhteam_count = 0 
	arianneteam_count = 0
	merillonteam_count = 0 

	-- Count all surviving enemies and allies.
	for _, enemy in ipairs(enemyList) do
		if enemy:isValid() then
			enemy_count = enemy_count + 1
		end
	end

	for _, friendly in ipairs(friendlyList) do
		if friendly:isValid() then
			friendly_count = friendly_count + 1
		end
	end

	-- If not playing the Empty variation, declare victory for the
	-- Humans (players) once all enemies are destroyed. Note that players can win
	-- even if they destroy the enemies by blowing themselves up.
	--
	-- In the Empty variation, the GM must use the Win button to declare
	-- a Human victory.

	-- If all allies are destroyed, the Humans (players) lose.
	if friendly_count == 0 then
		victory("Namorites");
	else
		-- As the battle continues, award reputation based on
		-- the players' progress and number of surviving allies.
		for _, friendly in ipairs(friendlyList) do
			if friendly:isValid() then
				friendly:addReputationPoints(delta * friendly_count * 0.1)
			end
		end
	end

	
	for _, vindhteam in ipairs(vindhteamList) do
		if vindhteam:isValid() then
			vindhteam_count = vindhteam_count + 1
		end
	end

	for _, arianneteam in ipairs(arianneteamList) do
		if arianneteam:isValid() then
			arianneteam_count = arianneteam_count + 1
		end
	end

	for _, merillonteam in ipairs(merillonteamList) do
		if merillonteam:isValid() then
			merillonteam_count = merillonteam_count + 1
		end
	end


	for _, vindhteam in ipairs(vindhteamList) do
		if vindhteam:isValid() then
			vindhteam:addReputationPoints(delta * vindhteam_count * 0.02)
		end
	end

	for _, arianneteam in ipairs(arianneteamList) do
		if arianneteam:isValid() then
			arianneteam:addReputationPoints(delta * arianneteam_count * 0.02)
		end
	end

	for _, merillonteam in ipairs(merillonteamList) do
		if merillonteam:isValid() then
			merillonteam:addReputationPoints(delta * merillonteam_count * 0.02)
		end
	end
end

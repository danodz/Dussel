	-- Name: Dussel 1
	-- Description: Scénario 1 pour le beta de Dussel-3
	-- Variation[Vindh]: Scénario unique pour le Vindh
	-- Variation[Merillon]: Scénario unique pour les Merillons
	-- Variation[Arianne]: Scénario unique pour Arianne
	
	-- Notes :
	-- appelle les factions
	-- require("dussel/factioninfo_dussel.lua")
	
	-- appelle carte dussel
	require("dussel/map_dussel.lua")
	
	-- appelle vaisseaux joueurs dussel
	require("dussel/playership_dussel.lua")
	



	-- Appeller les cartes basé sur les variations de scénarios :
	if getScenarioVariation() == "Vindh" then
		Script():run("dussel/map_vindh1.lua")
	elseif getScenarioVariation() == "Merillon" then
		Script():run("dussel/map_baron1.lua")
	elseif getScenarioVariation() == "Arianne" then
		Script():run("dussel/map_arianne1.lua")
	else
		Script():run("dussel/map_arianne1.lua")
		Script():run("dussel/map_baron1.lua")
		Script():run("dussel/map_vindh1.lua")
	end
	

	dussel_3 = SpaceStation():setTemplate("Huge Station"):setFaction("Dussel"):setCallSign("D-3"):setPosition(-30012, -30015):setCommsFunction(commsDussel3)

-- fonction scenario empty	
	
function init()
	
	addGMFunction ("Respawn playership", function()
	
			--CpuShip():setTemplate('Fighter'):setFaction("Vindh"):setPosition(531000, -38700):setCallSign("Korog3")
			--PlayerSpaceship():setFaction("Vindh"):setTemplate("Artheurge"):setCallSign("KoroG3")setPosition(531000, -38500)
			
			if not Korosheg:isValid() then 
				Korosheg = New PlayerSpaceship():setFaction("Vindh"):setTemplate("Artheurge"):setTypeName("Camarade DIVX"):setCallSign("Korog2"):setPosition(531000, -38600)
			end
		
			if not DIVX:isValid() then
				DIVX = New PlayerSpaceship():setFaction("Vindh"):setTemplate("Artheurge"):setTypeName("Camarade DIVX"):setCallSign("DIVX2"):setPosition(532600, -38600)
			end
		
			if not ToisondOr:isValid() then
				ToisondOr = New PlayerSpaceship()PlayerSpaceship():setFaction("Arianne"):setTemplate("Marchand"):setCallSign("LTO2"):setTypeName("LaToisondOr"):setPosition(-357000, 5000)
			end
			
			if not CigogneIV:isValid() then	
				CigogneIV = New PlayerSpaceship():setFaction("Arianne"):setTemplate("Marchand"):setCallSign("CigIV"):setTypeName("CigogneIV"):setPosition(-357000, 10000)
			end
			
			if not GuerrillaRadio:isValid() then	
				GuerrillaRadio = New PlayerSpaceship():setFaction("Arianne"):setTemplate("Camelot"):setTypeName("GuerrillaRadio"):setCallSign("TGR"):setPosition(-357000, 15000)
			end
			
			if not Excommunicateur:isValid() then
				Excommunicateur = New PlayerSpaceship():setFaction("Merillon"):setTemplate("Celesien"):setCallSign("FEE"):setTypeName("Excommunicateur"):setCallSign("FEE")setPosition(-26000, 550000)
			end
			
			if not NexusVoid:isValid() then
				NexusVoid = New PlayerSpaceship():setFaction("Merillon"):setTemplate("Celesien"):setCallSign("NV"):setTypeName("NexusVoid"):setCallSign("NV"):setPosition(-32700, 550000)
			end
	end)
end


function commsDussel3()
	if comms_source:isDocked(comms_target) then
		setCommsMessage("Bienvenue, visiteurs, à la station de défense Dussel-3.Vous êtes actuellement sur le territoire des Duchés de Dussel. Les lois de la fédération y sont appliquées comme partout ailleurs, et nous espérons que vous passerez un bon moment. Nous sommes heureux que vous ayez choisi Dussel-3 pour votre séjour sur la bordure.\n Cette station fut construite en l’an 4128, et représentait alors la fine pointe de la technologie humaine. Elle fut rénovée régulièrement, et nous sommes particulièrement fiers de vous recevoir en ces lieux. \n Vous y trouverez toutes les commodités essentielles à votre confort, ainsi que les équipements nécessaires à la réparation et à l’amélioration de vos vaisseaux. Les employés de la station se feront un plaisir de mettre à votre disposition tous les bienfaits de la vie moderne.Vous trouverez à l’intérieur un comptoir où vous attendent des rafraîchissements en tous genre. N’hésitez pas à goûter à nos cocktails, qui font la réputation de notre beau coin de pays.\n Passez un bon séjour parmis nous. Car votre plaisir est notre bonheur.")
		addCommsReply("Entrez dans la station - Fin du jeu")
	end
end

-- Name: Dussel 2
-- Description: Scenario 2 pour le beta de Dussel-3



-- Init is run when the scenario is started. Create your initial world
function init()
	-- appelle carte dussel
	require("dussel/map_dussel.lua")
	-- appelle vaisseaux joueurs dussel
	require("dussel/playership_dussel.lua")

	vindhteamList = {}
	arianneteamList = {}
	merillonteamList = {}
	
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

	vindhteamList[1]:addReputationPoints(100.0)
	arianneteamList[1]:addReputationPoints(100.0)
	merillonteamList[1]:addReputationPoints(100.0)


	-- set faction comm
	arianne_comm = SpaceStation():setCallSign("Le Postier")
	merillon_comm = SpaceStation():setCallSign("Marquis Asimov")
	vindh_comm = SpaceStation():setCallSign("Camarade Zimine")
	

	dussel_3 = SpaceStation():setTemplate("Huge Station"):setFaction("Dussel"):setCallSign("D-3"):setPosition(-30012, -30015)

	-- create faction stations
	mstation_A4 = SpaceStation():setTemplate("Medium Station"):setFaction("Epave"):setCallSign("DS-A4"):setPosition(-17505, -92912):setScanned(true):setCommsFunction(stationComms)
    mstation_C6 = SpaceStation():setTemplate("Medium Station"):setFaction("Epave"):setCallSign("DS-C6"):setPosition(36639, -55983):setScanned(true):setCommsFunction(stationComms)
    mstation_E7 = SpaceStation():setTemplate("Medium Station"):setFaction("Epave"):setCallSign("DS-E7"):setPosition(46110, -10221):setScanned(true):setCommsFunction(stationComms)
	
	-- create scavenging stations
	
    SpaceStation():setTemplate("Small Station"):setFaction("Epave"):setCallSign("DS01"):setPosition(10612, -76123):setCommsFunction(commsStationLoot)
    SpaceStation():setTemplate("Small Station"):setFaction("Epave"):setCallSign("DS02"):setPosition(37364, -33386):setCommsFunction(commsStationLoot)
	SpaceStation():setTemplate("Small Station"):setFaction("Epave"):setCallSign("DS03"):setPosition(70970, -7267):setCommsFunction(commsStationLoot)
    SpaceStation():setTemplate("Small Station"):setFaction("Epave"):setCallSign("DS04"):setPosition(-42805, -86606):setCommsFunction(commsStationLoot)
    SpaceStation():setTemplate("Small Station"):setFaction("Epave"):setCallSign("DS05"):setPosition(43325, -64885):setCommsFunction(commsStationLoot)
	
	-- create ship for scavenging
	-- small transport
    T1 = CpuShip():setFaction("Charognards"):setTemplate("Garbage Freighter 1"):setCallSign("VK103"):setPosition(-29410, -77486):orderRoaming()
    T2 = CpuShip():setFaction("Charognards"):setTemplate("Garbage Freighter 1"):setCallSign("SS104"):setPosition(240, -70725):orderRoaming()
    T3 = CpuShip():setFaction("Charognards"):setTemplate("Garbage Freighter 1"):setCallSign("BR105"):setPosition(22847, -45865):orderRoaming()
    
	-- medium transport
	T5 = CpuShip():setFaction("Charognards"):setTemplate("Equipment Freighter 3"):setCallSign("UTI107"):setPosition(-18836, -56621):orderRoaming()
    T6 = CpuShip():setFaction("Charognards"):setTemplate("Equipment Freighter 3"):setCallSign("SS108"):setPosition(-39240, -67121):orderRoaming()
    T7 = CpuShip():setFaction("Charognards"):setTemplate("Equipment Freighter 3"):setCallSign("SS109"):setPosition(16524, -11356):orderRoaming()
   
	-- farther transport for special loot
	T8 = CpuShip():setFaction("Charognards"):setTemplate("Fuel Freighter 1"):setCallSign("CV110"):setPosition(-82740, -28296):orderRoaming()
    T9 = CpuShip():setFaction("Charognards"):setTemplate("Fuel Freighter 5"):setCallSign("NC111"):setPosition(-15632, 20680):orderRoaming()
    T10 = CpuShip():setFaction("Charognards"):setTemplate("Fuel Freighter 5"):setCallSign("CSS112"):setPosition(71606, -110273):orderRoaming()
	

    -- ennemy ships 

    CpuShip():setFaction("Charognards"):setTemplate("Adder MK5"):setCallSign("NC17"):setPosition(-84269, -27958):orderDefendTarget(T8):setWeaponStorage("HVLI", 1)
    CpuShip():setFaction("Charognards"):setTemplate("Adder MK5"):setCallSign("S18"):setPosition(-83726, -29798):orderDefendTarget(T8):setWeaponStorage("HVLI", 1)
    CpuShip():setFaction("Charognards"):setTemplate("Adder MK5"):setCallSign("CSS19"):setPosition(-81206, -27972):orderDefendTarget(T8):setWeaponStorage("HVLI", 1)
    CpuShip():setFaction("Charognards"):setTemplate("Adder MK5"):setCallSign("CCN20"):setPosition(-17134, 20706):orderDefendTarget(T9):setWeaponStorage("HVLI", 1)
    CpuShip():setFaction("Charognards"):setTemplate("Adder MK5"):setCallSign("VK21"):setPosition(-15661, 19685):orderDefendTarget(T9):setWeaponStorage("HVLI", 1)
    CpuShip():setFaction("Charognards"):setTemplate("Adder MK5"):setCallSign("BR22"):setPosition(-13989, 21513):orderDefendTarget(T9):setWeaponStorage("HVLI", 1)
    CpuShip():setFaction("Charognards"):setTemplate("Adder MK5"):setCallSign("CV23"):setPosition(15770, -11906):orderIdle():setWeaponStorage("HVLI", 1)
    CpuShip():setFaction("Charognards"):setTemplate("Adder MK5"):setCallSign("SS24"):setPosition(17368, -10602):orderIdle():setWeaponStorage("HVLI", 1)
    CpuShip():setFaction("Charognards"):setTemplate("Adder MK5"):setCallSign("SS26"):setPosition(21925, -46267):orderIdle():setWeaponStorage("HVLI", 1)
    CpuShip():setFaction("Charognards"):setTemplate("Adder MK5"):setCallSign("VK27"):setPosition(24074, -45134):orderIdle():setWeaponStorage("HVLI", 1)
    CpuShip():setFaction("Charognards"):setTemplate("Adder MK5"):setCallSign("CV28"):setPosition(-19528, -56800):orderIdle():setWeaponStorage("HVLI", 1)
    CpuShip():setFaction("Charognards"):setTemplate("Adder MK5"):setCallSign("SS29"):setPosition(-18189, -56328):orderIdle():setWeaponStorage("HVLI", 1)
    CpuShip():setFaction("Charognards"):setTemplate("Adder MK5"):setCallSign("BR30"):setPosition(-40111, -67909):orderIdle():setWeaponStorage("HVLI", 1)
    CpuShip():setFaction("Charognards"):setTemplate("Adder MK5"):setCallSign("VK31"):setPosition(-38546, -66456):orderIdle():setWeaponStorage("HVLI", 1)
    CpuShip():setFaction("Charognards"):setTemplate("Adder MK5"):setCallSign("S32"):setPosition(-29462, -78264):orderIdle():setWeaponStorage("HVLI", 1)
    CpuShip():setFaction("Charognards"):setTemplate("Adder MK5"):setCallSign("BR33"):setPosition(-29425, -76281):orderIdle():setWeaponStorage("HVLI", 1)
    CpuShip():setFaction("Charognards"):setTemplate("Adder MK5"):setCallSign("VS34"):setPosition(-49, -71353):orderIdle():setWeaponStorage("HVLI", 1)
    CpuShip():setFaction("Charognards"):setTemplate("Adder MK5"):setCallSign("VK35"):setPosition(588, -69640):orderIdle():setWeaponStorage("HVLI", 1)
    CpuShip():setFaction("Charognards"):setTemplate("Adder MK5"):setCallSign("VS36"):setPosition(70965, -109866):orderIdle():setWeaponStorage("HVLI", 1)
    CpuShip():setFaction("Charognards"):setTemplate("Adder MK5"):setCallSign("CV37"):setPosition(71017, -110734):orderIdle():setWeaponStorage("HVLI", 1)
    CpuShip():setFaction("Charognards"):setTemplate("Adder MK5"):setCallSign("S38"):setPosition(73067, -110171):orderIdle():setWeaponStorage("HVLI", 1)


    CpuShip():setFaction("Charognards"):setTemplate("Phobos T3"):setCallSign("CCN39"):setPosition(-43314, -86988):orderDefendLocation(-43024, -86878):setWeaponStorage("Homing", 2)
    CpuShip():setFaction("Charognards"):setTemplate("Phobos T3"):setCallSign("VS40"):setPosition(-17535, -93639):orderDefendLocation(-17557, -93944):setWeaponStorage("Homing", 2)
    CpuShip():setFaction("Charognards"):setTemplate("Phobos T3"):setCallSign("NC41"):setPosition(10897, -76302):orderDefendLocation(10986, -76274):setWeaponStorage("Homing", 2)
    CpuShip():setFaction("Charognards"):setTemplate("Phobos T3"):setCallSign("BR42"):setPosition(37319, -55983):orderDefendLocation(37283, -56241):setWeaponStorage("Homing", 2)
    CpuShip():setFaction("Charognards"):setTemplate("Phobos T3"):setCallSign("NC43"):setPosition(43845, -65272):orderDefendLocation(43666, -65519):setWeaponStorage("Homing", 2)
    CpuShip():setFaction("Charognards"):setTemplate("Phobos T3"):setCallSign("VK44"):setPosition(37098, -33632):orderDefendLocation(37342, -33548):setWeaponStorage("Homing", 2)
    CpuShip():setFaction("Charognards"):setTemplate("Phobos T3"):setCallSign("CV45"):setPosition(46793, -9855):orderDefendLocation(46912, -10136):setWeaponStorage("Homing", 2)
    CpuShip():setFaction("Charognards"):setTemplate("Phobos T3"):setCallSign("UTI46"):setPosition(71500, -6817):orderDefendLocation(71480, -7122):setWeaponStorage("Homing", 2)
    CpuShip():setFaction("Charognards"):setTemplate("MT52 Hornet"):setCallSign("CSS47"):setPosition(-44042, -86325):orderDefendLocation(-43369, -86267)
    CpuShip():setFaction("Charognards"):setTemplate("MT52 Hornet"):setCallSign("VK48"):setPosition(-42237, -87651):orderDefendLocation(-42506, -87355)
    CpuShip():setFaction("Charognards"):setTemplate("MT52 Hornet"):setCallSign("CSS49"):setPosition(-42116, -85485):orderDefendLocation(-42128, -86161)
    CpuShip():setFaction("Charognards"):setTemplate("MT52 Hornet"):setCallSign("VK50"):setPosition(-43431, -87080):orderDefendLocation(-43739, -87336)
    CpuShip():setFaction("Charognards"):setTemplate("MT52 Hornet"):setCallSign("UTI51"):setPosition(10177, -76473):orderDefendLocation(9959, -76168)
    CpuShip():setFaction("Charognards"):setTemplate("MT52 Hornet"):setCallSign("VK52"):setPosition(10029, -76305):orderDefendLocation(10338, -76882)
    CpuShip():setFaction("Charognards"):setTemplate("MT52 Hornet"):setCallSign("NC53"):setPosition(10481, -75518):orderDefendLocation(10851, -75365)
    CpuShip():setFaction("Charognards"):setTemplate("MT52 Hornet"):setCallSign("BR54"):setPosition(42685, -65087):orderDefendLocation(42588, -64699)
    CpuShip():setFaction("Charognards"):setTemplate("MT52 Hornet"):setCallSign("VK55"):setPosition(43624, -64876):orderDefendLocation(43860, -64784)
    CpuShip():setFaction("Charognards"):setTemplate("MT52 Hornet"):setCallSign("SS56"):setPosition(42859, -63735):orderDefendLocation(43394, -64148)
    CpuShip():setFaction("Charognards"):setTemplate("MT52 Hornet"):setCallSign("NC57"):setPosition(69655, -6977):orderDefendLocation(70193, -7385)
    CpuShip():setFaction("Charognards"):setTemplate("MT52 Hornet"):setCallSign("SS58"):setPosition(70049, -7892):orderDefendLocation(70660, -8179)
    CpuShip():setFaction("Charognards"):setTemplate("MT52 Hornet"):setCallSign("BR59"):setPosition(70696, -5865):orderDefendLocation(71034, -6450)
    CpuShip():setFaction("Charognards"):setTemplate("MT52 Hornet"):setCallSign("CV60"):setPosition(47552, -8103):orderDefendLocation(47269, -8717)
    CpuShip():setFaction("Charognards"):setTemplate("MT52 Hornet"):setCallSign("CV61"):setPosition(44403, -11331):orderDefendLocation(45057, -11162)
    CpuShip():setFaction("Charognards"):setTemplate("MT52 Hornet"):setCallSign("SS62"):setPosition(35001, -56159):orderDefendLocation(34463, -56567)
    CpuShip():setFaction("Charognards"):setTemplate("MT52 Hornet"):setCallSign("CCN63"):setPosition(37423, -54323):orderDefendLocation(37024, -54355)
    CpuShip():setFaction("Charognards"):setTemplate("MT52 Hornet"):setCallSign("SS64"):setPosition(-18695, -92610):orderDefendLocation(-19092, -92659)
    CpuShip():setFaction("Charognards"):setTemplate("MT52 Hornet"):setCallSign("CV65"):setPosition(-16623, -92491):orderDefendLocation(-15949, -92542)
    CpuShip():setFaction("Charognards"):setTemplate("Starhammer II"):setCallSign("SS66"):setPosition(-17674, -91309):orderDefendLocation(-17672, -91531):setWeaponStorage("Homing", 3):setWeaponStorage("EMP", 1)
    CpuShip():setFaction("Charognards"):setTemplate("Starhammer II"):setCallSign("CSS67"):setPosition(36768, -57464):orderDefendLocation(36784, -57244):setWeaponStorage("Homing", 3):setWeaponStorage("EMP", 1)
    CpuShip():setFaction("Charognards"):setTemplate("Starhammer II"):setCallSign("SS68"):setPosition(45027, -8920):orderDefendLocation(44947, -9128):setWeaponStorage("Homing", 3):setWeaponStorage("EMP", 1)
    CpuShip():setFaction("Charognards"):setTemplate("MU52 Hornet"):setCallSign("CV69"):setPosition(36466, -32520):orderDefendLocation(36938, -33026)
    CpuShip():setFaction("Charognards"):setTemplate("MU52 Hornet"):setCallSign("VK70"):setPosition(37356, -34356):orderDefendLocation(37210, -34007)




	-- send player first comm 
	
	arianne_comm:sendCommsMessage(ToisondOr, [[Alors, c’est bien Dussel? C’est pas trop le trou de cul du monde? J’espère qu’ils vous ont servi à boire ou quelque chose, avec tout ce Mercassium que vous leur avez apporté. 

On a continué de chercher pour la mine. J’ai rien trouvé, mais on a quelque chose qui pourrait être pertinent pour nos recherches. Quelque part dans les cadran C6 ou A4 , il y aurait une station minière abandonnée depuis quelques temps. C’est probablement infesté de charognards, mais vous devriez aller y faire un tour. Si jamais on pouvait la remettre sur pied, on pourrait trouver des informations sur les dépôts miniers du coin, voire pouvoir utiliser la station pour en tirer un petit profit. Si la fédé peut nous laisser tranquille, on pourrait faire un beau magot.

Donc ouais, aller voir ça, mais faites attention.]])
	arianne_comm:sendCommsMessage(CigogneIV, [[Alors, c’est bien Dussel? C’est pas trop le trou de cul du monde? J’espère qu’ils vous ont servi à boire ou quelque chose, avec tout ce Mercassium que vous leur avez apporté. 

On a continué de chercher pour la mine. J’ai rien trouvé, mais on a quelque chose qui pourrait être pertinent pour nos recherches. Quelque part dans les cadran C6 ou E7, il y aurait une station minière abandonnée depuis quelques temps. C’est probablement infesté de charognards, mais vous devriez aller y faire un tour. Si jamais on pouvait la remettre sur pied, on pourrait trouver des informations sur les dépôts miniers du coin, voire pouvoir utiliser la station pour en tirer un petit profit. Si la fédé peut nous laisser tranquille, on pourrait faire un beau magot.

Donc ouais, aller voir ça, mais faites attention.]])
	arianne_comm:sendCommsMessage(GuerrillaRadio, [[Alors, c’est bien Dussel? C’est pas trop le trou de cul du monde? J’espère qu’ils vous ont servi à boire ou quelque chose, avec tout ce Mercassium que vous leur avez apporté. 

On a continué de chercher pour la mine. J’ai rien trouvé, mais on a quelque chose qui pourrait être pertinent pour nos recherches. Quelque part dans le cadran A4 ou E7, il y aurait une station minière abandonnée depuis quelques temps. C’est probablement infesté de charognards, mais vous devriez aller y faire un tour. Si jamais on pouvait la remettre sur pied, on pourrait trouver des informations sur les dépôts miniers du coin, voire pouvoir utiliser la station pour en tirer un petit profit. Si la fédé peut nous laisser tranquille, on pourrait faire un beau magot.

Donc ouais, aller voir ça, mais faites attention.]])
	

	merillon_comm:sendCommsMessage(Excommunicateur, [[Capitaine? Nous sommes contents de vous revoir parmis nous. Cette station semble étrange. Ils ne sont pas affiliés aux Barons, ni aux autres factions habituellement présentes dans la région. Il semblerait que les Ducs de Dussels ne soient plus en communication avec nous, ni avec la fédération en général, depuis très longtemps. Méfiez-vous d’eux, ils cachent sans aucun doute quelque chose.

Nous souhaitons établir une station relais dans le coin, afin de garder un oeil sur ces Ducs de Dussel. Nous avons repéré une station abandonnée dans les environs du cadran A4. Rendez-vous y et nettoyez le tout. Il y aura probablement des pillards dans le coin, faites attention.

Bonne chance, Capitaine.]])
	merillon_comm:sendCommsMessage(NexusVoid, [[Capitaine? Nous sommes contents de vous revoir parmis nous. Cette station semble étrange. Ils ne sont pas affiliés aux Barons, ni aux autres factions habituellement présentes dans la région. Il semblerait que les Ducs de Dussels ne soient plus en communication avec nous, ni avec la fédération en général, depuis très longtemps. Méfiez-vous d’eux, ils cachent sans aucun doute quelque chose.

Nous souhaitons établir une station relais dans le coin, afin de garder un oeil sur ces Ducs de Dussel. Nous avons repéré une station abandonnée dans les environs du cadran A4 ou C6. Rendez-vous y et nettoyez le tout. Il y aura probablement des pillards dans le coin, faites attention.

Bonne chance, Capitaine.]])
	

	vindh_comm:sendCommsMessage(DIVX, [[Rebonjour Camarade. J’espère que les gens de Dussel-3 ne vous ont pas trop malmené. Même s’ils étaient hospitaliers, je vous conseille de vous méfier d’eux, nous ne savons pas exactement ce qu’il en retourne, et nous avons perdu toute communication avec eux depuis un certain temps. Mais passons.

Nous avons identifié une station qui pourrait nous servir d’avant-poste, non loin de la station de Dussel-3. Vous pouvez vous rendre aux coordonnées E7, et faire un peu de ménage. Il y aura potentiellement des charognards dans le coin, surtout avec des stations aussi sophistiquées. Vous ne devriez pas trop avoir de problème.]])
	vindh_comm:sendCommsMessage(Korosheg, [[Rebonjour Camarade. J’espère que les gens de Dussel-3 ne vous ont pas trop malmené. Même s’ils étaient hospitaliers, je vous conseille de vous méfier d’eux, nous ne savons pas exactement ce qu’il en retourne, et nous avons perdu toute communication avec eux depuis un certain temps. Mais passons.

Nous avons identifié une station qui pourrait nous servir d’avant-poste, non loin de la station de Dussel-3. Vous pouvez vous rendre aux coordonnées E7 ou C6, et faire un peu de ménage. Il y aura potentiellement des charognards dans le coin, surtout avec des stations aussi sophistiquées. Vous ne devriez pas trop avoir de problème.]])
	
	
	-- Envoyer un message de fin à tous 
	addGMFunction("SOS Dussel", function()
		globalMessage("URGENT Retournez à Dussel-3");
	end)

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
end


function stationComms()	
		if not comms_source:isDocked(comms_target) then
				if comms_source:isEnemy(comms_target) then
					setCommsMessage("La station semble récemment remise en marche.\n Approchez-vous pour en savoir plus")
				else if not comms_source:isFriendly(comms_target) then
					setCommsMessage("Aucun signal de la sation\nCelle-ci semble abandonnée depuis un moment.\n Approchez-vous pour en savoir plus")
				else 
					setCommsMessage("Une voix électronique vous interpelle.\n Bonjour Capitaine,\n amarrez-vous pour vous recharger.")
				end
			end
		
		else		
			if comms_source:isEnemy(comms_target) then
				setCommsMessage("La station vient d'être capturée au nom d'une autre faction que la votre.")
			else if not comms_source:isFriendly(comms_target) then
				setCommsMessage("La station semble avor été abandonnée. \n Elle est encore en bon état et pourrait être récupérée pour en faire un poste avancé")

				addCommsReply("Capturer la station au nom de l'empire du Vindh (50 reputation)", function()
					if not comms_source:takeReputationPoints(50) then setCommsMessage("Pas assez de reputation."); return end
					setCommsMessage("C'est un plaisir camarade")
					table.insert (vindhteamList, comms_target:setFaction("Vindh"))
				end)

				addCommsReply("Capturer la station pour la Sainte-Alliance (50 reputation)", function()
					if not comms_source:takeReputationPoints(50) then setCommsMessage("Pas assez de reputation."); return end
					setCommsMessage("Que le céleste vous garde Capitaine")
					table.insert (merillonteamList, comms_target:setFaction("Merillon"))
				end)

				addCommsReply("Capturer la station  au nom du Conglomerat d'Arianne (50 reputation)", function()
					if not comms_source:takeReputationPoints(50) then setCommsMessage("Pas assez de reputation."); return end
					setCommsMessage("Génial un autre poste avancé !")
					table.insert (arianneteamList, comms_target:setFaction("Arianne"))
				end)
			else 
				setCommsMessage("Une voix électronique vous interpelle.\n Bonjour Capitaine,\n Comment puis-je vous aider aujourd'hui?")
				addCommsReply("Nous avons besoin de munitions.", supplyDialogue)

				addCommsReply("Inspecter la station", function()
					if comms_target:getCallSign("DS-A4") then
						setCommsMessage("Vous débarquez dans la station qui semble entièrement abandonnée. Rien ne semble anormal au premiers abords, bien que vous remarquez le passage des charognards, qui ont pris plusieurs modules importants de la station. Un seul détail vous marque particulièrement : Les nacelles de survie sont toutes intactes, et à l’intérieur vous retrouvez plusieurs cadavres, probablement des membres d’équipage.\n En fouillant dans les cartes des archives vous remarquez la présence de stations aux secteurs A2, B5 et E8. \n(Butin : Code CRD-TK48)  ")			
					elseif comms_target:getCallSign("DS-C6") then
						setCommsMessage("En entrant dans la station, une fois vos combinaisons enlevées, une forte odeur vous assaille. Vous reconnaissez rapidement le très caractéristique Uracier brut, matière que l’on peut retrouver dans certaines ceintures d’astéroïdes sur la bordure. Après avoir fait le tour de la station, vous arrivez à remettre en marche les équipements principaux. Vous remarquez néanmoins que de nombreux modules sont absents, probablement pillés par les charognards que vous avez rencontré à votre arrivée. \n En fouillant dans les cartes des archives vous remarquez la présence de stations aux secteurs B7, D6 et E8. \n (Butin : Code MOD-UR45)")
					elseif comms_target:getCallSign("DS-E7") then
						setCommsMessage("En entrant dans la station, elle vous semble étrangement calme, voire sereine. Tout est propre, bien rangé, et aucun des pillards que vous avez rencontrés à l’arrivée ne semble avoir réussi à pénétrer à l’intérieur. Vous réussissez à repartir l’électricité et une douce musique se dégage. \n En fouillant dans les cartes des archives vous remarquez la présence de stations aux secteurs A2, B7 et D6. \n (Butin: Code CRD-78RY)")
					end
				end)
			end
		end
	end
end

function commsStationLoot()
	if not comms_source:isDocked(comms_target) then
		setCommsMessage("Aucun signal de la sation\nCelle-ci semble abandonnée depuis un moment.\n Approchez-vous pour en savoir plus")
	else
		setCommsMessage("Après avoir inspecté brièvement les lieux, vous remarquez que la station semble avoir étée abandonnée sans heurts ni bataille")		
	end

	if  comms_source:isDocked(comms_target) then
		addCommsReply("Récolter tout ce qui est récupérable. (10 réputation)", function()
			if not comms_source:takeReputationPoints(10) then setCommsMessage("Pas assez de reputation."); return end
				if comms_target:getCallSign("DS01") then
					setCommsMessage("Vous avez récupéré les pièces en meilleur état qui pourront être vendus pour quelques crédits.\n Dans le journal de bord, vous notez le passage de convois venant de F4, D0, E5 \n Notez le Code CRD-X8E4. \n \n Il n'y a plus rien pour vous ici.")			
				elseif comms_target:getCallSign("DS02") then
					setCommsMessage("Vous avez récupéré les pièces en meilleur état qui pourront être vendus pour quelques crédits.\n Dans le journal de bord, vous notez le passage de convois venant de C6, B5, C4 \n Notez le Code CRD-X9E4. \n \n Il n'y a plus rien pour vous ici.")
				elseif comms_target:getCallSign("DS03") then 
					setCommsMessage("Vous avez récupéré les pièces en meilleur état qui pourront être vendus pour quelques crédits.\n Dans le journal de bord, vous notez le passage de convois venant de B3, ZZ8, D0 \n Notez le Code CRD-1874. \n \n Il n'y a plus rien pour vous ici.")
				elseif comms_target:getCallSign("DS04") then
					setCommsMessage("Vous avez récupéré les pièces en meilleur état qui pourront être vendus pour quelques crédits.\n Dans le journal de bord, vous notez le passage de convois venant de D0, ZZ8, B5 \n Notez le Code CRD-0000. \n \n Il n'y a plus rien pour vous ici.")
				elseif comms_target:getCallSign("DS05") then
					setCommsMessage("Vous avez récupéré les pièces en meilleur état qui pourront être vendus pour quelques crédits.\n Dans le journal de bord, vous notez le passage de convois venant de F4, B3, C4 \n Notez le Code CRD-LP9J. \n \n Il n'y a plus rien pour vous ici.")
				end 
		addCommsReply("Capturer cette station", stationComms)
		end)
	end
end

function supplyDialogue()
	setCommsMessage("Que désirez-vous?")
		addCommsReply("Do you have spare homing missiles for us? (2rep each)", function()
			if not comms_source:isDocked(comms_target) then setCommsMessage("Vous devez être amarré pour cette action."); return end
			if not comms_source:takeReputationPoints(2 * (comms_source:getWeaponStorageMax("Homing") - comms_source:getWeaponStorage("Homing"))) then setCommsMessage("Pas assez de reputation."); return end
			if comms_source:getWeaponStorage("Homing") >= comms_source:getWeaponStorageMax("Homing") then
				setCommsMessage("Sorry sir, but you are fully stocked with homing missiles.");
				addCommsReply("Retour", supplyDialogue)
			else
				comms_source:setWeaponStorage("Homing", comms_source:getWeaponStorageMax("Homing"))
				setCommsMessage("Filled up your missile supply.")
				addCommsReply("Retour", supplyDialogue)
			end
		end)
		addCommsReply("Please re-stock our mines. (2rep each)", function()
			if not comms_source:isDocked(comms_target) then setCommsMessage("Vous devez être amarré pour cette action."); return end
			if not comms_source:takeReputationPoints(2 * (comms_source:getWeaponStorageMax("Mine") - comms_source:getWeaponStorage("Mine"))) then setCommsMessage("Pas assez de reputation."); return end
			if comms_source:getWeaponStorage("Mine") >= comms_source:getWeaponStorageMax("Mine") then
				setCommsMessage("Captain,\nYou have all the mines you can fit in that ship.");
				addCommsReply("Retour", supplyDialogue)
			else
				comms_source:setWeaponStorage("Mine", comms_source:getWeaponStorageMax("Mine"))
				setCommsMessage("These mines, are yours.")
				addCommsReply("Retour", supplyDialogue)
			end
		end)
		addCommsReply("Can you supply us with some nukes? (15rep each)", function()
			if not comms_source:isDocked(comms_target) then setCommsMessage("Vous devez être amarré pour cette action."); return end
			if not comms_source:takeReputationPoints(15 * (comms_source:getWeaponStorageMax("Nuke") - comms_source:getWeaponStorage("Nuke"))) then setCommsMessage("Pas assez de reputation."); return end
			if comms_source:getWeaponStorage("Nuke") >= comms_source:getWeaponStorageMax("Nuke") then
				setCommsMessage("All nukes are charged and primed for destruction.");
				addCommsReply("Retour", supplyDialogue)
			else
				comms_source:setWeaponStorage("Nuke", comms_source:getWeaponStorageMax("Nuke"))
				setCommsMessage("You are fully loaded,\nand ready to explode things.")
				addCommsReply("Retour", supplyDialogue)
			end
		end)
		addCommsReply("Please re-stock our EMP Missiles. (10rep each)", function()
			if not comms_source:isDocked(comms_target) then setCommsMessage("Vous devez être amarré pour cette action."); return end
			if not comms_source:takeReputationPoints(10 * (comms_source:getWeaponStorageMax("EMP") - comms_source:getWeaponStorage("EMP"))) then setCommsMessage("Pas assez de reputation."); return end
			if comms_source:getWeaponStorage("EMP") >= comms_source:getWeaponStorageMax("EMP") then
				setCommsMessage("All storage for EMP missiles is filled, sir.");
				addCommsReply("Retour", supplyDialogue)
			else
				comms_source:setWeaponStorage("EMP", comms_source:getWeaponStorageMax("EMP"))
				setCommsMessage("Recallibrated the electronics and fitted you with all the EMP missiles you can carry.")
				addCommsReply("Retour", supplyDialogue)
			end
		end)
end


function update(delta)
	
	
	if T1:isValid() then
		if T1:getHull() <= 20 then 
			DropState = 1
			local x, y = T1:getPosition()
				
				if DropState == 1 then
				SupplyDrop():setFaction("Vindh"):setPosition(x + random(-300, 300), y + random(-300, 300)):setEnergy(500):setWeaponStorage("Nuke", 1):setWeaponStorage("Homing", 4):setWeaponStorage("Mine", 2):setWeaponStorage("EMP", 1)
				DropState = 2 
				end
				
				if DropState == 2 then
				SupplyDrop():setFaction("Arianne"):setPosition(x + random(-400, 300), y + random(-400, 300)):setEnergy(500):setWeaponStorage("Nuke", 1):setWeaponStorage("Homing", 4):setWeaponStorage("Mine", 2):setWeaponStorage("EMP", 1)
				DropState = 3
				end
				
				if DropState == 3 then
				SupplyDrop():setFaction("Merillon"):setPosition(x + random(-500, 300), y + random(-500, 300)):setEnergy(500):setWeaponStorage("Nuke", 1):setWeaponStorage("Homing", 4):setWeaponStorage("Mine", 2):setWeaponStorage("EMP", 1)
				DropState = 4
				end

				if DropState == 4 then 
				T1:destroy()	
				DropState = 5
				end
		end 	
	end

	if T2:isValid() then
		if T2:getHull() <= 20 then 
			DropState = 1
			local x, y = T2:getPosition()
				
				if DropState == 1 then
				SupplyDrop():setFaction("Vindh"):setPosition(x + random(-300, 300), y + random(-300, 300)):setEnergy(500):setWeaponStorage("Nuke", 1):setWeaponStorage("Homing", 4):setWeaponStorage("Mine", 2):setWeaponStorage("EMP", 1)
				DropState = 2 
				end
				
				if DropState == 2 then
				SupplyDrop():setFaction("Arianne"):setPosition(x + random(-400, 300), y + random(-400, 300)):setEnergy(500):setWeaponStorage("Nuke", 1):setWeaponStorage("Homing", 4):setWeaponStorage("Mine", 2):setWeaponStorage("EMP", 1)
				DropState = 3
				end
				
				if DropState == 3 then
				SupplyDrop():setFaction("Merillon"):setPosition(x + random(-500, 300), y + random(-500, 300)):setEnergy(500):setWeaponStorage("Nuke", 1):setWeaponStorage("Homing", 4):setWeaponStorage("Mine", 2):setWeaponStorage("EMP", 1)
				DropState = 4
				end

				if DropState == 4 then 
				T2:destroy()	
				DropState = 5
				end
		end 	
	end

	if T3:isValid() then
		if T3:getHull() <= 20 then 
			DropState = 1
			local x, y = T3:getPosition()
				
				if DropState == 1 then
				SupplyDrop():setFaction("Vindh"):setPosition(x + random(-300, 300), y + random(-300, 300)):setEnergy(500):setWeaponStorage("Nuke", 1):setWeaponStorage("Homing", 4):setWeaponStorage("Mine", 2):setWeaponStorage("EMP", 1)
				DropState = 2 
				end
				
				if DropState == 2 then
				SupplyDrop():setFaction("Arianne"):setPosition(x + random(-400, 300), y + random(-400, 300)):setEnergy(500):setWeaponStorage("Nuke", 1):setWeaponStorage("Homing", 4):setWeaponStorage("Mine", 2):setWeaponStorage("EMP", 1)
				DropState = 3
				end
				
				if DropState == 3 then
				SupplyDrop():setFaction("Merillon"):setPosition(x + random(-500, 300), y + random(-500, 300)):setEnergy(500):setWeaponStorage("Nuke", 1):setWeaponStorage("Homing", 4):setWeaponStorage("Mine", 2):setWeaponStorage("EMP", 1)
				DropState = 4
				end

				if DropState == 4 then 
				T3:destroy()	
				DropState = 5
				end
		end 	
	end

	if T5:isValid() then
		if T5:getHull() <= 20 then 
			DropState = 1
			local x, y = T5:getPosition()
				
				if DropState == 1 then
				SupplyDrop():setFaction("Vindh"):setPosition(x + random(-300, 300), y + random(-300, 300)):setEnergy(500):setWeaponStorage("Nuke", 1):setWeaponStorage("Homing", 4):setWeaponStorage("Mine", 2):setWeaponStorage("EMP", 1)
				DropState = 2 
				end
				
				if DropState == 2 then
				SupplyDrop():setFaction("Arianne"):setPosition(x + random(-400, 300), y + random(-400, 300)):setEnergy(500):setWeaponStorage("Nuke", 1):setWeaponStorage("Homing", 4):setWeaponStorage("Mine", 2):setWeaponStorage("EMP", 1)
				DropState = 3
				end
				
				if DropState == 3 then
				SupplyDrop():setFaction("Merillon"):setPosition(x + random(-500, 300), y + random(-500, 300)):setEnergy(500):setWeaponStorage("Nuke", 1):setWeaponStorage("Homing", 4):setWeaponStorage("Mine", 2):setWeaponStorage("EMP", 1)
				DropState = 4
				end

				if DropState == 4 then 
				T5:destroy()	
				DropState = 5
				end
		end 	
	end

	if T6:isValid() then
		if T6:getHull() <= 20 then 
			DropState = 1
			local x, y = T6:getPosition()
				
				if DropState == 1 then
				SupplyDrop():setFaction("Vindh"):setPosition(x + random(-300, 300), y + random(-300, 300)):setEnergy(500):setWeaponStorage("Nuke", 1):setWeaponStorage("Homing", 4):setWeaponStorage("Mine", 2):setWeaponStorage("EMP", 1)
				DropState = 2 
				end
				
				if DropState == 2 then
				SupplyDrop():setFaction("Arianne"):setPosition(x + random(-400, 300), y + random(-400, 300)):setEnergy(500):setWeaponStorage("Nuke", 1):setWeaponStorage("Homing", 4):setWeaponStorage("Mine", 2):setWeaponStorage("EMP", 1)
				DropState = 3
				end
				
				if DropState == 3 then
				SupplyDrop():setFaction("Merillon"):setPosition(x + random(-500, 300), y + random(-500, 300)):setEnergy(500):setWeaponStorage("Nuke", 1):setWeaponStorage("Homing", 4):setWeaponStorage("Mine", 2):setWeaponStorage("EMP", 1)
				DropState = 4
				end

				if DropState == 4 then 
				T6:destroy()	
				DropState = 5
				end
		end 	
	end

	if T7:isValid() then
		if T7:getHull() <= 20 then 
			DropState = 1
			local x, y = T7:getPosition()
				
				if DropState == 1 then
				SupplyDrop():setFaction("Vindh"):setPosition(x + random(-300, 300), y + random(-300, 300)):setEnergy(500):setWeaponStorage("Nuke", 1):setWeaponStorage("Homing", 4):setWeaponStorage("Mine", 2):setWeaponStorage("EMP", 1)
				DropState = 2 
				end
				
				if DropState == 2 then
				SupplyDrop():setFaction("Arianne"):setPosition(x + random(-400, 300), y + random(-400, 300)):setEnergy(500):setWeaponStorage("Nuke", 1):setWeaponStorage("Homing", 4):setWeaponStorage("Mine", 2):setWeaponStorage("EMP", 1)
				DropState = 3
				end
				
				if DropState == 3 then
				SupplyDrop():setFaction("Merillon"):setPosition(x + random(-500, 300), y + random(-500, 300)):setEnergy(500):setWeaponStorage("Nuke", 1):setWeaponStorage("Homing", 4):setWeaponStorage("Mine", 2):setWeaponStorage("EMP", 1)
				DropState = 4
				end

				if DropState == 4 then 
				T7:destroy()	
				DropState = 5
				end
		end 	
	end

	if T8:isValid() then
		if T8:getHull() <= 20 then 
			DropState = 1
			local x, y = T8:getPosition()
				
				if DropState == 1 then
				SupplyDrop():setFaction("Vindh"):setPosition(x + random(-300, 300), y + random(-300, 300)):setEnergy(500):setWeaponStorage("Nuke", 1):setWeaponStorage("Homing", 4):setWeaponStorage("Mine", 2):setWeaponStorage("EMP", 1)
				DropState = 2 
				end
				
				if DropState == 2 then
				SupplyDrop():setFaction("Arianne"):setPosition(x + random(-400, 300), y + random(-400, 300)):setEnergy(500):setWeaponStorage("Nuke", 1):setWeaponStorage("Homing", 4):setWeaponStorage("Mine", 2):setWeaponStorage("EMP", 1)
				DropState = 3
				end
				
				if DropState == 3 then
				SupplyDrop():setFaction("Merillon"):setPosition(x + random(-500, 300), y + random(-500, 300)):setEnergy(500):setWeaponStorage("Nuke", 1):setWeaponStorage("Homing", 4):setWeaponStorage("Mine", 2):setWeaponStorage("EMP", 1)
				DropState = 4
				end

				if DropState == 4 then 
				T8:destroy()	
				DropState = 5
				end
		end 	
	end

	if T9:isValid() then
		if T9:getHull() <= 20 then 
			DropState = 1
			local x, y = T9:getPosition()
				
				if DropState == 1 then
				SupplyDrop():setFaction("Vindh"):setPosition(x + random(-300, 300), y + random(-300, 300)):setEnergy(500):setWeaponStorage("Nuke", 1):setWeaponStorage("Homing", 4):setWeaponStorage("Mine", 2):setWeaponStorage("EMP", 1)
				DropState = 2 
				end
				
				if DropState == 2 then
				SupplyDrop():setFaction("Arianne"):setPosition(x + random(-400, 300), y + random(-400, 300)):setEnergy(500):setWeaponStorage("Nuke", 1):setWeaponStorage("Homing", 4):setWeaponStorage("Mine", 2):setWeaponStorage("EMP", 1)
				DropState = 3
				end
				
				if DropState == 3 then
				SupplyDrop():setFaction("Merillon"):setPosition(x + random(-500, 300), y + random(-500, 300)):setEnergy(500):setWeaponStorage("Nuke", 1):setWeaponStorage("Homing", 4):setWeaponStorage("Mine", 2):setWeaponStorage("EMP", 1)
				DropState = 4
				end

				if DropState == 4 then 
				T9:destroy()	
				DropState = 5
				end
		end 	
	end

	if T10:isValid() then
		if T10:getHull() <= 20 then 
			DropState = 1
			local x, y = T10:getPosition()
				
				if DropState == 1 then
				SupplyDrop():setFaction("Vindh"):setPosition(x + random(-300, 300), y + random(-300, 300)):setEnergy(500):setWeaponStorage("Nuke", 1):setWeaponStorage("Homing", 4):setWeaponStorage("Mine", 2):setWeaponStorage("EMP", 1)
				DropState = 2 
				end
				
				if DropState == 2 then
				SupplyDrop():setFaction("Arianne"):setPosition(x + random(-400, 300), y + random(-400, 300)):setEnergy(500):setWeaponStorage("Nuke", 1):setWeaponStorage("Homing", 4):setWeaponStorage("Mine", 2):setWeaponStorage("EMP", 1)
				DropState = 3
				end
				
				if DropState == 3 then
				SupplyDrop():setFaction("Merillon"):setPosition(x + random(-500, 300), y + random(-500, 300)):setEnergy(500):setWeaponStorage("Nuke", 1):setWeaponStorage("Homing", 4):setWeaponStorage("Mine", 2):setWeaponStorage("EMP", 1)
				DropState = 4
				end

				if DropState == 4 then 
				T10:destroy()	
				DropState = 5
				end
		end 	
	end



	vindhteam_count = 0 
	arianneteam_count = 0
	merillonteam_count = 0 

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
			vindhteam:addReputationPoints(delta * vindhteam_count * 0.05)
		end
	end

	for _, arianneteam in ipairs(arianneteamList) do
		if arianneteam:isValid() then
			arianneteam:addReputationPoints(delta * arianneteam_count * 0.05)
		end
	end

	for _, merillonteam in ipairs(merillonteamList) do
		if merillonteam:isValid() then
			merillonteam:addReputationPoints(delta * merillonteam_count * 0.05)
		end
	end
end




-- ajouter gain passif de réputation
-- Player:addReputationPoints(delta * 1)

-- sstation_D6 = SpaceStation():setTemplate("Small Station"):setFaction("Epave"):setCallSign("DS16203"):setPosition(37364, -33386):setCommsFunction(stationCommsD6)
-- sstation_E8 = SpaceStation():setTemplate("Small Station"):setFaction("Epave"):setCallSign("DS16204"):setPosition(70970, -7267):setCommsFunction(stationCommsE8)
-- sstation_A2 = SpaceStation():setTemplate("Small Station"):setFaction("Epave"):setCallSign("DS16205"):setPosition(-42805, -86606):setCommsFunction(stationCommsA2)
-- sstation_B7 = SpaceStation():setTemplate("Small Station"):setFaction("Epave"):setCallSign("DS16208"):setPosition(43325, -64885):setCommsFunction(stationCommsB7)






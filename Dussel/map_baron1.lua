-- name : carte baron1



function init()
	

	  merillonteamList = {}

	-- Create player locations
		table.insert(merillonteamList, Excommunicateur:setPosition(-26000, 550000))
		table.insert(merillonteamList, NexusVoid:setPosition(-32700, 550000))

	-- Create mission state
		Merillon_mission = 0
		Merillon_comms = 0
		Excommunicateur_comms = 0
		NexusVoid_comms = 0 

	    merillonteamList[1]:addReputationPoints(300.0)

	-- Éléments de mission
		Frontier_A3 = SpaceStation():setTemplate("Medium Station"):setFaction("Merillon"):setCallSign("Marquis Asimov.Frontier A3"):setPosition(-29069, 549204)
		transport_MT3 = CpuShip():setFaction("Merillon"):setTemplate("Goods Freighter 3"):setCallSign("MT_3"):setPosition(73957, 526542):orderFlyTowards(-29069, 549204)		
	-- create wormhole to Dussel-3
		WormHole():setPosition(-9581, 370251):setTargetPosition(-23922, 21921)

	-- create merillon stations
		
		-- merillon first station
		CpuShip():setFaction("Merillon"):setTemplate("Adder MK6"):setCallSign("UTI4"):setPosition(-35883, 548888):orderDefendLocation(-35883, 548888):setWeaponStorage("HVLI", 7)
	    CpuShip():setFaction("Merillon"):setTemplate("Adder MK6"):setCallSign("SS5"):setPosition(-29192, 554752):orderDefendLocation(-29192, 554752):setWeaponStorage("HVLI", 7)
	    CpuShip():setFaction("Merillon"):setTemplate("Adder MK6"):setCallSign("CCN6"):setPosition(-21900, 549640):orderDefendLocation(-21900, 549640):setWeaponStorage("HVLI", 7)
	    
		-- merillon raided transport ships, heading to station in A3
	    CpuShip():setFaction("Merillon"):setTemplate("Goods Freighter 3"):setCallSign("MT_1"):setPosition(57594, 528336):orderFlyTowards(-29069, 549204)
	    CpuShip():setFaction("Merillon"):setTemplate("Goods Freighter 3"):setCallSign("MT_2"):setPosition(49659, 529945):orderFlyTowards(-29069, 549204)
	    CpuShip():setFaction("Merillon"):setTemplate("Goods Freighter 3"):setCallSign("MT_4"):setPosition(65624, 527515):orderFlyTowards(-29069, 549204)
		
	--Start off the mission by sending a transmission to the merillon faction
	        	
		-- merillon second station
			SpaceStation():setTemplate("Medium Station"):setFaction("Merillon"):setCallSign("Frontier-A13"):setPosition(170766, 549774)
			CpuShip():setFaction("Merillon"):setTemplate("Adder MK4"):setCallSign("BR37"):setPosition(164257, 550302):orderDefendLocation(164257, 550302):setWeaponStorage("HVLI", 1)
			CpuShip():setFaction("Merillon"):setTemplate("Adder MK4"):setCallSign("CCN38"):setPosition(169534, 544849):orderDefendLocation(169534, 544849):setWeaponStorage("HVLI", 1)
			CpuShip():setFaction("Merillon"):setTemplate("Adder MK4"):setCallSign("VK39"):setPosition(176570, 550830):orderDefendLocation(176570, 550830):setWeaponStorage("HVLI", 1)	
			
			-- asteroid field
				Asteroid():setPosition(169476, 557271)
				Asteroid():setPosition(177369, 546277)
				Asteroid():setPosition(160361, 545431)
				Asteroid():setPosition(176618, 556990)
				Asteroid():setPosition(169100, 565165)
				Asteroid():setPosition(179155, 567232)
				Asteroid():setPosition(174738, 570051)
				Asteroid():setPosition(181974, 573246)
				Asteroid():setPosition(179813, 575501)
				Asteroid():setPosition(172107, 578602)
				Asteroid():setPosition(170886, 579636)
				Asteroid():setPosition(182068, 585932)
				Asteroid():setPosition(187518, 588751)
				Asteroid():setPosition(178967, 595140)
				Asteroid():setPosition(185826, 597114)
				Asteroid():setPosition(187424, 598241)
				Asteroid():setPosition(174456, 562440)
				Asteroid():setPosition(173141, 552573)
				Asteroid():setPosition(164496, 535001)
			
		-- merillon back station

			SpaceStation():setTemplate("Large Station"):setFaction("Merillon"):setCallSign("DS214"):setPosition(-29059, 657778)
			CpuShip():setFaction("Merillon"):setTemplate("Adv. Striker"):setCallSign("VS35"):setPosition(-35391, 657074):orderDefendLocation(-29059, 657778)
			CpuShip():setFaction("Merillon"):setTemplate("Adv. Striker"):setCallSign("VK36"):setPosition(-23078, 655140):orderDefendLocation(-29059, 657778)
			
		
		-- baron advanced station
			
			Bar_sation = SpaceStation():setTemplate("Small Station"):setFaction("Barons"):setCallSign("DS164"):setPosition(25308, 469066)
			
			Bar_1 = CpuShip():setFaction("Barons"):setTemplate("Adv. Striker"):setCallSign("VK7"):setPosition(90618, 506206):orderRoaming()
			


			Bar_1 = CpuShip():setFaction("Barons"):setTemplate("Adder MK4"):setCallSign("VK14"):setPosition(86554, 512139):orderRoaming():setWeaponStorage("HVLI", 1)
			Bar_1 = CpuShip():setFaction("Barons"):setTemplate("Adder MK4"):setCallSign("NC15"):setPosition(89370, 509214):orderRoaming():setWeaponStorage("HVLI", 1)
			Bar_1 = CpuShip():setFaction("Barons"):setTemplate("Adder MK4"):setCallSign("VK16"):setPosition(92728, 511489):orderRoaming():setWeaponStorage("HVLI", 1)
			Bar_1 = CpuShip():setFaction("Barons"):setTemplate("Adder MK4"):setCallSign("NC17"):setPosition(97386, 509214):orderRoaming():setWeaponStorage("HVLI", 1)
			Bar_1 = CpuShip():setFaction("Barons"):setTemplate("Adder MK4"):setCallSign("VS12"):setPosition(84388, 507589):orderRoaming():setWeaponStorage("HVLI", 1)
			Bar_1 = CpuShip():setFaction("Barons"):setTemplate("Adder MK4"):setCallSign("S13"):setPosition(80380, 509647):orderRoaming():setWeaponStorage("HVLI", 1)


			CpuShip():setFaction("Barons"):setTemplate("MU52 Hornet"):setCallSign("VS30"):setPosition(17293, 462812):orderRoaming()
			CpuShip():setFaction("Barons"):setTemplate("MU52 Hornet"):setCallSign("CSS31"):setPosition(23479, 459270):orderRoaming()
			CpuShip():setFaction("Barons"):setTemplate("MU52 Hornet"):setCallSign("BR32"):setPosition(34475, 468627):orderRoaming()
			CpuShip():setFaction("Spectre"):setTemplate("Tug"):setCallSign("VK33"):setPosition(85160, 498826):orderFlyTowards(-28920, 398605)
			CpuShip():setFaction("Barons"):setTemplate("Piranha F8"):setCallSign("VS18"):setPosition(23006, 469189):orderDefendLocation(23006, 469189):setWeaponStorage("Homing", 4):setWeaponStorage("HVLI", 8)
			CpuShip():setFaction("Barons"):setTemplate("Adv. Gunship"):setCallSign("VS21"):setPosition(25271, 467288):orderDefendLocation(25271, 467288):setWeaponStorage("Homing", 2)
			CpuShip():setFaction("Barons"):setTemplate("Adder MK4"):setCallSign("UTI22"):setPosition(17250, 469054):orderDefendLocation(17250, 469054):setWeaponStorage("HVLI", 1)
			CpuShip():setFaction("Barons"):setTemplate("Adder MK4"):setCallSign("UTI23"):setPosition(23560, 463835):orderDefendLocation(23560, 463835):setWeaponStorage("HVLI", 1)
			CpuShip():setFaction("Barons"):setTemplate("MU52 Hornet"):setCallSign("VS28"):setPosition(25917, 471163):orderDefendLocation(25917, 471163)
			CpuShip():setFaction("Barons"):setTemplate("MU52 Hornet"):setCallSign("UTI29"):setPosition(21764, 472431):orderDefendLocation(21764, 472431)
			CpuShip():setFaction("Barons"):setTemplate("Defense platform"):setCallSign("CCN34"):setPosition(-25567, 369964):orderDefendLocation(-25567, 369964)
			
			
			-- asteroid protection	
				Asteroid():setPosition(24952, 468769)
				Asteroid():setPosition(24812, 469312)
				Asteroid():setPosition(23392, 466350)
				Asteroid():setPosition(19622, 465736)
				Asteroid():setPosition(21007, 462791)
				Asteroid():setPosition(13556, 462808)
				Asteroid():setPosition(12644, 466016)
				Asteroid():setPosition(12346, 470943)
				Asteroid():setPosition(16186, 466963)
				Asteroid():setPosition(16782, 472293)
				Asteroid():setPosition(24725, 475391)
				Asteroid():setPosition(31563, 473142)
				Asteroid():setPosition(26327, 472557)
				Asteroid():setPosition(38340, 467382)
				Asteroid():setPosition(31348, 468522)
				Asteroid():setPosition(28052, 467875)
				Asteroid():setPosition(29068, 465165)
				Asteroid():setPosition(26173, 464795)
				Asteroid():setPosition(27682, 462947)
				Asteroid():setPosition(21152, 468491)
				Asteroid():setPosition(19951, 470370)
				Asteroid():setPosition(27959, 469785)
				Asteroid():setPosition(28606, 471387)
				Asteroid():setPosition(30855, 469477)
				Asteroid():setPosition(29438, 466951)
	    

	-- nebulae nest baron ships + warp jammers

	CpuShip():setFaction("Barons"):setTemplate("Atlantis X23"):setCallSign("CV41"):setPosition(-8821, 359232):orderRoaming():setWeaponStorage("Homing", 0)
	CpuShip():setFaction("Barons"):setTemplate("Adder MK4"):setCallSign("SS43"):setPosition(-4124, 393632):orderRoaming():setWeaponStorage("HVLI", 1)
	CpuShip():setFaction("Barons"):setTemplate("Adder MK5"):setCallSign("VK44"):setPosition(-38397, 401883):orderDefendLocation(-38397, 401883):setWeaponStorage("HVLI", 3)
	CpuShip():setFaction("Barons"):setTemplate("Adder MK5"):setCallSign("CSS45"):setPosition(-4276, 388647):orderRoaming():setWeaponStorage("HVLI", 3)
	Bar_2 = CpuShip():setFaction("Barons"):setTemplate("Atlantis X23"):setCallSign("Vallonier"):setPosition(-6773, 379492):orderDefendLocation(-6773, 379492):setWeaponStorage("Homing", 4):setWeaponStorage("HVLI", 3)
	CpuShip():setFaction("Barons"):setTemplate("Adder MK4"):setCallSign("BR47"):setPosition(-29489, 369927):orderRoaming():setWeaponStorage("HVLI", 1)
	CpuShip():setFaction("Barons"):setTemplate("Adder MK4"):setCallSign("CCN48"):setPosition(-27201, 366663):orderRoaming():setWeaponStorage("HVLI", 1)
	CpuShip():setFaction("Barons"):setTemplate("Adder MK4"):setCallSign("NC49"):setPosition(-20824, 368276):orderRoaming():setWeaponStorage("HVLI", 1)
	CpuShip():setFaction("Barons"):setTemplate("Adder MK4"):setCallSign("UTI50"):setPosition(-21500, 371089):orderRoaming():setWeaponStorage("HVLI", 1)
	CpuShip():setFaction("Barons"):setTemplate("Adder MK4"):setCallSign("S51"):setPosition(-24388, 372852):orderRoaming():setWeaponStorage("HVLI", 1)
	CpuShip():setFaction("Barons"):setTemplate("Blockade Runner"):setCallSign("BR53"):setPosition(-15501, 413931):orderDefendLocation(-15501, 413931)

	WarpJammer():setFaction("Barons"):setPosition(-26682, 368866)
	WarpJammer():setFaction("Barons"):setPosition(-5781, 392768) 	
		
		
	-- create nebulae nest
		Nebula():setPosition(10661, 425539)
	    Nebula():setPosition(23422, 429664)
	    Nebula():setPosition(31284, 445906)
	    Nebula():setPosition(-10577, 380328)
	    Nebula():setPosition(11070, 380893)
	    Nebula():setPosition(-23357, 341308)
	    Nebula():setPosition(-6128, 356983)
	    Nebula():setPosition(-24706, 401750)
	    Nebula():setPosition(-19074, 421637)
	    Nebula():setPosition(-50666, 374180)
	    Nebula():setPosition(-53376, 359699)
	    Nebula():setPosition(-52670, 345172)
	    Nebula():setPosition(-24735, 378789)
	    Nebula():setPosition(-16723, 352117)
	    Nebula():setPosition(-30021, 413773)
	    Nebula():setPosition(-37958, 340802)
	    Nebula():setPosition(-49360, 384733)
	    Nebula():setPosition(36444, 411597)
	    Nebula():setPosition(-68297, 386549)
	    Nebula():setPosition(6456, 355642)
	    Nebula():setPosition(-3302, 377512)
	    Nebula():setPosition(-400, 374051)
	    Nebula():setPosition(-2747, 403674)
	    Nebula():setPosition(-36494, 362378)
	    Nebula():setPosition(-48728, 351774)
	    Nebula():setPosition(37217, 366888)
	    Nebula():setPosition(-57501, 342441)
	    Nebula():setPosition(-38329, 420979)
	    Nebula():setPosition(-27558, 417667)
	    Nebula():setPosition(-53275, 419342)
	    Nebula():setPosition(-5727, 397227)
	    Nebula():setPosition(-19234, 326736)
	    Nebula():setPosition(-35370, 342870)
	    Nebula():setPosition(4184, 346239)
	    Nebula():setPosition(-47164, 348926)
	    Nebula():setPosition(-18787, 405961)
	    Nebula():setPosition(-13572, 324193)
	    Nebula():setPosition(-51180, 396005)
	    Nebula():setPosition(-49497, 325891)
	    Nebula():setPosition(-30893, 390904)
	    Nebula():setPosition(32959, 398203)
	    Nebula():setPosition(-74705, 360327)
	    Nebula():setPosition(15575, 395914)
	    Nebula():setPosition(-8103, 400223)
	    Nebula():setPosition(10874, 393650)
	    Nebula():setPosition(-58271, 345718)
	    Nebula():setPosition(-2865, 344119)
	    Nebula():setPosition(7463, 336882)
	    Nebula():setPosition(-33435, 336487)
	    Nebula():setPosition(6658, 354685)
	    Nebula():setPosition(-49837, 409128)
	    Nebula():setPosition(10085, 390497)
	    Nebula():setPosition(-51342, 365656)
	    Nebula():setPosition(5940, 418188)
	    Nebula():setPosition(55842, 377323)
	    Nebula():setPosition(-76575, 374966)
	    Nebula():setPosition(-105258, 400899)
	    Nebula():setPosition(-82469, 416223)
	    Nebula():setPosition(83543, 337245)
	    
		-- mine frontier line
		Mine():setPosition(-37871, 341371)
	    Mine():setPosition(-5343, 398657)
	    Mine():setPosition(-38854, 391469)
	    Mine():setPosition(3975, 390093)
	    Mine():setPosition(-14885, 399327)
	    Mine():setPosition(-25887, 378502)
	    Mine():setPosition(-51231, 363571)
	    Mine():setPosition(-25691, 355516)
	    Mine():setPosition(-41211, 373787)
	    Mine():setPosition(7905, 365732)
	    Mine():setPosition(28730, 374180)
	    Mine():setPosition(30105, 393041)
	    Mine():setPosition(18317, 406989)
	    Mine():setPosition(-20285, 379163)
	    Mine():setPosition(-19157, 379374)
	    Mine():setPosition(-18125, 379622)
	    Mine():setPosition(-17017, 379813)
	    Mine():setPosition(-15718, 380004)
	    Mine():setPosition(211, 362024)
	    Mine():setPosition(-928, 363630)
	    Mine():setPosition(937, 364822)
	    Mine():setPosition(-618, 366428)
	    Mine():setPosition(1222, 367490)
	    Mine():setPosition(-151, 369174)
	    Mine():setPosition(-1550, 360521)
	    Mine():setPosition(-79757, 499892)
	    Mine():setPosition(-69934, 499695)
	    Mine():setPosition(-59717, 499892)
	    Mine():setPosition(-48519, 499695)
	    Mine():setPosition(-39482, 499892)
	    Mine():setPosition(-27890, 499695)
	    Mine():setPosition(-19639, 499695)
	    Mine():setPosition(-9226, 499499)
	    Mine():setPosition(400, 499695)
	    Mine():setPosition(20243, 499499)
	    Mine():setPosition(39693, 499892)
	    Mine():setPosition(60518, 499302)
	    Mine():setPosition(79772, 499302)
	    Mine():setPosition(100204, 499695)
	    Mine():setPosition(119654, 499695)
	    Mine():setPosition(139890, 499892)
	    Mine():setPosition(90184, 499695)
	    Mine():setPosition(110617, 499892)
	    Mine():setPosition(130263, 499695)
	    Mine():setPosition(70342, 499695)
	    Mine():setPosition(49123, 499695)
	    Mine():setPosition(28888, 499892)
	    Mine():setPosition(10224, 499695)
	    Mine():setPosition(-90169, 499695)
	    Mine():setPosition(-99993, 499499)
	    Mine():setPosition(-109619, 499499)
	    Mine():setPosition(-120818, 499499)
	    Mine():setPosition(-130248, 499499)
	    Mine():setPosition(-140071, 499695)
	    Mine():setPosition(-149894, 499695)
	    Mine():setPosition(-160110, 499499)
	    Mine():setPosition(-169934, 499695)
	    Mine():setPosition(-179953, 500088)
	    Mine():setPosition(-189187, 500088)
	    Mine():setPosition(-200189, 499892)
	    Mine():setPosition(-220032, 499892)
	    Mine():setPosition(-210012, 500088)
	    Mine():setPosition(150302, 499892)
	    Mine():setPosition(159143, 499695)
	    Mine():setPosition(170538, 500088)
	    Mine():setPosition(180165, 499695)
	    Mine():setPosition(191952, 499892)
	    Mine():setPosition(199811, 499892)
	    Mine():setPosition(211599, 499892)
	    Mine():setPosition(219850, 499892)
	    Mine():setPosition(231442, 499695)
	    Mine():setPosition(240479, 499695)
	    Mine():setPosition(251874, 499695)
	    Mine():setPosition(260518, 499695)
	    Mine():setPosition(-230248, 499499)
	    Mine():setPosition(-239678, 500088)
	    Mine():setPosition(-27209, 401929)
	    Mine():setPosition(-26923, 389612)
	    Mine():setPosition(-10708, 380137)
	    Mine():setPosition(-3865, 377116)
	    Mine():setPosition(-5406, 357326)
	    Mine():setPosition(-16750, 353010)
end

function update(delta) 
    if Merillon_mission == 0 then
        if Merillon_comms == 0 then
        Frontier_A3:sendCommsMessage(Excommunicateur, [[Capitaine, heureux que vous soyez arrivés si vite.
Notre rôle sur la frontière n’est que d’observer et d’entretenur des liens diplomatiques avec les barons libres. Mais les dernières semaines ont été rudes, et les frictions à la frontière sont de plus en plus nombreuses. 
Des barons rebelles ont récemment fait l’affront de dépasser la frontière d’armistrice. Officiellement vous êtes ici tenter d'arriver à une entente avec les Barons... 
À  mon avis il vaudra mieux s'occuper de la source du problème, si vous voyez ce que je veux dire.
		
...
		
Capitaine, les troupes des barons attaquent à nouveau! Les gueux s'en prennent à nos convois. 
Nous avons reçu un message de détresse provenant d'en haut du secteur A8. Nous avons besoin que vous vous débarassiez de ces rebelles rapidement.]])

        Frontier_A3:sendCommsMessage(NexusVoid, [[ Capitaine, heureux que vous soyez arrivés si vite.
Notre rôle sur la frontière n’est que d’observer et d’entretenur des liens diplomatiques avec les barons libres. Mais les dernières semaines ont été rudes, et les frictions à la frontière sont de plus en plus nombreuses. 
Des barons rebelles ont récemment fait l’affront de dépasser la frontière d’armistrice. Officiellement vous êtes ici tenter d'arriver à une entente avec les Barons... 
À  mon avis il vaudra mieux s'occuper de la source du problème, si vous voyez ce que je veux dire.
		
...
		
Capitaine, les troupes des barons attaquent à nouveau! Les gueux s'en prennent à nos convois. 
Nous avons reçu un message de détresse provenant d'en haut du secteur A8]. Nous avons besoin que vous vous débarassiez de ces rebelles rapidement.]])

        Merillon_comms = 1
        Merillon_mission = 1
        end
    end

    if not Bar_1:isValid() then
        if Merillon_mission == 1 then
            if Merillon_comms == 1 then
                Frontier_A3:sendCommsMessage(Excommunicateur, [[Bien joué, Capitaine. Nous savions que nous pouvions vous faire confiance. 
Nous avons reçu des communications qui nous laissent croire que le Baron Friedrich Der Vaast serait à l’origine de l’attaque. Il dispose d’un avant-poste dans le cadran ]7. 
Allez lui rendre une petite visite et détruisez cet avant-poste. Nous ne pouvons pas laisser un tel affront à la Fédération impuni.]])
                
                Frontier_A3:sendCommsMessage(NexusVoid, [[Bien joué, Capitaine. Nous savions que nous pouvions vous faire confiance. 
Nous avons reçu des communications qui nous laissent croire que le Baron Friedrich Der Vaast serait à l’origine de l’attaque. Il dispose d’un avant-poste dans le cadran ]7. 
Allez lui rendre une petite visite et détruisez cet avant-poste. Nous ne pouvons pas laisser un tel affront à la Fédération impuni.]])

                Merillon_mission = 2
                Merillon_comms = 2
            end
        end
    end

    if not Bar_station:isValid() then
        if Merillon_mission == 2 then 
            if Merillon_comms == 2 then 
        
                    Frontier_A3:sendCommsMessage(Excommunicateur, [[ Capitaine, nous sommes fier de vous. Ces barons vont bien finir par apprendre à se tenir tranquille. 
Nous espérons ne pas avoir une nouvelle guerre sur nos bras, mais vos actions étaient nécessaires. 
Nous vous envoyons quelques crédits pour combler vos dépenses, ainsi qu’un petit supplément pour vos bons services rendus [butin : CRD-YULA]

…

Capitaine, une dernière chose. Il semblerait que le baron Der Vaast tente de s’enfuir à bord de son vaisseau, le Vallonier. 
Trouvez-le dans le secteur Y4 et détruisez son vaisseau. Si vous pouvez, essayez de capturer sa navette de sauvetage.]])
            
                    Frontier_A3:sendCommsMessage(NexusVoid, [[ Capitaine, nous sommes fier de vous. Ces barons vont bien finir par apprendre à se tenir tranquille. 
Nous espérons ne pas avoir une nouvelle guerre sur nos bras, mais vos actions étaient nécessaires. 
Nous vous envoyons quelques crédits pour combler vos dépenses, ainsi qu’un petit supplément pour vos bons services rendus [butin : CRD-YULA]

…

Capitaine, une dernière chose. Il semblerait que le baron Der Vaast tente de s’enfuir à bord de son vaisseau, le Vallonier. 
Trouvez-le dans le secteur Y4 et détruisez son vaisseau. Si vous pouvez, essayez de capturer sa navette de sauvetage.]])
                Merillon_comms = 3
            end
        end
    end

    if not Bar_2:isValid() then
        if Merillon_mission == 2 then 
            if Merillon_comms == 3 then 
                Frontier_A3:sendCommsMessage(Excommunicateur, [[ Une fois le vaisseau du baron Der Vaast détruit, vous le voyez tentant de fuir à bord d’une navette de sauvetage. L’un de vous le capture, lui et les quelques cargaisons qu’il transportait, ce qui vous donne un [butin : CRD-6754, et POD-DV12 à diviser avec l’autre vaisseau Mérillon]

Félicitations, Capitaine. Nous sommes fier de vous. Lors de votre arrivée à une prochaine station, vous pourrez envoyer le Baron vers la Fédération, et nous vous paierons une rançon. À vous de décider lequel d’entre vos deux navires pourra la gagner. 

Il y a probablement d’autres barons non loin. Il y a un trou de ver non loin. Empruntez-le et explorez les environs, avec un peu de chance nous tomberons sur des informations à leur propos.]])
            
                Frontier_A3:sendCommsMessage(NexusVoid, [[ Une fois le vaisseau du baron Der Vaast détruit, vous le voyez tentant de fuir à bord d’une navette de sauvetage. L’un de vous le capture, lui et les quelques cargaisons qu’il transportait, ce qui vous donne un [butin : CRD-6754, et POD-DV12 à diviser avec l’autre vaisseau Mérillon]

Félicitations, Capitaine. Nous sommes fier de vous. Lors de votre arrivée à une prochaine station, vous pourrez envoyer le Baron vers la Fédération, et nous vous paierons une rançon. À vous de décider lequel d’entre vos deux navires pourra la gagner. 

Il y a probablement d’autres barons non loin. Il y a un trou de ver non loin. Empruntez-le et explorez les environs, avec un peu de chance nous tomberons sur des informations à leur propos.]])

                Merillon_mission = 3
                Merillon_comms = 4
            end
        end
    end

    if (distance(Excommunicateur, dussel_3) < 100000) then
        if Excommunicateur_comms == 0 then 
                Frontier_A3:sendCommsMessage(Excommunicateur, [[ Capitaine, la Fédération sera fière de votre travail. 
Nous n’arrivons pas à retracer les informations sur le secteur où vous êtes, plusieurs de nos données semblent être effacées. 
Fouillez l’endroit. Si vous trouver une station, vous devriez y entrer et regarder un peu. Ne touchez à rien surtout, il ne faudrait pas nuir à nos relations avec les habitants potentiels du secteur.]])
            Excommunicateur_comms = 1
        end
    end

    if (distance(NexusVoid, dussel_3) < 100000) then
        if NexusVoid_comms == 0 then 
                Frontier_A3:sendCommsMessage(NexusVoid, [[ Capitaine, la Fédération sera fière de votre travail. 
Nous n’arrivons pas à retracer les informations sur le secteur où vous êtes, plusieurs de nos données semblent être effacées. 
Fouillez l’endroit. Si vous trouver une station, vous devriez y entrer et regarder un peu. Ne touchez à rien surtout, il ne faudrait pas nuir à nos relations avec les habitants potentiels du secteur.]])
            NexusVoid_comms = 1
        end
    end
end
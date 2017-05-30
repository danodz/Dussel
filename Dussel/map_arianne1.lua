-- name : carte arianne1


arianneteamList = {}
  

-- Create player locations
	table.insert(arianneteamList,ToisondOr:setPosition(-357000, 5000))	
	table.insert(arianneteamList,CigogneIV:setPosition(-357000, 10000))
	table.insert(arianneteamList,GuerrillaRadio:setPosition(-357000, 15000))

	
-- Create mission state
	Arianne_mission = 0
	Arianne_comms = 0
    ToisondOr_comms = 0 
    CigogneIV_comms = 0
    GuerrillaRadio_comms = 0 

    arianneteamList[1]:addReputationPoints(300.0)



function init()

    -- dussel_3 = SpaceStation():setTemplate("Huge Station"):setFaction("Dussel"):setCallSign("D-3"):setPosition(-30012, -30015)

    -- arianne station

        Station_SF87 = SpaceStation():setTemplate("Small Station"):setFaction("Arianne"):setCallSign("Le Postier.S-F87"):setPosition(-349578, 10662)
    	
    	CpuShip():setFaction("Arianne"):setTemplate("Adder MK4"):setCallSign("CV26"):setPosition(-352905, 10343):orderDefendLocation(-352902, 10347):setWeaponStorage("HVLI", 1)
        CpuShip():setFaction("Arianne"):setTemplate("Adder MK4"):setCallSign("UTI27"):setPosition(-349499, 12774):orderDefendLocation(-349504, 12775):setWeaponStorage("HVLI", 1)
        CpuShip():setFaction("Arianne"):setTemplate("Adder MK4"):setCallSign("VS28"):setPosition(-345720, 11087):orderDefendLocation(-345718, 11092):setWeaponStorage("HVLI", 1)  

    -- transport ships

    	Transport_AT3 = CpuShip():setFaction("Arianne"):setTemplate("Goods Freighter 3"):setCallSign("At_3"):setPosition(-304114, -13833):orderFlyTowards(-345959, 8431)
        CpuShip():setFaction("Arianne"):setTemplate("Goods Freighter 3"):setCallSign("AT_1"):setPosition(-311187, -13755):orderFlyTowards(-353032, 8509)
        Transport_AT2 = CpuShip():setFaction("Arianne"):setTemplate("Goods Freighter 3"):setCallSign("At_2"):setPosition(-307702, -10714):orderFlyTowards(-349546, 11549)
        CpuShip():setFaction("Arianne"):setTemplate("Goods Freighter 3"):setCallSign("At_4"):setPosition(-302607, -9313):orderFlyTowards(-344451, 12950)

    -- ennemy attacking transports

    	Ind_1 = CpuShip():setFaction("Independent"):setTemplate("MT52 Hornet"):setCallSign("S5"):setPosition(-320791, -16977):orderAttack(Transport_AT3)
        Ind_1 = CpuShip():setFaction("Independent"):setTemplate("MT52 Hornet"):setCallSign("NC6"):setPosition(-318983, -19341):orderAttack(Transport_AT3)
        Ind_1 = CpuShip():setFaction("Independent"):setTemplate("MT52 Hornet"):setCallSign("BR7"):setPosition(-322052, -18639):orderAttack(Transport_AT2)
        Ind_1 = CpuShip():setFaction("Independent"):setTemplate("Adder MK5"):setCallSign("SS8"):setPosition(-319401, -17815):orderAttack(Transport_AT2):setWeaponStorage("HVLI", 3)
        Ind_1 = CpuShip():setFaction("Independent"):setTemplate("Adv. Striker"):setCallSign("VK9"):setPosition(-321063, -19542):orderAttack(Transport_AT2)
    	
    -- ennemy station
    	Ind_station = SpaceStation():setTemplate("Medium Station"):setFaction("Independent"):setCallSign("P-58"):setPosition(-311445, -47114) 	
    	
    -- looter 
    	CpuShip():setFaction("Charognards"):setTemplate("Adder MK4"):setCallSign("CV24"):setPosition(-293900, -30640):orderStandGround():setWeaponStorage("Homing", 1)
    	CpuShip():setFaction("Charognards"):setTemplate("Adder MK4"):setCallSign("CV21"):setPosition(-293950, -30700):orderStandGround():setWeaponStorage("Homing", 1)

    -- Nebula frontier
    	Nebula():setPosition(-449621, -112691)
        Nebula():setPosition(-467689, -109235)
        Nebula():setPosition(-211412, -130931)
        Nebula():setPosition(-198269, -100927)
        Nebula():setPosition(-457410, -91738)
        Nebula():setPosition(-215942, -126018)
        Nebula():setPosition(-198877, -143242)
        Nebula():setPosition(-196660, -99642)
        Nebula():setPosition(-448608, -93021)
        Nebula():setPosition(-217672, -143541)
        Nebula():setPosition(-212487, -114463)
        Nebula():setPosition(-192488, -148554)
        Nebula():setPosition(-217815, -95984)
        Nebula():setPosition(-183016, -134037)
        Nebula():setPosition(-205844, -121642)
        Nebula():setPosition(-457340, -132600)
        Nebula():setPosition(-195399, -93219)
        Nebula():setPosition(-222109, -145175)
        Nebula():setPosition(-481668, -89537)
        Nebula():setPosition(-186838, -109115)
        Nebula():setPosition(-457535, -88762)
        Nebula():setPosition(-200202, -138862)
        Nebula():setPosition(-447159, -97199)
        Nebula():setPosition(-201880, -151515)
        Nebula():setPosition(-215997, -157122)
        Nebula():setPosition(-193485, -118238)
        Nebula():setPosition(-199556, -107317)
        Nebula():setPosition(-191518, -190204)
        Nebula():setPosition(-469618, -86364)
        Nebula():setPosition(-215184, -110747)
        Nebula():setPosition(-183545, -98611)
        Nebula():setPosition(-211799, -110195)
        Nebula():setPosition(-473102, -97810)
        Nebula():setPosition(-446899, -126411)
        Nebula():setPosition(-350845, -105782)
        Nebula():setPosition(-427498, -103270)
        Nebula():setPosition(-383049, -151445)
        Nebula():setPosition(-411401, -137085)
        Nebula():setPosition(-415275, -113639)
        Nebula():setPosition(-385996, -131203)
        Nebula():setPosition(-436598, -107812)
        Nebula():setPosition(-414905, -101261)
        Nebula():setPosition(-397242, -122653)
        Nebula():setPosition(-408334, -138530)
        Nebula():setPosition(-430872, -123289)
        Nebula():setPosition(-408762, -99092)
        Nebula():setPosition(-393725, -146279)
        Nebula():setPosition(-337984, -104822)
        Nebula():setPosition(-420612, -125763)
        Nebula():setPosition(-337442, -140050)
        Nebula():setPosition(-371554, -93343)
        Nebula():setPosition(-337166, -134478)
        Nebula():setPosition(-351837, -120285)
        Nebula():setPosition(-339797, -135942)
        Nebula():setPosition(-376885, -122508)
        Nebula():setPosition(-349322, -100452)
        Nebula():setPosition(-429601, -109000)
        Nebula():setPosition(-386447, -161217)
        Nebula():setPosition(-409373, -106681)
        Nebula():setPosition(-429979, -141609)
        Nebula():setPosition(-381527, -148895)
        Nebula():setPosition(-397416, -148973)
        Nebula():setPosition(-376416, -95354)
        Nebula():setPosition(-381285, -99084)
        Nebula():setPosition(-298226, -90830)
        Nebula():setPosition(-297886, -85966)
        Nebula():setPosition(-296041, -160018)
        Nebula():setPosition(-320511, -150260)
        Nebula():setPosition(-247160, -133453)
        Nebula():setPosition(-232944, -127795)
        Nebula():setPosition(-258489, -112951)
        Nebula():setPosition(-322975, -116790)
        Nebula():setPosition(-264437, -148886)
        Nebula():setPosition(-294692, -185083)
        Nebula():setPosition(-292329, -177582)
        Nebula():setPosition(-263294, -117002)
        Nebula():setPosition(-319589, -133807)
        Nebula():setPosition(-238668, -163186)
        Nebula():setPosition(-287429, -151701)
        Nebula():setPosition(-245352, -113286)
        Nebula():setPosition(-262421, -176327)
        Nebula():setPosition(-234939, -137846)
        Nebula():setPosition(-329543, -151820)
        Nebula():setPosition(-326009, -117553)
        Nebula():setPosition(-275412, -182930)
        Nebula():setPosition(-329510, -124559)
        Nebula():setPosition(-257023, -176208)
        Nebula():setPosition(-286006, -162678)
        Nebula():setPosition(-321404, -103686)
        Nebula():setPosition(-297965, -127938)
        Nebula():setPosition(-268721, -101681)
        Nebula():setPosition(-240099, -93811)
        Nebula():setPosition(-232580, -98316)
        Nebula():setPosition(-277667, -170258)
        Nebula():setPosition(-279848, -178643)
        Nebula():setPosition(-329319, -91464)
        Nebula():setPosition(-291730, -118599)
        Nebula():setPosition(-284139, -135767)
        Nebula():setPosition(-279303, -182096)
        Nebula():setPosition(-307433, -98945)
        Nebula():setPosition(-260838, -142138)
        Nebula():setPosition(-246306, -165857)
        Nebula():setPosition(-282542, -96366)
        Nebula():setPosition(-242259, -182980)
        Nebula():setPosition(-294351, -155038)
        Nebula():setPosition(-249155, -163993)
        Nebula():setPosition(-241054, -133282)
        Nebula():setPosition(-270398, -85826)
        Nebula():setPosition(-318659, -88280)
        Nebula():setPosition(-245183, -162919)
        Nebula():setPosition(-257871, -124882)
        Nebula():setPosition(-305540, -137627)
        Nebula():setPosition(-317735, -158600)
        Nebula():setPosition(-271727, -180167)
        Nebula():setPosition(-303230, -129474)
        Nebula():setPosition(-289825, -111989)

    -- Asteroi hideaout	
    	Asteroid():setPosition(-316780, -59098)
        Asteroid():setPosition(-306800, -62291)
        Asteroid():setPosition(-311989, -54108)
        VisualAsteroid():setPosition(-285922, -51459)
        VisualAsteroid():setPosition(-329768, -47888)
        Asteroid():setPosition(-308827, -35628)
        Asteroid():setPosition(-292641, -48619)
        VisualAsteroid():setPosition(-352631, -54831)
        VisualAsteroid():setPosition(-324754, -56179)
        VisualAsteroid():setPosition(-335354, -45635)
        Asteroid():setPosition(-320092, -44092)
        VisualAsteroid():setPosition(-288596, -27634)
        Asteroid():setPosition(-336075, -63635)
        VisualAsteroid():setPosition(-337733, -42766)
        Asteroid():setPosition(-292952, -51995)
        VisualAsteroid():setPosition(-295480, -23755)
        VisualAsteroid():setPosition(-309474, -58156)
        Asteroid():setPosition(-324066, -44370)
        Asteroid():setPosition(-295665, -58153)
        Asteroid():setPosition(-298038, -58952)
        Asteroid():setPosition(-289592, -29474)
        VisualAsteroid():setPosition(-340929, -44860)
        Asteroid():setPosition(-321275, -39826)
        Asteroid():setPosition(-324145, -54910)
        Asteroid():setPosition(-315715, -57282)
        VisualAsteroid():setPosition(-338010, -50959)
        Asteroid():setPosition(-321809, -52129)
        VisualAsteroid():setPosition(-310632, -42370)
        VisualAsteroid():setPosition(-313921, -38582)
        Asteroid():setPosition(-308363, -64183)
        VisualAsteroid():setPosition(-317879, -60156)
        VisualAsteroid():setPosition(-320823, -39633)
        VisualAsteroid():setPosition(-347981, -52302)
        VisualAsteroid():setPosition(-321204, -44807)
        VisualAsteroid():setPosition(-339434, -65507)
        VisualAsteroid():setPosition(-293967, -33687)
        VisualAsteroid():setPosition(-321539, -59397)
        VisualAsteroid():setPosition(-319245, -63592)
        Asteroid():setPosition(-322452, -37296)
        Asteroid():setPosition(-288103, -31803)
        Asteroid():setPosition(-335679, -68475)
        Asteroid():setPosition(-307147, -36470)
        Asteroid():setPosition(-317814, -52904)
        VisualAsteroid():setPosition(-308786, -63676)
        VisualAsteroid():setPosition(-287315, -50433)
        VisualAsteroid():setPosition(-289960, -28589)
        Asteroid():setPosition(-311627, -55440)
        VisualAsteroid():setPosition(-307034, -35900)
        VisualAsteroid():setPosition(-310904, -63830)
        VisualAsteroid():setPosition(-321965, -52691)
        VisualAsteroid():setPosition(-309069, -59828)
        Asteroid():setPosition(-287671, -30628)
        VisualAsteroid():setPosition(-303375, -35312)
        Asteroid():setPosition(-329963, -45467)
        VisualAsteroid():setPosition(-341014, -65257)
        VisualAsteroid():setPosition(-334593, -39620)
        Asteroid():setPosition(-312124, -62746)
        Asteroid():setPosition(-323806, -38161)
        VisualAsteroid():setPosition(-322465, -45779)
        VisualAsteroid():setPosition(-316163, -51549)
        Asteroid():setPosition(-314300, -64001)
        VisualAsteroid():setPosition(-320024, -55250)
        VisualAsteroid():setPosition(-339303, -43634)
        Asteroid():setPosition(-292546, -47002)
        Asteroid():setPosition(-293380, -27456)
        VisualAsteroid():setPosition(-324010, -48528)
        Asteroid():setPosition(-335241, -66648)
        VisualAsteroid():setPosition(-313628, -64510)
        Asteroid():setPosition(-329608, -33005)
        VisualAsteroid():setPosition(-307171, -34974)
        Asteroid():setPosition(-310171, -35907)
        Asteroid():setPosition(-309749, -59509)
        VisualAsteroid():setPosition(-312503, -59361)
        VisualAsteroid():setPosition(-333805, -47121)
        VisualAsteroid():setPosition(-309023, -41215)
        Asteroid():setPosition(-321350, -58729)
        Asteroid():setPosition(-318795, -27667)
        VisualAsteroid():setPosition(-309250, -58752)
        VisualAsteroid():setPosition(-285448, -47220)
        Asteroid():setPosition(-307282, -59169)
        VisualAsteroid():setPosition(-296528, -52619)
        Asteroid():setPosition(-295582, -26699)
        Asteroid():setPosition(-325965, -46294)
        VisualAsteroid():setPosition(-319404, -29874)
        Asteroid():setPosition(-297799, -50047)
        Asteroid():setPosition(-349003, -54104)
        VisualAsteroid():setPosition(-292415, -45907)
        VisualAsteroid():setPosition(-321534, -40539)
        VisualAsteroid():setPosition(-298591, -47936)
        Asteroid():setPosition(-341670, -68251)
        VisualAsteroid():setPosition(-310828, -39572)
        Asteroid():setPosition(-288667, -44928)
        Asteroid():setPosition(-322959, -42029)
        VisualAsteroid():setPosition(-335382, -56058)
        VisualAsteroid():setPosition(-311796, -41982)
        Asteroid():setPosition(-324856, -36748)
        VisualAsteroid():setPosition(-321178, -54673)
        VisualAsteroid():setPosition(-307453, -43138)
        Asteroid():setPosition(-318096, -51467)
        VisualAsteroid():setPosition(-322738, -47483)
        Asteroid():setPosition(-342471, -65622)
        VisualAsteroid():setPosition(-315716, -56830)
        Asteroid():setPosition(-340261, -49303)
        VisualAsteroid():setPosition(-306950, -40712)
        VisualAsteroid():setPosition(-339713, -66993)
        Asteroid():setPosition(-336792, -35724)
        VisualAsteroid():setPosition(-304512, -36290)
        Asteroid():setPosition(-296337, -59529)
        Asteroid():setPosition(-338211, -43485)
        Asteroid():setPosition(-296110, -50717)
        Asteroid():setPosition(-296027, -25572)
        VisualAsteroid():setPosition(-350281, -56197)
        Asteroid():setPosition(-333593, -56069)
        VisualAsteroid():setPosition(-285089, -52045)
        VisualAsteroid():setPosition(-285610, -44798)
        VisualAsteroid():setPosition(-320445, -52100)
        Asteroid():setPosition(-337832, -37089)
        Asteroid():setPosition(-336105, -67801)
        Asteroid():setPosition(-310402, -42183)
        Asteroid():setPosition(-292572, -28997)
        VisualAsteroid():setPosition(-314953, -56505)
        Asteroid():setPosition(-293893, -44763)
        Asteroid():setPosition(-298266, -47844)
        VisualAsteroid():setPosition(-332042, -48236)
        Asteroid():setPosition(-288317, -32453)
        VisualAsteroid():setPosition(-331630, -55596)
        VisualAsteroid():setPosition(-307693, -40718)
        Asteroid():setPosition(-318742, -36720)
        VisualAsteroid():setPosition(-319796, -46773)
        Asteroid():setPosition(-315928, -47242)
        VisualAsteroid():setPosition(-312123, -40311)
        VisualAsteroid():setPosition(-340019, -45217)
        Asteroid():setPosition(-316177, -47713)
        VisualAsteroid():setPosition(-324002, -60817)
        Asteroid():setPosition(-298590, -50578)
        Asteroid():setPosition(-313032, -52358)
        Asteroid():setPosition(-326212, -52571)
        VisualAsteroid():setPosition(-338899, -63034)
        VisualAsteroid():setPosition(-325147, -55166)
        Asteroid():setPosition(-311431, -50993)
        Asteroid():setPosition(-305946, -33943)
        VisualAsteroid():setPosition(-287633, -32546)
        VisualAsteroid():setPosition(-294321, -47235)
        Asteroid():setPosition(-290103, -29914)
        VisualAsteroid():setPosition(-317733, -44482)
        VisualAsteroid():setPosition(-287246, -28079)
        Asteroid():setPosition(-317836, -59372)
        VisualAsteroid():setPosition(-288788, -32968)
        VisualAsteroid():setPosition(-325469, -59761)
        Asteroid():setPosition(-294268, -25923)
        VisualAsteroid():setPosition(-297440, -50153)
        VisualAsteroid():setPosition(-312318, -54443)
        Asteroid():setPosition(-289037, -51453)
        VisualAsteroid():setPosition(-340856, -52824)
        VisualAsteroid():setPosition(-321249, -41476)
        VisualAsteroid():setPosition(-350722, -55196)
        VisualAsteroid():setPosition(-343618, -69273)
        VisualAsteroid():setPosition(-298778, -31205)
        Asteroid():setPosition(-326585, -39956)
        VisualAsteroid():setPosition(-305676, -35705)
        Asteroid():setPosition(-287228, -45766)
        Asteroid():setPosition(-329330, -56228)
        Asteroid():setPosition(-338458, -43470)
        Asteroid():setPosition(-312251, -63277)
        Asteroid():setPosition(-305427, -34287)
        Asteroid():setPosition(-293498, -50766)
        VisualAsteroid():setPosition(-293916, -30641)
        Asteroid():setPosition(-297831, -24647)
        VisualAsteroid():setPosition(-336212, -36954)
        VisualAsteroid():setPosition(-320863, -56333)
        Asteroid():setPosition(-288076, -26761)
        VisualAsteroid():setPosition(-318760, -52392)
        Asteroid():setPosition(-312584, -51402)
        VisualAsteroid():setPosition(-297208, -48283)
        VisualAsteroid():setPosition(-313985, -43261)
        Asteroid():setPosition(-327978, -33482)
        VisualAsteroid():setPosition(-335841, -66457)
        Asteroid():setPosition(-319329, -44586)
        Asteroid():setPosition(-314448, -42609)
        VisualAsteroid():setPosition(-308517, -35954)
        VisualAsteroid():setPosition(-321986, -55704)
        Asteroid():setPosition(-329827, -54617)
        VisualAsteroid():setPosition(-326181, -55783)
        Asteroid():setPosition(-296312, -23042)
        VisualAsteroid():setPosition(-320677, -42777)
        Asteroid():setPosition(-315031, -61992)
        VisualAsteroid():setPosition(-343916, -69504)
        Asteroid():setPosition(-320466, -36134)
        Asteroid():setPosition(-322450, -45821)
        Asteroid():setPosition(-351603, -54479)
        VisualAsteroid():setPosition(-317380, -57976)
        Asteroid():setPosition(-323553, -47017)
        Asteroid():setPosition(-313801, -57956)
        VisualAsteroid():setPosition(-286843, -44972)
        Asteroid():setPosition(-313012, -56928)
        VisualAsteroid():setPosition(-325279, -52805)
        Asteroid():setPosition(-312064, -54691)
        Asteroid():setPosition(-316283, -61350)
        Asteroid():setPosition(-295346, -60849)
        VisualAsteroid():setPosition(-335450, -57586)
        Asteroid():setPosition(-323225, -60156)
        Asteroid():setPosition(-325086, -35422)
        Asteroid():setPosition(-334457, -53766)
        VisualAsteroid():setPosition(-309131, -61133)
        Asteroid():setPosition(-297625, -32245)
        VisualAsteroid():setPosition(-324478, -60519)
        Asteroid():setPosition(-320382, -50089)
        Asteroid():setPosition(-312290, -62639)
        Asteroid():setPosition(-326086, -47216)
        VisualAsteroid():setPosition(-314982, -40938)
        Asteroid():setPosition(-335390, -41819)
        VisualAsteroid():setPosition(-308520, -63943)
        Asteroid():setPosition(-289123, -32265)
        Asteroid():setPosition(-293079, -30422)
        VisualAsteroid():setPosition(-323091, -53713)
        Asteroid():setPosition(-291276, -53091)
        VisualAsteroid():setPosition(-297494, -46493)
        VisualAsteroid():setPosition(-328310, -49563)
        Asteroid():setPosition(-311787, -35851)
        VisualAsteroid():setPosition(-325167, -50999)
        VisualAsteroid():setPosition(-310921, -33623)
        VisualAsteroid():setPosition(-319578, -41785)
        VisualAsteroid():setPosition(-291329, -45058)
        Asteroid():setPosition(-315822, -39202)
        VisualAsteroid():setPosition(-296160, -23361)
        Asteroid():setPosition(-320613, -52699)
        VisualAsteroid():setPosition(-318707, -62497)
        Asteroid():setPosition(-294752, -44359)
        Asteroid():setPosition(-316288, -51714)
        VisualAsteroid():setPosition(-298656, -52272)
        VisualAsteroid():setPosition(-319346, -47825)
        VisualAsteroid():setPosition(-319165, -52991)
        Asteroid():setPosition(-293328, -47949)
        VisualAsteroid():setPosition(-322553, -58802)
        Asteroid():setPosition(-337062, -43397)
        VisualAsteroid():setPosition(-340151, -66442)
        VisualAsteroid():setPosition(-328862, -57348)
        VisualAsteroid():setPosition(-343366, -65927)
        VisualAsteroid():setPosition(-306809, -43872)
        Asteroid():setPosition(-306825, -64796)
        VisualAsteroid():setPosition(-317389, -38308)
        Asteroid():setPosition(-297243, -29203)
        Asteroid():setPosition(-322962, -60297)
        Asteroid():setPosition(-307640, -43990)
        VisualAsteroid():setPosition(-305693, -34319)
        Asteroid():setPosition(-320376, -61609)
        VisualAsteroid():setPosition(-308258, -34591)
        Asteroid():setPosition(-319414, -59564)
        VisualAsteroid():setPosition(-325929, -34142)
        Asteroid():setPosition(-287160, -29075)
        VisualAsteroid():setPosition(-338083, -63011)
        VisualAsteroid():setPosition(-313340, -57157)
        VisualAsteroid():setPosition(-314048, -41487)
        Asteroid():setPosition(-292342, -27690)
        Asteroid():setPosition(-296560, -26394)
        VisualAsteroid():setPosition(-338487, -48761)
        VisualAsteroid():setPosition(-352183, -56769)
        VisualAsteroid():setPosition(-323792, -38784)
        Asteroid():setPosition(-307469, -43236)
        Asteroid():setPosition(-310452, -41501)
        VisualAsteroid():setPosition(-326153, -40057)
        VisualAsteroid():setPosition(-315612, -51713)
        VisualAsteroid():setPosition(-312006, -36610)
        VisualAsteroid():setPosition(-286360, -46281)
        Asteroid():setPosition(-327215, -35927)
    	
    -- Mines hideout
     
        Mine():setPosition(-346837, -54848)
        Mine():setPosition(-338637, -65064)
        Mine():setPosition(-331378, -51488)
        Mine():setPosition(-336486, -45707)
        Mine():setPosition(-311619, -58612)
        Mine():setPosition(-292666, -51084)
        Mine():setPosition(-310409, -40734)
        Mine():setPosition(-325195, -40600)
        Mine():setPosition(-291052, -27158)
      
        CpuShip():setFaction("Independent"):setTemplate("Adder MK5"):setCallSign("VS10"):setPosition(-314095, -48315):orderDefendLocation(-314150, -48326):setWeaponStorage("HVLI", 3)
        CpuShip():setFaction("Independent"):setTemplate("Adder MK5"):setCallSign("SS11"):setPosition(-307963, -51956):orderDefendLocation(-308016, -51975):setWeaponStorage("HVLI", 3)
        CpuShip():setFaction("Independent"):setTemplate("Adder MK5"):setCallSign("CSS12"):setPosition(-305894, -49011):orderDefendLocation(-305890, -48955):setWeaponStorage("HVLI", 3)
        CpuShip():setFaction("Independent"):setTemplate("Adder MK5"):setCallSign("CV13"):setPosition(-320022, -49025):orderDefendLocation(-320068, -48992):setWeaponStorage("HVLI", 3)
        CpuShip():setFaction("Independent"):setTemplate("Atlantis X23"):setCallSign("VS14"):setPosition(-314480, -51996):orderDefendLocation(-314477, -52017):setWeaponStorage("Homing", 0)
        CpuShip():setFaction("Independent"):setTemplate("Adv. Gunship"):setCallSign("VK15"):setPosition(-296040, -47202):orderDefendLocation(-296040, -47207):setWeaponStorage("Homing", 2)
        
    	
    -- wormhole	hideout

    	WormHole():setPosition(-274607, -116444):setTargetPosition(-67542, 8801)
    	
        Ind_2 = CpuShip():setFaction("Independent"):setTemplate("Atlantis X23"):setCallSign("EmRoDeh"):setPosition(-289306, -111793):orderDefendLocation(-289305, -111794):setWeaponStorage("Homing", 0)
        CpuShip():setFaction("Independent"):setTemplate("Atlantis X23"):setCallSign("BR17"):setPosition(-277520, -103144):orderDefendLocation(-277519, -103143):setWeaponStorage("Homing", 0)
        CpuShip():setFaction("Independent"):setTemplate("MU52 Hornet"):setCallSign("NC19"):setPosition(-281637, -109767):orderDefendLocation(-281952, -117092)
        CpuShip():setFaction("Independent"):setTemplate("MU52 Hornet"):setCallSign("BR20"):setPosition(-273308, -122713):orderDefendLocation(-273302, -122715)
        CpuShip():setFaction("Independent"):setTemplate("MU52 Hornet"):setCallSign("CCN21"):setPosition(-266495, -114385):orderDefendLocation(-266490, -114389)
        CpuShip():setFaction("Independent"):setTemplate("MU52 Hornet"):setCallSign("VK22"):setPosition(-284659, -98056):orderDefendLocation(-284655, -98061)
        CpuShip():setFaction("Independent"):setTemplate("MU52 Hornet"):setCallSign("UTI23"):setPosition(-298502, -99575):orderDefendLocation(-298496, -99575)
        CpuShip():setFaction("Independent"):setTemplate("MU52 Hornet"):setCallSign("VS24"):setPosition(-307367, -98598):orderDefendLocation(-307362, -98602)
        CpuShip():setFaction("Independent"):setTemplate("MU52 Hornet"):setCallSign("NC25"):setPosition(-269844, -88107):orderDefendLocation(-269842, -88113)
        
    	Mine():setPosition(-273075, -99644)
        Mine():setPosition(-275046, -99092)
        Mine():setPosition(-277016, -98540)
        Mine():setPosition(-264325, -109260)
        Mine():setPosition(-266926, -125420)
        Mine():setPosition(-276859, -131489)
        Mine():setPosition(-285766, -127706)
        Mine():setPosition(-289392, -122582)
        Mine():setPosition(-288682, -107684)
        Mine():setPosition(-291441, -94126)
        WarpJammer():setFaction("Independent"):setPosition(-278750, -110522)
end


function update(delta) 
    if Arianne_mission == 0 then
        if Arianne_comms == 0 then
        Station_SF87:sendCommsMessage(ToisondOr, [[ Vous avez bien fait de vous rendre dans le coin. 
Pleins de petits indépendants qui n'attendent que de se faire plumer. Et presque pas de présence de la Fédé, à part ces deux ou trois petits vaisseaux Mérillon. 
Vous devriez pas avoir trop de problème à les éviter.

...

Hum, attendez. Je viens de recevoir une communication. 
Ouais. C'est pas beau ça. Un de nos équipages est allé se perdre dans le secteur E89. 
Il revenait d'une petite mission de prospection, si vous voyez ce que je veux dire. 
Mais on dirait qu'il s'est fait voir, et il a besoin d'aide si on veut pas qu'il se fasse manger tout cru. 
Faudrait aller l'aider. Ils pourront vous récompenser j'imagine.]])

        Station_SF87:sendCommsMessage(CigogneIV, [[ Vous avez bien fait de vous rendre dans le coin. 
Pleins de petits indépendants qui n'attendent que de se faire plumer. Et presque pas de présence de la Fédé, à part ces deux ou trois petits vaisseaux Mérillon. 
Vous devriez pas avoir trop de problème à les éviter.

...

Hum, attendez. Je viens de recevoir une communication. 
Ouais. C'est pas beau ça. Un de nos équipages est allé se perdre dans le secteur E89. 
Il revenait d'une petite mission de prospection, si vous voyez ce que je veux dire. 
Mais on dirait qu'il s'est fait voir, et il a besoin d'aide si on veut pas qu'il se fasse manger tout cru. 
Faudrait aller l'aider. Ils pourront vous récompenser j'imagine.]])

        Station_SF87:sendCommsMessage(GuerrillaRadio, [[  Vous avez bien fait de vous rendre dans le coin. 
Pleins de petits indépendants qui n'attendent que de se faire plumer. Et presque pas de présence de la Fédé, à part ces deux ou trois petits vaisseaux Mérillon. 
Vous devriez pas avoir trop de problème à les éviter.

...

Hum, attendez. Je viens de recevoir une communication. 
Ouais. C'est pas beau ça. Un de nos équipages est allé se perdre dans le secteur E89. 
Il revenait d'une petite mission de prospection, si vous voyez ce que je veux dire. 
Mais on dirait qu'il s'est fait voir, et il a besoin d'aide si on veut pas qu'il se fasse manger tout cru. 
Faudrait aller l'aider. Ils pourront vous récompenser j'imagine.]])
        Arianne_comms = 1
        Arianne_mission = 1
        end
    end

    if not Ind_1:isValid() then
        if Arianne_mission == 1 then
            if Arianne_comms == 1 then
                Station_SF87:sendCommsMessage(ToisondOr, [[Bordel, je savais pas que ces escortes marchandes étaient présentes dans le coin. 
Ils doivent avoir une base temporaire dans le coin, histoire de se ravitailler et de mettre de l'ordre dans le secteur. 
Ça pourrait être une bonne idée d'aller couper ces ravitaillements, non? Il y aura probablement des trucs à piller en chemin, gâtez-vous.

Attendez un peu. Hum. Oui, ok.

Il y a des bonnes chances que la station se trouve au cadran C89. 
Dépêchez-vous, avec un peu de chance on pourra les prendre par surprise. Bonne chance, et faites-vous pas mal, d'accord?]])
                
                Station_SF87:sendCommsMessage(CigogneIV, [[Bordel, je savais pas que ces escortes marchandes étaient présentes dans le coin. 
Ils doivent avoir une base temporaire dans le coin, histoire de se ravitailler et de mettre de l'ordre dans le secteur. 
Ça pourrait être une bonne idée d'aller couper ces ravitaillements, non? Il y aura probablement des trucs à piller en chemin, gâtez-vous.

Attendez un peu. Hum. Oui, ok.

Il y a des bonnes chances que la station se trouve au cadran C89. 
Dépêchez-vous, avec un peu de chance on pourra les prendre par surprise. Bonne chance, et faites-vous pas mal, d'accord?]])

                 Station_SF87:sendCommsMessage(GuerrillaRadio, [[Bordel, je savais pas que ces escortes marchandes étaient présentes dans le coin. 
Ils doivent avoir une base temporaire dans le coin, histoire de se ravitailler et de mettre de l'ordre dans le secteur. 
Ça pourrait être une bonne idée d'aller couper ces ravitaillements, non? Il y aura probablement des trucs à piller en chemin, gâtez-vous.

Attendez un peu. Hum. Oui, ok.

Il y a des bonnes chances que la station se trouve au cadran C89. 
Dépêchez-vous, avec un peu de chance on pourra les prendre par surprise. Bonne chance, et faites-vous pas mal, d'accord?]])
                Arianne_mission = 2
                Arianne_comms = 2
            end
        end
    end

    if not Ind_station:isValid() then
        if Arianne_mission == 2 then 
            if Arianne_comms == 2 then 
        
                    Station_SF87:sendCommsMessage(ToisondOr, [[ Bravo. Ça va rendre le coin un peu plus libre pour nous, et ça va sécuriser nos convois. 
J'imagine que vous avez pu piller des trucs? Gardez tout, c'est bien mérité. On se reparle bientôt. (Notez votre butin = [Code : CRD-9872])

[Vous interceptez une nouvelle communication, qui semblerait provenir des alentours du secteur ZZ90. En la décodant, vous comprenez qu'il s'agit d'un message de secours en provenance d'un vaisseau de marchands indépendants situés non loin]

"Mayday, mayday. Ici EmRoDeH, je répète, nous avons besoin de soutient. Des pirates sévissent dans le coin. 
Nous recevez vous, P-58? Mayday, mayday, nous avons besoin de soutien. Nous nous mettons en route pour Dussel-3, mais nous aurons besoin d'une escorte pour le retour. 
Cargaisons de Mercassium à bord. P-58? Répondez?"

Vous avez entendu ça? Ça vaut cher, ce Mercassium. Ça serait bien qu'ils ne se rendent même pas à Dussel, non?]])
            
                    Station_SF87:sendCommsMessage(CigogneIV, [[ Bravo. Ça va rendre le coin un peu plus libre pour nous, et ça va sécuriser nos convois. 
J'imagine que vous avez pu piller des trucs? Gardez tout, c'est bien mérité. On se reparle bientôt. (Notez votre butin = [Code : CRD-9872])

[Vous interceptez une nouvelle communication, qui semblerait provenir des alentours du secteur ZZ90. En la décodant, vous comprenez qu'il s'agit d'un message de secours en provenance d'un vaisseau de marchands indépendants situés non loin]

"Mayday, mayday.Ici EmRoDeH, je répète, nous avons besoin de soutient. Des pirates sévissent dans le coin. 
Nous recevez vous, P-58? Mayday, mayday, nous avons besoin de soutien. Nous nous mettons en route pour Dussel-3, mais nous aurons besoin d'une escorte pour le retour. 
Cargaisons de Mercassium à bord. P-58? Répondez?"

Vous avez entendu ça? Ça vaut cher, ce Mercassium. Ça serait bien qu'ils ne se rendent même pas à Dussel, non?]])

                    Station_SF87:sendCommsMessage(GuerrillaRadio, [[ Bravo. Ça va rendre le coin un peu plus libre pour nous, et ça va sécuriser nos convois. 
J'imagine que vous avez pu piller des trucs? Gardez tout, c'est bien mérité. On se reparle bientôt. (Notez votre butin = [Code : CRD-9872])

[Vous interceptez une nouvelle communication, qui semblerait provenir des alentours du secteur ZZ90. En la décodant, vous comprenez qu'il s'agit d'un message de secours en provenance d'un vaisseau de marchands indépendants situés non loin]

"Mayday, mayday. Ici EmRoDeH, je répète, nous avons besoin de soutient. Des pirates sévissent dans le coin. 
Nous recevez vous, P-58? Mayday, mayday, nous avons besoin de soutien. Nous nous mettons en route pour Dussel-3, mais nous aurons besoin d'une escorte pour le retour. 
Cargaisons de Mercassium à bord. P-58? Répondez?"

Vous avez entendu ça? Ça vaut cher, ce Mercassium. Ça serait bien qu'ils ne se rendent même pas à Dussel, non?]])
                Arianne_comms = 3
            end
        end
    end

    if not Ind_2:isValid() then
        if Arianne_mission == 2 then 
            if Arianne_comms == 3 then 
                Station_SF87:sendCommsMessage(ToisondOr, [[ Après avoir explosé le.. hum hum... "EmRoDeh", vous récupérez dans les décombres (butin : [Code : MOD-TU11] )]. 
Pas mal, pas mal. Vous déciderez qui le garde. 
C'est probablement pour ça qu'il y a plus d'escorte qu'on pensait dans le secteur. S'ils ont trouvé une mine de Mercassium, ça peut valoir très cher.

Il devrait y avoir un trou de ver dans le coin, allez voir ce qui s'y trouve ! Voyez voir ci on peut avoir plus d'informations sur cette mine.
Cherchez une station dans le secteur et allez vous y ammarer. ]])
            
                Station_SF87:sendCommsMessage(CigogneIV, [[ Après avoir explosé le.. hum hum... "EmRoDeh", vous récupérez dans les décombres (butin : [Code : MOD-5612] )]. 
Pas mal, pas mal. Vous déciderez qui le garde. 
C'est probablement pour ça qu'il y a plus d'escorte qu'on pensait dans le secteur. S'ils ont trouvé une mine de Mercassium, ça peut valoir très cher.

Il devrait y avoir un trou de ver dans le coin, allez voir ce qui s'y trouve ! Voyez voir ci on peut avoir plus d'informations sur cette mine.
Cherchez une station dans le secteur et allez vous y ammarer.  ]])

                Station_SF87:sendCommsMessage(GuerrillaRadio, [[ Après avoir explosé le.. hum hum... "EmRoDeh", vous récupérez dans les décombres (butin : [Code : MOD-NA34] )]. 

Pas mal, pas mal. Vous déciderez qui le garde. 
C'est probablement pour ça qu'il y a plus d'escorte qu'on pensait dans le secteur. S'ils ont trouvé une mine de Mercassium, ça peut valoir très cher.

Il devrait y avoir un trou de ver dans le coin, allez voir ce qui s'y trouve! Voyez voir ci on peut avoir plus d'informations sur cette mine. 
Cherchez une station dans le secteur et allez vous y ammarer. ]])
                Arianne_mission = 3
                Arianne_comms = 4
            end
        end
    end

    if (distance(ToisondOr, dussel_3) < 100000) then
        if ToisondOr_comms == 0 then 
                Station_SF87:sendCommsMessage(ToisondOr, [[ C’est quoi tous ces astéroides? Et ces épaves? C’est vraiment pas net tout ça, vous devriez aller investiguer. Faites attention, ça serait pas la première fois que la Fédé nous tenderait des embuscades.

Il doit bien y avoir une station quelque part, probablement abandonnée. Essayer de trouver ça, et de vous y accoster. Nous vous recontacterons rendu là. 

Bonne chance
 ]])
            ToisondOr_comms = 1
        end
    end

    if (distance(CigogneIV, dussel_3) < 100000) then
        if CigogneIV_comms == 0 then 
                Station_SF87:sendCommsMessage(CigogneIV, [[ C’est quoi tous ces astéroides? Et ces épaves? C’est vraiment pas net tout ça, vous devriez aller investiguer. 
Faites attention, ça serait pas la première fois que la Fédé nous tenderait des embuscades.

Il doit bien y avoir une station quelque part, probablement abandonnée. Essayer de trouver ça, et de vous y accoster. Nous vous recontacterons rendu là. 

Bonne chance ]])
            CigogneIV_comms = 1
        end
    end

    if (distance(GuerrillaRadio, dussel_3) < 100000) then
        if GuerrillaRadio_comms == 0 then 
                Station_SF87:sendCommsMessage(GuerrillaRadio, [[C’est quoi tous ces astéroides? Et ces épaves? C’est vraiment pas net tout ça, vous devriez aller investiguer. 
Faites attention, ça serait pas la première fois que la Fédé nous tenderait des embuscades.

Il doit bien y avoir une station quelque part, probablement abandonnée. Essayer de trouver ça, et de vous y accoster. Nous vous recontacterons rendu là. 

Bonne chance ]])
           GuerrillaRadio_comms = 1
        end
    end

    for _, arianneteam in ipairs(arianneteamList) do
        if arianneteam:isValid() then
            arianneteam:addReputationPoints(delta * 0.1)
        end
    end
end
-- name : carte vindh1



function init()
    
    vindhteamList = {}

    -- Create player locations
        table.insert(vindhteamList, DIVX:setPosition(532600, -38600))   
        table.insert(vindhteamList, Korosheg:setPosition(531000, -38600))
        
    -- Create mission state
        Vindh_mission = 0
        Vindh_comms = 0
        DIVX_comms = 0 
        Korosheg_comms = 0

        vindhteamList[1]:addReputationPoints(300.0)


    -- vindh station
        Station_D31 = SpaceStation():setTemplate("Small Station"):setFaction("Vindh"):setCallSign("Camarade Zimine.D31"):setPosition(530148, -36993)
    	
        CpuShip():setFaction("Vindh"):setTemplate("Adder MK4"):setCallSign("CV26"):setPosition(526819, -37320):orderStandGround():setWeaponStorage("HVLI", 1)
        CpuShip():setFaction("Vindh"):setTemplate("Adder MK4"):setCallSign("UTI27"):setPosition(530232, -34881):orderStandGround():setWeaponStorage("HVLI", 1)
        CpuShip():setFaction("Vindh"):setTemplate("Adder MK4"):setCallSign("VS28"):setPosition(534002, -36575):orderStandGround():setWeaponStorage("HVLI", 1)

    -- vindh transport ship
        Transport_Vt3 = CpuShip():setFaction("Vindh"):setTemplate("Goods Freighter 3"):setCallSign("Vt_3"):setPosition(490652, -39567):orderFlyTowards(534706, -38666)
        Transport_Vt2 = CpuShip():setFaction("Vindh"):setTemplate("Goods Freighter 3"):setCallSign("Vt_2"):setPosition(487064, -36448):orderFlyTowards(531119, -35548)
        CpuShip():setFaction("Vindh"):setTemplate("Goods Freighter 3"):setCallSign("Vt_1"):setPosition(492159, -35047):orderFlyTowards(536214, -34146)	
    	 
    -- Epaves	
    	SpaceStation():setTemplate("Small Station"):setFaction("Epave"):setCallSign("DS29055"):setPosition(485738, -37674)    
    	
    	CpuShip():setFaction("Epave"):setTemplate("Adder MK5"):setCallSign("VS29"):setPosition(479420, -37940):orderIdle()
        CpuShip():setFaction("Epave"):setTemplate("Adder MK5"):setCallSign("VK30"):setPosition(483119, -41776):orderIdle()
        CpuShip():setFaction("Epave"):setTemplate("Adder MK5"):setCallSign("S31"):setPosition(488668, -44585):orderIdle()
        CpuShip():setFaction("Epave"):setTemplate("Adder MK5"):setCallSign("SS32"):setPosition(487846, -38557):orderIdle()
        CpuShip():setFaction("Epave"):setTemplate("Adder MK5"):setCallSign("SS33"):setPosition(488599, -32117):orderIdle()
        CpuShip():setFaction("Epave"):setTemplate("Adder MK5"):setCallSign("CV34"):setPosition(496956, -37666):orderIdle()
        CpuShip():setFaction("Epave"):setTemplate("Adder MK6"):setCallSign("BR35"):setPosition(472501, -38146):orderIdle()
        CpuShip():setFaction("Epave"):setTemplate("Adder MK6"):setCallSign("UTI36"):setPosition(480105, -48627):orderIdle()
        CpuShip():setFaction("Epave"):setTemplate("Adder MK6"):setCallSign("CV37"):setPosition(469007, -45886):orderIdle()
    	
    -- ennemy station

       Sp_station = SpaceStation():setTemplate("Medium Station"):setFaction("Spectre"):setCallSign("DS29014"):setPosition(449307, -72470)	
    	
    -- ennemy ship	
        WarpJammer():setFaction("Spectre"):setPosition(383136, -108164)
    	
    -- attacking transport
        Sp_1 = CpuShip():setFaction("Spectre"):setTemplate("Adv. Striker"):setCallSign("VK9"):setPosition(480765, -44761):orderFlyTowards(486797, -37815)
        Sp_1 = CpuShip():setFaction("Spectre"):setTemplate("Adv. Striker"):setCallSign("VK9"):setPosition(482765, -44761):orderFlyTowards(486797, -37815)
        CpuShip():setFaction("Spectre"):setTemplate("R-Camelot"):setCallSign("BR38"):setPosition(480915, -43881):orderDefendLocation(480915, -43881)
        CpuShip():setFaction("Spectre"):setTemplate("R-Camelot"):setCallSign("CV39"):setPosition(479200, -43069):orderDefendLocation(480915, -43881)

        CpuShip():setFaction("Spectre"):setTemplate("MT52 Hornet"):setCallSign("S5"):setPosition(492657, -30486):orderFlyTowards(487115, -35227)
        CpuShip():setFaction("Spectre"):setTemplate("MT52 Hornet"):setCallSign("NC6"):setPosition(497959, -43192):orderFlyTowards(488918, -37582)
  
        CpuShip():setFaction("Spectre"):setTemplate("MT52 Hornet"):setCallSign("BR7"):setPosition(479866, -40754):orderFlyTowards(485853, -36886)
        CpuShip():setFaction("Spectre"):setTemplate("Adder MK5"):setCallSign("SS8"):setPosition(482831, -30923):orderFlyTowards(488489, -36069):setWeaponStorage("HVLI", 3)
        CpuShip():setFaction("Spectre"):setTemplate("Adder MK5"):setCallSign("VS10"):setPosition(446689, -73668):orderDefendLocation(446689, -73668):setWeaponStorage("HVLI", 3)
        CpuShip():setFaction("Spectre"):setTemplate("Adder MK5"):setCallSign("SS11"):setPosition(452819, -77303):orderDefendLocation(452819, -77303):setWeaponStorage("HVLI", 3)
        CpuShip():setFaction("Spectre"):setTemplate("Adder MK5"):setCallSign("CSS12"):setPosition(454864, -74398):orderDefendLocation(454864, -74398):setWeaponStorage("HVLI", 3)
        CpuShip():setFaction("Spectre"):setTemplate("Adder MK5"):setCallSign("CV13"):setPosition(440759, -74391):orderDefendLocation(440759, -74391):setWeaponStorage("HVLI", 3)
        CpuShip():setFaction("Spectre"):setTemplate("Atlantis X23"):setCallSign("VS14"):setPosition(446270, -77339):orderDefendLocation(446270, -77339):setWeaponStorage("Homing", 0)
        CpuShip():setFaction("Spectre"):setTemplate("Adv. Gunship"):setCallSign("VK15"):setPosition(464712, -72552):orderDefendLocation(464712, -72552):setWeaponStorage("Homing", 2)
        WormHole():setPosition(387279, -114087):setTargetPosition(-10749, 5425)
        
        Sp_2 = CpuShip():setFaction("Spectre"):setTemplate("Atlantis X23"):setCallSign("UTI16"):setPosition(372579, -109434):orderDefendLocation(372579, -109434):setWeaponStorage("Homing", 0)
        CpuShip():setFaction("Spectre"):setTemplate("Atlantis X23"):setCallSign("BR17"):setPosition(384364, -100787):orderDefendLocation(384364, -100787):setWeaponStorage("Homing", 0)
        CpuShip():setFaction("Spectre"):setTemplate("MU52 Hornet"):setCallSign("NC19"):setPosition(380248, -107418):orderDefendLocation(380248, -107418)
        CpuShip():setFaction("Spectre"):setTemplate("MU52 Hornet"):setCallSign("BR20"):setPosition(388569, -120352):orderDefendLocation(388569, -120352)
        CpuShip():setFaction("Spectre"):setTemplate("MU52 Hornet"):setCallSign("CCN21"):setPosition(395383, -112023):orderDefendLocation(395383, -112023)
        CpuShip():setFaction("Spectre"):setTemplate("MU52 Hornet"):setCallSign("VK22"):setPosition(377221, -95690):orderDefendLocation(377221, -95690)
        CpuShip():setFaction("Spectre"):setTemplate("MU52 Hornet"):setCallSign("UTI23"):setPosition(401617, -106920):orderDefendLocation(401617, -106920)
        CpuShip():setFaction("Spectre"):setTemplate("MU52 Hornet"):setCallSign("VS24"):setPosition(392274, -85068):orderDefendLocation(392274, -85068)
        CpuShip():setFaction("Spectre"):setTemplate("MU52 Hornet"):setCallSign("NC25"):setPosition(393839, -95949):orderDefendLocation(393839, -95949)

    	
    -- nebula hideout
        Nebula():setPosition(363660, -88473)
        Nebula():setPosition(364000, -83608)
        Nebula():setPosition(414726, -131095)
        Nebula():setPosition(403397, -110593)
        Nebula():setPosition(397449, -146528)
        Nebula():setPosition(398592, -114645)
        Nebula():setPosition(416535, -110928)
        Nebula():setPosition(393165, -99323)
        Nebula():setPosition(370156, -116242)
        Nebula():setPosition(377747, -133410)
        Nebula():setPosition(356170, -98440)
        Nebula():setPosition(401049, -139780)
        Nebula():setPosition(379344, -94008)
        Nebula():setPosition(391487, -83468)
        Nebula():setPosition(404015, -122524)
        Nebula():setPosition(372061, -109632)
        
    -- asteroid hideout	
    	Asteroid():setPosition(443972, -84453)
        Asteroid():setPosition(453952, -87647)
        Asteroid():setPosition(448763, -79463)
        VisualAsteroid():setPosition(474830, -76815)
        VisualAsteroid():setPosition(430984, -73243)
        Asteroid():setPosition(451925, -60984)
        Asteroid():setPosition(468111, -73975)
        VisualAsteroid():setPosition(408121, -80187)
        VisualAsteroid():setPosition(435998, -81535)
        VisualAsteroid():setPosition(425398, -70991)
        Asteroid():setPosition(440660, -69448)
        VisualAsteroid():setPosition(472156, -52990)
        Asteroid():setPosition(424678, -88991)
        VisualAsteroid():setPosition(423019, -68122)
        Asteroid():setPosition(467800, -77351)
        VisualAsteroid():setPosition(465272, -49111)
        VisualAsteroid():setPosition(451278, -83512)
        Asteroid():setPosition(436686, -69726)
        Asteroid():setPosition(465088, -83509)
        Asteroid():setPosition(462714, -84308)
        Asteroid():setPosition(471161, -54830)
        VisualAsteroid():setPosition(419823, -70216)
        Asteroid():setPosition(439477, -65182)
        Asteroid():setPosition(436607, -80266)
        Asteroid():setPosition(445037, -82638)
        VisualAsteroid():setPosition(422742, -76315)
        Asteroid():setPosition(438943, -77485)
        VisualAsteroid():setPosition(450120, -67725)
        VisualAsteroid():setPosition(446831, -63938)
        Asteroid():setPosition(452389, -89539)
        VisualAsteroid():setPosition(442873, -85512)
        VisualAsteroid():setPosition(439929, -64989)
        VisualAsteroid():setPosition(412771, -77658)
        VisualAsteroid():setPosition(439548, -70163)
        VisualAsteroid():setPosition(421318, -90863)
        VisualAsteroid():setPosition(466785, -59043)
        VisualAsteroid():setPosition(439213, -84753)
        VisualAsteroid():setPosition(441507, -88948)
        Asteroid():setPosition(438300, -62652)
        Asteroid():setPosition(472649, -57159)
        Asteroid():setPosition(425073, -93831)
        Asteroid():setPosition(453605, -61825)
        Asteroid():setPosition(442939, -78260)
        VisualAsteroid():setPosition(451966, -89031)
        VisualAsteroid():setPosition(473437, -75788)
        VisualAsteroid():setPosition(470793, -53945)
        Asteroid():setPosition(449125, -80796)
        VisualAsteroid():setPosition(453718, -61256)
        VisualAsteroid():setPosition(449849, -89186)
        VisualAsteroid():setPosition(438787, -78047)
        VisualAsteroid():setPosition(451684, -85184)
        Asteroid():setPosition(473081, -55984)
        VisualAsteroid():setPosition(457377, -60667)
        Asteroid():setPosition(430790, -70823)
        VisualAsteroid():setPosition(419738, -90613)
        VisualAsteroid():setPosition(426159, -64976)
        Asteroid():setPosition(448629, -88102)
        Asteroid():setPosition(436946, -63517)
        VisualAsteroid():setPosition(438287, -71135)
        VisualAsteroid():setPosition(444589, -76905)
        Asteroid():setPosition(446452, -89357)
        VisualAsteroid():setPosition(440728, -80606)
        VisualAsteroid():setPosition(421449, -68990)
        Asteroid():setPosition(468206, -72358)
        Asteroid():setPosition(467372, -52812)
        VisualAsteroid():setPosition(436742, -73884)
        Asteroid():setPosition(425511, -92004)
        VisualAsteroid():setPosition(447124, -89866)
        Asteroid():setPosition(431144, -58361)
        VisualAsteroid():setPosition(453581, -60330)
        Asteroid():setPosition(450581, -61263)
        Asteroid():setPosition(451003, -84865)
        VisualAsteroid():setPosition(448249, -84717)
        VisualAsteroid():setPosition(426947, -72477)
        VisualAsteroid():setPosition(451729, -66571)
        Asteroid():setPosition(439403, -84085)
        Asteroid():setPosition(441957, -53023)
        VisualAsteroid():setPosition(451502, -84108)
        VisualAsteroid():setPosition(475304, -72576)
        Asteroid():setPosition(453471, -84525)
        VisualAsteroid():setPosition(464224, -77974)
        Asteroid():setPosition(465170, -52055)
        Asteroid():setPosition(434787, -71650)
        VisualAsteroid():setPosition(441348, -55230)
        Asteroid():setPosition(462953, -75403)
        Asteroid():setPosition(411749, -79460)
        VisualAsteroid():setPosition(468337, -71263)
        VisualAsteroid():setPosition(439218, -65895)
        VisualAsteroid():setPosition(462161, -73292)
        Asteroid():setPosition(419082, -93607)
        VisualAsteroid():setPosition(449925, -64927)
        Asteroid():setPosition(472085, -70284)
        Asteroid():setPosition(437793, -67385)
        VisualAsteroid():setPosition(425370, -81414)
        VisualAsteroid():setPosition(448956, -67338)
        Asteroid():setPosition(435896, -62104)
        VisualAsteroid():setPosition(439574, -80029)
        VisualAsteroid():setPosition(453299, -68494)
        Asteroid():setPosition(442656, -76823)
        VisualAsteroid():setPosition(438015, -72839)
        Asteroid():setPosition(418282, -90978)
        VisualAsteroid():setPosition(445036, -82186)
        Asteroid():setPosition(420492, -74659)
        VisualAsteroid():setPosition(453802, -66068)
        VisualAsteroid():setPosition(421039, -92349)
        Asteroid():setPosition(423960, -61080)
        VisualAsteroid():setPosition(456240, -61646)
        Asteroid():setPosition(464415, -84885)
        Asteroid():setPosition(422541, -68841)
        Asteroid():setPosition(464643, -76073)
        Asteroid():setPosition(464725, -50928)
        VisualAsteroid():setPosition(410472, -81553)
        Asteroid():setPosition(427159, -81425)
        VisualAsteroid():setPosition(475663, -77401)
        VisualAsteroid():setPosition(475142, -70154)
        VisualAsteroid():setPosition(440307, -77456)
        Asteroid():setPosition(422921, -62445)
        Asteroid():setPosition(424647, -93157)
        Asteroid():setPosition(450351, -67539)
        Asteroid():setPosition(468180, -54353)
        VisualAsteroid():setPosition(445799, -81861)
        Asteroid():setPosition(466859, -70119)
        Asteroid():setPosition(462486, -73199)
        VisualAsteroid():setPosition(428711, -73592)
        Asteroid():setPosition(472436, -57809)
        VisualAsteroid():setPosition(429123, -80952)
        VisualAsteroid():setPosition(453059, -66074)
        Asteroid():setPosition(442011, -62076)
        VisualAsteroid():setPosition(440956, -72129)
        Asteroid():setPosition(444824, -72598)
        VisualAsteroid():setPosition(448629, -65667)
        VisualAsteroid():setPosition(420733, -70573)
        Asteroid():setPosition(444576, -73069)
        VisualAsteroid():setPosition(436750, -86173)
        Asteroid():setPosition(462162, -75934)
        Asteroid():setPosition(447720, -77714)
        Asteroid():setPosition(434540, -77927)
        VisualAsteroid():setPosition(421853, -88390)
        VisualAsteroid():setPosition(435605, -80522)
        Asteroid():setPosition(449321, -76349)
        Asteroid():setPosition(454806, -59299)
        VisualAsteroid():setPosition(473119, -57902)
        VisualAsteroid():setPosition(466431, -72591)
        Asteroid():setPosition(470649, -55270)
        VisualAsteroid():setPosition(443020, -69838)
        VisualAsteroid():setPosition(473507, -53435)
        Asteroid():setPosition(442917, -84728)
        VisualAsteroid():setPosition(471965, -58323)
        VisualAsteroid():setPosition(435283, -85117)
        Asteroid():setPosition(466485, -51279)
        VisualAsteroid():setPosition(463312, -75509)
        VisualAsteroid():setPosition(448434, -79799)
        Asteroid():setPosition(471716, -76809)
        VisualAsteroid():setPosition(419897, -78180)
        VisualAsteroid():setPosition(439503, -66832)
        VisualAsteroid():setPosition(410030, -80552)
        VisualAsteroid():setPosition(417134, -94629)
        VisualAsteroid():setPosition(461974, -56561)
        Asteroid():setPosition(434167, -65312)
        VisualAsteroid():setPosition(455076, -61061)
        Asteroid():setPosition(473525, -71122)
        Asteroid():setPosition(431422, -81584)
        Asteroid():setPosition(422294, -68825)
        Asteroid():setPosition(448501, -88633)
        Asteroid():setPosition(455326, -59643)
        Asteroid():setPosition(467254, -76122)
        VisualAsteroid():setPosition(466836, -55997)
        Asteroid():setPosition(462922, -50003)
        VisualAsteroid():setPosition(424540, -62310)
        VisualAsteroid():setPosition(439889, -81688)
        Asteroid():setPosition(472676, -52117)
        VisualAsteroid():setPosition(441992, -77748)
        Asteroid():setPosition(448169, -76758)
        VisualAsteroid():setPosition(463544, -73639)
        VisualAsteroid():setPosition(446767, -68617)
        Asteroid():setPosition(432774, -58838)
        VisualAsteroid():setPosition(424911, -91813)
        Asteroid():setPosition(441423, -69942)
        Asteroid():setPosition(446304, -67965)
        VisualAsteroid():setPosition(452235, -61310)
        VisualAsteroid():setPosition(438767, -81060)
        Asteroid():setPosition(430925, -79973)
        VisualAsteroid():setPosition(434571, -81139)
        Asteroid():setPosition(464440, -48398)
        VisualAsteroid():setPosition(440075, -68133)
        Asteroid():setPosition(445722, -87348)
        VisualAsteroid():setPosition(416836, -94860)
        Asteroid():setPosition(440287, -61490)
        Asteroid():setPosition(438302, -71176)
        Asteroid():setPosition(409149, -79835)
        VisualAsteroid():setPosition(443372, -83332)
        Asteroid():setPosition(437199, -72373)
        Asteroid():setPosition(446951, -83312)
        VisualAsteroid():setPosition(473909, -70328)
        Asteroid():setPosition(447740, -82284)
        VisualAsteroid():setPosition(435473, -78161)
        Asteroid():setPosition(448688, -80047)
        Asteroid():setPosition(444469, -86706)
        Asteroid():setPosition(465406, -86205)
        VisualAsteroid():setPosition(425302, -82942)
        Asteroid():setPosition(437528, -85512)
        Asteroid():setPosition(435666, -60778)
        Asteroid():setPosition(426296, -79122)
        VisualAsteroid():setPosition(451622, -86489)
        Asteroid():setPosition(463127, -57601)
        VisualAsteroid():setPosition(436274, -85874)
        Asteroid():setPosition(440370, -75445)
        Asteroid():setPosition(448462, -87995)
        Asteroid():setPosition(434667, -72572)
        VisualAsteroid():setPosition(445770, -66294)
        Asteroid():setPosition(425362, -67175)
        VisualAsteroid():setPosition(452232, -89299)
        Asteroid():setPosition(471630, -57621)
        Asteroid():setPosition(467673, -55778)
        VisualAsteroid():setPosition(437661, -79069)
        Asteroid():setPosition(469476, -78447)
        VisualAsteroid():setPosition(463259, -71849)
        VisualAsteroid():setPosition(432442, -74919)
        Asteroid():setPosition(448966, -61207)
        VisualAsteroid():setPosition(435585, -76355)
        VisualAsteroid():setPosition(449832, -58979)
        VisualAsteroid():setPosition(441175, -67140)
        VisualAsteroid():setPosition(469423, -70414)
        Asteroid():setPosition(444931, -64558)
        VisualAsteroid():setPosition(464592, -48717)
        Asteroid():setPosition(440139, -78055)
        VisualAsteroid():setPosition(442045, -87853)
        Asteroid():setPosition(466000, -69715)
        Asteroid():setPosition(444464, -77070)
        VisualAsteroid():setPosition(462096, -77627)
        VisualAsteroid():setPosition(441407, -73181)
        VisualAsteroid():setPosition(441588, -78347)
        Asteroid():setPosition(467424, -73305)
        VisualAsteroid():setPosition(438199, -84158)
        Asteroid():setPosition(423690, -68753)
        VisualAsteroid():setPosition(420601, -91798)
        VisualAsteroid():setPosition(431890, -82704)
        VisualAsteroid():setPosition(417386, -91283)
        VisualAsteroid():setPosition(453943, -69228)
        Asteroid():setPosition(453927, -90152)
        VisualAsteroid():setPosition(443363, -63664)
        Asteroid():setPosition(463509, -54559)
        Asteroid():setPosition(437791, -85653)
        Asteroid():setPosition(453112, -69345)
        VisualAsteroid():setPosition(455060, -59675)
        Asteroid():setPosition(440376, -86965)
        VisualAsteroid():setPosition(452494, -59947)
        Asteroid():setPosition(441338, -84920)
        VisualAsteroid():setPosition(434823, -59498)
        Asteroid():setPosition(473592, -54431)
        VisualAsteroid():setPosition(422669, -88367)
        VisualAsteroid():setPosition(447412, -82513)
        VisualAsteroid():setPosition(446704, -66842)
        Asteroid():setPosition(468410, -53046)
        Asteroid():setPosition(464192, -51750)
        VisualAsteroid():setPosition(422265, -74117)
        VisualAsteroid():setPosition(408570, -82125)
        VisualAsteroid():setPosition(436960, -64140)
        Asteroid():setPosition(453283, -68592)
        Asteroid():setPosition(450300, -66857)
        VisualAsteroid():setPosition(434599, -65412)
        VisualAsteroid():setPosition(445140, -77069)
        VisualAsteroid():setPosition(448746, -61966)
        VisualAsteroid():setPosition(474392, -71637)
        Asteroid():setPosition(433537, -61283)
     
    -- mines 
    	
    	Mine():setPosition(413916, -80204)
        Mine():setPosition(422115, -90420)
        Mine():setPosition(429374, -76843)
        Mine():setPosition(424266, -71063)
        Mine():setPosition(449134, -83968)
        Mine():setPosition(468087, -76440)
        Mine():setPosition(450343, -66090)
        Mine():setPosition(435557, -65955)
        Mine():setPosition(469700, -52513)
        Mine():setPosition(388811, -97286)
        Mine():setPosition(386840, -96734)
        Mine():setPosition(384870, -96182)
        Mine():setPosition(397561, -106903)
        Mine():setPosition(394960, -123062)
        Mine():setPosition(385027, -129132)
        Mine():setPosition(376120, -125348)
        Mine():setPosition(372494, -120224)
        Mine():setPosition(373204, -105326)
        Mine():setPosition(370445, -91768)	
end


function update(delta) 
    if Vindh_mission == 0 then
        if Vindh_comms == 0 then
        Station_D31:sendCommsMessage(DIVX, [[Camarade,
Nous avons intercepté des signaux de détresse étranges en provenance de la frontière de Dussel-3. 
Il s’agit d’un de nos vaisseau scientifique, actuellement en reconnaissance auprès des épaves de la région. 
Rendez-vous à la coordonnée D29, et assurez-vous que les vaisseaux ne soient pas endommagés. 
Vous serez près de la bordure, et il y a des charognards dans le coin. Et les Spectres que la fédération ignore encore. 
L’Empire sera bien content si vous en éliminez quelques-uns. Faites attention, vous nous êtes plus utiles en vie.]])

        Station_D31:sendCommsMessage(Korosheg, [[ Camarade,
Nous avons intercepté des signaux de détresse étranges en provenance de la frontière de Dussel-3. 
Il s’agit d’un de nos vaisseau scientifique, actuellement en reconnaissance auprès des épaves de la région. 
Rendez-vous à la coordonnée D29, et assurez-vous que les vaisseaux ne soient pas endommagés. 
Vous serez près de la bordure, et il y a des charognards dans le coin. Et les Spectres que la fédération ignore encore. 
L’Empire sera bien content si vous en éliminez quelques-uns. Faites attention, vous nous êtes plus utiles en vie.]])

        Vindh_comms = 1
        Vindh_mission = 1
        end
    end

    if not Sp_1:isValid() then
        if Vindh_mission == 1 then
            if Vindh_comms == 1 then
                Station_D31:sendCommsMessage(DIVX, [[Camarade,
Nous nous doutions bien qu’il y aurait des problèmes de ce genre dans la région. Ces Spectres semblent dangereux, et il sera pertinent de les purger à vue. 
Ne nous décevez pas là-dessus.
Nous avons découvert quelques échos de présence spectre dans la région, qui devraient se situer un peu plus loin sur la bordure. 
Cela semble plus gros, potentiellement un vaisseau de très grande taille, voire une station. 
Ils devraient se situer autour des cadrans B27. Bon succès, camarades.]])
                
                Station_D31:sendCommsMessage(Korosheg, [[Camarade,
Nous nous doutions bien qu’il y aurait des problèmes de ce genre dans la région. Ces Spectres semblent dangereux, et il sera pertinent de les purger à vue. 
Ne nous décevez pas là-dessus.
Nous avons découvert quelques échos de présence spectre dans la région, qui devraient se situer un peu plus loin sur la bordure. 
Cela semble plus gros, potentiellement un vaisseau de très grande taille, voire une station. 
Ils devraient se situer autour des cadrans B27. Bon succès, camarades.]])

                Vindh_mission = 2
                Vindh_comms = 2
            end
        end
    end

    if not Sp_station:isValid() then
        if Vindh_mission == 2 then 
            if Vindh_comms == 2 then 
        
                    Station_D31:sendCommsMessage(DIVX, [[ Nous avions raison de nous douter de la présence de ces épaves dans le coin. Vous avez bien travaillé, Camarade. 
Si jamais vous en trouvez d’autres dans le coin, assurez-vous de les purger et de nous rapporter des informations sur leur cas. 
Contrairement aux pirates traditionnels, ils ne répondent presque jamais à nos communications et semblent vouloir se battre jusqu’à la mort. 
Pourtant, ils ne répondent qu’à notre arrivée, et ne semblent pas s’intéresser aux autres vaisseaux de la Fédération. 
Nous n’avons jamais réussi, mais en prendre un vaisseau vivant serait inestimable pour l’Empire. 
N’ayez pas trop d’espoir par contre, cela n’a jamais été réussi depuis que nous nous intéressons à eux.

… Attendez. Nous recevons une nouvelle fréquence, un vaisseau-épave semble s’activer non-loin de votre secteur. 
Rendez-vous au cadran ZZ23 et détruisez le, camarade.
L'empire vous tansfert quelques crédits pour cette mission. [CODE : CRD-VD11] ]])
            
                    Station_D31:sendCommsMessage(Korosheg, [[ Nous avions raison de nous douter de la présence de ces épaves dans le coin. Vous avez bien travaillé, Camarade. 
Si jamais vous en trouvez d’autres dans le coin, assurez-vous de les purger et de nous rapporter des informations sur leur cas. 
Contrairement aux pirates traditionnels, ils ne répondent presque jamais à nos communications et semblent vouloir se battre jusqu’à la mort. 
Pourtant, ils ne répondent qu’à notre arrivée, et ne semblent pas s’intéresser aux autres vaisseaux de la Fédération. 
Nous n’avons jamais réussi, mais en prendre un vaisseau vivant serait inestimable pour l’Empire. 
N’ayez pas trop d’espoir par contre, cela n’a jamais été réussi depuis que nous nous intéressons à eux.

… Attendez. Nous recevons une nouvelle fréquence, un vaisseau-épave semble s’activer non-loin de votre secteur. 
Rendez-vous au cadran ZZ23 et détruisez le, camarade. 
L'empire vous tansfert quelques crédits pour cette mission. [CODE : CRD-VD11] ]])
                Vindh_comms = 3
            end
        end
    end

    if not Sp_2:isValid() then
        if Vindh_mission == 2 then 
            if Vindh_comms == 3 then 
                Station_D31:sendCommsMessage(DIVX, [[ Félicitation, Camarade. Nous avons bien fait de vous envoyer dans la région. 
Nous avons détecté la présence d’un trou de ver non loin, vous devez l’avoir remarqué. 
Empruntez-le, et faites nous un rapport sur ce qui se trouve de l’autre côté. 
Nous reprendrons contact avec vous à ce moment.
Merci encore camarade. Nous vous transférons quelques crédits pour votre solde. [CODE : CRD-P87U] ]])
            
                Station_D31:sendCommsMessage(Korosheg, [[ Félicitation, Camarade. Nous avons bien fait de vous envoyer dans la région. 
Nous avons détecté la présence d’un trou de ver non loin, vous devez l’avoir remarqué. 
Empruntez-le, et faites nous un rapport sur ce qui se trouve de l’autre côté. 
Nous reprendrons contact avec vous à ce moment.
Merci encore camarade. Nous vous transférons quelques crédits pour votre solde. [CODE : CRD-P87U] ]])

                Vindh_mission = 3
                Vindh_comms = 4
            end
        end
    end

    if (distance(DIVX, dussel_3) < 100000) then
        if DIVX_comms == 0 then 
                Station_D31:sendCommsMessage(DIVX, [[ Eh bien Camarade, je ne sais vraiment pas où vous êtes rendu. 
L’endroit semble crouler sous les fantômes et les épaves. 
Nous avons vraiment besoin que vous trouviez plus d’informations.

Fouillez l’endroit, vous devriez être capable de trouver une station encore en état de marche. 
Connectez-vous à leur base de donnée et transférez-les nous, nous pourrons savoir de quoi il en retourne.]])
            DIVX_comms = 1
        end
    end

    if (distance(Korosheg, dussel_3) < 100000) then
        if Korosheg_comms == 0 then 
                Station_D31:sendCommsMessage(Korosheg, [[ Eh bien Camarade, je ne sais vraiment pas où vous êtes rendu. 
L’endroit semble crouler sous les fantômes et les épaves. 
Nous avons vraiment besoin que vous trouviez plus d’informations.

Fouillez l’endroit, vous devriez être capable de trouver une station encore en état de marche. 
Connectez-vous à leur base de donnée et transférez-les nous, nous pourrons savoir de quoi il en retourne.]])
            Korosheg_comms = 1
        end
    end

    for _, vindhteam in ipairs(vindhteamList) do
        if vindhteam:isValid() then
            vindhteam:addReputationPoints(delta * 0.1)
        end
    end
end



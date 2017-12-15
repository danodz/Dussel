--Name: Combat final

function init()

nexusvoid = PlayerSpaceship():setFaction("Merillon"):setTemplate("MCorvette"):setCallSign("NV"):setPosition(0,0):setWarpDrive(true)
succubicherubim = PlayerSpaceship():setFaction("Arianne"):setTemplate("ACorvette"):setCallSign("SCHER"):setPosition(0,0);

vasserand = PlayerSpaceship():setFaction("Vindh"):setTemplate("VCorvette"):setCallSign("VSR"):setPosition(0, 0);
-- Batterie d'appoint
vasserand:setEnergyLevelMax(900);
vasserand:setEnergyLevel(900);
-- Propulseur Amélioré V1
vasserand:setImpulseMaxSpeed(87)
vasserand:setRotationMaxSpeed(13)
-- Cargo supplémentaire (+2 mines);
vasserand:setWeaponStorageMax("Mine", 4);
vasserand:setWeaponStorage("Mine", 4);
-- 1 nuke
vasserand:setWeaponStorage("Nuke", 1);

viceimperium = PlayerSpaceship():setFaction("Merillon"):setTemplate("MCorvette"):setCallSign("VID"):setPosition(0,0);


-- batterie d'appoint +100
viceimperium:setEnergyLevelMax(900)
viceimperium:setEnergyLevel(900)

players = { nexusvoid, succubicherubim, vasserand, viceimperium };

boss = CpuShip():setFaction("Loyalistes"):setTemplate("Battlecruiser"):setCallSign("GROSVERNOR"):setPosition(-10419, -49178):orderRoaming()
     
exitStation = SpaceStation():setTemplate("Large Station"):setFaction("Resistance"):setCallSign("ExitStation"):setPosition(-11243, 7934)

SpaceStation():setTemplate("Large Station"):setFaction("Resistance"):setCallSign("DS197"):setPosition(-10144, -12782)
SpaceStation():setTemplate("Large Station"):setFaction("Resistance"):setCallSign("DS196"):setPosition(-33264, -7707)
CpuShip():setFaction("Resistance"):setTemplate("MT52 Hornet"):setCallSign("UTI32"):setPosition(3203, -15073):orderRoaming()
CpuShip():setFaction("Resistance"):setTemplate("Atlantis X23"):setCallSign("CSS35"):setPosition(1528, -12028):orderRoaming():setWeaponStorage("Homing", 0)
CpuShip():setFaction("Resistance"):setTemplate("MT52 Hornet"):setCallSign("UTI25"):setPosition(-147, -9135):orderRoaming()
CpuShip():setFaction("Resistance"):setTemplate("MT52 Hornet"):setCallSign("UTI31"):setPosition(-10348, -15226):orderRoaming()
CpuShip():setFaction("Resistance"):setTemplate("Atlantis X23"):setCallSign("VK34"):setPosition(-11566, -12485):orderRoaming():setWeaponStorage("Homing", 0)
CpuShip():setFaction("Resistance"):setTemplate("MT52 Hornet"):setCallSign("VK26"):setPosition(4725, -9288):orderRoaming()
CpuShip():setFaction("Resistance"):setTemplate("MT52 Hornet"):setCallSign("CV24"):setPosition(-3040, -9135):orderRoaming()
CpuShip():setFaction("Resistance"):setTemplate("MT52 Hornet"):setCallSign("VK23"):setPosition(-9587, -8070):orderRoaming()
CpuShip():setFaction("Resistance"):setTemplate("Atlantis X23"):setCallSign("VK33"):setPosition(-22376, -12485):orderRoaming():setWeaponStorage("Homing", 0)
CpuShip():setFaction("Resistance"):setTemplate("MT52 Hornet"):setCallSign("VK20"):setPosition(-21919, -9288):orderRoaming()
CpuShip():setFaction("Resistance"):setTemplate("MT52 Hornet"):setCallSign("VK30"):setPosition(-16286, -15530):orderRoaming()
CpuShip():setFaction("Resistance"):setTemplate("MT52 Hornet"):setCallSign("VK29"):setPosition(-29380, -15530):orderRoaming()
CpuShip():setFaction("Resistance"):setTemplate("MT52 Hornet"):setCallSign("S28"):setPosition(-29837, -10049):orderRoaming()
CpuShip():setFaction("Resistance"):setTemplate("MT52 Hornet"):setCallSign("S22"):setPosition(-12480, -8070):orderRoaming()
CpuShip():setFaction("Resistance"):setTemplate("MT52 Hornet"):setCallSign("BR21"):setPosition(-16286, -8526):orderRoaming()
CpuShip():setFaction("Resistance"):setTemplate("MT52 Hornet"):setCallSign("CSS27"):setPosition(7618, -9288):orderRoaming()
CpuShip():setFaction("Resistance"):setTemplate("MT52 Hornet"):setCallSign("UTI32"):setPosition(3203, -15073):orderRoaming()
CpuShip():setFaction("Resistance"):setTemplate("Atlantis X23"):setCallSign("CSS35"):setPosition(1528, -12028):orderRoaming():setWeaponStorage("Homing", 0)
CpuShip():setFaction("Resistance"):setTemplate("MT52 Hornet"):setCallSign("UTI25"):setPosition(-147, -9135):orderRoaming()
CpuShip():setFaction("Resistance"):setTemplate("MT52 Hornet"):setCallSign("UTI31"):setPosition(-10348, -15226):orderRoaming()
CpuShip():setFaction("Resistance"):setTemplate("Atlantis X23"):setCallSign("VK34"):setPosition(-11566, -12485):orderRoaming():setWeaponStorage("Homing", 0)
CpuShip():setFaction("Resistance"):setTemplate("MT52 Hornet"):setCallSign("VK26"):setPosition(4725, -9288):orderRoaming()
CpuShip():setFaction("Resistance"):setTemplate("MT52 Hornet"):setCallSign("CV24"):setPosition(-3040, -9135):orderRoaming()
CpuShip():setFaction("Resistance"):setTemplate("MT52 Hornet"):setCallSign("VK23"):setPosition(-9587, -8070):orderRoaming()
CpuShip():setFaction("Resistance"):setTemplate("Atlantis X23"):setCallSign("VK33"):setPosition(-22376, -12485):orderRoaming():setWeaponStorage("Homing", 0)
CpuShip():setFaction("Resistance"):setTemplate("MT52 Hornet"):setCallSign("VK20"):setPosition(-21919, -9288):orderRoaming()
CpuShip():setFaction("Resistance"):setTemplate("MT52 Hornet"):setCallSign("VK30"):setPosition(-16286, -15530):orderRoaming()
CpuShip():setFaction("Resistance"):setTemplate("MT52 Hornet"):setCallSign("VK29"):setPosition(-29380, -15530):orderRoaming()
CpuShip():setFaction("Resistance"):setTemplate("MT52 Hornet"):setCallSign("S28"):setPosition(-29837, -10049):orderRoaming()
CpuShip():setFaction("Resistance"):setTemplate("MT52 Hornet"):setCallSign("S22"):setPosition(-12480, -8070):orderRoaming()
CpuShip():setFaction("Resistance"):setTemplate("MT52 Hornet"):setCallSign("BR21"):setPosition(-16286, -8526):orderRoaming()
CpuShip():setFaction("Resistance"):setTemplate("MT52 Hornet"):setCallSign("CSS27"):setPosition(7618, -9288):orderRoaming()

CpuShip():setFaction("Loyalistes"):setTemplate("MT52 Hornet"):setCallSign("VS16"):setPosition(-3953, -42632):orderRoaming()
CpuShip():setFaction("Loyalistes"):setTemplate("MT52 Hornet"):setCallSign("CCN14"):setPosition(-9891, -44915):orderRoaming()
CpuShip():setFaction("Loyalistes"):setTemplate("Piranha"):setCallSign("S4"):setPosition(-10896, -45677):orderRoaming():setWeaponStorage("Homing", 8):setWeaponStorage("Nuke", 4)
CpuShip():setFaction("Loyalistes"):setTemplate("MT52 Hornet"):setCallSign("UTI13"):setPosition(-15220, -47504):orderRoaming()
CpuShip():setFaction("Loyalistes"):setTemplate("MT52 Hornet"):setCallSign("BR12"):setPosition(-15220, -47961):orderRoaming()
CpuShip():setFaction("Loyalistes"):setTemplate("MT52 Hornet"):setCallSign("CSS15"):setPosition(-5476, -47047):orderRoaming()
CpuShip():setFaction("Loyalistes"):setTemplate("MT52 Hornet"):setCallSign("VS17"):setPosition(-1822, -50397):orderRoaming()
CpuShip():setFaction("Loyalistes"):setTemplate("Phobos T3"):setCallSign("UTI3"):setPosition(-2813, -48496):orderRoaming():setWeaponStorage("Homing", 4)
CpuShip():setFaction("Loyalistes"):setTemplate("MT52 Hornet"):setCallSign("S19"):setPosition(-6998, -55878):orderRoaming()
CpuShip():setFaction("Loyalistes"):setTemplate("MT52 Hornet"):setCallSign("NC18"):setPosition(-6998, -52376):orderRoaming()
CpuShip():setFaction("Loyalistes"):setTemplate("MT52 Hornet"):setCallSign("CCN9"):setPosition(-7912, -51462):orderRoaming()
CpuShip():setFaction("Loyalistes"):setTemplate("MT52 Hornet"):setCallSign("CCN11"):setPosition(-13393, -52528):orderRoaming()
CpuShip():setFaction("Loyalistes"):setTemplate("MT52 Hornet"):setCallSign("NC10"):setPosition(-11262, -52528):orderRoaming()
CpuShip():setFaction("Loyalistes"):setTemplate("MT52 Hornet"):setCallSign("CCN6"):setPosition(-15981, -49635):orderRoaming()
CpuShip():setFaction("Loyalistes"):setTemplate("Atlantis X23"):setCallSign("CCN2"):setPosition(-15983, -49615):orderRoaming():setWeaponStorage("Homing", 0)
CpuShip():setFaction("Loyalistes"):setTemplate("MT52 Hornet"):setCallSign("UTI8"):setPosition(-4258, -49940):orderRoaming()
CpuShip():setFaction("Loyalistes"):setTemplate("MT52 Hornet"):setCallSign("SS7"):setPosition(-4258, -49026):orderRoaming()
CpuShip():setFaction("Loyalistes"):setTemplate("Phobos M3"):setCallSign("CCN5"):setPosition(-11084, -54887):orderRoaming():setWeaponStorage("Homing", 4)
CpuShip():setFaction("Loyalistes"):setTemplate("MT52 Hornet"):setCallSign("VS16"):setPosition(-3953, -42632):orderRoaming()
CpuShip():setFaction("Loyalistes"):setTemplate("MT52 Hornet"):setCallSign("CCN14"):setPosition(-9891, -44915):orderRoaming()
CpuShip():setFaction("Loyalistes"):setTemplate("Piranha"):setCallSign("S4"):setPosition(-10896, -45677):orderRoaming():setWeaponStorage("Homing", 8):setWeaponStorage("Nuke", 4)
CpuShip():setFaction("Loyalistes"):setTemplate("MT52 Hornet"):setCallSign("UTI13"):setPosition(-15220, -47504):orderRoaming()
CpuShip():setFaction("Loyalistes"):setTemplate("MT52 Hornet"):setCallSign("BR12"):setPosition(-15220, -47961):orderRoaming()
CpuShip():setFaction("Loyalistes"):setTemplate("MT52 Hornet"):setCallSign("CSS15"):setPosition(-5476, -47047):orderRoaming()
CpuShip():setFaction("Loyalistes"):setTemplate("MT52 Hornet"):setCallSign("VS17"):setPosition(-1822, -50397):orderRoaming()
CpuShip():setFaction("Loyalistes"):setTemplate("Phobos T3"):setCallSign("UTI3"):setPosition(-2813, -48496):orderRoaming():setWeaponStorage("Homing", 4)
CpuShip():setFaction("Loyalistes"):setTemplate("MT52 Hornet"):setCallSign("S19"):setPosition(-6998, -55878):orderRoaming()
CpuShip():setFaction("Loyalistes"):setTemplate("MT52 Hornet"):setCallSign("NC18"):setPosition(-6998, -52376):orderRoaming()
CpuShip():setFaction("Loyalistes"):setTemplate("MT52 Hornet"):setCallSign("CCN9"):setPosition(-7912, -51462):orderRoaming()
CpuShip():setFaction("Loyalistes"):setTemplate("MT52 Hornet"):setCallSign("CCN11"):setPosition(-13393, -52528):orderRoaming()
CpuShip():setFaction("Loyalistes"):setTemplate("MT52 Hornet"):setCallSign("NC10"):setPosition(-11262, -52528):orderRoaming()
CpuShip():setFaction("Loyalistes"):setTemplate("MT52 Hornet"):setCallSign("CCN6"):setPosition(-15981, -49635):orderRoaming()
CpuShip():setFaction("Loyalistes"):setTemplate("Atlantis X23"):setCallSign("CCN2"):setPosition(-15983, -49615):orderRoaming():setWeaponStorage("Homing", 0)
CpuShip():setFaction("Loyalistes"):setTemplate("MT52 Hornet"):setCallSign("UTI8"):setPosition(-4258, -49940):orderRoaming()
CpuShip():setFaction("Loyalistes"):setTemplate("MT52 Hornet"):setCallSign("SS7"):setPosition(-4258, -49026):orderRoaming()
CpuShip():setFaction("Loyalistes"):setTemplate("Phobos M3"):setCallSign("CCN5"):setPosition(-11084, -54887):orderRoaming():setWeaponStorage("Homing", 4)



-- map


 Nebula():setPosition(-36292, -42515)
    Nebula():setPosition(-26589, -51442)
    Nebula():setPosition(-20573, -46202)
    Nebula():setPosition(-6989, -64832)
    Nebula():setPosition(7759, -49307)
    Nebula():setPosition(18045, -41739)
    Nebula():setPosition(29300, -40186)
    Nebula():setPosition(42884, -39992)
    Nebula():setPosition(-52205, -39798)
    Nebula():setPosition(-46965, -13212)
    Nebula():setPosition(-57251, -210)
    Nebula():setPosition(-39203, 2701)
    Nebula():setPosition(-77433, -24273)
    Nebula():setPosition(-24260, -16)
    Nebula():setPosition(-9318, 14539)
    Nebula():setPosition(34734, 14927)
    Nebula():setPosition(16298, -3509)
    Nebula():setPosition(27942, -9525)
    Nebula():setPosition(35898, -11077)
    Nebula():setPosition(56274, -15346)
    Nebula():setPosition(56857, -23885)
    Nebula():setPosition(31823, -26796)
    Nebula():setPosition(-68700, -60368)
    Nebula():setPosition(-93928, -51247)
    Nebula():setPosition(-42502, -64249)
    Nebula():setPosition(-76851, -43679)
    Nebula():setPosition(16686, -81327)
    Nebula():setPosition(68306, -55711)
    Nebula():setPosition(27553, -58040)
    Nebula():setPosition(82861, -24079)
    Asteroid():setPosition(-31790, -29194)
    Asteroid():setPosition(-28607, -26903)
    Asteroid():setPosition(-27206, -30977)
    Asteroid():setPosition(-23896, -26011)
    Asteroid():setPosition(-22750, -26648)
    Asteroid():setPosition(-20840, -28812)
    Asteroid():setPosition(-25678, -29449)
    Asteroid():setPosition(-21221, -30519)
    Asteroid():setPosition(-18460, -26459)
    Asteroid():setPosition(-16240, -33333)
    Asteroid():setPosition(-14292, -30248)
    Asteroid():setPosition(-12722, -30086)
    Asteroid():setPosition(-10936, -31385)
    Asteroid():setPosition(-15699, -29382)
    Asteroid():setPosition(-10394, -27920)
    Asteroid():setPosition(-4602, -28624)
    Asteroid():setPosition(-13155, -27866)
    Asteroid():setPosition(-12451, -34254)
    Asteroid():setPosition(-5631, -31872)
    Asteroid():setPosition(-5414, -30573)
    Asteroid():setPosition(-6930, -28570)
    Asteroid():setPosition(-5306, -26838)
    Asteroid():setPosition(-2599, -27758)
    Asteroid():setPosition(-217, -29923)
    Asteroid():setPosition(-9312, -32900)
    Asteroid():setPosition(-7850, -29165)
    Asteroid():setPosition(-4115, -33929)
    Asteroid():setPosition(-1571, -33063)
    Asteroid():setPosition(1677, -29707)
    Asteroid():setPosition(5304, -31168)
    Asteroid():setPosition(5520, -25105)
    Asteroid():setPosition(1894, -26513)
    Asteroid():setPosition(-272, -29652)
    Asteroid():setPosition(-2329, -30031)
    Asteroid():setPosition(2976, -32576)
    Asteroid():setPosition(4059, -31818)
    Asteroid():setPosition(8173, -28029)
    Asteroid():setPosition(12449, -28949)
    Asteroid():setPosition(12233, -31655)
    Asteroid():setPosition(7902, -28678)
    Asteroid():setPosition(5899, -27758)
    Asteroid():setPosition(3734, -29274)
    Asteroid():setPosition(7144, -31980)
    Asteroid():setPosition(8606, -32900)
    Asteroid():setPosition(10122, -26459)
    Asteroid():setPosition(10988, -25105)
    Asteroid():setPosition(10609, -29923)
    Asteroid():setPosition(8877, -31006)
    Asteroid():setPosition(6062, -29977)
    Asteroid():setPosition(9418, -26784)
    Asteroid():setPosition(6657, -24456)
    Asteroid():setPosition(8985, -25484)
    Asteroid():setPosition(12774, -27541)
    Asteroid():setPosition(13694, -28299)
    Asteroid():setPosition(-13967, -29057)
    Asteroid():setPosition(-20787, -30789)
    Asteroid():setPosition(-20084, -31006)
    Asteroid():setPosition(-19272, -28732)
    Asteroid():setPosition(-20571, -25701)
    Asteroid():setPosition(-21491, -26784)
    Asteroid():setPosition(-23007, -28841)
    Asteroid():setPosition(-26309, -26405)
    Asteroid():setPosition(-28420, -27650)
    Asteroid():setPosition(-30152, -30356)
    Asteroid():setPosition(-26255, -33658)
    Asteroid():setPosition(-24306, -34957)
    Asteroid():setPosition(-25335, -27541)
    Asteroid():setPosition(-24793, -26567)
    Asteroid():setPosition(-16511, -32034)
    Asteroid():setPosition(-13967, -32521)
    Asteroid():setPosition(-15807, -27162)
    Asteroid():setPosition(-17756, -26026)
    Asteroid():setPosition(-19109, -25214)
    Asteroid():setPosition(-21437, -24239)
    Asteroid():setPosition(-17377, -30302)
    Asteroid():setPosition(-17377, -30356)
    Asteroid():setPosition(-33346, -28191)
    Asteroid():setPosition(-37622, -28732)
    Asteroid():setPosition(-39355, -31601)
    Asteroid():setPosition(-35295, -27217)
    Asteroid():setPosition(-34645, -27650)
    Asteroid():setPosition(-34483, -31006)
    Asteroid():setPosition(-37785, -28732)
    Asteroid():setPosition(-41953, -25863)
    Asteroid():setPosition(-46392, -28678)
    Asteroid():setPosition(-45580, -29977)
    Asteroid():setPosition(-39950, -27433)
    Asteroid():setPosition(-38488, -25376)
    Asteroid():setPosition(-41033, -29923)
    Asteroid():setPosition(-41466, -29707)
    Asteroid():setPosition(-35674, -30898)
    Asteroid():setPosition(-34050, -28245)
    Asteroid():setPosition(-31181, -25972)
    Asteroid():setPosition(-28366, -26405)
    Asteroid():setPosition(-27500, -28732)
    Asteroid():setPosition(-29394, -28299)
    Asteroid():setPosition(-29990, -28029)
    Asteroid():setPosition(-30098, -32900)
    Asteroid():setPosition(-27337, -31710)
    Asteroid():setPosition(-27500, -29869)
    Asteroid():setPosition(-27446, -29761)
    Asteroid():setPosition(-24956, -31276)
    Asteroid():setPosition(-24360, -30843)
    Asteroid():setPosition(18133, -32576)
    Asteroid():setPosition(18296, -30410)
    Asteroid():setPosition(16996, -29707)
    Asteroid():setPosition(13586, -27758)
    Asteroid():setPosition(14939, -25376)
    Asteroid():setPosition(17917, -26242)
    Asteroid():setPosition(18620, -27271)
    Asteroid():setPosition(16076, -29815)
    Asteroid():setPosition(14506, -31601)
    Asteroid():setPosition(14723, -28353)
    Asteroid():setPosition(15860, -27704)
    Asteroid():setPosition(17862, -28353)
    Asteroid():setPosition(20353, -28895)
    Asteroid():setPosition(22843, -26188)
    Asteroid():setPosition(23763, -25972)
    Asteroid():setPosition(21219, -26459)
    Asteroid():setPosition(22031, -28245)
    Asteroid():setPosition(22843, -29003)
    Asteroid():setPosition(15372, -30519)
    Asteroid():setPosition(12612, -29869)
    Asteroid():setPosition(12558, -29869)
    Asteroid():setPosition(1057, -26173)
    Asteroid():setPosition(5471, -29908)
    Asteroid():setPosition(-5055, -28324)
    Asteroid():setPosition(-8563, -27418)
    Asteroid():setPosition(-13430, -26626)
    Asteroid():setPosition(-9582, -25494)
    Asteroid():setPosition(11017, -22665)
    Asteroid():setPosition(18487, -22099)
    Asteroid():setPosition(26750, -30361)
    Asteroid():setPosition(23128, -31267)
    Asteroid():setPosition(24146, -30248)
    Asteroid():setPosition(29353, -27645)
    Asteroid():setPosition(34672, -25381)
    Asteroid():setPosition(35578, -23910)
    Mine():setPosition(-29569, -30072)
    Mine():setPosition(-24958, -28335)
    Mine():setPosition(-19745, -30206)
    Mine():setPosition(-11257, -26998)
    Mine():setPosition(-4373, -30607)
    Mine():setPosition(4048, -28268)
    Mine():setPosition(-2368, -27399)
    Mine():setPosition(8459, -29605)
    Mine():setPosition(13070, -26397)
    Mine():setPosition(18217, -27065)
    Mine():setPosition(22160, -27065)
    Mine():setPosition(-34715, -27332)
    Mine():setPosition(-11623, 4555)
    Mine():setPosition(-15526, 7361)
    Mine():setPosition(-7370, 7274)
    Mine():setPosition(-10878, 10826)
    BlackHole():setPosition(-36888, -53273)
    WormHole():setPosition(13357, -56803):setTargetPosition(-4811, 10833)

end

broken = false;
carryingArtefact = false;
artefactInPlay = true;
function update()
    if artefactInPlay then
        if not broken then
            if boss:getSystemHealth("reactor") < 0 and boss:getSystemHealth("maneuver") < 0 and boss:getSystemHealth("impulse") < 0 and boss:getSystemHealth("jumpdrive") < 0 then
                local x,y = boss:getPosition();
                toDock = SpaceStation():setFaction("Épave"):setTemplate("Small Station"):setCallSign("Relique"):setPosition(x, y);
                broken = true;
            end
        else
            for i,player in pairs(players) do
                if not carryingArtefact then
                    if player:isDocked(toDock) then
                        toDock:setFaction(player:getFaction());
                        player.hasArtefact = true;
                        carryingArtefact = true;
                    end
                else
                    if player.hasArtefact and player:isDocked(exitStation) then
                        print(player:getCallSign());
                        artefactInPlay = false;
                    end
                end
            end
        end
    end
end




   

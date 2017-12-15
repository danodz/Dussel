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

boss = CpuShip():setFaction("Loyalistes"):setTemplate("Battlecruiser"):setCallSign("BR1"):setPosition(-10419, -49178):orderRoaming()
     
exitStation = SpaceStation():setTemplate("Large Station"):setFaction("Resistance"):setCallSign("Export"):setPosition(50082, -4323)

SpaceStation():setTemplate("Large Station"):setFaction("Resistance"):setCallSign("DS198"):setPosition(5082, -4323)
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
end

broken = false;
carryingArtefact = false;
artefactInPlay = true;
function update()
    if artefactInPlay then
        if not broken then
            if boss:getSystemHealth("reactor") < 0 and boss:getSystemHealth("maneuver") < 0 and boss:getSystemHealth("impulse") < 0 and boss:getSystemHealth("jumpdrive") < 0 then
                local x,y = boss:getPosition();
                toDock = SpaceStation():setFaction("Épave"):setTemplate("Small Station"):setCallSign(""):setPosition(x, y);
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

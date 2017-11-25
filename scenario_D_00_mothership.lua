-- Name: Mothership
-- Description: You are surrounded by astroids, enemies and mines.
-- Type: Basic

function setCirclePos(obj, angle, distance)
	obj:setPosition(math.sin(angle / 180 * math.pi) * distance, -math.cos(angle / 180 * math.pi) * distance)
end

function init()
    SpaceStation():setTemplate("Small Station"):setFaction("Dussel"):setPosition(0, -500):setRotation(random(0, 360))
    
    for n=1,5 do
        ship = CpuShip():setFaction("Loyalistes"):setTemplate("Phobos T3"):orderRoaming()
		setCirclePos(ship, random(0, 360), random(7000, 10000))
	end
    for n=1,2 do
        ship = CpuShip():setFaction("Loyalistes"):setTemplate("Piranha F12"):orderRoaming()
		setCirclePos(ship, random(0, 360), random(7000, 10000))
	end
	
	a = random(0, 360)
	d = 9000
	ship = CpuShip():setFaction("Loyalistes"):setTemplate("Atlantis X23"):setRotation(a + 180):orderRoaming()
	setCirclePos(ship, a, d)

    wingman = CpuShip():setFaction("Loyalistes"):setTemplate("MT52 Hornet"):setRotation(a + 180)
	setCirclePos(wingman, a - 5, d + 100)
	wingman:orderFlyFormation(ship, 500, 100)

    wingman = CpuShip():setFaction("Loyalistes"):setTemplate("MT52 Hornet"):setRotation(a + 180)
	setCirclePos(wingman, a + 5, d + 100)
	wingman:orderFlyFormation(ship, -500, 100)

    wingman = CpuShip():setFaction("Loyalistes"):setTemplate("MT52 Hornet"):setRotation(a + 180)
	setCirclePos(wingman, a + random(-5, 5), d - 500)
	wingman:orderFlyFormation(ship, 0, 600)
	
	
    for n=1,10 do
        setCirclePos(Mine(), random(0, 360), random(10000, 20000))
    end
    
    for n=1, 300 do
        setCirclePos(Asteroid(), random(0, 360), random(10000, 20000))
    end

   
    localPlayers = {};
 	mothership = PlayerSpaceship():setTemplate("Cuirasse"):setFaction("Resistance"):setCallSign("Mother"):setPosition(0, 0);

 	for i=1,12,1 do
        table.insert(localPlayers, mkPlayer("Resistance", 0, 0));
    end

end


function mkPlayer(faction, x, y)
    return PlayerSpaceship():setTemplate("Chasseur"):setFaction(faction):setCallSign(irandom(2,3) .. irandom(10,999)):setPosition(x, y):setScanned(false):setScannedByFaction(faction,true);
end

function update(delta)
	local lx,ly = mothership:getPosition();
     
    for i,ship in pairs(localPlayers) do
        if not ship:isValid() then
            localPlayers[i] = mkPlayer("Resistance", lx,ly);
        end
    end
end




-- Name: Empty planet
-- Description: Empty scenario, no enemies, no friendlies. Can be used by a GM player to setup a scenario in the GM screen. The F5 key can be used to copy the current layout to the clipboard for use in scenario scripts.
-- Type: Basic

require("utils.lua")
-- For this scenario, utils.lua provides:
--   vectorFromAngle(angle, length)
--      Returns a relative vector (x, y coordinates)
--   setCirclePos(obj, x, y, angle, distance)
--      Returns the object with its position set to the resulting coordinates.

function init()
	--SpaceStation():setPosition(1000, 1000):setTemplate('Small Station'):setFaction("Human Navy"):setRotation(random(0, 360))
	--SpaceStation():setPosition(-1000, 1000):setTemplate('Medium Station'):setFaction("Human Navy"):setRotation(random(0, 360))
	--SpaceStation():setPosition(1000, -1000):setTemplate('Large Station'):setFaction("Human Navy"):setRotation(random(0, 360))
	--SpaceStation():setPosition(-1000, -1000):setTemplate('Huge Station'):setFaction("Human Navy"):setRotation(random(0, 360))
	--player1 = PlayerSpaceship():setFaction("Human Navy"):setTemplate("Atlantis"):setRotation(200)
    --player2 = PlayerSpaceship():setFaction("Human Navy"):setTemplate("Atlantis"):setRotation(0)
	--Nebula():setPosition(-5000, 0)
    --Artifact():setPosition(1000, 9000):setModel("small_frigate_1"):setDescription("An old space derelict.")
    --Artifact():setPosition(9000, 2000):setModel("small_frigate_1"):setDescription("A wrecked ship.")
    --Artifact():setPosition(3000, 4000):setModel("small_frigate_1"):setDescription("Tons of rotting plasteel.")
    --addGMFunction("move 1 to 2", function() player1:transferPlayersToShip(player2) end)
    --addGMFunction("move 2 to 1", function() player2:transferPlayersToShip(player1) end)
    --CpuShip():setTemplate("Adder MK5"):setPosition(0, 0):setRotation(0):setFaction("Human Navy")
    --CpuShip():setTemplate("Piranha F12"):setPosition(2000, 0):setRotation(-90):setFaction("Kraylor")
    
    
    planet1 = Planet():setPosition(5000, 149600):setCallSign("P1"):setPlanetRadius(637):setDistanceFromMovementPlane(-3000):setPlanetSurfaceTexture("planets/planet-1.png"):setPlanetCloudTexture("planets/clouds-1.png"):setPlanetAtmosphereTexture("planets/atmosphere.png"):setAxialRotationTime(-240.0):setPlanetAtmosphereColor(0.2,0.1,0.0)
    planet2 = Planet():setPosition(5000, 200000):setCallSign("P2"):setPlanetRadius(1000):setDistanceFromMovementPlane(-5000):setPlanetSurfaceTexture("planets/planet-2.png"):setPlanetCloudTexture("planets/clouds-1.png"):setPlanetAtmosphereTexture("planets/atmosphere.png"):setAxialRotationTime(-240.0):setPlanetAtmosphereColor(0.2,0.1,0.0)
    planet3 = Planet():setPosition(5000, 250000):setCallSign("P3"):setPlanetRadius(2000):setDistanceFromMovementPlane(-1000):setPlanetSurfaceTexture("planets/gas-1.png"):setPlanetCloudTexture("planets/clouds-1.png"):setPlanetAtmosphereTexture("planets/atmosphere.png"):setAxialRotationTime(-240.0):setPlanetAtmosphereColor(0.2,0.1,0.0)
    planet4 = Planet():setPosition(5000, 300000):setCallSign("P4"):setPlanetRadius(500):setDistanceFromMovementPlane(-2000):setPlanetSurfaceTexture("planets/moon-1.png"):setPlanetCloudTexture("planets/clouds-1.png"):setPlanetAtmosphereTexture("planets/atmosphere.png"):setAxialRotationTime(-240.0):setPlanetAtmosphereColor(0.2,0.1,0.0)
    planet5 = Planet():setPosition(5000, 10000):setCallSign("P5"):setPlanetRadius(350):setDistanceFromMovementPlane(-4000):setPlanetSurfaceTexture("planets/planet-1.png"):setPlanetCloudTexture("planets/clouds-1.png"):setPlanetAtmosphereTexture("planets/atmosphere.png"):setAxialRotationTime(-240.0):setPlanetAtmosphereColor(0.2,0.1,0.0)

    moon1 = Planet():setPosition(5000, 160000):setCallSign("Moon1"):setPlanetRadius(170):setDistanceFromMovementPlane(-2800):setPlanetSurfaceTexture("planets/moon-1.png")
    sun1 = Planet():setPosition(5000, 0):setCallSign("Sun"):setPlanetRadius(10000):setDistanceFromMovementPlane(-20000):setPlanetSurfaceTexture("planets/planet-2.png"):setPlanetAtmosphereTexture("planets/star-1.png"):setAxialRotationTime(-240.0):setPlanetAtmosphereColor(1.0,1.0,0.4)
    
    center = Planet():setPosition(0,0):setPlanetRadius(5)

    sun1:setOrbit(center, 30)    
    planet1:setOrbit(sun1, 3650)
    moon1:setOrbit(planet1, 200)
    planet2:setOrbit(sun1, 400)
    planet3:setOrbit(sun1, 300)
    planet4:setOrbit(sun1, 200)
    planet5:setOrbit(sun1, 1000)

    CpuShip():setTemplate("Adder MK5"):setPosition(5000, 4500):setRotation(0):setFaction("Human Navy"):orderDefendTarget(planet5)
    
    
    local x, y = sun1:getPosition()
    for n=1, 100 do
        local xx, yy = vectorFromAngle(random(0, 360), random(20000, 25000))
        Asteroid():setPosition(x + xx, y + yy)
    end


    addGMFunction("Random asteroid field", function()
        --cleanup()
        for n=1,1000 do
			Asteroid():setPosition(random(-50000, 50000), random(-50000, 50000)):setSize(random(100, 500))
			VisualAsteroid():setPosition(random(-50000, 50000), random(-50000, 50000)):setSize(random(100, 500))
        end
    end)
    addGMFunction("Random nebula field", function()
        --cleanup()
        for n=1,50 do
			Nebula():setPosition(random(-50000, 50000), random(-50000, 50000))
        end
    end)
    addGMFunction("Delete unselected", function()
        local gm_selection = getGMSelection()
        for _, obj in ipairs(getAllObjects()) do
            local found = false
            for _, obj2 in ipairs(gm_selection) do
                if obj == obj2 then
                    found = true
                end
            end
            if not found then
                obj:destroy()
            end
        end
    end)
end

function cleanup()
    --Clean up the current play field. Find all objects and destroy everything that is not a player.
    -- If it is a player, position him in the center of the scenario.
    for _, obj in ipairs(getAllObjects()) do
        if obj.typeName == "PlayerSpaceship" then
            obj:setPosition(random(-100, 100), random(-100, 100))
        else
            obj:destroy()
        end
    end
end

function update(delta)
	--No victory condition
end

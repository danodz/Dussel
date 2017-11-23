
-- Name: Random System
-- Description: randomly generated star system
-- Type: Basic


require("utils.lua")


function init()

	function randomStar()
		for cnt=1,3 do
			Star = Planet():setPlanetSurfaceTexture("planets/star_" .. cnt .. ".png")
			Star:setPlanetCloudTexture("planets/clouds_" .. cnt .. ".png")
			Star:setPlanetAtmosphereTexture("planets/atmosphere.png")
			Star:setPlanetAtmosphereColor(1.0,1.0,0.6)
			Star:setCallSign("Star type" .. cnt)
			Star:setPlanetRadius(random(2000,7000))
			Star:setDistanceFromMovementPlane(random(-5000,-15000))
			Star:setAxialRotationTime(random(10,150))
		end
	end

	function randomStarSystem()
		
		n = random(0, 100)

		randomStar()

		-- binary system
		if n < 10 then do
			Center = Planet():setPosition(0,0):setPlanetRadius(0)
			s = random(1,10)
			Star:setPosition(1000 * s, 1000 * s)
			Star:setPosition(random(-1000 * s, -1000 * s))
			Star:setOrbit(center,(random(10,100)))
			end
		end


		-- black hole system
		if n < 30 then do
			center = blackhole():setPosition(random(5000,10000),random(5000,10000))
			local x, y = center:getPosition()

		    for n=1, random(1, 5) do
		        local xx, yy = vectorFromAngle(random(0, 360), random(15000, 45000))
		        Star:setPosition(x + xx, y + yy)
		        Star:setOrbit(center,(random(100,1000)))
	    		end
			end
		end	
		
		-- Stellar system
		if n >= 30 then do 
			center = Star:setPosition(random(1000,10000),random(1000,10000))
			end
		end
	end

	function randomPlanet()
		for cnt=1,10 do
			Planet = Planet():setPlanetSurfaceTexture("planets/planet_" .. cnt .. ".png")
			Planet:setPlanetCloudTexture("planets/clouds_" .. (random(1,3)) .. ".png")
			Planet:setPlanetAtmosphereTexture("planets/atmosphere.png")
			Planet:setPlanetAtmosphereColor(0.6,1.0,1.0)
			Planet:setCallSign("Planet type" .. cnt)
			Planet:setPlanetRadius(random(500,2000))
			Planet:setDistanceFromMovementPlane(random(-2000,-5000))
			Planet:setAxialRotationTime(random(10,300))
		end
	end


	--	for _, star do 
	--		local x, y = star:getPosition()
	--		for n=1, random(1, 6) do
	--			local xx, yy = vectorFromAngle(random(0, 360), random(5000, 30000))
	--	        Planet:setPosition(x + xx, y + yy)
	--	        Planet:setOrbit(Star,(random(100,500) * n)
	--	    end
	--	end	
	--end

	function AsteroidBelt()
		
		local x, y = center:getPosition()
		for n=0, random(0,3) do 
			for a=1, random(75,225) do
	        	local xx, yy = vectorFromAngle(random(0, 360), random(20000, 25000)*a)
	        	Asteroid():setPosition(x + xx, y + yy)
	    	end
	    end
	end
end
-- function nebulaeField()
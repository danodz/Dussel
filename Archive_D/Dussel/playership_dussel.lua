    
	-- Name: playership dussel
	-- comprend les vaisseaux joueurs modifiés

    -- Create the main ships for the players.
	
function init_ships()
	
    -- Vindh    
   DIVX = PlayerSpaceship():setFaction("Vindh"):setTemplate("Artheurge")
   DIVX:setTypeName("Camarade DIVX"):setCallSign("DIVX")
   DIVX:setHull(10)
   A = DIVX:getShieldMax(1) 
   B = DIVX:getShieldMax(2) 
   DIVX:setShieldsMax(A+10, B+10)
   DIVX:setBeamWeapon(0,10, 0, 2000, 6.0, 8)
   --DIVX:addCustomButton("engineering", "BatteryLow","Battery", function() 
   --end)
   
--[[ DIVX:addCustomButton("engineering", "REFINE_DILITHUIM", "refine dilithuim", function()
		if DIVX.minerai["Dilithuim"] == 0 then
			DIVX:addToShipLog("Yttrium not available","red")
		end
		
		if DIVX.minerai["Dilithuim"] > 0 then
			DIVX.minerai["Dilithuim"] = DIVX.minerai["Dilithuim"] - 1
			DIVX.update_stock = 1
			DIVX:setEnergyLevel(DIVX:getEnergyLevel()+200)
		end
		a = 12
	end)]]
   
   
   
   Korosheg = PlayerSpaceship():setFaction("Vindh"):setTemplate("Artheurge"):setCallSign("KoroG")
   Korosheg:setTypeName("Korosheg"):setCallSign("KoroG")

    -- Arianne
   CigogneIV = PlayerSpaceship():setFaction("Arianne"):setTemplate("Marchand"):setCallSign("CigIV")
   CigogneIV:setTypeName("CigogneIV"):setCallSign("CigIV")
   
   
   GuerrillaRadio = PlayerSpaceship():setFaction("Arianne"):setTemplate("Camelot")
   GuerrillaRadio:setTypeName("GuerrillaRadio"):setCallSign("TGR")
	
   ToisondOr = PlayerSpaceship():setFaction("Arianne"):setTemplate("Marchand"):setCallSign("LTO")
   ToisondOr:setTypeName("LaToisondOr"):setCallSign("LTO")


    -- Merillon
   Excommunicateur = PlayerSpaceship():setFaction("Merillon"):setTemplate("Celesien"):setCallSign("FEE")
   Excommunicateur:setTypeName("Excommunicateur"):setCallSign("FEE")

   NexusVoid = PlayerSpaceship():setFaction("Merillon"):setTemplate("Celesien"):setCallSign("NV")
   NexusVoid:setTypeName("NexusVoid"):setCallSign("NV")


end




-- LFusion_1 
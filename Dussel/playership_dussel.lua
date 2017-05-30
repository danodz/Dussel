    
	-- Name: playership dussel
	-- comprend les vaisseaux joueurs modifiés

    -- Create the main ships for the players.
	
    -- Vindh    
   DIVX = PlayerSpaceship():setFaction("Vindh"):setTemplate("Artheurge")
   DIVX:setTypeName("Camarade DIVX"):setCallSign("DIVX")

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


 
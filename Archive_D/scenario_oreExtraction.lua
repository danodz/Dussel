

function init()

	-- Peut être prevoir de scanner tous les joueurs pour leur attribuer cela
	player = getPlayerShip(-1)
	
	-- Tableau des minerais
	
	-- par ligne : id, nom, proba de trouver, facilite de scanner, concentration max
	-- Attention, la somme des proba de trouver doit être egale a 1
	-- "Vide" est un cas a part qui doit toujours exister
	table_minerai = {} -- creation d'une table
	table_minerai[1] = {"Fer",0.3,"facile",20}
	table_minerai[2] = {"Nickel",0.2,"moyen",20}
	table_minerai[3] = {"Silice",0.1,"moyen",15}
	table_minerai[4] = {"Vide",0.4,"facile",0}
	
	table_minerai_nebula = {}
	table_minerai_nebula[1] = {"Fer",0.1,"facile",20}
	table_minerai_nebula[2] = {"Nickel",0.1,"moyen",20}
	table_minerai_nebula[3] = {"Silice",0.05,"moyen",15}
	table_minerai_nebula[4] = {"Scandium",0.15,"facile",5}
	table_minerai_nebula[5] = {"Yttrium",0.2,"moyen",5}
	table_minerai_nebula[6] = {"Cerium",0.1,"difficile",5}
	table_minerai_nebula[7] = {"Praseodyme",0.1,"difficile",5}
	table_minerai_nebula[8] = {"Vide",0.2,"facile",0}
	
	liste_minerais = {"Fer","Nickel","Silice","Scandium","Yttrium","Cerium","Praseodyme"}
	player.minerai = {["Fer"]=0,["Nickel"]=0,["Silice"]=0,["Scandium"]=0,["Yttrium"]=0,["Cerium"]=0,["Praseodyme"]=0}
	
	player.max_stock = 50

	table_scan = {}
	table_scan[1] = {"facile","Tres faible probabilite de minerai precieux",0,0,1,1,"Faible probabilite de minerai precieux",0,1,1,2}
	table_scan[2] = {"moyen","Faible probabilite de minerai precieux",1,3,1,2,"Moyenne probabilite de minerai precieux",1,3,2,3}
	table_scan[3] = {"difficile","Moyenne probabilite de minerai precieux",1,3,2,3,"Forte probabilite de minerai precieux",2,4,1,3}
	
	-- Les asteroids avec du minerais
	
	for _, obj in ipairs(getAllObjects()) do
		if obj.typeName == "Asteroid" then
			creation_minerai(obj,"Vide","Rien d'interessant","Rien d'interessant",0,0,0)
		end
	end
	
	-- Fonctions supplementaires pour les joueurs 
	player:addCustomButton("engineering", "FARM_ASTEROID", "Extraire Minerai", function()
		x0,y0 = player:getPosition()
		for _, obj in ipairs(getObjectsInRadius(x0,y0,1000)) do
			-- if math.abs(player:getVelocity()) < 40 and obj.typeName == "Asteroid" and obj:isScannedBy(player) then
			if obj.typeName == "Asteroid" and obj:isScannedBy(player) and compte_stocks(player) < player.max_stock then
				player:commandImpulse(0)
				if obj.minerai == "Vide" then
					player:addToShipLog("Rien d'interessant a extraire","white")
				else
					local diff_max = player.max_stock - compte_stocks(player)
					player.minerai[obj.minerai] = player.minerai[obj.minerai] + math.min(obj.concentration,diff_max)
					
					if diff_max < obj.concentration then player:addToShipLog("Stock maximum atteint","red") end
					
					vider_minerai(obj)
					
					player.update_stock = 1
					
				end
			end
		end
	end)
	
	player:addCustomButton("engineering", "REMOVE_ASTEROID", "Decharger Minerai", function()
		if compte_stocks(player) > 0 then
			for _, res in ipairs(liste_minerais) do
				player.minerai[res] = 0
			end
			
			local x,y = player:getPosition()
			local dummy_station = 0
			for _, obj in ipairs(getObjectsInRadius(x,y,1500)) do
				if obj.typeName == "SpaceStation" then dummy_station = 1 end
			end
			if dummy_station == 1 then
				player:addToShipLog("Ressources minieres dechargees","white")
			else
				player:addToShipLog("Ressources minieres evacuees dans l'espace","red")
			end
			player.update_stock = 1
		end
	end)
	
	player:addCustomButton("weapons", "ASTEROID_DESTROY", "Detruire asteroids", function()
		x0,y0 = player:getPosition()
		if player:getWeaponStorage("HVLI") >= 1 then
			player:setWeaponStorage("HVLI",player:getWeaponStorage("HVLI")-1)
			for _, obj in ipairs(getObjectsInRadius(x0,y0,2500)) do
				if obj.typeName == "Asteroid" then
					CpuShip():setHull(1):setShields(0,0,0,0):setPosition(obj:getPosition()):orderIdle():setScanned(true):setRadarTrace("RadarBlip.png")
				end
			end
		end
	end)
	
	-- Fonctions MJ
	addGMFunction("Ajouter minerai", function()
        for _, obj in ipairs(getGMSelection()) do
            if obj.typeName == "Asteroid" then alea_creation_minerai(obj) end
        end
    end)
	
	addGMFunction("Ajouter minerai spe", function()
		for _, ligne_minerai_temp in ipairs(table_minerai_nebula) do
			if ligne_minerai_temp[1] ~= "Vide" then
				addGMFunction(ligne_minerai_temp[1], function()
					for _, obj in ipairs(getGMSelection()) do
						if obj.typeName == "Asteroid" then alea_creation_minerai(obj,ligne_minerai_temp[1]) end
					end
				end)
			end
		end
    end)
	
	addGMFunction("Vider minerai", function()
        for _, obj in ipairs(getGMSelection()) do
            if obj.typeName == "Asteroid" then vider_minerai(obj) end
        end
    end)
		
end


function update(delta)
	-- MAJ des stocks du joueur
	MAJ_minerai(delta)
	
	-- Calcul des probas pour le relais
	if sonde_minerai == nil then sonde_minerai = 0 end
	if sonde_asteroid == nil then sonde_asteroid = 0 end
	if pc_minerai == nil then pc_minerai = 0 end
	
	sonde_minerai_new = 0
	sonde_asteroid_new = 0
	pc_minerai_new = 0
	
	-- MAJ des descriptions des asteroids et des sondes du relais
	for _, obj in ipairs(getAllObjects()) do
		if obj.typeName == "Asteroid" then
			if obj:isScannedBy(player) then 
				if obj.description2 ~= nil then
					obj:setDescription(obj.description2)
				end
			end
			
			-- Calcul des probas pour le relay
			x,y = obj:getPosition()
			for _, obj2 in ipairs(getObjectsInRadius(x,y,5000)) do
				if obj2.typeName == "ScanProbe" or obj2 == player then
					sonde_asteroid_new = sonde_asteroid_new + 1
					if obj.bool_minerai == 1 then sonde_minerai_new = sonde_minerai_new + 1 end
				end
			end
		end
	end
	
	if sonde_asteroid_new > 0 then pc_minerai_new = sonde_minerai_new / sonde_asteroid_new end
		
	if pc_minerai_new ~= pc_minerai then
	
		player:removeCustom("INFO_minerai_relay")
		player:addCustomInfo("relay","INFO_TEMP_RELAY","MAJ des capteurs...")
		
		if timer_probe == nil then timer_probe = 0 end
		timer_probe = timer_probe + delta
		
		if timer_probe > 3 then
			player:removeCustom("INFO_TEMP_RELAY")
				
			sonde_minerai = sonde_minerai_new
			sonde_asteroid = sonde_asteroid_new
			pc_minerai = pc_minerai_new
			player:addCustomInfo("relay","INFO_minerai_relay","% de minerai : ".. math.floor(pc_minerai*100) .. " %")
			timer_probe = nil
		end
	end
end

-- Gestion des minerais
function vider_minerai(obj)

	obj.minerai = "Vide"
	obj.bool_minerai = 0
	
	obj.description1 = nil
	obj.description2 = nil
	obj.concentration = nil
	
	obj:setDescription("Rien d'interessant")
	obj:setScanningParameters(0,0)
	
end

function creation_minerai(obj,minerai,description1,description2,para_scan1,para_scan2,concentration)

	obj.minerai = minerai
	if minerai == "Vide" then obj.bool_minerai = 0 
	else obj.bool_minerai = 1 end
	
	obj.description1 = description1
	obj.description2 = description2
	obj.concentration = concentration
	
	obj:setDescription(description1)
	obj:setScanningParameters(para_scan1,para_scan2)
	
end

function alea_creation_minerai(obj,choix_minerai)
	if choix_minerai == nil then choix_minerai = "" end
	if obj.typeName == "Asteroid" then
		
		-- Pour savoir si l'asteroid est dans une nebuleuse
		obj.bool_nebula = 0
		local x0,y0 = obj:getPosition()
		for _, obj_temp in ipairs(getObjectsInRadius(x0,y0,5000)) do
			if obj_temp.typeName == "Nebula" then obj.bool_nebula = 1 end
		end
		
		if choix_minerai == "" then
			-- Asteroid avec ou sans nebuleuse
			local table_minerai_temp
			if obj.bool_nebula == 0 then table_minerai_temp = table_minerai end
			if obj.bool_nebula == 1 then table_minerai_temp = table_minerai_nebula end
			
			local r = random(0,100)/100
			local r_temp = 0
			for _, ligne_minerai in ipairs(table_minerai_temp) do
				r_temp = r_temp + ligne_minerai[2]
				-- obj:setDescription("TEST BUG")
				if r <= r_temp then
					-- Pour être sûr de ne plus avoir de resultat valide
					r = 1.1
									
					-- la bonne description
					local descri2 = ""
					local random_concentration = 0
					if ligne_minerai[1] == "Vide" then 
						local random_concentration = 0
						descri2 = "Aucune Ressource presente" 
					else
						-- Pour determiner la concentration
						random_concentration = math.floor(random(1,ligne_minerai[4]))
						descri2 =  "Minerai : " .. ligne_minerai[1] .. " ; concentration : ".. random_concentration
					end

					-- Pour trouver la difficulte de scan
					for _, ligne_scan in ipairs(table_scan) do
						if ligne_scan[1] == ligne_minerai[3] then
							local random_scan = random(0,100)/100
							if random_scan <= 0.5 then
								-- creation du minerai
								creation_minerai(obj,ligne_minerai[1],ligne_scan[2],descri2,random(ligne_scan[3],ligne_scan[4]),random(ligne_scan[5],ligne_scan[6]),random_concentration)
							else
								-- creation du minerai
								creation_minerai(obj,ligne_minerai[1],ligne_scan[7],descri2,random(ligne_scan[8],ligne_scan[9]),random(ligne_scan[10],ligne_scan[11]),random_concentration)
							end
						end
					end
				end
			end
		else -- Determination manuelle du minerai
			for _, ligne_minerai in ipairs(table_minerai_nebula) do
				if ligne_minerai[1] == choix_minerai then
					-- Pour determiner la concentration
					local random_concentration = math.floor(random(1,ligne_minerai[4]))
					local  descri2 =  "Minerai : " .. ligne_minerai[1] .. " ; concentration : ".. random_concentration

					-- Pour trouver la difficulte de scan
					for _, ligne_scan in ipairs(table_scan) do
						if ligne_scan[1] == ligne_minerai[3] then
							local random_scan = random(0,100)/100
							if random_scan <= 0.5 then
								-- creation du minerai
								creation_minerai(obj,ligne_minerai[1],ligne_scan[2],descri2,random(ligne_scan[3],ligne_scan[4]),random(ligne_scan[5],ligne_scan[6]),random_concentration)
							else
								-- creation du minerai
								creation_minerai(obj,ligne_minerai[1],ligne_scan[7],descri2,random(ligne_scan[8],ligne_scan[9]),random(ligne_scan[10],ligne_scan[11]),random_concentration)
							end
						end
					end
				end
			end
		end
	end
end

	
function MAJ_minerai(delta)
	if player.update_stock == nil then player.update_stock = 0 end
	if timer_ressource == nil then timer_ressource = 0 end
	
	if player.update_stock == 1 then
		player:addCustomInfo("engineering","INFO_TEMP","MAJ des minerais...")
		
		for _, res in ipairs(liste_minerais) do
			player:removeCustom("INFO_"..res)
		end

		timer_ressource = timer_ressource + delta
		if timer_ressource > 3 then
			
			for _, res in ipairs(liste_minerais) do
				if player.minerai[res] > 0 then player:addCustomInfo("engineering", "INFO_"..res, res.." : "..player.minerai[res]) end
			end
		
			player:removeCustom("INFO_TEMP")
			timer_ressource = 0
			player.update_stock = 0
		end
	end		
end

function compte_stocks(obj)
	local compte = 0
	for _, res in ipairs(liste_minerais) do
		compte = compte + obj.minerai[res]
	end
	return compte
end



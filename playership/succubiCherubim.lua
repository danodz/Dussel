function spawnSuccubiCherubim(x,y)
    succubiCherubim = PlayerSpaceship():setFaction("Arianne"):setTemplate("ACorvette"):setCallSign("SCHER"):setPosition(x,y);
    
    succubiCherubim.inventory = makeInventory({});
    succubiCherubim.kredits = 300;
    succubiCherubim.inventorySpace = 20;
    
    succubiCherubim:addCustomButton("relay", "displayInventory", "Afficher l'inventaire", function() 
        succubiCherubim:addCustomMessage("relay", "displayInventoryMsg", getInventoryStr(succubiCherubim));
    end);
    table.insert(players, succubiCherubim);
end
addGMFunction("Succubi Cherubim", function() spawnSuccubiCherubim(0,0) end);


function spawnSuccubiCherubim()
    succubiCherubim = PlayerSpaceship():setFaction("Arianne"):setTemplate("ACorvette"):setCallSign("SCHER"):setPosition(0,0);
    
    succubiCherubim.inventory = makeInventory({});
    succubiCherubim.kredits = 300;
    succubiCherubim.inventorySpace = 20;
    
    succubiCherubim:addCustomButton("relay", "displayInventory", "Afficher l'inventaire", function() 
        succubiCherubim:addCustomMessage("relay", "displayInventoryMsg", getInventoryStr(succubiCherubim));
    end);
    table.insert(players, succubiCherubim);
end
addGMFunction("Succubi Cherubim", spawnSuccubiCherubim);


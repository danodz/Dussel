function spawnVafJerrold(x,y)
    vafJerrold = PlayerSpaceship():setFaction("Arianne"):setTemplate("C-Camelot"):setCallSign("JVAF"):setPosition(x,y);
    
    vafJerrold.inventory = makeInventory({});
    vafJerrold.kredits = 0;
    vafJerrold.inventorySpace = 20;
    
    vafJerrold:addCustomButton("relay", "displayInventory", "Afficher l'inventaire", function() 
        vafJerrold:addCustomMessage("relay", "displayInventoryMsg", getInventoryStr(vafJerrold));
    end);
    table.insert(players, vafJerrold);
end
addGMFunction("VAF-Jerrold", function() spawnVafJerrold(0,0) end);

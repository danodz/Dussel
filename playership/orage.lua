function spawnOrage(x,y)
    orage = PlayerSpaceship():setFaction("Merillon"):setTemplate("C-Citoyen"):setCallSign("LOM71"):setPosition(x,y);
    
    orage.inventory = makeInventory({});
    orage.kredits = 0;
    orage.inventorySpace = 20;
    
    orage:addCustomButton("relay", "displayInventory", "Afficher l'inventaire", function() 
        orage:addCustomMessage("relay", "displayInventoryMsg", getInventoryStr(orage));
    end);
    table.insert(players, orage);
end
addGMFunction("Orage", function() spawnOrage(0,0) end);

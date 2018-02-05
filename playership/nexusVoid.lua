function spawnNexusvoid(x,y)
    nexusvoid = PlayerSpaceship():setFaction("Merillon"):setTemplate("C-Apotre"):setCallSign("NV"):setPosition(x,y):setWeaponStorage("EMP", 0):setWeaponStorage("HVLI", 3)
    nexusvoid:setWarpDrive(true)
    
    nexusvoid.inventory = makeInventory({});
    nexusvoid.kredits = 150;
    nexusvoid.inventorySpace = 20;
    
    nexusvoid:addCustomButton("relay", "displayInventory", "Afficher l'inventaire", function() 
        nexusvoid:addCustomMessage("relay", "displayInventoryMsg", getInventoryStr(nexusvoid));
    end);
    table.insert(players, nexusvoid);
end
addGMFunction("nexusvoid", function() spawnNexusvoid(0,0) end);

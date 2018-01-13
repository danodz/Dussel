--Name: Tester
--Description: Sert a tester des feature
players = {};
crewPositions = { "helms","weapons","engineering","science","relay" };

function init()
    --[[{{utils/allShips.lua}}]]--
    addGMFunction("save", function() error("test") end); 

    trader = PlayerSpaceship():setTemplate("ACorvette"):setPosition(-83, 678);
    trader.inventory = makeInventory ( { Patates = { amount = 50, value = 5 }
                                       , Fer = { amount = 12 , value = 5}
                                       , Carbone = { amount = 14 , value = 5}
                                       });
    trader.kredits = 100;
    trader.inventorySpace = 80;
    
    trader:addCustomButton("relay", "displayInventory", "Afficher l'inventaire", function()
        local inv = "";
        for name,item in pairs(trader.inventory) do
            if item.amount ~= 0 then
                inv = inv .. name .. " : " .. item.amount .. "\n";
            end
        end
        trader:addCustomMessage("relay", "displayInventoryMsg", inv);
    end);
    
    local questStart = SpaceStation():setTemplate("Medium Station"):setFaction("Independent"):setCallSign("DS5"):setPosition(0,0);
    local questCheckpoint = SpaceStation():setTemplate("Medium Station"):setFaction("Independent"):setCallSign("DS5"):setPosition(1000,0);

    questStart.inventory = makeInventory ({ Fer = { amount = 10, value = 2 }
                                          , questItem = { amount = 1, value = 3 }
                                          });

    questStart:setCommsFunction(function()
        setCommsMessage("Que voulez vous?");
        stationTrade();
    end);
end

function update()
end

--[[{{utils/dussel.lua}}]]--

--[[{{utils/trading.lua}}]]--

--[[{{utils/shipUpdate.lua}}]]--

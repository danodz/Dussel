--Name: Succubi Cherubim quest
--Description: Quest personalisée du Succubi Cherubim
players = {};
availableItems = { technologie = {amount = 0, value = 5}
                 , matiere_premiere = {amount = 0, value = 5}
                 , produit_chimique = {amount = 0, value = 5}
                 , travailleur = {amount = 0, value = 5}
                 , drogue = {amount = 0, value = 5}
                 }
function init()
    --[[{{playership/succubiCherubim.lua}}]]--
    addGMFunction("save", save);
    spawnSuccubiCherubim();
    succubiCherubim.inventory.produit_chimique.amount = 10;

    labo = SpaceStation():setTemplate("Small Station"):setFaction("Independent"):setCallSign("Labo"):setPosition(1000, 1000);
    labo.inventory = makeInventory( { technologie = {amount = 25, value = 0}
                                    , matiere_premiere = {amount = 35, value = 0}
                                    , produit_chimique = {amount = 10, value = 0}
                                    , travailleur = {amount = 15, value = 0}
                                    , drogue = {amount = 0, value = 0}
                                    });
    labo:setCommsFunction(function()
        if comms_source:isDocked(comms_target) then
            setCommsMessage("Larguer des ressources.");
            tradeSellComm();
        else
            setCommsMessage("Venez nous voir sur place.");
        end
    end);
end

function update()
    if labo:getFaction() ~= "Arianne" then
        if labo.inventory.technologie.amount >= 25 and labo.inventory.matiere_premiere.amount >= 35 and labo.inventory.produit_chimique.amount >= 10 and labo.inventory.travailleur.amount >= 15 then

            labo.inventory.technologie.amount = labo.inventory.technologie.amount - 25 
            labo.inventory.matiere_premiere.amount = labo.inventory.matiere_premiere.amount - 35 
            labo.inventory.produit_chimique.amount = labo.inventory.produit_chimique.amount - 10 
            labo.inventory.travailleur.amount = labo.inventory.travailleur.amount - 15

            labo:setFaction("Arianne");
            labo:setCommsFunction(function()
                --if comms_source:isDocked(comms_target) then
                    setCommsMessage("Récolter la drogue");
                    labo.inventory.drogue.amount = labo.inventory.drogue.amount + labo.inventory.produit_chimique.amount;
                    labo.inventory.produit_chimique.amount = 0;
                    tradeSellComm();
                    tradeBuyComm();
                --else
                    --setCommsMessage("Venez nous voir sur place.");
                --end
            end);
        end
    else
    end
end

function drogueComm()
end
--[[{{utils/dussel.lua}}]]--

--[[{{utils/trading.lua}}]]--

defaultValues = { Patate = 5
                , Fer = 5
                , Carbone = 5
                , questItem = 5
                , Homing = 5
                , Mine = 5
                }

function stationTrade()
    addCommsReply("Acheter", stationTradeBuyList);
    addCommsReply("Vendre", stationTradeSellList);
end

function stationTradeBuyList()
    setCommsMessage("Que voulez-vous?");
    for name,item in pairs(comms_target.inventory) do
        if not item.amount == 0 then
            addCommsReply("nous avons " .. item.amount .. " " .. name .. " pour " .. item.value .. " rep", stationTradeBuyItem(name, item) );
        end
    end
end

function stationTradeBuyItem(name, item)
    return function()
        if comms_source.kredits <= item.value then
            setCommsMessage("Vous n'avez pas les kredits pour l'acheter");
        else
    
            if item.amount == 0 then
                setCommsMessage("Il semblerait que nous n'en avons plus.");
            else
                if isInventoryFull(comms_source) then
                    setCommsMessage("Allez faire de la place dans votre cargo");
                else
                    setCommsMessage("Merci");
                    item.amount = item.amount - 1;
    
                    if comms_source.inventory[name] then
                        comms_source.inventory[name] = comms_source.inventory[name] + 1;
                    else
                        comms_source.inventory[name] = 1;
                    end
    
                    comms_source.kredits = comms_source.kredits - item.value;
                    addCommsReply("Acheter un autre", stationTradeBuyItem(name, item));
                end
            end
        end

        addCommsReply("Acheter autre chose", stationTradeBuyList);
    end
end
--[[
function stationTradeSellList()
    setCommsMessage("Que voulez-vous vendre?");
    for name,item in pairs(comms_source.inventory) do
        if not item.amount == 0 then
            addCommsReply(item.amount .. " " .. name .. " pour " .. item.value .. " rep", stationTradeSellItem(name, item) );
        end
    end
end

function stationTradeSellItem(name, item)
    if item.amount == 0 then
        setCommsMessage("Il semblerait que vous soyez à sec");
    else
        setCommsMessage("Bonne affaire");
        addCommsReply("Vendre un autre", stationTradeBuyItem(name, item));
    end
    addCommsReply("Acheter autre chose", stationTradeBuyList);
end
]]

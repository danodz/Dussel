function makeInventory(override)
    local inv = {};
    for name,value in pairs(availableItems) do
        if override[name] then
            inv[name] = deepCopy(override[name]);
        else
            inv[name] = deepCopy(value);
        end
    end
    return inv
end

function getInventoryStr(player)
    local inv = "";
    if player.kredits then
        inv = "Kredits : " .. player.kredits .. "\n";
    end
    if player.inventory then
        for name,item in pairs(player.inventory) do
            if item.amount ~= 0 then
                inv = inv .. name .. " : " .. item.amount .. "\n";
            end
        end
    end
    return inv
end

function tradeBuyComm()
    addCommsReply("Acheter", stationTradeBuyList);
end
function tradeSellComm()
    addCommsReply("Vendre", stationTradeSellList);
end

function stationTradeBuyList()
    setCommsMessage("Que voulez-vous acheter?");
    for name,item in pairs(comms_target.inventory) do
        if not (item.amount == 0) then
            addCommsReply("nous avons " .. item.amount .. " " .. name .. " pour " .. item.value .. " Kredits", stationTradeBuyItem(name, item) );
        end
    end
end

function stationTradeBuyItem(name, item)
    return function()
        if comms_source.kredits < item.value then
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
    
                    if comms_source.inventory[name].amount then
                        comms_source.inventory[name].amount = comms_source.inventory[name].amount + 1;
                    else
                        comms_source.inventory[name].amount = 1;
                    end
    
                    comms_source.kredits = comms_source.kredits - item.value;
                    addCommsReply("Acheter un autre", stationTradeBuyItem(name, item));
                end
            end
        end

        addCommsReply("Acheter autre chose", stationTradeBuyList);
    end
end

function stationTradeSellList()
    setCommsMessage("Que voulez-vous vendre?");
    for name,item in pairs(comms_source.inventory) do
        if item.amount ~= 0 then
            addCommsReply("Vendre un des " .. item.amount .. " " .. name .. " pour " .. getSaleValue(comms_target, name), stationTradeSellItem(name, item));
        end
    end
end

function stationTradeSellItem(name, item)
    return function()
        if item.amount == 0 then
            setCommsMessage("Vous êtes à sec");
        else
            item.amount = item.amount - 1;
            comms_source.kredits = comms_source.kredits + getSaleValue(comms_target, name);
            comms_target.inventory[name].amount = comms_target.inventory[name].amount + 1;
    
            setCommsMessage("Merci");
            addCommsReply("Vendre un autre", stationTradeSellItem(name, item));
        end
        addCommsReply("Vendre autre chose", stationTradeSellList);
    end
end

function countInventory(player)
    local total = 0;

    for i,item in pairs(player.inventory) do
        total = total + item.amount;
    end

    return total;
end

function isInventoryFull(player)
    return countInventory(player) == player.inventorySpace;
end

function getSaleValue(buyer, name)
    if buyer.inventory[name] then
        return math.ceil( buyer.inventory[name].value / 2 );
    else
        return math.ceil( defaultValues[name] / 2 );
    end
end

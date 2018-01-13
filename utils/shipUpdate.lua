players = {};

function init()
    addGMFunction("all_playership", playerShipFn("all_playership"));
    addGMFunction("nexusVoid", playerShipFn("nexusVoid"));
    addGMFunction("succubiCherubim", playerShipFn("succubiCherubim"));
    addGMFunction("vasserand", playerShipFn("vasserand"));
    addGMFunction("viceImperiumDoleo", playerShipFn("viceImperiumDoleo"));
    addGMFunction("printShips", printShips);
end

function playerShipFn(name)
    return function()
        Script():run("playership/"..name..".lua");
        updatePlayersList();
    end
end

function update()
end

function printShips()
    for i,player in pairs(players) do
        print(player:getCallSign());
    end
end

function updatePlayersList()
    players = {};
    for i=1,50,1 do
        player = getPlayerShip(i);
        if(player) then
            table.insert(players, player);
        end
    end
end

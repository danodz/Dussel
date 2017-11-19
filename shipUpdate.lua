function init()
    playerSigns = {"Larth1", "Vasserand"};
    players = {};
    for i,sign in pairs(playerSigns) do
        for i=1,#playerSigns,1 do
            if getPlayerShip(i):getCallSign() == sign then
                updates[sign](getPlayerShip(i));
            end
        end
    end
end

updates = {

    Larth1 = function(larth)
    end,

    Vasserand = function(vasserand)
    end

}

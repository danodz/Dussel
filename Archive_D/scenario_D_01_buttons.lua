--Name: Buttons
presses = {};
totalPresses = 0;
crewPositions = { "helms","weapons","engineering","science","relay" };


function makeUpdatableInfo(position, name, value)
    player:addCustomInfo(position,name, value);
    return { currentValue = value
           , newValue = value
           , position = position
           , name = name
           , toUpdate = false
           , countdown = 0
           };
end

function init()
	player = PlayerSpaceship():setFaction("Human Navy"):setTemplate("Atlantis")
    info =  makeUpdatableInfo("helms", "updatable", "initial");
    customInfos = {info};
    player:addCustomButton("helms", "button", "Press the button", function()
        print("pressed");
        info.newValue = math.random();
    end);
    
    --buttonChangeValue("helms");
    --for i,position in pairs(crewPositions) do
        --buttonChangeValue(position);
    --end
end
coolDown = 0;
function update()
    
    for i,info in pairs(customInfos) do
        if not (info.currentValue == info.newValue) then
            if info.toUpdate and info.countdown == 0 then
                info.currentValue = info.newValue;
                toUpdate = false;
                player:removeCustom(info.name .. "placeholder");
                player:addCustomInfo(info.position,info.name, info.currentValue);
            else if info.toUpdate then
                info.countdown = info.countdown -1;
            else
                info.toUpdate = true;
                info.countdown = 60;
                player:removeCustom(info.name);
                player:addCustomInfo(info.position,info.name .. "placeholder", "MAJ des info");
            end end
        end
    end
--
--    coolDown = coolDown + 1;
--    if coolDown >= 60 * 5 then
--        player:addCustomInfo("helms","placeholder", "Mise a jour");
--        player:removeCustom("random");
--        coolDown = 0;
--    else if coolDown >= 60 * 10 then
--        player:removeCustom("placeholder");
--        player:addCustomInfo("helms","random", math.random());
--    end end
end

function buttonChangeValue(position)
    presses[position] = 0;
    player:addCustomButton("helms", "button" .. position, "Press the button", function()
        presses[position] = presses[position] + 1;
        totalPresses = totalPresses + 1;

        player:removeCustom("helms","nbPress" .. position,presses[position]);
        player:addCustomInfo("helms","nbPress" .. position,presses[position]);
        player:addCustomInfo("helms","totalPress" .. position, totalPresses);
        print(position);
    end)

    player:addCustomInfo(position,"nbPress" .. position,presses[position]);
    player:addCustomInfo(position,"totalPress" .. position, totalPresses);
end

function updateValues()
    for i,position in pairs(crewPositions) do
        player:addCustomInfo(position,"nbPress" .. position,presses[position]);
        player:addCustomInfo(position,"totalPress" .. position,totalPresses);
    end
end

--    if presses[position] == 1 then
--        player:addCustomMessage(position,"info" .. position,"First press wow")
--    end
--    if totalPresses == 10 then
--        player:addCustomMessage(position,"info" .. position,"Total reached ten, nice.")
--    end

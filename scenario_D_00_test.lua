--Name: TEST
require("utils_dussel.lua")

players = { PlayerSpaceship():setFaction("Vindh"):setTemplate("VCorvette"):setCallSign("Larth1"):setPosition(-7640, 39663):setWeaponStorage("Nuke", 0)
          , PlayerSpaceship():setFaction("Vindh"):setTemplate("VCorvette"):setCallSign("Vasserand"):setPosition(-7540, 39663):setWeaponStorage("Nuke", 1)
          , PlayerSpaceship():setFaction("Loyalistes"):setTemplate("VCorvette"):setCallSign("Ducal-2"):setPosition(-24068, -27131):setWeaponStorage("Nuke", 0)
          };
scenarioPart = main;
scenarioParts = {
    main = {
        init = function() 
        end,
        update = function()
        end
    },
    second = {
        init = function() 
        end,
        update = function()
        end
    }
};

function init()
    print(1);
   dusselInit();
end

function update()
end

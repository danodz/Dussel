--Name: Expérimentation dans un vaisseau
nbPlayers = 3;

scenarioPart = "alert";

scenarioParts = {
    alert = {
        init = function() 
        end,
        update = function()
        end
    },
    explore = {
        init = function()
        end,
        update = function()
        end
    },
    ambush = {
        init = function()
        end,
        update = function()
        end
    }
};

function init()
    
    players = { PlayerSpaceship():setFaction("Arianne"):setTemplate("DusselAcademieBase"):setCallSign("ASD")
              , PlayerSpaceship():setFaction("Vindh"):setTemplate("DusselAcademieBase"):setCallSign("SDF")
              , PlayerSpaceship():setFaction("Merillon"):setTemplate("DusselAcademieBase"):setCallSign("ZXC")
              };

    scenarioParts[scenarioPart].init();
end

function update()
    scenarioParts[scenarioPart].update();
end

function changePart(partName)
    scenarioPart = partName;
    scenarioParts[scenarioPart].init();
end

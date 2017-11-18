--Name: Conquete

players = { PlayerSpaceship():setFaction("Vindh"):setTemplate("VCorvette"):setCallSign("Larth1"):setPosition(-7640, 39663):setWeaponStorage("Nuke", 0):setReputationPoints(1000)
          , PlayerSpaceship():setFaction("Merillon"):setTemplate("VCorvette"):setCallSign("Vasserand"):setPosition(-7540, 39663):setWeaponStorage("Nuke", 1):setReputationPoints(1000)
          , PlayerSpaceship():setFaction("Loyalistes"):setTemplate("VCorvette"):setCallSign("Ducal-2"):setPosition(-24068, -27131):setWeaponStorage("Nuke", 0)
          };

function init()
    FuelStation = mkConquestStation("Vindh", "Fuel", -7508, 42370);
    AmmoStation = mkConquestStation("Merillon", "Ammo", -9857, 37918);
    EngineerStation = mkConquestStation("Barons", "Engi", -5632, 39312);
end

function update()
end

function mkConquestStation(faction, callSign, x, y)
    EngineerStation = { station = SpaceStation():setTemplate("Large Station"):setFaction(faction):setCallSign(callSign):setPosition(x, y):setCommsFunction(convertStationComms(100))
                      , investment = { vindh = 0
                                     , ariane = 0
                                     , merillon = 0
                                     }
                      , troops = { hornets = {}
                                 , atlantis = {}
                                 }
                      };
end

function convertStationComms(price)
    return function()
            if comms_target:getFaction() == comms_source:getFaction() then
                setCommsMessage("De quoi as-tu besoin");
                sellStuffComm("Nuke", 1000);
                sellStuffComm("Homing", 10);
                sellStuffComm("HVLI", 10);
                sellStuffComm("EMP", 10);
                sellStuffComm("Mine", 10);
            else
                setCommsMessage("Obtenir la loyauté de la station pour sa faction (".. price .." crédits)")
                addCommsReply("J'ai les crédits", function()
                    if not comms_source:takeReputationPoints(price) then setCommsMessage("On ne s'allie pas à des pauvres"); return end
                    setCommsMessage("Vos arguments sont convaincants")
                    comms_target:setFaction(comms_source:getFaction())
                    addCommsReply("Acheter des trucs?", convertStationComms(0))
                end)
            end
    end
end

function sellStuffComm(weapon, price)
        addCommsReply("1 ".. weapon .." pour " .. price, function()
            if not comms_source:takeReputationPoints(price) then
                setCommsMessage("Pas assez de reputation.");
                addCommsReply("Je veux acheter autre chose.", convertStationComms(0)) 
                return;
            end
            if comms_source:getWeaponStorage(weapon) == comms_source:getWeaponStorageMax(weapon) then
                setCommsMessage("Pas assez de place dans ton vaisseau");
                addCommsReply("Je veux acheter autre chose.", convertStationComms(0)) 
                return
            end
            setCommsMessage("Merci");
            addCommsReply("Je veux acheter autre chose.", convertStationComms(0)) 
    
            comms_source:setWeaponStorage(weapon, comms_source:getWeaponStorage(weapon) + 1);
        end)
    end

function generateMobs(nb, template, faction, centerX, centerY, radius, fn)
        local mobs = {};
    
        for i=1, nb, 1 do
            local mob = CpuShip():setFaction(faction):setTemplate(template):setCallSign(srandom(irandom(2,3)) .. irandom(10,999)):setPosition(irandom(centerX - radius, centerX + radius), irandom(centerY - radius, centerY + radius))
            fn(mob);
            table.insert(mobs, mob);
        end
    
        return mobs;
end

--[[
Base of the ship templates, from here different classes of ships are included to be used within the game.
Each sub-file defines it's own set of ship classes.

These are:
* Stations: For different kinds of space stations, from tiny to huge.
* Starfighters: Smallest ships in the game.
* Frigates: Medium sized ships. Operate on a small crew.
* Covette: Large, slower, less maneuverable ships.
* Dreadnaught: Huge things. Everything in here is really really big, and generally really really deadly.

Player ships are in general large frigates to small corvette class
--]]
require("shipTemplates_Stations.lua")
---[[Until these are ready, they are disabled
require("shipTemplates_StarFighters.lua")
require("shipTemplates_Frigates.lua")
require("shipTemplates_Corvette.lua")
require("shipTemplates_Dreadnaught.lua")
--]]
--For now, we add our old ship templates as well. These should be removed at some point.
require("shipTemplates_OLD.lua")
--require("shipTemplates_testDrone.lua")
--require("shipTemplates_testShip.lua")
require("shipTemplates_ToEscort.lua")
require("shipTemplates_UnknownEnnemy.lua")
--require("shipTemplates_Examen.lua")
--require("shipTemplates_Exercice.lua")
require("shipTemplates_Dussel.lua")
require("shipTemplates_epave.lua")
require("shipTemplates_Mothership.lua")

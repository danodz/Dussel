-- Addon for ships 

--//// Beam 
SpaceShip:setBeamWeapon(int index, float arc, float direction, float range, float cycle_time, float damage)
SpaceShip:setBeamWeaponTurret(int index, float arc, float direction, float rotation_rate)
SpaceShip:setBeamWeaponTexture(int index, string texture)
SpaceShip:setBeamWeaponEnergyPerFire(int index, float energy)
SpaceShip:setBeamWeaponHeatPerFire(int index, float heat)

--//// Weapon tube
SpaceShip:setWeaponTubeExclusiveFor(int index, EMissileWeapons type)
SpaceShip:setWeaponTubeDirection(int index, float direction)
SpaceShip:setWeaponTubeCount(int amount)
SpaceShip:weaponTubeAllowMissle(int index, EMissileWeapons type)
SpaceShip:weaponTubeDisallowMissle(int index, EMissileWeapons type)
SpaceShip:setWeaponStorage(EMissileWeapons weapon, int amount)
SpaceShip:setWeaponStorageMax(EMissileWeapons weapon, int amount)

--//// Movement 
SpaceShip:setCombatManeuver(float boost, float strafe)

SpaceShip:setJumpDrive(bool has_jump)
SpaceShip:setJumpDriveRange(float min, float max)

--//// Hull 
ShipTemplateBasedObject:setHull(float amount)
ShipTemplateBasedObject:setHullMax(float amount)

--//// Shield
ShipTemplateBasedObject:setShields(std::vector<float> amounts)
ShipTemplateBasedObject:setShieldsMax(std::vector<float> amounts)


--//// Energy
SpaceShip:setEnergy(float amount)
SpaceShip:setMaxEnergy(float amount)

SpaceShip:setSystemPower(ESystem system, float power)
SpaceShip:setSystemCoolant(ESystem system, float coolant)
SpaceShip:setSystemHeat(ESystem system, float heat)
SpaceShip:setSystemHealth(ESystem system, float health)


--//// Map + other
SpaceShip:setRadarTrace(string trace)

SpaceShip:addBroadcast(int threshold, string message)

SpaceShip:isFriendOrFoeIdentified()
SpaceShip:isFullyScanned()
SpaceShip:isFriendOrFoeIdentifiedBy(P<SpaceObject> other)
SpaceShip:isFullyScannedBy(P<SpaceObject> other)
SpaceShip:isFriendOrFoeIdentifiedByFaction(int faction_id)
SpaceShip:isFullyScannedByFaction(int faction_id)


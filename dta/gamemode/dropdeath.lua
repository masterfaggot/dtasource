AddCSLuaFile()

if SERVER thenlocal SWEP = FindMetaTable("Weapon")
	if !SWEP thenreturnendfunction SWEP:DampenDrop()--Originally from TTTlocal phys = self:GetPhysicsObject()
		if IsValid(phys) then
			phys:SetVelocityInstantaneous(Vector(0,0,-75) + phys:GetVelocity() * 0.001)
			phys:AddAngleVelocity(phys:GetAngleVelocity() * -0.99)
		endendlocal WeaponBlackList = {
		weapon_crowbar = true,
		weapon_fist = true,
		weapon_physgun = true,
		weapon_knife = true
	}
	
	local CVarName = "DropWeaponToggle"if !ConVarExists(CVarName) then
		CreateConVar(CVarName, "1", FCVAR_NOTIFY)
	end
	
	hook.Add("DoPlayerDeath", "DropActiveWeapon", function(ply, attacker, dmginfo)local wep = ply:GetActiveWeapon()
		local CVar = GetConVar(CVarName)
		local CVarEnabled = CVar:GetBool()
		local CanDrop = WeaponBlackList[wep:GetClass()]
		if IsValid(wep) and CVarEnabled and !CanDrop then
			ply:DropWeapon(wep)
			wep:DampenDrop()
		endend)
end
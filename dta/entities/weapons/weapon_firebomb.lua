AddCSLuaFile()

SWEP.HoldType           = "grenade"

   SWEP.PrintName       = "grenade_fire"
   SWEP.Slot            = 4

   SWEP.ViewModelFlip   = true
   SWEP.ViewModelFOV    = 54

   SWEP.Icon            = ""
   SWEP.IconLetter      = "P"

SWEP.Slot					=	4
SWEP.SlotPos				=	0

SWEP.Base               = "weapon_frag"

SWEP.Kind               = WEAPON_NADE
SWEP.WeaponID           = AMMO_MOLOTOV

SWEP.UseHands           = true
SWEP.ViewModel          = "models/weapons/cstrike/c_eq_flashbang.mdl"
SWEP.WorldModel         = "models/weapons/w_eq_flashbang.mdl"

SWEP.Weight             = 5
SWEP.AutoSpawnable      = true
SWEP.Spawnable          = true
-- really the only difference between grenade weapons: the model and the thrown
-- ent.

function SWEP:GetGrenadeName()
   return "weapon_firebomb"
end

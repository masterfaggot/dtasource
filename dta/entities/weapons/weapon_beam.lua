AddCSLuaFile()

SWEP.Author					=	"nox"
SWEP.Base					=	"weapon_base"
SWEP.PrintName				=	"Silenced AR"
SWEP.Instructions			=	[[The assault rifle is begging you for blood...]]

SWEP.ViewModel				=	"models/weapons/cstrike/c_rif_m4a1.mdl"
SWEP.ViewModelFlip			=	false
SWEP.UseHands				=	true
SWEP.WorldModel				=	"models/weapons/w_rif_m4a1.mdl"
SWEP.SetHoldType			=	"ar2"
SWEP.Weight					=	2
SWEP.AutoSwitchTo			=	true
SWEP.AutoSwitchFrom			=	false

SWEP.Slot					=	2
SWEP.SlotPos				=	0

SWEP.DrawAmmo				=	true
SWEP.DrawCrosshair			=	true

SWEP.Spawnable				=	true
SWEP.AdminSpawnable			=	true

SWEP.Primary.ClipSize		=	200
SWEP.Primary.DefaultClip	=	100
SWEP.Primary.Ammo			=	"AR2"
SWEP.Primary.Automatic		=	false
SWEP.Primary.Recoil			=	1.6
SWEP.Primary.Damage			=	6
SWEP.Primary.NumShots		=	1
SWEP.Primary.Spread			=	0
SWEP.Primary.Cone			=	0.018
SWEP.Primary.Delay			=	0.09

SWEP.Secondary.Clipsize		=	-1
SWEP.Secondary.DefaultClip	=	-1
SWEP.Secondary.Ammo			=	"none"
SWEP.Secondary.Automatic	=	false

SWEP.Secondary.Clipsize		=	-1
SWEP.Secondary.DefaultClip	=	-1
SWEP.Secondary.Ammo			=	"none"
SWEP.Secondary.Automatic	=	false

SWEP.ShouldDropOnDie		=	true

SWEP.DeploySpeed            = 7
SWEP.IsSilent              = true

--SWEP.PrimaryAnim           = ACT_VM_PRIMARYATTACK_SILENCED
--SWEP.ReloadAnim            = ACT_VM_RELOAD_SILENCED

local ShootSound			=	Sound("Weapon_M4A1.Silenced")

function SWEP:Initialize()
	self:SetHoldType( "ar2" )
end

function SWEP:PrimaryAttack()

		if( not self:CanPrimaryAttack() ) then
		
		return
	end
	
	local ply = self:GetOwner()
	
	ply:LagCompensation( true )
	
	local Bullet = {}
		Bullet.Num		=	self.Primary.NumShots
		Bullet.Src		=	ply:GetShootPos()
		Bullet.Dir		=	ply:GetAimVector()
		Bullet.Spread	=	Vector( self.Primary.Spread, self.PrimarySpread, 0 )
		Bullet.Tracer	=	1
		Bullet.Damage	=	self.Primary.Damage
		Bullet.AmmoType	=	self.Primary.Ammo
	
	self:FireBullets( Bullet )
	self:ShootEffects()

	
	self:EmitSound( ShootSound )
	self.BaseClass.ShootEffects( self )
	self:TakePrimaryAmmo( 1 )
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	
	
	ply:LagCompensation( false )
	
end

function SWEP:CanSecondaryAttack()
	return false
end

function SWEP:Deploy()
   self:SendWeaponAnim(ACT_VM_DRAW_SILENCED)
   return self.BaseClass.Deploy(self)			--oh please fucking work for the love of god 
end

function SWEP:Reload()
   self:DefaultReload( ACT_VM_RELOAD )
end
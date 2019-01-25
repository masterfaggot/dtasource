AddCSLuaFile()
//client inflictor
SWEP.Author					=	"nox"
SWEP.Base					=	"weapon_base"
SWEP.PrintName				=	"inflictor"
SWEP.Instructions			=	[[This weapon is bound to your soul...]]

SWEP.ViewModel				=	"models/weapons/cstrike/c_pist_usp.mdl"
SWEP.ViewModelFlip			=	false
SWEP.UseHands				=	true
SWEP.WorldModel				=	"models/weapons/w_pist_usp_silencer.mdl"
SWEP.SetHoldType			=	"pistol"
SWEP.Weight					=	0
SWEP.AutoSwitchTo			=	true
SWEP.AutoSwitchFrom			=	false

SWEP.Slot					=	1
SWEP.SlotPos				=	0

SWEP.DrawAmmo				=	false
SWEP.DrawCrosshair			=	true

SWEP.Spawnable				=	true
SWEP.AdminSpawnable			=	true

SWEP.Primary.ClipSize		=	30
SWEP.Primary.DefaultClip	=	30
SWEP.Primary.Ammo			=	"357"
SWEP.Primary.Automatic		=	false
SWEP.Primary.Recoil			=	1
SWEP.Primary.Damage			=	7
SWEP.Primary.NumShots		=	1
SWEP.Primary.Spread			=	0
SWEP.Primary.Cone			=	0
SWEP.Primary.Delay			=	0.01

SWEP.Secondary.Clipsize		=	-1
SWEP.Secondary.DefaultClip	=	-1
SWEP.Secondary.Ammo			=	"none"
SWEP.Secondary.Automatic	=	true

SWEP.ShouldDropOnDie		=	true

SWEP.IsSilent              = true
SWEP.DeploySpeed            = 5

SWEP.PrimaryAnim           = ACT_VM_PRIMARYATTACK_SILENCED
SWEP.ReloadAnim            = ACT_VM_RELOAD_SILENCED


local ShootSound = Sound( "Weapon_USP.SilencedShot" )

function SWEP:Initialize()
	self:SetHoldType( "pistol" )
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
   return self.BaseClass.Deploy(self)
end

function SWEP:Reload()
   self:DefaultReload( ACT_VM_RELOAD )
end
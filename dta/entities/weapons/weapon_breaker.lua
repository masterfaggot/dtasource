AddCSLuaFile()

SWEP.Author					=	"nox"
SWEP.Base					=	"weapon_base"
SWEP.PrintName				=	"breaker"
SWEP.Instructions			=	[[Left click shoots]]

SWEP.ViewModel				=	"models/weapons/v_357.mdl"
SWEP.ViewModelFlip			=	false
SWEP.UseHands				=	true
SWEP.WorldModel				=	"models/weapons/w_357.mdl"
SWEP.SetHoldType			=	"revolver"
SWEP.Weight					=	5
SWEP.AutoSwitchTo			=	true
SWEP.AutoSwitchFrom			=	false

SWEP.Slot					=	1
SWEP.SlotPos				=	2

SWEP.DrawAmmo				=	true		--???
SWEP.DrawCrosshair			=	true

SWEP.Spawnable				=	true
SWEP.AdminSpawnable			=	true

SWEP.Primary.ClipSize		=	6
SWEP.Primary.DefaultClip	=	6
SWEP.Primary.Ammo			=	"357"
SWEP.Primary.Automatic		=	false
SWEP.Primary.Recoil			=	1
SWEP.Primary.Damage			=	15
SWEP.Primary.NumShots		=	1
SWEP.Primary.Spread			=	0
SWEP.Primary.Cone			=	0
SWEP.Primary.Delay			=	.50

SWEP.Secondary.Clipsize		=	-1
SWEP.Secondary.DefaultClip	=	-1
SWEP.Secondary.Ammo			=	"none"
SWEP.Secondary.Automatic	=	true

SWEP.ShouldDropOnDie		=	true

local ShootSound = Sound( "Weapon_357.Single" )

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


function SWEP:SecondaryAttack()
		if( not self:CanSecondaryAttack() ) then
		return
	end
end
	
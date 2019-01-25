AddCSLuaFile()

SWEP.Author					=	"nox"
SWEP.Base					=	"weapon_base"
SWEP.PrintName				=	"Lifestealer"
SWEP.Instructions			=	[[You feel a powerful presence coming from this blade...]]

SWEP.ViewModel				=	"models/weapons/cstrike/c_knife_t.mdl"
SWEP.ViewModelFlip			=	false
SWEP.UseHands				=	true
SWEP.WorldModel				=	"models/weapons/w_knife_t.mdl"
SWEP.SetHoldType			=	"melee"
SWEP.Weight					=	2
SWEP.AutoSwitchTo			=	true
SWEP.AutoSwitchFrom			=	false

SWEP.Slot					=	0
SWEP.SlotPos				=	0

SWEP.DrawAmmo				=	false
SWEP.DrawCrosshair			=	true

SWEP.Spawnable				=	true
SWEP.AdminSpawnable			=	true

SWEP.Primary.Clipsize		=	-1
SWEP.Primary.DefaultClip	=	-1
SWEP.Primary.Ammo			=	"none"
SWEP.Primary.Automatic		=	true

SWEP.Secondary.Clipsize		=	-1
SWEP.Secondary.DefaultClip	=	-1
SWEP.Secondary.Ammo			=	"none"
SWEP.Secondary.Automatic	=	false


SWEP.ShouldDropOnDie		= false

local SwingSound = Sound( "Weapon_Crowbar.Single" )
local HitSound = Sound( "Weapon_Crowbar.Melee_Hit" )

function SWEP:Initialize()
	self:SetWeaponHoldType( "melee" ) 
end

function SWEP:PrimaryAttack()
	if( CLIENT ) then return end
	
	local ply = self:GetOwner()
	
	ply:LagCompensation( true )
	
	local shootpos = ply:GetShootPos()
	local endshootpos = shootpos + ply:GetAimVector() * 70
	local tmin = Vector( 1, 1, 1 ) * -10
	local tmax = Vector( 1, 1, 1 ) * 10
	
	local tr = util.TraceHull( {
		start = shootpos, 
		endpos = endshootpos,
		filter = ply,
		mask = MASK_SHOT_HULL,
		mins = tmin,
		maxs = tmax	} )
		
		if( not IsValid( tr.Entity ) ) then
		tr = util.TraceLine( {
		start = shootpos,
		endpos = endshootpos,
		filter = ply,
		mask = MASK_SHOT_HULL } )
		
		end
		
		local ent = tr.Entity
		
		if ( IsValid( ent ) && ( ent:IsPlayer() || ent:IsNpc() ) ) then
		
			self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER )
			ply:SetAnimation( PLAYER_ATTACK1 )
			
			ply:EmitSound( HitSound )
			ent:SetHealth( ent:Health() - 10 )
			if( ent:Health() < 1 ) then
				ent:Kill()
				ply:SetHealth( math.Clamp( ply:Health() + 50, 1, ply:GetMaxHealth() ) )
			end
		
			ply:SetHealth( math.Clamp( ply:Health() + 10, 1, ply:GetMaxHealth() ) )
			
			elseif( !IsValid( ent ) ) then 
			
				self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER )
			ply:SetAnimation( PLAYER_ATTACK1 )
			
			ply:EmitSound( SwingSound )
			
			end
		
	self:SetNextPrimaryFire( CurTime() + 0.5)
	
	ply:LagCompensation( false )
end

function SWEP:CanSecondaryAttack()
	return false
end
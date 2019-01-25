local ply = FindMetaTable("Player")
//client side setup
local teams = {}

teams[0] = {
	name = "Red",
	color = Vector(1.0, 0, 0 ),
	weapons = { "weapon_inflictor", "weapon_beam", "weapon_frag", "weapon_slam", "weapon_lifestealer", "weapon_breaker", "weapon_smg1" }	}
	
teams[1] = {
	name = "Blue",
	color = Vector(0.0, 0, 1.0 ),
	weapons = { "weapon_inflictor", "weapon_beam", "weapon_frag", "weapon_slam", "weapon_lifestealer", "weapon_breaker", "weapon_smg1" }	}
	
function ply:SetupTeam( n )
if ( not teams[n] ) then return end

self:SetTeam( n )
self:SetPlayerColor( teams[n].color )
self:SetHealth( 100 )
self:SetMaxHealth( 200 )
self:SetWalkSpeed( 300 )		--was 450. felt too much.
self:SetRunSpeed( 100 )
self:SetModel( "models/player/combine_super_soldier.mdl" )

self:GiveWeapons( n )
end

function ply:GiveWeapons( n )

	for k, weapon in pairs( teams[n].weapons ) do
		self:Give( weapon )
	end
end
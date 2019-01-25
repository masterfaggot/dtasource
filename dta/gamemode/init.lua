AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "teamsetup.lua" )
AddCSLuaFile( "roundsystem.lua" )
AddCSLuaFile( "cl_scoreboard.lua" )
AddCSLuaFile( "dropdeath.lua" )

include( "shared.lua" )
include( "roundsystem.lua" )
include( "teamsetup.lua" )

roundActive = false

function GM:PlayerSpawn( ply )
	print( "Player: " .. ply:Nick() .. " has risen!" )
	ply:SetupHands()	--setup hands on spawn
	ply:SetupTeam( math.random( 0, 1 ) )	--teams chosen by rng every round..fuck

	if( roundActive == true ) then		-- this is saying if round is active, kill any newcomers
			ply:KillSilent()
			return
		else
			RoundStart()
	end
end

function GM:PlayerDeathThink( ply )
	if( roundActive == false ) then
		ply:Spawn()
		return true							--allows spawn while round isn't active
	else
		return false						--does not allow spawn while round is active
	end
end

function GM:PlayerSetHandsModel( ply, ent )	--this function makes hands exist. without == goldeneye source

	local simplemodel = player_manager.TranslateToPlayerModelName( ply:GetModel() )
	local info = player_manager.TranslatePlayerHands( simplemodel )
	if ( info ) then
		ent:SetModel( info.model )
		ent:SetSkin( info.skin )
		ent:SetBodyGroups( info.body )
	end

end

function GM:ScalePlayerDamage( ply, hitgroup, dmginfo )
	if ( hitgroup == HITGROUP_HEAD ) then
		dmginfo:ScaleDamage( 5 ) -- 5x headshot damage
 	else
		dmginfo:ScaleDamage( 1 ) -- less damage when shot anywhere else (decimals work)..do negatives?
	end
end

function GM:PlayerDisconnected( ply )		--function for disconnected players
RoundEndCheck()								--if someone dc's check if round is over
print( ply.Nick() .. " is chicken!" )		--hopefully this isnt broken
ply:ShouldDropWeapon( true )
end											

function GM:PlayerDeath( ply )
ply:ShouldDropWeapon( true )				--function of a player's death..obviously
RoundEndCheck()								--checks if round is over if player dies.
end	

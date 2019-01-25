function RoundStart()
	local Alive = 0
	for k, v in pairs( player.GetAll() ) do
		if( v:Alive() ) then
			Alive = Alive + 1
			end
		end
		if(Alive == table.Count( player.GetAll() ) && table.Count( player.GetAll() ) > 1 ) then  --Alive was >= not ==
		roundActive = true
	end
		print( "Onslaught Starting: " .. tostring(roundActive) )  --slaughter starting
		RoundEndCheck()
end

function RoundEndCheck()
	print( "Round Active :" .. tostring(roundActive) )
	if( roundActive == false ) then return end
	timer.Create( "checkdelay", 1, 1, function()	--open? "("
		local redAlive = 0
		local blueAlive = 0
		for k, v in pairs( team.GetPlayers( 0 ) ) do
			if( v:Alive() ) then
			redAlive = redAlive + 1
			end
		end
			for k, v in pairs( team.GetPlayers( 1 ) ) do
		if( v:Alive() ) then
			blueAlive = blueAlive + 1
			end
		end
			print( "Red Alive: " .. tostring(redAlive) .. " |Blue Alive : " .. tostring(blueAlive) )
			if( redAlive == 0 ) then
				EndRound( "Blue" )
			elseif( blueAlive == 0 ) then
				EndRound( "Red" )
		end
	end)
end

function EndRound( winners )
	print( winners .. " committed genocide!" ) --SLAUGHTER
	for _, v in pairs( team.GetPlayers( 1 ) ) do 
		if( team.GetName( v:Team() ) == winners ) then
			print( "Excellent! New round..."	)			--might be broken block of code
		end	
	end										--extra end?
	timer.Create( "cleanup", 3, 1, function()
		game.CleanUpMap( false, {} )				--cleans the map up so there is no persistent item drops
		for _, v in pairs( player.GetAll() ) do 	--they get all of the v: hooks
		if( v:Alive() ) then
			v:SetupHands()							--set their hands up so it doesn't look like goldeneye
			v:StripWeapons()						--this would be an unbalanced mess gameplaywise without this
			v:KillSilent()							--kill them silently so they respawn in new round
			end	
			v:SetupTeam( v:Team() )					--maybe this is the reason why teams still go random after a round ends?
		end
		roundActive = false
	end)
end

--function AutoBalance()		--will make teams balanced if they are not..duh
	--if( table.Count( team.GetPlayers( 0 ) ) > table.Count( team.GetPlayers( 1 ) ) ) then
		--return 1
	--elseif( table.Count( team.GetPlayers( 0 ) ) < table.Count( team.GetPlayers( 1 ) ) ) then
		--return 0
	--end
	--if( table.Count( team.GetPlayers( 1 ) ) > table.Count( team.GetPlayers( 0 ) ) ) then
		--return 1
	--elseif( table.Count( team.GetPlayers( 1 ) ) < table.Count( team.GetPlayers( 0 ) ) ) then
		--return 0
	--end
--end                                                                                 
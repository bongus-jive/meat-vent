local oi = init
function init()
	if oi then oi() end
	
	if world.type() == "outpost" then
		world.setUniverseFlag("pat_meatvent")
	end
end
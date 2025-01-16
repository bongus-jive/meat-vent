local _init = init
function init()
  if _init then _init() end
  
  if world.type() == "outpost" then
    world.setUniverseFlag("pat_meatvent")
  end
end

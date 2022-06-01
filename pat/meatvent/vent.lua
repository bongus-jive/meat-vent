require "/scripts/util.lua"
require "/scripts/vec2.lua"
require "/scripts/rect.lua"

function init()
	meat = config.getParameter("meat")
	timer = 0.1
	parameters = {}
	center = rect.center(object.boundBox())
  
  onInputNodeChange({node = 0, level = object.getInputNodeLevel(0)})
end

function update(dt)
	timer = math.max(0, timer - dt)
	if timer == 0 then
		timer = util.randomInRange(meat.time)
		
		parameters.speed = util.randomInRange(meat.speed)
		parameters.processing = "."..math.random(1, meat.variants)
		
		local flips = math.random(0, 3)
		if flips ~= 0 then
			local f = "?flip"
			if flips >= 1 then f = f.."x" end
			if flips <= 3 then f = f.."y" end
			parameters.processing = parameters.processing..f
		end
		
		world.spawnProjectile(meat.projectile, center, nil, vec2.rotate({-1, 0}, math.random() * math.pi), nil, parameters)
		
		animator.setSoundPitch("meat", util.randomInRange(meat.soundPitch))
		animator.playSound("meat")
		animator.burstParticleEmitter("blood")
	end
end

function onInputNodeChange(args)
  if args.node == 0 then
    local connected = object.isInputNodeConnected(0)
    if not connected then args.level = true end
    
    animator.setParticleEmitterActive("drip", args.level)
    script.setUpdateDelta(args.level and 1 or 0)
  end
end

function onNodeConnectionChange()
  onInputNodeChange({node = 0, level = object.getInputNodeLevel(0)})
end
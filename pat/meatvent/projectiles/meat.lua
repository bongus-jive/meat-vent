require "/scripts/vec2.lua"

function init()
	rotationSpeed = config.getParameter("rotationSpeed", 20)
	mcontroller.setRotation(math.random() * math.pi * 2)
	
	bounces = config.getParameter("maxBounces")
	stickSettings = config.getParameter("stickSettings")
end

function update(dt)
	local vel = mcontroller.velocity()
	local dir = vel[1] > 0 and 1 or -1
	
	local rot = (vec2.mag(vel) / 180 * math.pi) * -dir * dt * rotationSpeed
	mcontroller.setRotation(mcontroller.rotation() + rot)
end

function bounce()
	if bounces > 0 then
		bounces = bounces - 1
		if bounces == 0 then
			mcontroller.applyParameters(stickSettings)
		end
	end
end

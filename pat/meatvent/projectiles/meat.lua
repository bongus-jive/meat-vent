function init()
  self.rotationSpeed = config.getParameter("rotationSpeed", 20)
  mcontroller.setRotation(math.random() * math.pi * 2)
  
  self.bounces = config.getParameter("maxBounces")
end

function update(dt)
  local vel = mcontroller.velocity()
  local dir = vel[1] > 0 and 1 or -1
  
  local mag = math.sqrt(vel[1] * vel[1] + vel[2] * vel[2])
  local rot = (mag / 180 * math.pi) * -dir * dt * self.rotationSpeed
  mcontroller.setRotation(mcontroller.rotation() + rot)
end

function bounce()
  if self.bounces == 0 then return end

  self.bounces = self.bounces - 1
  if self.bounces == 0 then
    local params = config.getParameter("stickSettings")
    mcontroller.applyParameters(params)
  end
end

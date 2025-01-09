function init()
  self.projectile = config.getParameter("meatProjectile")
  self.projectile.position = object.toAbsolutePosition(self.projectile.offset)

  self.pitchRange = config.getParameter("soundPitchRange")

  self.timeRange = config.getParameter("timeRange")
  resetTimer()
  
  onNodeConnectionChange()
end

function update(dt)
  if not self.meatEnabled then return end

  self.timer = self.timer - dt
  if self.timer <= 0 then
    resetTimer()
    spawnMeat()
  end
end

function resetTimer()
  self.timer = randomInRange(self.timeRange)
end

function spawnMeat()
  world.spawnProjectile(self.projectile.type, self.projectile.position, nil, meatVector(), nil, meatParams())
    
  animator.setSoundPitch("meat", randomInRange(self.pitchRange))
  animator.playSound("meat")
  animator.burstParticleEmitter("blood")
end

function meatParams()
  local params = {}
  params.speed = randomInRange(self.projectile.speedRange)
  params.processing = "." .. math.random(self.projectile.variants)

  local rand = math.random(0, 3)
  if rand > 0 then
    local flip = "?flip"
    if rand > 1 then flip = flip .. "x" end
    if rand < 3 then flip = flip .. "y" end
    params.processing = params.processing .. flip
  end

  return params
end

function meatVector()
  local angle = math.random() * -math.pi
  return {math.cos(angle), math.sin(angle)}
end

function randomInRange(range)
  return range[1] + (math.random() * (range[2] - range[1]))
end

function onInputNodeChange(args)
  if args.node == 0 then
    local connected = object.isInputNodeConnected(0)
    if not object.isInputNodeConnected(0) then args.level = true end
    
    animator.setParticleEmitterActive("drip", args.level)
    self.meatEnabled = args.level
  end
end

function onNodeConnectionChange()
  onInputNodeChange({node = 0, level = object.getInputNodeLevel(0)})
end

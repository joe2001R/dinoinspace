PlayerWalkingState=Class(BaseState)

function PlayerWalkingState:construct(player)
    BaseState.construct(self)
    self.player=player
    self.animation=Animation({
        frames={5,6,7,8,9,10},
        interval=0.05
    })
    self.player.currentAnimation= self.animation
end

function PlayerWalkingState:update(dt)
    self.player.currentAnimation:update(dt)
    if(self.player.lastY) then
        self.player:updateScore()
    end

    if (not self.player.Controller.goLeft() and not self.player.Controller.goRight()) then
        self.player:changeState('idle')
    elseif (self.player.Controller.goLeft()) then
        self.player:moveLeft(dt,true)
    else
        self.player:moveRight(dt,true)
    end
    if (self.player.Controller.jump()) then
        self.player:changeState('jump',self.player.y)
    end
  --  if (not love.keyboard.isDown('left') and not love.keyboard.isDown('right')) then
  --      self.player:changeState('idle')
  --  elseif love.keyboard.isDown('left') then
  --      self.player:moveLeft(dt,true)
  --  else
  --      self.player:moveRight(dt,true)
  --  end
  --  if love.keyboard.wasPressed('space') then
  --      self.player:changeState('jump',self.player.y)
  --  end
end

function PlayerWalkingState:exit()
    BaseState.exit(self)
end
function PlayerWalkingState:render()
    BaseState.render(self)
end
function PlayerWalkingState:enter()
    BaseState.enter(self)
end
        

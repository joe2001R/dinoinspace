Background = Class()

function Background:construct(def)
    self.stateMachine=def.stateMachine
    self.y=0
    self.at=0 -- relate where we are at to the shifting of the background: relevant for the level background state
end

function Background:update(dt,at)
    self.stateMachine:update(dt)
    self.at=at
end

function Background:render()
    love.graphics.draw(gTextures[self.texture],gFrames[self.texture][self.currentAnimation:getCurrentFrame()],0,self.y-(self.yf-1)*VIRTUAL_HEIGHT,0,math.ceil(self.xf*VIRTUAL_WIDTH/self.w),math.ceil(self.yf*VIRTUAL_HEIGHT/self.h))
end

function Background:changeState(stateName)
    self.stateMachine:change(stateName)
end

Entity = Class()

function Entity:construct(def)
    self.x=def.x
    self.y=def.y

    self.dx=0
    self.dy=0

    self.w=def.width
    self.h=def.height

    self.texture=def.texture
    self.stateMachine=def.stateMachine

    self.direction="right"

    self.map=def.map -- check relation between the entity and the tilemap so that collisions can be handled
end

function Entity:changeState(state,params)
    self.stateMachine:change(state,params)
end

function Entity:update(dt)
    self.stateMachine:update(dt)
end

function Entity:render()
    love.graphics.draw(gTextures[self.texture],gFrames[self.texture][self.currentAnimation.getCurrentFrame(self.currentAnimation)],math.floor(self.x+ self.w/2), math.floor(self.y+self.h/2),0,self.direction=="right" and 1 or -1, 1,math.floor(self.w/2),math.floor(self.h/2)) --currentAnimation will exist in the defined states
    --[[ love.graphics.circle('fill',DinoX1Convert(self.x),self.y + self.h,1)
    love.graphics.circle('fill',DinoX2Convert(self.x),self.y +self.h,1) ]] 

end


PlayerFallingState= Class(BaseState)

function PlayerFallingState:construct(player)
    BaseState.construct(self)
    self.player=player
    self.animation= Animation({
        frames={13,15},
        interval=0.3
    })
    self.player.currentAnimation=self.animation
end

function PlayerFallingState:update(dt)
    self.player.currentAnimation:update(dt)
    self.player.dy=self.player.dy + GRAVITY*dt
    self.player.y=self.player.y + (self.player.dy*dt)
 
    
    if(self.player:checkVerticalCollisions()) then
        if not self.player.Controller.goLeft() and not self.player.Controller.goRight() then
            self.player:changeState('idle')
        else
            self.player:changeState('walking')
        end
    end
    
    

    if (self.player.Controller.goLeft()) then
        self.player:moveLeft(dt,false)
    elseif (self.player.Controller.goRight()) then
        self.player:moveRight(dt,false)
    end

end

function PlayerFallingState:enter()
    BaseState.enter(self)
end
function PlayerFallingState:exit()
    BaseState.exit(self)
end
function PlayerFallingState:render()
    BaseState.render(self)
end


    
            


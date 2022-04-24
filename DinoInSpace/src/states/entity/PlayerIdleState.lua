PlayerIdleState= Class(BaseState)

function PlayerIdleState:construct(player)
    BaseState.construct(self)
    self.player=player
    self.animation = Animation({
        frames={1,2,3,4},
        interval=0.3
    })
    self.player.currentAnimation=self.animation
end

function PlayerIdleState:update(dt)
    self.player.currentAnimation:update(dt)
    if(self.player.lastY) then
        self.player:updateScore()
    end
    
    if not self.player:checkVerticalCollisions() then
        self.player:changeState('falling')
    end
    
    if self.player.Controller.jump() then
        self.player:changeState('jump',self.player.y)
    end

    if (self.player.Controller.goLeft() or self.player.Controller.goRight()) then
        self.player:changeState('walking')
    end



    

end

function PlayerIdleState:enter()
    BaseState.enter(self)
end
function PlayerIdleState:exit()
    BaseState.exit(self)
end
function PlayerIdleState:render()
    BaseState.render(self)
end
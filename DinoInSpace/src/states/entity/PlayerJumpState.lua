PlayerJumpState=Class(BaseState)

function PlayerJumpState:construct(player)
    BaseState.construct(self)
    self.player=player
    self.animation= Animation({
        frames={13},
        interval=1
    })
    self.player.currentAnimation=self.animation
end

function PlayerJumpState:enter(lasty)
    self.player.dy=INITIAL_JUMP_VELOCITY
    self.player:updateJumpSpeed()
    self.player.counter=0 --reset counter
    self.player.lastY=lasty
    gSounds['jump']:stop()
    gSounds['jump']:play()
end

function PlayerJumpState:update(dt)
    self.player.dy=self.player.dy + GRAVITY*dt
    self.player.y=self.player.y + (self.player.dy*dt)

    if(self.player.dy>=0) then
        self.player:changeState('falling')
    end
    if(self.player.Controller.goRight()) then
        self.player:moveRight(dt,false)
    end

    if(self.player.Controller.goLeft()) then
        self.player:moveLeft(dt,false)
    end

    --if (love.keyboard.isDown('right')) then
    --    self.player:moveRight(dt,false)
    --end
--
    --if (love.keyboard.isDown('left')) then
    --    self.player:moveLeft(dt,false)
    --end
end

function PlayerJumpState:exit()
    BaseState.exit(self)
end

function PlayerJumpState:render()
    BaseState.exit(self)
end
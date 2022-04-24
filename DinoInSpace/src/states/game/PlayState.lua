PlayState= Class(BaseState)

function PlayState:construct()
    BaseState.construct(self)
    self.occ=0
    self.camDY=0
    self.camY=0
    self.at=0
    self.map=TileMap(TileGen:Generate({
        ['init']=true,
    }))
    self.background=Background({
        stateMachine=StateMachine({
            ['level']=function() return LevelBackground(self.background) end,
            ['trans']=function() return TransitionBackground(self.background) end
        })
    })
    self.background:changeState('level')
    self.player=Player({
        ['x'] = VIRTUAL_WIDTH/2,
	    ['y'] = VIRTUAL_HEIGHT/2,
	    ['width'] = DINO_WIDTH,
	    ['height'] = DINO_HEIGHT,
	    ['texture'] = 'dino'..tostring(math.random(4)),
	    ['map']=self.map,
	    ['stateMachine']=StateMachine({
		falling= function() return PlayerFallingState(self.player) end,
		idle= function() return PlayerIdleState(self.player) end,
		walking = function() return PlayerWalkingState(self.player) end,
		jump = function() return PlayerJumpState(self.player) end
	}),
    ['controller']=PlayerController()
})
    self.player:changeState('falling')
    gSounds['music']:setLooping(true)
    gSounds['music']:play()
end

function PlayState:update(dt)
    local atBefore=self.at  -- used to calculate the score
    local atAfter

    if(self.map:inCriticalSection( convertAtToY(self.at))) then
        self.player.y=resetY(self.player.y)
        self.camY=0
        self:updateCam(dt) -- Compensate the resetY
        self.map:downWardShift()
        self.map:push(TileGen:Generate({},self.map.lastY))
    end
    self.player:update(dt)
    self:updateCam(dt)

    atAfter=((self.at>atBefore) and self.at) or (self.at + (CHUNKS_TOTAL-CMODE)*SCREEN_TILE_HEIGHT*TILE_SIZE)
    self.player.score=self.player.score + math.pow((atAfter - atBefore)/SCORE_SCALE, 2)

    self:playerLose(dt)
    self.background:update(dt,self.at)
    
end

function PlayState:updateCam(dt)
    self.camDY=math.min(self.camDY + DIFFICULTY*dt*dt,MAXCAMSPEED)
    self.camY=self.camY + self.camDY*dt
    self.at=math.max(self.camY, ((self.player.y < convertAtToY(self.at)) and - math.floor(self.player.y - VIRTUAL_HEIGHT/CAMSCALAR))or 0)
    self.camY=self.at
end

function PlayState:render()
    self.background:render()  --not affected by the translate operation
    love.graphics.print(tostring(math.floor(self.player.score)),gFonts['main'],0,0,0,PLAYT,PLAYT)    
    love.graphics.translate(0,self.at)
    self.map:render()
    self.player:render()
end

function PlayState:playerLose(dt)
    if ((self.player.y + 8) > convertAtToY(self.at)) then
        gSounds['lose']:play()
        GstateMachine:change('gameover',self.player.score)
    end
end

function PlayState:enter() end
function PlayState:exit()
    gSounds['music']:stop()
end
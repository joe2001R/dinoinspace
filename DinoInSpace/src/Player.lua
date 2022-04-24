Player = Class(Entity)

function Player:construct(def)
    Entity.construct(self,def)
    self.Controller=def.controller
    self.lastY=nil
    self.score=0
    self.counter=COMBO
    self.streak=0
end

function Player:update(dt)
    Entity.update(self,dt)
    if(self.counter>COMBO) then
    else
        self.counter=self.counter+dt
    end
end

function Player:render()
    Entity.render(self)
end

function Player:checkHorizontalCollisions()
    if ((DinoX1Convert(self.x) - 1 < 3 )) then
        self.x=invX1(3)
    end
    if ((DinoX2Convert(self.x) + 1)>VIRTUAL_WIDTH - 3) then
        self.x= invX2(VIRTUAL_WIDTH - 3)
    end
end

function Player:checkVerticalCollisions() --used only when falling and walking. For better use, check 1px ahead of player's box by temporarily changing the y.
    local leftBottomTile=self.map:pointToTile(DinoX1Convert(self.x),self.y + self.h)
    local rightBottomTile=self.map:pointToTile(DinoX2Convert(self.x), self.y + self.h)
    if((leftBottomTile:collidable() or rightBottomTile:collidable())) then
        self.dy=0
        self.y=((leftBottomTile.y or rightBottomTile.y) - 1)*TILE_SIZE - self.h + 2  --fixing player's y so that the brick will be perfectly touched, max is used because nil tiles have could have a random y
        return true  -- implies: Falling --> idle/walking 
    end
    return false -- implies: walking/idle --> Falling
    -- need to check when walking, falling, or idle
end


function Player:move(dt,dir,checkVC)
    if (self.direction ~= dir) then
        self.dx=0
    end
    self.dx=self.dx + ((self.direction=='left' and -PLAYER_ACCELERATION*dt) or PLAYER_ACCELERATION*dt)
    self.direction=dir
    self.x=self.x + ((self.direction == 'left' and ( - PLAYER_WALKING_SPEED*dt)) or PLAYER_WALKING_SPEED*dt) + self.dx*dt
    self:checkHorizontalCollisions()
    if(checkVC) then
        if(not self:checkVerticalCollisions()) then
            self:changeState('falling')
        end
    end
end

function Player:moveLeft(dt,checkVC)
    self:move(dt,'left',checkVC)
end

function Player:moveRight(dt,checkVC)
    self:move(dt,'right',checkVC)
end

function Player:updateScore()
    self.score=self.score + math.max(math.pow((self.lastY - self.y)/math.pow(SCORE_SCALE,2),5),0) -- score never goes down
    self.lastY=nil
end

function Player:updateJumpSpeed()
    self.streak=self.streak+1
if(self.counter< (COMBO + math.sqrt(self.streak) - 1)) then
else
    self.streak=math.floor(math.sqrt(self.streak))
end
self.dy=math.max(self.dy + JUMP_VELOCITY_INCREMENT*self.streak,MAX_JUMP_VELOCITY)
end

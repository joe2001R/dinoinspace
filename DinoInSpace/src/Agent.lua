Agent = Class(Player)

function Agent:construct(def)
    Player.construct(self,def)
    self.plan={
        ['x']=nil,
        ['exists'] = false,
        ['done']=false,
        ['ymax'] = nil,
        ['ymin'] =nil,
        ['xmax']=nil,
        ['xmin']=nil
    }
end

function Agent:inform(dt)
    tdy=math.max(self.streak * JUMP_VELOCITY_INCREMENT + INITIAL_JUMP_VELOCITY + GRAVITY*dt,MAX_JUMP_VELOCITY)
    self.plan['ymax']=self.y + self.h - math.pow(tdy,2)/(2*GRAVITY)
    self.plan['ymin']=self.plan['ymax'] + (1-1/CAMSCALAR)*VIRTUAL_HEIGHT
    self.plan['xmax']= math.min((tdy/GRAVITY)*((PLAYER_ACCELERATION/2)*(tdy)/GRAVITY - PLAYER_WALKING_SPEED) + DinoX2Convert(self.x),VIRTUAL_WIDTH)
    self.plan['xmin']=math.max(DinoX1Convert(self.x)-(tdy/GRAVITY)*((PLAYER_ACCELERATION/2)*(tdy)/GRAVITY - PLAYER_WALKING_SPEED) - SCREEN_TILE_WIDTH,0)
    
end

function Agent:getPlan(dt)
    y=self.plan['ymax'] +5
    x=self.plan['xmax']

    while y < self.plan['ymin'] do
        x=self.plan['xmax']
        while x > self.plan['xmin'] do
            tile = self.map:pointToTile(x,y)
            if tile and tile:collidable() then
                self.plan['x']=(tile.x-1)*TILE_SIZE
                self.plan['exists']=true
                self.plan['done']=false
                return
            end
        x=x-SCREEN_TILE_WIDTH
        end
        y=y+SCREEN_TILE_HEIGHT
    end
    if self.plan['exists']==false then
    self.plan['x']=VIRTUAL_WIDTH/2
    self.plan['exists']=true
    self.plan['done']=false
    end
end

function Agent:update(dt)
    
    if (self.plan['exists']==false and self:checkVerticalCollisions()) then
    -- inform agent with relevant information
        self:changeState('idle') -- to prevent bugs (checkVerticalCollisions fixes the agent's position if true)
        self:inform(dt)
    -- come up with a plan if informed
        self:getPlan(dt)        
    end
    -- execute the plan if such a plan exists
    if (self.plan['exists']==true and not self.plan['done']==true) then    
        self.Controller.signals['jump']=true
        if self.x > self.plan['x'] then
        if DinoX1Convert(self.x)+(TILE_SIZE/2)>self.plan['x'] then  
        self.Controller.signals['left']=true
        elseif self.dy>0 then  --dy>0 --> dino is falling
        self.plan['done']=true
        self.plan['exists']=false
        end
        else
        if(DinoX2Convert(self.x)-(TILE_SIZE/2)<self.plan['x']) then
        self.Controller.signals['right']=true
        elseif self.dy>0 then
        self.plan['done']=true
        self.plan['exists']=false
        end
    end
end
    Player.update(self,dt)

    -- reset the commands
    for i in pairs(self.Controller.signals) do
        self.Controller.signals[i] = false
    end
end

function Agent:render()
    if(self.plan['x']) then  --for illustration purposes
    love.graphics.line(self.plan['xmin'],self.plan['ymin'],self.plan['xmin'],self.plan['ymax'])
    love.graphics.line(self.plan['xmax'],self.plan['ymin'],self.plan['xmax'],self.plan['ymax'])
    love.graphics.line(self.plan['xmin'],self.plan['ymin'],self.plan['xmax'],self.plan['ymin'])
    love.graphics.line(self.plan['xmin'],self.plan['ymax'],self.plan['xmax'],self.plan['ymax'])
    end
    Player.render(self)
end

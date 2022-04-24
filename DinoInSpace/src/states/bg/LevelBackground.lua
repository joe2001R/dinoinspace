LevelBackground= Class(BaseState)

function LevelBackground:construct(background)
    BaseState.construct(self)
    self.background=background
    self.background.texture='bgsp'..tostring(math.random(9))
    self.background.currentAnimation=Animation({
        frames={1,2,3,4},
        interval=0.3
    })
    self.background.w, self.background.h = QuadDim(gFrames['bgsp1'][1])
    self.background.yf, self.background.xf = 2,1
end

function LevelBackground:update(dt)
    self.background.currentAnimation:update(dt)
    self.background.y=(self.background.at)/PAR  -- for parallax
    if(self.background.y>(self.background.yf - 1)*VIRTUAL_HEIGHT) then
        self.background:changeState('trans')
    end
    
end

function LevelBackground:enter()
    self.background.y=0
end


function LevelBackground:render() end
function LevelBackground:exit() end
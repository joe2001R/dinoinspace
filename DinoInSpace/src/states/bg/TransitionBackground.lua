TransitionBackground= Class(BaseState)

function TransitionBackground:construct(background)
    BaseState.construct(self)
    self.background=background
    self.background.texture='trans'
    self.background.currentAnimation=Animation({
        frames=ret(function(par) while(#par<52) do
            table.insert(par,#par+1)
        end
        return par
    end, {}),
        interval=0.1
    })
    self.background.w, self.background.h = 250, 500
    self.background.yf, self.background.xf = 2,1
    self.timer=0
    self.interval=self.background.currentAnimation.interval*52*3
end

function TransitionBackground:update(dt)
    self.background.currentAnimation:update(dt)
    self.timer=self.timer+dt
    if(self.timer > self.interval) then
        self.background:changeState('level')
    else
        self.background.y=(self.timer/self.interval)*(self.background.yf-1)*VIRTUAL_HEIGHT --background will shift according to time.
    end
end

function TransitionBackground:enter()
    self.background.y=0
end


function TransitionBackground:render() end
function TransitionBackground:exit() end
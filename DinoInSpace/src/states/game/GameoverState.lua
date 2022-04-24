GameoverState = Class(BaseState)

function GameoverState:construct() 
    BaseState.construct(self)
    self.playerScore=0
end

function GameoverState:update(dt) 
    if(love.keyboard.wasPressed('return')) then
        GstateMachine:change('menu')
    end
end

function GameoverState:enter(score)
    self.playerScore=score
end

function GameoverState:render()
    local score='Score '..tostring(math.floor(self.playerScore))
    local ws=gFonts['main']:getWidth(score)
    
    local text="Press Enter to go back to the menu"
    local wt = gFonts['main']:getWidth(text)

    love.graphics.print(score,gFonts['main'],VIRTUAL_WIDTH/2 - ws/2,VIRTUAL_HEIGHT/2 -gFonts['main']:getHeight()/2,0,GAMEOVERT,GAMEOVERT)
    love.graphics.print(text,gFonts['main'],VIRTUAL_WIDTH/2 - wt/2, VIRTUAL_HEIGHT/2 +3*gFonts['main']:getHeight()/2,0,GAMEOVERT,GAMEOVERT)

end

function GameoverState:exit() end
MenuState = Class(BaseState)

function MenuState:construct() 
    BaseState.construct(self)
end

function MenuState:update(dt) 
    if(love.keyboard.wasPressed('a')) then
        GstateMachine:change('agent')
    elseif (love.keyboard.wasPressed('return')) then
        GstateMachine:change('play')
    end
    
end


function MenuState:enter()
end

function MenuState:render()
    local gamename="DINO IN SPACE"
    local ws=gFonts['main']:getWidth(gamename)
    
    local text="Press Enter to play, Press a to let an agent play for you "
    local wt = gFonts['main']:getWidth(text)

    love.graphics.print(gamename,gFonts['main'],VIRTUAL_WIDTH/2 - ws/2,VIRTUAL_HEIGHT/2 -gFonts['main']:getHeight()/2,0,MENUT,MENUT)
    love.graphics.print(text,gFonts['main'],VIRTUAL_WIDTH/2 - wt/2, VIRTUAL_HEIGHT/2 +3*gFonts['main']:getHeight()/2,0,MENUT,MENUT)

end

function GameoverState:exit() end
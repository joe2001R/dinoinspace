require "src/Dependencies"


function love.load()
	love.window.setTitle('Dino In Space')
	love.graphics.setDefaultFilter("nearest","nearest")
	push:setupScreen(VIRTUAL_WIDTH,VIRTUAL_HEIGHT,WINDOW_WIDTH,WINDOW_HEIGHT,{fullscreen=true, resizable=false, vsync=true})
	
	math.randomseed(os.time())
	GstateMachine=StateMachine({
		['play']=function () return PlayState() end,
		['agent'] = function() return AgentState() end,
		['gameover'] = function() return GameoverState() end,
		['menu'] = function() return MenuState() end
	})
	GstateMachine:change('menu')
	
	love.keyboard.keysPressed={}
end



function love.keypressed(key)
	if (key=="escape") then
		love.event.quit()
	end
	love.keyboard.keysPressed[key]=true
end

function love.keyboard.wasPressed(key)
	return love.keyboard.keysPressed[key]
end

function love.update(dt)
	GstateMachine:update(dt)
	love.keyboard.keysPressed = {}
end


function love.draw()
	push:start()
	GstateMachine:render()
	push:finish()
end
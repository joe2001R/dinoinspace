PlayerController = Class(Controller)

function PlayerController:construct()
    Controller.construct(self)
    self.goRight=function() return love.keyboard.isDown('right') end
    self.goLeft=function() return love.keyboard.isDown('left') end
    self.jump=function() return love.keyboard.wasPressed('space') end
end
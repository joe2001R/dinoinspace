AgentController = Class(Controller)

function AgentController:construct()
    Controller.construct(self)
    self.signals={
        ['jump']=false,
        ['left']=false,
        ['right']=false
    }
    self.goLeft = function () return self.signals['left'] end
    self.goRight=function() return self.signals['right'] end
    self.jump= function() return self.signals['jump'] end
end
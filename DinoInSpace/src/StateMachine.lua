StateMachine = Class()

function StateMachine:construct(states)
    self.empty = {
        render= function() end,
        update= function() end,
        enter= function() end,
        exit= function() end,
    }
    self.states=states or{}
    self.current=self.empty
end

function StateMachine:change(stateName,Parms)
    assert(self.states[stateName])
    self.current:exit()
    self.current = self.states[stateName]()
    self.current:enter(Parms)
end

function StateMachine:update(dt)
    self.current:update(dt)
end

function StateMachine:render()
    self.current:render()
end
Tile= Class()

function Tile:construct(x,y,id,set)  --x,y coordinates will be referring to the virtualscreen dimensions in terms of tiles 
    self.x=x
    self.y=y

    self.id=id
    self.set=set  --later for variety if i was successful finding any good thing free
end

function Tile:collidable()
    if(self.id) then
        return true
    end
end

function Tile:alter(y)
    self.y=y
end

function Tile:render()
    if(self.id) then
        love.graphics.draw(gTextures['tiles'],gFrames['tiles'][self.id],(self.x-1)*TILE_SIZE,(self.y-1)*TILE_SIZE)
    end
end
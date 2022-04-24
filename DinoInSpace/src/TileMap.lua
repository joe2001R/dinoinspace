-- Table <--> (x,y) coordinate
TileMap = Class()

function TileMap:construct(tiles,lastY,flag)
    self.width=SCREEN_TILE_WIDTH
    self.height=CHUNKS_TOTAL*SCREEN_TILE_HEIGHT
    self.tiles=tiles or {}   -- row by row generation
    self.lastY=lastY
    self.flag=( flag or {})  --rows that are empty
    self.occ=0
end

function TileMap:pointToTile(x,y)
    if x < 0 or x > self.width * TILE_SIZE then
        return nil
    end
    return self.tiles[math.floor(tileYConverter(y) / TILE_SIZE) + 1][math.floor(x / TILE_SIZE) + 1]
end


function TileMap:render()
    for y =self.height,1,-1 do
        for x = 1, self.width do
            self.tiles[y][x]:render()
        end
    end
end

function TileMap:returnSection(y)
    return math.ceil( tileYConverter(y) / (SCREEN_TILE_HEIGHT*TILE_SIZE) )
end

function TileMap:downWardShift() -- {s1, s2, s3,s4,s5} (leftmost section <-->bottommost section) --> {s4,s5, s6, s7, s8} (will be fixed later by tileGen)
    self.occ=self.occ+1
    local counter=SCREEN_TILE_HEIGHT
    for k=(CMODE+1-CHUNKS_TOTAL)*SCREEN_TILE_HEIGHT,(1-CHUNKS_TOTAL)*SCREEN_TILE_HEIGHT + 1,-1 do
        if(isIn(k,self.flag)) then
            self.tiles[tileYindexConverter(counter)]=self.tiles[tileYindexConverter(k)]
        else
            for x=1,SCREEN_TILE_WIDTH,1 do
                if(self.tiles[tileYindexConverter(k)][x].id ~= nil) then
                    self.tiles[tileYindexConverter(k)][x]:alter(self.tiles[tileYindexConverter(k)][x].y + (CHUNKS_TOTAL-CMODE)*SCREEN_TILE_HEIGHT)
                end
                self.tiles[tileYindexConverter(counter)][x]=self.tiles[tileYindexConverter(k)][x]
            end
        end
        counter=counter - 1
    end
end

function TileMap:push(tiles,lasty,flag)
    self.lastY=lasty -- update lastY
    self.flag=flag --update flags
    for k=(1-CMODE)*SCREEN_TILE_HEIGHT,(CMODE - CHUNKS_TOTAL - 1)*SCREEN_TILE_HEIGHT + 1,-1 do
        self.tiles[tileYindexConverter(k)]=tiles[tileYindexConverter(k)]
    end
end

function TileMap:inCriticalSection(y)
    return TileMap:returnSection(y)==CHUNKS_TOTAL-(CMODE-1)
end





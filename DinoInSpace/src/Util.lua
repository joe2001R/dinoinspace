function table.slice(tb, i, f, step)
    local rtable={}
    for x = i or 1, f or #tb, step or 1 do
        rtable[#rtable + 1]=tb[x]
    end
    return rtable
end

function GenerateQuads(atlas,w,h)
    pw,ph = atlas:getDimensions()
    quads={} 
    tw= pw/w
    th=ph/h
    for j = 1, th, 1 do
        for i = 1,tw, 1 do
            quads[#quads+1]=love.graphics.newQuad((i-1)*w,(j-1)*h,w,h,pw,ph)
        end
    end
    return quads
end

function QuadDim(Quad)
    x,y,w,h = Quad:getViewport()
    return w,h
end

function ret(funct,params)
    return funct(params)
end

function table.reverse(table)
    rtable={}
    for i = #table, 1 , -1 do
        rtable[#rtable+1]=table[i]
    end
    return rtable
end

function tileYindexConverter(y)
    return (((y>0) and y) or (SCREEN_TILE_HEIGHT + 1 - y))
end

function tileYConverter(y)
    return (((y>0)and y) or ((SCREEN_TILE_HEIGHT)*TILE_SIZE - y)) -- particular for the significance of the tiles table's column indices 
end

function DinoX1Convert(x)
    return x + (DINO_WIDTH-DINO_TWIDTH)/2
end

function DinoX2Convert(x)
    return x + DINO_WIDTH - (DINO_WIDTH-DINO_TWIDTH)/2
end

function invX1(x)
    return x - (DINO_WIDTH-DINO_TWIDTH)/2 
end

function invX2(x)
    return x - DINO_WIDTH + (DINO_WIDTH-DINO_TWIDTH)/2
end

function isIn(e,S)
    for k,v in ipairs(S) do
        if e==v then
            return true
        end
    end
return false
end

function randBtw(a,b)  --assuming b>=a 
    return a - 1 + math.random(b - a + 1)
end


function strictlyBetween(a,b,x) -- assumes b>a, test a< x <b
    return (x>a) and (x<b)
end

function resetY(y)
    return y + (CHUNKS_TOTAL-CMODE)*SCREEN_TILE_HEIGHT*TILE_SIZE
end

function convertAtToY(at)
    return SCREEN_TILE_HEIGHT*TILE_SIZE - at
end

function tilesToXY(tile)
    return (tile.x-1)*TILE_SIZE, (tile.y-1)*TILE_SIZE
end
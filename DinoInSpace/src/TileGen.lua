TileGen=Class()


function TileGen:Generate(def,last)
    tiles={}
    local flag={}
    for i=1,(CHUNKS_TOTAL)*SCREEN_TILE_HEIGHT,1 do --chunks will be multiple of SCREEN_TILE_HEIGHT
        table.insert(tiles,{}) -- initalize all rows to be empty
    end
    local rowPointer=(not last and SCREEN_TILE_HEIGHT) or (1 - CMODE)*SCREEN_TILE_HEIGHT --bottom row first or second section/chunk
    if def.init==true then
        local ly=rowPointer - (def.inith or 3)
        for y=rowPointer, ly ,-1 do
            for x=1, SCREEN_TILE_WIDTH, 1 do
                table.insert(tiles[tileYindexConverter(rowPointer)],Tile(x,y,((y == ly) and (((x == 1) and (LEFT))or ((x==SCREEN_TILE_WIDTH) and (RIGHT)) or MIDDLE)) or (((x == 1) and (NLEFT))or ((x==SCREEN_TILE_WIDTH) and (NRIGHT)) or NMIDDLE),nil))
            end
            rowPointer=rowPointer-1 --move upward
        end
    end
    local lastY=(last and (last + CMODE*SCREEN_TILE_HEIGHT)) or (SCREEN_TILE_HEIGHT - (def.inith or 3))
    
    if(last) then
        for x=1,SCREEN_TILE_WIDTH,1 do
            table.insert(tiles[tileYindexConverter(rowPointer)],Tile(x,rowPointer,(strictlyBetween(1,SCREEN_TILE_WIDTH,x) and MIDDLE) or ((x==1) and LEFT) or RIGHT,nil))
        end
        lastY=rowPointer
        rowPointer=rowPointer-1
    end 

    lastY=randBtw(lastY-MAXY,lastY-MINY)

    local tLastY=lastY --the true last Y after the algorithm is done

    for y=rowPointer,1 - (CHUNKS_TOTAL - 1)*SCREEN_TILE_HEIGHT,-1 do
        if(y~=lastY) then
            for x=1, SCREEN_TILE_WIDTH, 1 do
                table.insert(tiles[tileYindexConverter(rowPointer)],Tile(nil,nil,nil,nil))
            end
            if (tileYindexConverter(y)>((CHUNKS_TOTAL-CMODE)*SCREEN_TILE_HEIGHT)) then
                table.insert(flag,y)
            end
        else
            local done=false
            local updateY=false
            local lastX=1
            local pointer=1
            while(not done) do
                lastX=math.min(randBtw(lastX,SCREEN_TILE_WIDTH),randBtw(lastX,SCREEN_TILE_WIDTH))
                for x=pointer,lastX-1,1 do
                    table.insert(tiles[tileYindexConverter(rowPointer)],Tile(nil,nil,nil,nil))
                    pointer=pointer + 1
                end
                
                local width=randBtw(1,math.min(SCREEN_TILE_WIDTH-lastX-1,5))
                for x=pointer,lastX+width,1 do
                    table.insert(tiles[tileYindexConverter(rowPointer)],Tile(x,rowPointer,((width==1)and(ALONE))or(strictlyBetween(lastX,lastX+width,x) and MIDDLE) or ((x==lastX) and LEFT) or (RIGHT),nil))
                    pointer=pointer + 1
                end
                lastX=math.min(lastX+width,SCREEN_TILE_WIDTH)

                if((math.random() < PB_X) and (lastX~=SCREEN_TILE_WIDTH)) then
                else
                    done=true
                    for x=pointer,SCREEN_TILE_WIDTH,1 do
                        table.insert(tiles[tileYindexConverter(rowPointer)],Tile(x,rowPointer,nil,nil))
                    end
                    updateY=true
                end
                if(pointer==(SCREEN_TILE_WIDTH + 1)) then
                    done=true
                    updateY=true
                end
                if(updateY) then
                    tlastY=lastY
                    lastY=randBtw(lastY-MAXY,lastY-MINY)
                end
            end
        end
        rowPointer=rowPointer-1
    end
    return tiles,tlastY,flag
end

        
        
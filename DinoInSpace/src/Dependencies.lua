
--libraries
push = require "lib/push"
require "lib/class"

--code
require "src/Constants"
require "src/Util"
require "src/Entity"
require "src/Player"
require "src/Agent"
require "src/Animation"
require "src/Tile"
require "src/TileMap"
require "src/TileGen"
require "src/Background"
require "src/controller/Controller"
require "src/controller/PlayerController"
require "src/controller/AgentController"

--states
require "src/StateMachine"
require "src/states/BaseState"

require "src/states/entity/PlayerFallingState"
require "src/states/entity/PlayerIdleState"
require "src/states/entity/PlayerJumpState"
require "src/states/entity/PlayerWalkingState"

require "src/states/bg/TransitionBackground"
require "src/states/bg/LevelBackground"

require "src/states/game/PlayState"
require "src/states/game/GameoverState"
require "src/states/game/AgentState"
require "src/states/game/MenuState"

gSounds={
    ['jump']=love.audio.newSource('sounds/jump.wav','static'),                  --src: https://elements.envato.com
    ['lose']=love.audio.newSource('sounds/lose.wav','static'),
    ['music']=love.audio.newSource('sounds/music.wav','static')
}

gFonts={
    ['main']=love.graphics.newFont('fonts/ARCADECLASSIC.TTF')                   --src:https://www.1001fonts.com
}

gTextures = {
    ["dino1"]= love.graphics.newImage('graphics/char/DinoSprites - doux.png'),  --src: https://arks.itch.io/dino-characters
    ["dino2"]= love.graphics.newImage('graphics/char/DinoSprites - mort.png'),
    ["dino3"]= love.graphics.newImage('graphics/char/DinoSprites - tard.png'),
    ["dino4"]= love.graphics.newImage('graphics/char/DinoSprites - vita.png'),

    ["bgsp1"]= love.graphics.newImage("graphics/bg/space1_4-frames.png"),       --src: https://vectorpixelstar.itch.io/space
    ["bgsp2"]= love.graphics.newImage("graphics/bg/space2_4-frames.png"),  
    ["bgsp3"]= love.graphics.newImage("graphics/bg/space3_4-frames.png"),
    ["bgsp4"]= love.graphics.newImage("graphics/bg/space4_4-frames.png"),
    ["bgsp5"]= love.graphics.newImage("graphics/bg/space5_4-frames.png"),
    ["bgsp6"]= love.graphics.newImage("graphics/bg/space6_4-frames.png"),
    ["bgsp7"]= love.graphics.newImage("graphics/bg/space7_4-frames.png"),
    ["bgsp8"]= love.graphics.newImage("graphics/bg/space8_4-frames.png"),
    ["bgsp9"]= love.graphics.newImage("graphics/bg/space9_4-frames.png"),

    ['trans']=love.graphics.newImage('graphics/bg/transition.png'),             --src: https://opticalcamouflage.tumblr.com/post/60778645471
    ['tiles']=love.graphics.newImage('graphics/brick_tiles_v2.png')             --src: https://nearestneighbor.itch.io/platformer-brick-tileset?download
}

gFrames = {
    ['dino1']= GenerateQuads(gTextures['dino1'],24,24), --excess in the y axis --> remove 4 pixels in Player objects
    ['dino2']= GenerateQuads(gTextures['dino2'],24,24),
    ['dino3']= GenerateQuads(gTextures['dino3'],24,24),
    ['dino4']= GenerateQuads(gTextures['dino4'],24,24),
    ['trans']=table.reverse(GenerateQuads(gTextures['trans'],250,500)),
    ['tiles']=table.slice(GenerateQuads(gTextures['tiles'],16,16),1,7,1)

}
for i=1,9,1 do
    gFrames['bgsp'..tostring(i)]=GenerateQuads(gTextures['bgsp'..tostring(i)],64,64)
end
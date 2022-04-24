--Game Configuration

--display configuration

VIRTUAL_WIDTH = 384
VIRTUAL_HEIGHT = 216

WINDOW_WIDTH = 1920
WINDOW_HEIGHT = 1080

TILE_SIZE = 16

SCREEN_TILE_WIDTH= math.ceil(VIRTUAL_WIDTH/TILE_SIZE)
SCREEN_TILE_HEIGHT= math.ceil(VIRTUAL_HEIGHT/TILE_SIZE)


--Procedural generation
CHUNKS_TOTAL = 20
CMODE=2  -- CMODE is the number of chunks that will be kept in the procedural generation process

MAXY=7
MINY=3
PB_X=0.5

--Player + world configuration

GRAVITY = 800

INITIAL_JUMP_VELOCITY = -400
JUMP_VELOCITY_INCREMENT = -40
MAX_JUMP_VELOCITY = -600
PLAYER_WALKING_SPEED=200
PLAYER_ACCELERATION=200

PAR=13 -- Parallax. should be changed according to CHUNKS_TOTAL. Otherwise, transition will not be possible

SCORE_SCALE=10
COMBO=2 --counter limit(in seconds) that will reset dino's jump height

MAXCAMSPEED=150
DIFFICULTY=100 --affects the camera speed
CAMSCALAR = 4 -- Greater value --> less space above the player as he gets higher

--sprites

--Dino sprite
DINO_WIDTH=24
DINO_TWIDTH=8  --Dino true width -- will be used during vertical collision checking
DINO_HEIGHT=18

--bricks
LEFT,MIDDLE,RIGHT,ALONE = 1,2,3,4 --bricks IDs according to Quad Table
NLEFT,NMIDDLE,NRIGHT = 5,6,7

COLLIDABLE = {
    LEFT, MIDDLE, RIGHT, ALONE
}

--text size scale factor    
GAMEOVERT=1
MENUT=1
PLAYT=1
package gamedata


//= Imports
import "vendor:raylib"
import "../graphics/sprites"


//= Globals
worldstate   : ^Worldstate
player       : ^Player

enemyList    : [dynamic]Enemy
seedList     : [dynamic]Seed


attackSprite : sprites.Sprite
seedSprite   : sprites.Sprite
enemySprite  : sprites.Sprite

hpbarTex_1   : raylib.Texture
hpbarTex_2   : raylib.Texture


//= Constants
DEBUG :: true

SCREEN_WIDTH  :: 1080
SCREEN_HEIGHT ::  720


//= Structures

package gamedata


//= Imports
import "vendor:raylib"
import "../graphics/sprites"


//= Constants
PLAYER_BOUNDING_MIN_X :                : -2.5
PLAYER_BOUNDING_MIN_Y :                : -1.5
PLAYER_BOUNDING_MAX_X :                :  2.5
PLAYER_BOUNDING_MAX_Y :                :  3.5
PLAYER_STARTING       : raylib.Vector2 : {0,50}
PLAYER_STARTING_HP    :                :  10


//= Structures
Player :: struct {
	camera       : raylib.Camera2D,
	sprite       : sprites.Sprite,
	attackSprite : sprites.Sprite,

	//* Stats
	healthMax : u32,
	healthCur : u32,
	iframes   : u32,
	
	seeds     : u32,
}
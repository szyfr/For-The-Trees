package gamedata


//= Imports
import "vendor:raylib"
import "../graphics/sprites"


//= Constants
ENEMY_BOUNDING_SIZE_1_MIN_X :: -2.5
ENEMY_BOUNDING_SIZE_1_MIN_Y :: -1.5
ENEMY_BOUNDING_SIZE_1_MAX_X ::  2.5
ENEMY_BOUNDING_SIZE_1_MAX_Y ::  3.5
ENEMY_HP_DEF :: 2


//= Structures
Enemy :: struct {
	sprite   : sprites.Sprite,
	position : raylib.Vector2,

	boundingbox : raylib.BoundingBox,
	treeTarget  : raylib.Vector2,

	healthMax : u32,
	healthCur : u32,
	iframes   : u32,
}

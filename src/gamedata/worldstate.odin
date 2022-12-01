package gamedata


//= Imports
import "core:time"
import "vendor:raylib"
import "../graphics/sprites"


//= Constants
TREE_HEALTH_MAX :: 20


//= Structures
Worldstate :: struct {
	background : sprites.Sprite,
	tree       : sprites.Sprite,

	treeBounds : raylib.BoundingBox,

	treeHealthMax : u32,
	treeHealthCur : u32,

	clock      : time.Stopwatch,
	besttime   : i64,
	maxEnemies : u32,
	spawnTimer : u32,
}
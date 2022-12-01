package worldstate


//= Imports
import "core:fmt"
import "core:time"
import "core:os"
import "vendor:raylib"
import "../gamedata"
import "../graphics/sprites"
import "../graphics/sprites/animations"


//= Procedures

//* Initialization
init_worldstate :: proc() {
	using raylib, gamedata

	worldstate = new(Worldstate)

	//* Creating sprites for background and tree
	worldstate.background = sprites.create_sprite("data/sprites/bg.png")
	worldstate.tree       = sprites.create_sprite(
		filename = "data/sprites/tree.png",
		dim      = {211,218},
	)

	//* Create animations
	// TODO: Tree life states
	animations.add_animation(&worldstate.background, {0}, 10, false)
	animations.add_animation(&worldstate.tree      , {0}, 10, false)

	//* General data
	worldstate.treeHealthMax = TREE_HEALTH_MAX
	worldstate.treeHealthCur = TREE_HEALTH_MAX
	worldstate.treeBounds    = {
		{-50, -20, 0}, 
		{ 50,  35, 0},
	}

	//* Clock
	time.stopwatch_reset(&worldstate.clock)
	time.stopwatch_start(&worldstate.clock)

	//* Load score if exists
	if os.exists("score") {
		scoreArr, succ := os.read_entire_file_from_filename("score")
		for i:=0;i<8;i+=1 do worldstate.besttime |= (i64(scoreArr[i]) << (u32(i)*8))
	}
}
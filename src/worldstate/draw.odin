package worldstate


//= Imports
import "core:math"
import "vendor:raylib"
import "../gamedata"
import "../graphics/sprites"


//= Procedures

//* Background
draw_background :: proc() {
	sprites.draw_sprite(
		&gamedata.worldstate.background,
		{
			-(gamedata.worldstate.background.dim.x / 2),
			-(gamedata.worldstate.background.dim.y / 2),
		},
	)
}

//* Tree
draw_tree :: proc() {
	sprites.draw_sprite(
		&gamedata.worldstate.tree,
		{
			- gamedata.worldstate.tree.dim.x/2,
			-(gamedata.worldstate.tree.dim.y/2) - 75,
		},
	)

	if gamedata.DEBUG do raylib.DrawBoundingBox(gamedata.worldstate.treeBounds, raylib.PURPLE)
}
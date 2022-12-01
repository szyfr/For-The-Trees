package items


//= Imports
import "vendor:raylib"
import "core:math/rand"
import "../graphics"
import "../gamedata"


//= Procedures

//* Generate seed
create_seed :: proc(
	posi : raylib.Vector2,
) {
	seed : gamedata.Seed = {
		sprite   = gamedata.seedSprite,
		position = posi,
		amount   = 1,
	}

	append(&gamedata.seedList, seed)
}
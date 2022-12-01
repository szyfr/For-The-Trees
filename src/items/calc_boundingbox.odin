package items


//= Imports
import "vendor:raylib"
import "core:math/rand"
import "../graphics"
import "../gamedata"


//= Constants
SEED_BOUNDS_X :: 4
SEED_BOUNDS_Y :: 4


//= Procedures

//* Calculate bounding box
calc_seed_bounds :: proc(
	seed : gamedata.Seed,
) -> raylib.BoundingBox {
	bb : raylib.BoundingBox = {
		min = {
			(seed.position.x + (seed.sprite.dim.x / 2)) - SEED_BOUNDS_X,
			(seed.position.y + (seed.sprite.dim.y / 2)) - SEED_BOUNDS_Y,
			0,
		},
		max = {
			(seed.position.x + (seed.sprite.dim.x / 2)) + SEED_BOUNDS_X,
			(seed.position.y + (seed.sprite.dim.y / 2)) + SEED_BOUNDS_Y,
			0,
		},
	}

	return bb
}
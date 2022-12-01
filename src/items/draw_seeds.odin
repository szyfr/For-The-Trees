package items


//= Imports
import "vendor:raylib"
import "core:math/rand"
import "../graphics/sprites"
import "../gamedata"


//= Procedures

//* Draw seeds
draw_seeds :: proc() {
	for i:=0;i<len(gamedata.seedList);i+=1 {
		sprites.draw_sprite(
			&gamedata.seedList[i].sprite,
			gamedata.seedList[i].position,
		)

		if gamedata.DEBUG {
			raylib.DrawBoundingBox(calc_seed_bounds(gamedata.seedList[i]), raylib.PURPLE)
		}
	}
}
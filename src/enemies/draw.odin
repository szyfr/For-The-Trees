package enemies


//= Imports
import "vendor:raylib"
import "core:fmt"
import "../gamedata"
import "../graphics/sprites"


//= Procedures

//* Draw enemies
draw_enemies :: proc() {
	using raylib, gamedata

	for i:=0;i<len(enemyList);i+=1 {
		sprites.draw_sprite(
			&enemyList[i].sprite,
			enemyList[i].position,
		)
		if DEBUG do raylib.DrawBoundingBox(enemyList[i].boundingbox, raylib.PURPLE)
	}
}
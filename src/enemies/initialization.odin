package enemies


//= Imports
import "vendor:raylib"
import "core:math/rand"
import "../graphics"
import "../gamedata"


//= Procedures

//* Generate enemy
create_enemy :: proc(
	position : raylib.Vector2 = {0,0},
	type     : u32            =  0,
) -> gamedata.Enemy {
	using raylib, gamedata

	enemy : Enemy = {}

	switch type {
		case:
			enemy.sprite    = enemySprite
			enemy.healthMax = ENEMY_HP_DEF
	}

	if position == {0,0} {
		// TODO: Spawning range in darkness except for north
		//enemy.position = {rand.float32_range()}
	} else do enemy.position = position
	enemy.boundingbox = {
		{(position.x + (enemy.sprite.dim.x / 2)) + ENEMY_BOUNDING_SIZE_1_MIN_X, (position.y + (enemy.sprite.dim.y / 2)) + ENEMY_BOUNDING_SIZE_1_MIN_Y, 0},
		{(position.x + (enemy.sprite.dim.x / 2)) + ENEMY_BOUNDING_SIZE_1_MAX_X, (position.y + (enemy.sprite.dim.y / 2)) + ENEMY_BOUNDING_SIZE_1_MAX_Y, 0},
	}
	enemy.treeTarget  = {rand.float32_range(-45,45),rand.float32_range(-15,25)}
	enemy.healthCur   = enemy.healthMax

	return enemy
}
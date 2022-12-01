package enemies


//= Imports
import "vendor:raylib"
import "core:fmt"
import "core:math"
import "core:math/rand"
import "../items"
import "../gamedata"
import "../graphics"
import "../graphics/sprites/animations"
import "../player"


//= Procedures

//* Update all enemies
update_enemies :: proc() {
	using gamedata

	for i:=0;i<len(enemyList);i+=1 {
		if !update_single_enemy(i) do i-=1
	}
}

//* Update single enemy
update_single_enemy :: proc(
	member : int,
) -> bool {
	mem := &gamedata.enemyList[member]

	if mem.iframes != 0 {
		mem.iframes -= 1
		return true
	}

	//= Movement
	// ? Step 1: Check for player or plants in range
	//TODO: plants
	//* Player
	playerDist := distance(gamedata.player.camera.target, mem.position)

	// ? Step 2: Run to target
	if playerDist < 50 {
		//move to player
		mem.position = move_to(
			mem.position,
			gamedata.player.camera.target,
		)
	} else {
		//Move to tree
		mem.position = move_to(
			mem.position,
			mem.treeTarget,
		)
	}
	//* Update bounding box
	mem.boundingbox = {
		{(mem.position.x + (mem.sprite.dim.x / 2)) + gamedata.ENEMY_BOUNDING_SIZE_1_MIN_X, (mem.position.y + (mem.sprite.dim.y / 2)) + gamedata.ENEMY_BOUNDING_SIZE_1_MIN_Y, 0},
		{(mem.position.x + (mem.sprite.dim.x / 2)) + gamedata.ENEMY_BOUNDING_SIZE_1_MAX_X, (mem.position.y + (mem.sprite.dim.y / 2)) + gamedata.ENEMY_BOUNDING_SIZE_1_MAX_Y, 0},
	}

	//* Check collision with player attack
	atkBounds := player.player_attack_bounds()
	if raylib.CheckCollisionBoxes(
		atkBounds,
		mem.boundingbox,
	) && mem.iframes <= 0 {
		mem.healthCur -=  1
		mem.iframes    = 30

		dif := mem.position - gamedata.player.camera.target
		mem.position += dif * 1
		mem.boundingbox = {}
	}

	//* Check collision with Big Tree tm
	if raylib.CheckCollisionBoxes(
		gamedata.worldstate.treeBounds,
		mem.boundingbox,
	) && mem.iframes <= 0 {
		gamedata.worldstate.treeHealthCur -= 1
		fmt.printf("fuck\n")
		remove(member)
		return false
	}

	//* Check health
	if mem.healthCur <= 0 {
		drop := int(rand.float32_range(0,10))
		if drop == 1 do items.create_seed(mem.position)
		remove(member)
		return false
	}

	//* Update iframes
	if mem.iframes > 0 {
		mem.iframes -=1
		animations.set_animation(&mem.sprite, 2)
		//TODO: Try and figure out knockback
		return true
	}

	//* Reset animation
	animations.set_animation(&mem.sprite, 0)

	//* End
	return true
}


//*
move_to :: proc(
	position : raylib.Vector2,
	target   : raylib.Vector2,
	maxspeed : f32 = 0.1,
) -> raylib.Vector2 {
	newPosition : raylib.Vector2 = {}

	diffX := clamp((target.x - position.x), -maxspeed, maxspeed)
	diffY := clamp((target.y - position.y), -maxspeed, maxspeed)

	newPosition.x = position.x + diffX
	newPosition.y = position.y + diffY

	return newPosition
}

//* Calculating the distance between two positions
distance :: proc(
	pos1 : raylib.Vector2,
	pos2 : raylib.Vector2,
) -> f32 {
	return math.sqrt(math.pow(f32(pos2.x - pos1.x), 2) + math.pow(f32(pos2.y - pos1.y), 2))
}

//* Clamping a f32 to a min and max value
clamp :: proc(
	value : f32,
	min   : f32,
	max   : f32,
) -> f32 {
	if value > max do return max
	if value < min do return min
	return value
}

abs :: proc(
	value : f32,
) -> f32 {
	if value < 0 do return -value
	return value
}
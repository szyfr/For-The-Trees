package player


//= Imports
import "core:math"
import "vendor:raylib"
import "../gamedata"
import "../graphics"


//= Procedures

//* 
check_player_collisions :: proc(position : raylib.Vector2) -> bool {
	using raylib, gamedata

	//* Check center tree
	if CheckCollisionBoxes(
		{
			{position.x + PLAYER_BOUNDING_MIN_X, position.y + PLAYER_BOUNDING_MIN_Y, 0},
			{position.x + PLAYER_BOUNDING_MAX_X, position.y + PLAYER_BOUNDING_MAX_Y, 0},
		},
		{
			{-50, -20, 0},
			{ 50,  35, 0},
		},
	) {
		return false
	}

	return true
}
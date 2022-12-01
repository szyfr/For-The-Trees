package player


//= Imports
import "core:math"
import "vendor:raylib"
import "../gamedata"
import "../graphics"


//= Procedures

//* Get bounding box of player attack
player_attack_bounds :: proc() -> raylib.BoundingBox {
	using raylib, gamedata

	//* Checking if player is attacking
	if player.attackSprite.currentAnimation == 0 do return {}

	playerBounds := player_bounds()
	bounds : BoundingBox = {}

	if !player.sprite.flipped {
		bounds.min = {playerBounds.min.x - 10, playerBounds.min.y - 3  , 0 }
		bounds.max = {playerBounds.max.x -  8, playerBounds.max.y + 2.5, 0 }
	} else {
		bounds.min = {playerBounds.min.x +  8  , playerBounds.min.y - 3  , 0 }
		bounds.max = {playerBounds.max.x + 10.2, playerBounds.max.y + 2.5, 0 }
	}

	return bounds
}

//* Get Bounding box of player
player_bounds :: proc() -> raylib.BoundingBox {
	using raylib, gamedata

	bounds : BoundingBox = {
		{player.camera.target.x + PLAYER_BOUNDING_MIN_X, player.camera.target.y + PLAYER_BOUNDING_MIN_Y, 0},
		{player.camera.target.x + PLAYER_BOUNDING_MAX_X, player.camera.target.y + PLAYER_BOUNDING_MAX_Y, 0},
	}

	return bounds
}
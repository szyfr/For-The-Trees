package gamedata


//= Imports
import "vendor:raylib"
import "../graphics/sprites"


//= Constants

//= Structures
Seed :: struct {
	sprite   : sprites.Sprite,
	position : raylib.Vector2,
	amount   : int,
}
package animations


//= Imports
import "vendor:raylib"
import "../../sprites"


//= Procedures

//* Set current animation
set_animation :: proc(
	sprite    : ^sprites.Sprite,
	animation : u32,
) -> bool {
	if int(animation) > len(sprite.animationList) do return false

	//* Set new animation
	sprite.currentAnimation = animation

	return true
}

//* Reset animation timing
reset_animation :: proc(
	animation : ^sprites.Animation,
) {
	animation.frame      = 0
	animation.frameCount = 0
}
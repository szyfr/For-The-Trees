package sprites


//= Imports
import "vendor:raylib"
import "core:fmt"


//= Procedures

//* Generates a rectangle based on sprite
get_rect :: proc(
	sprite : ^Sprite,
) -> raylib.Rectangle {

	curAnimation := &sprite.animationList[sprite.currentAnimation]

	rect : raylib.Rectangle = {}
	rect.width  = sprite.dim.x
	rect.height = sprite.dim.y
	rect.x      = sprite.dim.x * f32(curAnimation.frameList[curAnimation.frame])
	rect.y      = 0

	return rect
}
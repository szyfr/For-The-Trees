package animations


//= Imports
import "vendor:raylib"
import "../../sprites"


//= Procedures

//* Add animation to sprite
add_animation :: proc(
	sprite    : ^sprites.Sprite,
	animation : [dynamic]u32,
	point     : i32 = 10,
	loop      : bool = true,
) {
	ani : sprites.Animation = {
		frame      = 0,
		frameList  = animation,
		loop       = loop,
		framePoint = point,
		frameCount = 0,
	}

	append(&sprite.animationList, ani)
}
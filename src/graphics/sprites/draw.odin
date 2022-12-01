package sprites


//= Imports
import "vendor:raylib"
import "core:fmt"


//= Procedures

//* Draw sprite and update animation
draw_sprite :: proc(
	sprite   : ^Sprite,
	position :  raylib.Vector2,
) {
	using raylib

	//* Animation
	if len(sprite.animationList) > 0 {
		curAnimation := &sprite.animationList[sprite.currentAnimation]

		curAnimation.frameCount += 1
		if curAnimation.frameCount >= curAnimation.framePoint {
			curAnimation.frameCount  = 0
			curAnimation.frame      += 1
			if int(curAnimation.frame) > len(curAnimation.frameList)-1 {
				if curAnimation.loop do curAnimation.frame = 0
				else {
					curAnimation.frame = 0
					sprite.currentAnimation = 0
				}
			}
		}
	}

	//* Drawing sprite
	rect := get_rect(sprite)
	if sprite.flipped do rect.width = -rect.width
	DrawTextureRec(
		sprite.texture,
		rect,
		position,
		sprite.color,
	)
}
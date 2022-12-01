package sprites


//= Imports
import "vendor:raylib"


//= Procedures

//* Create sprite

// TODO: look into merging instead of overloading
create_sprite :: proc{ create_sprite_full, create_sprite_nodim }

create_sprite_full :: proc(
	filename : cstring,
	dim      : raylib.Vector2,
) -> Sprite {
	sprite : Sprite = {}

	sprite.texture     = raylib.LoadTexture(filename)
	sprite.color       = raylib.WHITE
	sprite.dim         = dim
	sprite.spriteCount = sprite.texture.width / i32(dim.x)

	return sprite
}
create_sprite_nodim :: proc(
	filename : cstring,
) -> Sprite {
	sprite : Sprite = {}

	sprite.texture     = raylib.LoadTexture(filename)
	sprite.color       = raylib.WHITE
	sprite.dim         = {f32(sprite.texture.width), f32(sprite.texture.height)}
	sprite.spriteCount = sprite.texture.width / i32(sprite.dim.x)

	return sprite
}
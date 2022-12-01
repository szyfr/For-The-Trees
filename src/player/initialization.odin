package player


//= Imports
import "vendor:raylib"
import "../gamedata"
import "../graphics/sprites"
import "../graphics/sprites/animations"


//= Procedures
init_player :: proc() {
	using gamedata

	player = new(Player)
	
	//* Creating player sprite and animations
	player.sprite = sprites.create_sprite(
		filename = "data/sprites/sorax.png",
		dim      = {8,8},
	)
	animations.add_animation(&player.sprite, {0})
	animations.add_animation(&player.sprite, {1, 0, 2, 0})
	animations.add_animation(&player.sprite, {1, 3}, 7)

	//* Copying general melee attack animation
	player.attackSprite = attackSprite

	//* Setting starting Camera settings
	player.camera = {
		target   = PLAYER_STARTING,
		zoom     = 6,
	}
	player.camera.offset = {
		(gamedata.SCREEN_WIDTH  / 2) - (gamedata.player.sprite.dim.x / 2),
		(gamedata.SCREEN_HEIGHT / 2) + (gamedata.player.sprite.dim.y / 2),
	}

	//* Setting basic stats
	player.healthMax = PLAYER_STARTING_HP
	player.healthCur = PLAYER_STARTING_HP
	player.seeds     = 0
}
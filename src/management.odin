package main


//= Imports
import "vendor:raylib"
import "enemies"
import "items"
import "gamedata"
import "graphics/sprites"
import "graphics/sprites/animations"
import "player"
import "worldstate"



//= Procedures

//* Initialization
main_initialization :: proc() {
	//* Raylib
	if !gamedata.DEBUG do raylib.SetTraceLogLevel(raylib.TraceLogLevel.NONE)
	raylib.InitWindow(
		gamedata.SCREEN_WIDTH,
		gamedata.SCREEN_HEIGHT,
		"For the Trees",
	)
	raylib.SetTargetFPS(60)

	//* Worldstate
	worldstate.init_worldstate()

	//* Graphics
	// Attack
	gamedata.attackSprite = sprites.create_sprite("data/sprites/attack.png", raylib.Vector2{16,16})
	animations.add_animation(&gamedata.attackSprite, {0})
	animations.add_animation(&gamedata.attackSprite, {1,2,3,4,5}, 4, false)
	// Seed
	gamedata.seedSprite   = sprites.create_sprite("data/sprites/seed.png", raylib.Vector2{8,8})
	animations.add_animation(&gamedata.seedSprite, {0})
	// Enemy
	gamedata.enemySprite = sprites.create_sprite("data/sprites/enemy.png", raylib.Vector2{8,8})
	animations.add_animation(&gamedata.enemySprite, {1, 0, 2, 0}, 10)
	animations.add_animation(&gamedata.enemySprite, {1, 3}, 7)
	animations.add_animation(&gamedata.enemySprite, {1, 3}, 7)
	// HP bar
	gamedata.hpbarTex_1 = raylib.LoadTexture("data/sprites/hpbar_1.png")
	gamedata.hpbarTex_2 = raylib.LoadTexture("data/sprites/hpbar_2.png")
	
	//* Player
	player.init_player()
}

//* Free
main_free :: proc() {
	raylib.CloseWindow()
}
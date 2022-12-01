package player


//= Imports
import "core:math"
import "vendor:raylib"
import "../items"
import "../gamedata"
import "../graphics/sprites"
import "../graphics/sprites/animations"


//= Procedures

//* Movement
movement :: proc() {
	using raylib, gamedata

	//* Check enemies
	//TODO: Move this shit
	for i:=0;i<len(enemyList);i+=1 {
		if player.iframes <= 0 && enemyList[i].iframes <= 0 && CheckCollisionBoxes(
			player_bounds(),
			enemyList[i].boundingbox,
		) {
			player.iframes    = 30
			player.healthCur -=  1
			animations.set_animation(&player.sprite, 2)
			
			dif := player.camera.target - enemyList[i].position
			player.camera.target += dif * 1
			enemyList[i].iframes = 50
		}
	}

	//* Check seeds
	//TODO: Move this shit
	for i:=0;i<len(seedList);i+=1 {
		if CheckCollisionBoxes(
			player_bounds(),
			items.calc_seed_bounds(seedList[i]),
		) {
			player.seeds += 1
			worldstate.treeHealthCur += 1
			if worldstate.treeHealthCur > worldstate.treeHealthMax do worldstate.treeHealthCur = worldstate.treeHealthMax
			items.remove(i)
		}
	}

	//* Update iframes
	//TODO: Fix this shit
	if player.iframes > 0 {
		player.iframes -= 1
	}
	
	if player.iframes <= 0 {
		// TODO Check ALL collisions
		if IsKeyDown(raylib.KeyboardKey.W) {
			if check_player_collisions(
				{player.camera.target.x, player.camera.target.y-1.25},
			) {
				player.camera.target.y -= 1.25
				animations.set_animation(&player.sprite, 1)
			}
		}
		if IsKeyDown(raylib.KeyboardKey.S) {
			if check_player_collisions(
				{player.camera.target.x, player.camera.target.y+1.25},
			) {
				player.camera.target.y += 1.25
				animations.set_animation(&player.sprite, 1)
			}
		}
		if IsKeyDown(raylib.KeyboardKey.A) {
			if check_player_collisions(
				{player.camera.target.x-1.25, player.camera.target.y},
			) {
				player.camera.target.x -= 1.25
				player.sprite.flipped       = false
				player.attackSprite.flipped = false
				animations.set_animation(&player.sprite, 1)
			}
		}
		if IsKeyDown(raylib.KeyboardKey.D) {
			if check_player_collisions(
				{player.camera.target.x+1.25, player.camera.target.y},
			) {
				player.camera.target.x += 1.25
				player.sprite.flipped       = true
				player.attackSprite.flipped = true
				animations.set_animation(&player.sprite, 1)
			}
		}

		if  !IsKeyDown(raylib.KeyboardKey.W) && 
			!IsKeyDown(raylib.KeyboardKey.S) &&
			!IsKeyDown(raylib.KeyboardKey.A) &&
			!IsKeyDown(raylib.KeyboardKey.D) {
				animations.set_animation(&player.sprite, 0)
		}

		if IsKeyPressed(raylib.KeyboardKey.SPACE) {
			animations.set_animation(&player.attackSprite, 1)
		}
	}
}

//* Drawing
draw_player :: proc() {
	using raylib, gamedata, sprites

	//* Generating position for sprite and attack
	spritePos : Vector2 = {
		player.camera.target.x - (player.sprite.dim.x / 2),
		player.camera.target.y - (player.sprite.dim.y / 2),
	}
	attackpos : raylib.Vector2 = {
		player.camera.target.x - f32(player.attackSprite.dim.x/2),
		player.camera.target.y - f32(player.attackSprite.dim.y/2),
	}
	if player.sprite.flipped do attackpos.x += 5
	else                     do attackpos.x -= 5

	//* Drawing
	draw_sprite(
		&player.sprite,
		spritePos,
	)
	draw_sprite(
		&player.attackSprite,
		attackpos,
	)

	//* TEST
	if DEBUG {
		DrawBoundingBox(player_bounds(), PURPLE)
		DrawBoundingBox(player_attack_bounds(), PURPLE)
	}
}
package main


//= Imports
import "core:fmt"
import "core:strings"
import "vendor:raylib"
import "enemies"
import "items"
import "gamedata"
import "graphics"
import "player"
import "worldstate"


//= Procedures

//* Update
update :: proc() {
	player.movement()
	enemies.update_enemies()
	worldstate.update()
}

//* Draw
draw :: proc() {
	using raylib

	BeginDrawing()
	ClearBackground(raylib.BLACK)
	BeginMode2D(gamedata.player.camera)

	//* Draw
	worldstate.draw_background()
	items.draw_seeds()
	player.draw_player()
	worldstate.draw_tree()
	enemies.draw_enemies()

	EndMode2D()

	//DrawTextureRec(Texture2D texture, Rectangle source, Vector2 position, Color tint)
	//DrawTexturePro(Texture2D texture, Rectangle source, Rectangle dest, Vector2 origin, float rotation, Color tint)
	ratio := f32(gamedata.worldstate.treeHealthCur) / f32(gamedata.worldstate.treeHealthMax)
	color : Color = GREEN

	if ratio < .75 do color = YELLOW
	if ratio < .25 do color = RED

	DrawTexturePro(gamedata.hpbarTex_1, {0,0,128,16}, {5,5,256,32}, {0,0}, 0, BLACK)
	DrawTexturePro(gamedata.hpbarTex_2, {0,0,128*ratio,16}, {5,5,256*ratio,32}, {0,0}, 0, color)

	DrawText(worldstate.calculate_timer(), 10, 35, 40, raylib.BLACK)
	DrawText(worldstate.calculate_clock(gamedata.worldstate.besttime), 10, 70, 20, raylib.BLACK)

	if gamedata.DEBUG {
		builder : strings.Builder = {}
		str : cstring = strings.clone_to_cstring(
			fmt.sbprintf(
				&builder,
				"%v\n%v",
				gamedata.player.camera.target,
				gamedata.player.seeds,
			),
		)
		DrawText(str, 10, 125, 20, raylib.BLACK)
	}

	EndDrawing()
}

//* Main Loop
main_loop :: proc() {
	for !raylib.WindowShouldClose() {
		update()
		draw()
	}
}
package worldstate


//= Imports
import "core:fmt"
import "core:math"
import "core:math/rand"
import "core:os"
import "core:time"
import "core:strings"
import "vendor:raylib"
import "../items"
import "../gamedata"
import "../graphics"
import "../enemies"
import "../graphics/sprites/animations"


//= Procedures

//* Calculate timer
calculate_timer :: proc() -> cstring {
	duratio := i64(time.stopwatch_duration(gamedata.worldstate.clock))
	millise := (duratio / 10000000)   % 100
	seconds := (duratio / 1000000000) %  60
	minutes := ((duratio / 1000000000) / 60) % 60
	hours   := (((duratio / 1000000000) / 60) / 60)


	builder : strings.Builder = {}
	str     : string
	if hours > 0 {
		str = fmt.sbprintf(
			&builder,
			"%v:%v:%v.%v",
			hours,
			minutes,
			seconds,
			millise,
		)
	} else {
		str = fmt.sbprintf(
			&builder,
			"%v:%2.v.%2.v",
			minutes,
			seconds,
			millise,
		)
	}

	return strings.clone_to_cstring(str)
}

//
calculate_clock :: proc(duratio : i64) -> cstring {
	millise := (duratio / 10000000)   % 100
	seconds := (duratio / 1000000000) %  60
	minutes := ((duratio / 1000000000) / 60) % 60
	hours   := (((duratio / 1000000000) / 60) / 60)


	builder : strings.Builder = {}
	str     : string
	if hours > 0 {
		str = fmt.sbprintf(
			&builder,
			"%v:%v:%v.%v",
			hours,
			minutes,
			seconds,
			millise,
		)
	} else {
		str = fmt.sbprintf(
			&builder,
			"%v:%2.v.%2.v",
			minutes,
			seconds,
			millise,
		)
	}

	cstr := strings.clone_to_cstring(str)
	if cstr == "0:00.00" do cstr = "--:--"

	return cstr
}

//* Calculate number of enemies
calculate_enemies :: proc() -> (i64,u32) {
	duratio := i64(time.stopwatch_duration(gamedata.worldstate.clock))
	seconds := (duratio / 1000000000)

	gamedata.worldstate.maxEnemies = u32(2 + (seconds / 10))

	return seconds, gamedata.worldstate.maxEnemies
}

//* Spawn enemies
spawn_enemies :: proc(amount : int) {
	for i:=0;i<amount;i+=1 {
		angle := rand.float32_range(0,360)
		if angle >= 180 && angle <= 215 do angle -= 180
		if angle <  180 && angle >= 125 do angle += 180
		position : raylib.Vector2 = {
			300 * math.sin_f32(f32(math.PI * 2 * angle / 360)),
			300 * math.cos_f32(f32(math.PI * 2 * angle / 360)),
		}

		append(&gamedata.enemyList, enemies.create_enemy(position, 0))
	}
}

//* 
update :: proc() {
	seconds, amount := calculate_enemies()

	if gamedata.worldstate.spawnTimer <= 0 {
		spawn_enemies(int(amount) - len(gamedata.enemyList))
		gamedata.worldstate.spawnTimer = 400
	} else do gamedata.worldstate.spawnTimer -= 1

	if gamedata.worldstate.treeHealthCur == 0 {
		//* Stop clock
		time.stopwatch_stop(&gamedata.worldstate.clock)
		timing := i64(time.stopwatch_duration(gamedata.worldstate.clock))

		if os.exists("score") {
			scoreArr, succ := os.read_entire_file_from_filename("score")

			score : i64
			for i:=0;i<8;i+=1 do score |= (i64(scoreArr[i]) << (u32(i)*8))

			if timing > score {
				scoreArr : []u8 = {
					u8(timing >> 0),
					u8(timing >> 8),
					u8(timing >> 16),
					u8(timing >> 24),
					u8(timing >> 32),
					u8(timing >> 40),
					u8(timing >> 48),
					u8(timing >> 56),
				}
				os.write_entire_file("score", scoreArr)
				gamedata.worldstate.besttime = timing
			}
		} else {
			scoreArr : []u8 = {
				u8(timing >> 0),
				u8(timing >> 8),
				u8(timing >> 16),
				u8(timing >> 24),
				u8(timing >> 32),
				u8(timing >> 40),
				u8(timing >> 48),
				u8(timing >> 56),
			}
			os.write_entire_file("score", scoreArr)
			gamedata.worldstate.besttime = timing
		}

		//* Restart game
		time.stopwatch_reset(&gamedata.worldstate.clock)
		time.stopwatch_start(&gamedata.worldstate.clock)

		//* Reset enemy list
		delete(gamedata.enemyList)
		gamedata.enemyList = make([dynamic]gamedata.Enemy)

		//* Reset player position
		gamedata.player.camera.target = gamedata.PLAYER_STARTING

		//* Reset tree HP
		gamedata.worldstate.treeHealthCur = gamedata.worldstate.treeHealthMax
	}
}
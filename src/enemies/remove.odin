package enemies


//= Imports
import "vendor:raylib"
import "core:fmt"
import "../gamedata"
import "../graphics"


//= Procedures

//* Remove member from dynamic array
remove :: proc(
	member : int,
) {
	using gamedata

	newArray : [dynamic]Enemy = make([dynamic]Enemy)

	for i:=0;i<len(enemyList);i+=1 {
		if i != member do append(&newArray, enemyList[i])
	}

	delete(enemyList)
	enemyList = newArray
}
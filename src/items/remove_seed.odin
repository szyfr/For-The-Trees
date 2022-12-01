package items


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

	newArray : [dynamic]Seed = make([dynamic]Seed)

	for i:=0;i<len(seedList);i+=1 {
		if i != member do append(&newArray, seedList[i])
	}

	delete(seedList)
	seedList = newArray
}
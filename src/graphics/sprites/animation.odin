package sprites


//= Imports
import "vendor:raylib"


//= Structures
Animation :: struct {
	frame       : i32,
	frameList   : [dynamic]u32,
	loop        : bool,

	//* Timing
	framePoint  : i32,
	frameCount  : i32,
}
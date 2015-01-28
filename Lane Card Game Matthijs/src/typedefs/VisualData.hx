package typedefs ;

/**
 * typedef for storing and handing the visual and audio data of an unit in a compact way
 * @author Matthijs van Gelder
 */

typedef VisualData =
{
	var spriteSheet : String;
	var spriteWidth : Int;
	var spriteHeight: Int;
	var idleFrame : Int;
	var walkStart : Int;
	var walkEnd : Int;
	var shootStart : Int;
	var shootEnd : Int;
	var deathStart : Int;
	var deathEnd : Int;
	var numFrames : Int;
	var numRows : Int;
	var numColums : Int;
	var firingSound : String;
}
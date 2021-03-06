package typedefs ;

/**
 * typedef for storing and handin a units combat and balance related variables in a compact way
 * @author Matthijs van Gelder
 */

typedef UnitStats =
{
	var health : Float;
	var armor : Int;
	var softDamage : Float;
	var apDamage : Float;
	var accuracy : Int;
	var critChance : Int;
	var glancingChance : Int;
	var cooldown : Int;
	var burst : Bool;
	var burstRate : Int;
	var burstSize : Int;
	var range : Int;
	var moveSpeed : Int;
	var squadSize : Int;
}
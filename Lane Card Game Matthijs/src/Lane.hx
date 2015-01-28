package ;
import openfl.display.Sprite;
import openfl.events.Event;

/**
 * A lane the units move down in the game
 * @author Matthijs van Gelder
 */
class Lane extends Sprite
{
	//class scope vars
	
	// the height of a lane
	var tallness:Int = 120;
	// which lane it is
	public var number:Int;
	// the colour of the debug square
	var colour:Int;

	//initialize the variables and add event listener for stage requiring initilisation
	public function new(whichLane:Int, laneBackground:Int = 0x004400) 
	{
		super();
		number = whichLane;
		colour = laneBackground;
		addEventListener(Event.ADDED_TO_STAGE, init);
	}
	function init(e)
	{
		drawBox();
		// place it at the correct spot considering which lane it is
		this.y = number * tallness;
	}
	// draws the box used for debug and hit test
	function drawBox()
	{
		this.graphics.beginFill(colour);
		this.graphics.drawRect(0, 0, stage.stageWidth, tallness - 20);
		this.graphics.endFill();
	}
}
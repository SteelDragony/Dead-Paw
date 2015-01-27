package ;
import openfl.display.Sprite;
import openfl.events.Event;

/**
 * ...
 * @author Matthijs van Gelder
 */
class Lane extends Sprite
{
	var tallness:Int = 120;
	public var number:Int;
	var colour:Int;

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
		this.y = number * tallness;
	}
	function drawBox()
	{
		this.graphics.beginFill(colour);
		this.graphics.drawRect(0, 0, stage.stageWidth, tallness - 20);
		this.graphics.endFill();
	}
}
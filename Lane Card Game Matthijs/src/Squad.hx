package ;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.geom.Point;
import typedefs.UnitStats;
import typedefs.VisualData;

/**
 * ...
 * @author Matthijs van Gelder
 */
class Squad extends Sprite
{
	var side:Int = 0;
	public var lane:Lane;
	
	public var squadMembers = new Array<Unit>();
	
	var formation = new Array<Point>();
	
	var unitStatistics:UnitStats;
	var unitVisuals:VisualData;
	var soundReference:Sound;
	
	public function update()
	{
		for (unit in squadMembers) 
		{
			unit.update();
		}
	}
	public function new(unitsStats:UnitStats, unitGraphics:VisualData, soundRef:Sound, owner:Int, laneIn:Lane) 
	{
		super();
		formation.push(new Point(0, -30));
		formation.push(new Point( -20, -20)); 
		formation.push(new Point(20, -20));
		formation.push(new Point(0, 0));
		formation.push(new Point(-20, 20));
		
		formation.push(new Point(20, 20));
		
		formation.push(new Point(0, 30));
		
		side = owner;
		unitStatistics = unitsStats;
		unitVisuals = unitGraphics;
		soundReference = soundRef;
		this.lane = laneIn;
		addEventListener(Event.ADDED_TO_STAGE, added);
	}
	
	function added(e)
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		for (i in 0 ... unitStatistics.squadSize) 
		{
			var unit = new Unit(this, side, unitStatistics, unitVisuals, soundReference);
			unit.x = 50 + formation[i].x;
			unit.y = (lane.y + lane.height / 2) + formation[i].y - (unit.unitHeight / 2);
			if (side == 2) unit.x += stage.stageWidth - 50;
			addChild(unit);
			squadMembers.push(unit);
		}
	}
	
}
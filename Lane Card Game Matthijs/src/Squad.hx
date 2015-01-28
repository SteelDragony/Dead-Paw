package ;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.geom.Point;
import typedefs.UnitStats;
import typedefs.VisualData;

/**
 * A squad in our game
 * spawns all the units of a squad in formation when created
 * will take care of movement in formation in future builds
 * @author Matthijs van Gelder
 */
class Squad extends Sprite
{
	// declare class scope state variables
	var side:Int = 0; // which side belongs this squad to
	public var lane:Lane; // which lane is this squad in
	
	// array with holding all the units beloning to this squad
	public var squadMembers = new Array<Unit>();
	
	// array with the point of the unit formation
	var formation = new Array<Point>();
	
	// unit stats an visuals holding typedefs, need to be class scope
	var unitStatistics:UnitStats;
	var unitVisuals:VisualData;
	// to store reference to central sound instance
	var soundReference:Sound;
	
	// updates all the units of the squad
	public function update()
	{
		for (unit in squadMembers) 
		{
			unit.update();
		}
	}
	/*
	 * initialize a new squad with the variables and data handed to it
	 */
	public function new(unitsStats:UnitStats, unitGraphics:VisualData, soundRef:Sound, owner:Int, laneIn:Lane) 
	{
		super();
		
		// set the points for he formation
		formation.push(new Point(0, -30));
		formation.push(new Point( -20, -20)); 
		formation.push(new Point(20, -20));
		formation.push(new Point(0, 0));
		formation.push(new Point(-20, 20));
		formation.push(new Point(20, 20));
		formation.push(new Point(0, 30));
		
		// set side
		side = owner;
		// import the the handed date
		unitStatistics = unitsStats;
		unitVisuals = unitGraphics;
		// store he soundref in the variable
		soundReference = soundRef;
		// store which lane this squad is in
		this.lane = laneIn;
		// add event listener for initilisation that needs the stage
		addEventListener(Event.ADDED_TO_STAGE, added);
	}
	
	function added(e)
	{
		removeEventListener(Event.ADDED_TO_STAGE, added); // remove event listener
		// for the amount of units specified by unitstats
		for (i in 0 ... unitStatistics.squadSize) 
		{
			// create new unit, giving it its stats and visual data, and a reference to the sound instance
			var unit = new Unit(this, side, unitStatistics, unitVisuals, soundReference);
			// set them to their representive formation positions
			unit.x = 50 + formation[i].x;
			unit.y = (lane.y + lane.height / 2) + formation[i].y - (unit.unitHeight / 2);
			// if it belongs to the right side move it to spawn it there
			if (side == 2) unit.x += stage.stageWidth - 100;
			// make it visible
			addChild(unit);
			// add it to the array of units in this squad
			squadMembers.push(unit);
		}
	}
	
}
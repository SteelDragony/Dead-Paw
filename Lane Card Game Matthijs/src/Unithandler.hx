package ;
import openfl.display.Sprite;
import openfl.events.Event;
import typedefs.UnitStats;
import typedefs.VisualData;

/**
 * Unithandler Class
 * 
 * will take care of all unit related tasks:
	 * calling unit updates
	 * doing range checks
	 * spawning squads
	 * removing squads
 * 
 * will hold 2 arrays containing the squads for both sides
 * 
 * @author Matthijs van Gelder
 */
class Unithandler extends Sprite
{
	//class scope arrays for holding the squads 1 = left side, 2 = right side
	var squads1 = new Array<Squad>();
	var squads2 = new Array<Squad>();
	
	public function new() 
	{
		super();
		// use event listener to avoid errors using stage in initialisation
		addEventListener(Event.ADDED_TO_STAGE, added);
	}
	
	function added(e)
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		/* old test code to be removed
		var squad = new Squad(0);
		squads1.push(squad);
		addChild(squad);
		trace(squad);
		*/
	}
	
	public function update()
	{
		rangeChecks();
		for (squad in squads1) 
		{
			squad.update();
		}
		for (squad in squads2) 
		{
			squad.update();
		}
	}
	
	public function spawnSquad(unitsStats:UnitStats, unitGraphics:VisualData, soundRef:Sound, side:Int, size:Int, lane:Lane)
	{
		var squad = new Squad(unitsStats,unitGraphics, soundRef, side, lane);
		if (side == 1) squads1.push(squad);
		else if (side == 2) squads2.push(squad);
		addChild(squad);
	}
	
	function rangeChecks()
	{
		// side 1 units
		
		// new range and target code
		var targetsInRange = new Array<Unit>(); // array to temporary store the possible targets for a unit.
		// cant figuere out yet how to reset it to 0 everytime.
		
		// for all squads on side 1
		for (squad1 in squads1)
		{
			// for every unit in those squads
			for (unit1 in squad1.squadMembers)
			{	
				var targetsInRange = new Array<Unit>();
				// set default state to no target in range
				var targetInRange:Bool = false;
				
				// for every squad in side 2
				for (squad2 in squads2)
				{
					// check if they are in the same lane, or an adjecent lane
					if (squad1.lane.number - 1 <= squad2.lane.number && squad1.lane.number + 1 >= squad2.lane.number)
					{
						// for every unit in those squads
						for (unit2 in squad2.squadMembers)
						{
							var distance = Math.abs(unit1.x - unit2.x);
							// check if target is in range
							if (distance < unit1.range)
							{
								targetsInRange.push(unit2);
								//unit1.attack(unit2); // tell unit to attack if in range.
								targetInRange = true; 
							}
						}
					}
				}
			if (targetsInRange.length > 0)
			{
				//unit1.attack(targetsInRange[Std.random(targetsInRange.length)]);
				targetsInRange.sort(function(a:Unit, b:Unit):Int {
					if (a.health == b.health)
						return 0;
					if (a.health > b.health)
						return 1;
					else
						return -1;
				});
				unit1.attack(targetsInRange);
			}
			// none of the targets where in range so start moving again
			if (targetInRange == false)
				{
					unit1.startMoving();
				}
			}
	
		}
		// for all squads on side 2
		for (squad1 in squads2)
		{
			// for every unit in those squads
			for (unit1 in squad1.squadMembers)
			{	
				var targetsInRange = new Array<Unit>();
				// set default state to target not in range
				var targetInRange:Bool = false;
				for (squad2 in squads1)
				{
					if (squad1.lane.number - 1 <= squad2.lane.number && squad1.lane.number + 1 >= squad2.lane.number)
					{
						for (unit2 in squad2.squadMembers)
						{
							var distance = Math.abs(unit1.x - unit2.x);
							//attack range check
							if (distance < unit1.range)
							{
								targetsInRange.push(unit2);
								//unit1.attack(unit2); // tell unit to attack if in range.
								targetInRange = true;
							}
						}
					}
				}
			if (targetsInRange.length > 0)
			{
				//unit1.attack(targetsInRange[Std.random(targetsInRange.length)]);
				targetsInRange.sort(function(a:Unit, b:Unit):Int {
					if (a.health == b.health)
						return 0;
					if (a.health > b.health)
						return 1;
					else
						return -1;
				});
				unit1.attack(targetsInRange);
			}
			// none of the targets where in range so start moving again
			if (targetInRange == false)
			{
				unit1.startMoving();
			}
			}

		}
		//old range and target code
		/*
		for ( unit1 in units1)
		{
			var targetInRange:Bool = false;
			targetInRange = false;
			unit1.update(); // unit update
			for ( unit2 in units2)
			{
				var distance = Math.abs(unit1.x - unit2.x);
				//attack range check
				if (distance < 50)
				{
					unit1.attack(unit2); // tell unit to attack if in range.
					targetInRange = true;
				}
			}
			
		if (targetInRange == false)
			{
				unit1.startMoving();
			}
		}
		// side 2 units
		for ( unit1 in units2)
		{
			var targetInRange:Bool = false;
			targetInRange = false;
			unit1.update(); // unit update
			for ( unit2 in units1)
			{
				var distance = Math.abs(unit1.x - unit2.x);
				//attack range check
				if (distance < 50)
				{
					unit1.attack(unit2); // tell unit to attack if in range.
					targetInRange = true;
				}
			}
			if (targetInRange == false)
			{
				unit1.startMoving();
			}
		}
		*/
	}
	/* obsolete unit death check, death checks now done by units themselfes
	function deathCheck()
	{
		//Unit health check, removes units if they have no health remaining (move into seperate class(es))
		for (unit in units1)
		{
			if (unit.health < 0)
			{
				units1.remove(unit);
				removeChild(unit);
			}
		}
		for (unit in units2)
		{
			if (unit.health < 0)
			{
				units2.remove(unit);
				removeChild(unit);
			}
		}
	}
	*/
}
package ;
import openfl.display.Sprite;
import openfl.events.Event;
import typedefs.UnitStats;
import typedefs.VisualData;

/**
 * Unithandler Class
 * 
 * takes care of all unit related tasks:
	 * calling unit updates
	 * doing range checks
	 * spawning squads
	 * removing squads
 * 
 * holds 2 arrays containing the squads for both sides
 * 
 * @author Matthijs van Gelder
 */
class Unithandler extends Sprite
{
	//class scope arrays for holding the squads 1 = left side, 2 = right side
	var squads1 = new Array<Squad>();
	var squads2 = new Array<Squad>();
	var game:Game;
	
	public function new(currentGame:Game) 
	{
		super();
		game = currentGame;
		// use event listener to avoid errors using stage in initialisation
		addEventListener(Event.ADDED_TO_STAGE, added);
	}
	
	function added(e)
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
	}
	/*
	 * calls rangeChecks and updates all squads
	 */
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
	
	/*
	 * spawns a new squad.
	 * called from game with the data handed to it from the card that was played.
	 */
	public function spawnSquad(unitsStats:UnitStats, unitGraphics:VisualData, soundRef:Sound, side:Int, size:Int, lane:Lane)
	{
		var squad = new Squad(unitsStats,unitGraphics, soundRef, side, lane);
		if (side == 1) squads1.push(squad);
		else if (side == 2) squads2.push(squad);
		addChild(squad);
	}
	
	/*
	 * checks for every unit if there is a target in range, if so gives the unit an array of targets that are in range
	 * else if no targets are in range tell the unit to move again
	 */
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
				// if no units where in range, check to see if the enemy base is in range
				if ( targetInRange == false)
				{
					//check if base is in range
					if ( unit1.x + unit1.range > stage.stageWidth)
					{
						unit1.attackBase(game); // attack base
						targetInRange = true; // it is attacking
					}
				}
				// if there are targets in range
				if (targetsInRange.length > 0)
				{
					// sort them to have target with least healt first
					targetsInRange.sort(function(a:Unit, b:Unit):Int {
						if (a.health == b.health)
							return 0;
						if (a.health > b.health)
							return 1;
						else
							return -1;
					});
					unit1.attack(targetsInRange); // give unit array with targets that are in range
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
				// if no units where in range, check to see if the enemy base is in range
				if ( targetInRange == false)
				{
					//check if base is in range
					if ( unit1.x - unit1.range <= 0)
					{
						unit1.attackBase(game);
						targetInRange = true;
					}
				}
				if (targetsInRange.length > 0)
				{
					// sort them to have target with least healt first
					targetsInRange.sort(function(a:Unit, b:Unit):Int {
					if (a.health == b.health)
						return 0;
					if (a.health > b.health)
						return 1;
					else
						return -1;
					});
					unit1.attack(targetsInRange);// give unit array with targets that are in range
				}
				// none of the targets where in range so start moving again
				if (targetInRange == false)
				{
					unit1.startMoving();
				}
			}
		}
	}
}
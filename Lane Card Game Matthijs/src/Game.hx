package ;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.Lib;
import haxe.Timer;
import openfl.ui.Keyboard;
import typedefs.UnitStats;
import typedefs.VisualData;

/**
 * Game Class
 * 
 * central point for one individual game from start to finish, all things relating to that one game will happen in here or in its children.
 * @author Matthijs van Gelder
 */
class Game extends Sprite
{
	var inited:Bool;
	
	// unit arrays storing all the units beloning to one side
	var units1 = new Array<Unit>();
	var units2 = new Array<Unit>();
	
	//variables to store the health of the player
	var player1hp:Int;
	var player2hp:Int;
	
	// declare Class scope variables
	var hand1:Hand;
	var hand2:Hand;
	var unithandler:Unithandler;
	
	//variables to store resources
	public var resourcesPlayer1:Int;
	public var resroucesPlayer2:Int;
	
	//array for looping through the lanes
	var lanes = new Array<Lane>();
	
	// the sound and music class and volumecontrol

	var soundvolume:Float = 1.0 ;
	var musicvolume:Float = 1.0 ;
	var music = new Music ();
	var sound = new Sound ();
	var userinterface:Userinterface;
	var drag:Bool = false;
	
	/* ENTRY POINT */
	
function resize(e) 
	{
		if (!inited) init();
		// else (resize or orientation change)
	}
	
	function init() 
	{
		if (inited) return;
		inited = true;
		
		// Adding children for sound and music libs //
		
		addChild (sound) ;
		addChild (music) ;
		
		// playing Ambient sound loop //
		
		sound.soundAmb1(soundvolume);
		
		// (your code here)
		
		unithandler = new Unithandler();
		addChild(unithandler);
		userinterface = new Userinterface();
		addChild(userinterface);
		resourcesPlayer1 = 19;
		resourcesPlayer1 = 19;
		player1hp = 24;
		player2hp = 25;
		
		//unit test code, will be removed
		/*
		var unit = new Unit(2, 4, 0);
		unit.x = (stage.stageWidth) / 2 - 50;
		unit.y = (stage.stageHeight) / 2;
		addChild(unit);
		units1.push(unit);
		
		var unit2 = new Unit(100, 2, 1);
		unit2.x = (stage.stageWidth) / 2 + 50;
		unit2.y = (stage.stageHeight) / 2;
		addChild(unit2);
		units2.push(unit2);
		*/
		
		//hand test code, needs to be changed
		hand1 = new Hand( this, 0 );
		hand2 = new Hand( this, 1 );
		addChild(hand1);
		addChild(hand2);
		hand1.addCard("YPR", sound);
		hand1.addCard("BearRifle", sound);
		hand1.addCard("BearAt", sound);
		hand2.addCard("YPR", sound);
		hand2.addCard("BearRifle", sound);
		hand2.x += 800;
		
		for ( i in 0 ... 5 )
		{
			var lane = new Lane(i);
			addChild(lane);
			setChildIndex(lane, 0);
			lanes.push(lane);
		}
	}

	public function update()
	{
		unithandler.update();
		userinterface.uiUpdate(units1, units2, player1hp, player2hp, resourcesPlayer1, resroucesPlayer2);
		if (drag == false)
		{
		hand1.update();
		hand2.update();
		}
		// side 1 units
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
		*/
	}
	
	// starts draggin a card to play a unit, gets passed said card by hand. called from hand.
	// might make card child of game, but how to handle false plays?
	public function cardDrag(card:Card)
	{
		drag = true;
		for (lane in lanes)
		{
			if (card.y < (lane.y + lane.height) && card.y > (lane.y))
			{
				spawnUnitOnDrag(card.unitStats, card.unitGraphics, card.side, lane);
				addChild(card);
				removeChild(card);
				if (card.unitGraphics.spriteSheet == "img/YPR.png")
				{
					if (card.side == 0)
					{
						hand1.addCard("YPR", sound);
					}
					if (card.side == 1)
					{
						hand2.addCard("YPR", sound);
					}
				}
				else if (card.unitGraphics.spriteSheet == "img/RuBearRifle.png")
				{
					if (card.side == 0)
					{
						hand1.addCard("BearRifle", sound);
					}
					if (card.side == 1)
					{
						hand2.addCard("BearRifle", sound);
					}
				}
				
				sound.playSound("click");
				drag = false;
			}	
		}
	}
	
	
	// very basic unit spawn
	function spawnUnitOnDrag(unitsStats:UnitStats, unitGrahics:VisualData, side:Int, lane:Lane )
	{
		unithandler.spawnSquad(unitsStats, unitGrahics, sound, side, 0, lane);
		/* old spawn code
		var unit = new Unit(2, 4, 0);
		unit.x = 50;
		unit.y = (stage.stageHeight) / 2 + (Std.random(51)-25);  // added randomized spawn height
		unithandler.addChild(unit);
		unithandler.units1.push(unit);
		*/
	}
	
	/* SETUP */

	public function new() 
	{
		super();
		addEventListener(Event.ADDED_TO_STAGE, added);
	}
	
	function added(e) 
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		stage.addEventListener(Event.RESIZE, resize);
		#if ios
		haxe.Timer.delay(init, 100); // iOS 6
		#else
		init();
		#end
	}
}
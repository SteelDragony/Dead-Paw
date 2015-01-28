package ;

import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.Lib;
import haxe.Timer;
import openfl.ui.Keyboard;


/**
 * Main Class
 * 
 * Top level class of our game.
 * Has the Menu and Game classes as a child.
 * starts with menu class, which creates a "game" class when a game is started by the player by clicking on a button in the menu.
 * 
 * 
 * @author Matthijs van Gelder
 */

class Main extends Sprite 
{
	
	var menu:Menu = new Menu(); // menu class variable
	var inited:Bool;
	var game:Game; //define game outside the functions so it can be accesed by all of them.
	public var started:Bool = false; // bool if the game is started
	public var exitGameBool:Bool = false; // bool if the game needs to end
	
	
	
	function resize(e) 
	{
		if (!inited) init();
		// else (resize or orientation change)
	}
	
	function init() 
	{
		if (inited) return;
		inited = true;
		drawmenu(); // calls the menu function

		update(); // starts running the update function.
	}

	
	/**
	 * update
	 * centralized game state update caller, every update call should originate from here to provide a central pause and stop point.
	 */
	function update()
	{

		if (menu.start && started == false)
		{
			removeChild(menu); // removes menu
			game = new Game(); // actually create the game.
			addChild(game); // add it as a child to display is.
			started = true;
		}
		if (started)
		{
			game.update(); // updates the game
			if (game.exitGameBool == true) // check if the game needs to end
			{
				game.sound.stopAmbsounds (); // stops ingame looped sound
				menu.playMusic (); // start the menu music again
				removeChild(game); // removes the game
				drawmenu(); // creates the menu
				exitGameBool = false; // resets the bools
				menu.start = false;
				started = false;
			}
		}
		Timer.delay(update, 50); // update freuency by delay
	}
	
	
	/**
	 * DONT TOUCH STUFF BELOW THIS.
	 */
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
	
	public static function main() 
	{
		// static entry point
		Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		Lib.current.addChild(new Main());
	}

	function drawmenu()
	{
		addChild(menu);
		// trace("drw");
		
	}	
}


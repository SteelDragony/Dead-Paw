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
 * will either have the menu or game class as child.
 * starts with menu class, which creates a "game" class when a game is started by the player by clicking on a button in the menu.
 * @author Matthijs van Gelder
 */

class Main extends Sprite 
{
	var inited:Bool;

	var game:Game; //define game outside the functions so it can be accesed by all of them.
	
	function resize(e) 
	{
		if (!inited) init();
		// else (resize or orientation change)
	}
	
	function init() 
	{
		if (inited) return;
		inited = true;

		// (your code here)
		game = new Game(); // actually create the game.
		addChild(game); // add it as a child to display is.
		update(); // starts running the update function.
	}

	
	/**
	 * update
	 * centralized game state update caller, every update call should originate from here to provide a central pause and stop point.
	 */
	function update()
	{
	
		game.update();
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
}

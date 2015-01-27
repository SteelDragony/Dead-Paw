package ;

import openfl.display.Bitmap;
import openfl.Assets;
import openfl.events.Event;
import openfl.events.MouseEvent;
import flash.system.System;
/**
 * ...
 * @author Ruben Visser
 */
class Menu extends openfl.display.Sprite
{



var startbutton:Menubutton = new Menubutton("img/MenuButtonStart.png", "img/MenuButtonStartHover.png");
var exitbutton:Menubutton = new Menubutton("img/MenuButtonExit.png", "img/MenuButtonExitHover.png");
public var start:Bool = false;

	public function new() 
	{
		super();
		addEventListener(Event.ADDED_TO_STAGE, added);

	}

	function added(e:Event)
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		
		drawbackground();
		drawmenu();
		
	}
	
	function drawmenu() {

		startbutton.x = (stage.stageWidth - startbutton.width) / 2;
		startbutton.y = (stage.stageHeight - startbutton.height) / 2 - 25;

		exitbutton.x = (stage.stageWidth - exitbutton.width) / 2;
		exitbutton.y = (stage.stageHeight - exitbutton.height) / 2 + 25;

		addChild(startbutton);
		addChild(exitbutton);
		startbutton.addEventListener(MouseEvent.CLICK, startGame);
		exitbutton.addEventListener(MouseEvent.CLICK, exit);

	}
	
	function startGame(e:MouseEvent) 
	{
		//startbutton.removeEventListener(MouseEvent.CLICK, startGame);
		//exitbutton.removeEventListener(MouseEvent.CLICK, exit);
		start = true;
	}

	function exit(e:MouseEvent) 
	{
		System.exit(0);
	}

	function drawbackground() 
	{
		var background = new Bitmap(Assets.getBitmapData("img/Background.png"));
		addChildAt (background, 0);
		
	}



}
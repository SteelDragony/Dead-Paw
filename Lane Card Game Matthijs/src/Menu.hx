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
	// Down below are are all the var's for the menu which declare the buttons and sound for the menu //

	var musicvolume:Float = 1.0 ;
	var menuMusic = new Music();
			
	var startbutton:Menubutton = new Menubutton("img/MenuButtonStart.png", "img/MenuButtonStartHover.png");
	var exitbutton:Menubutton = new Menubutton("img/MenuButtonExit.png", "img/MenuButtonExitHover.png");
	public var start:Bool = false;
	

	// public funtion new, this adds a new event to the stage, which is an event listener //

	
	public function new() 
	{
		super();
		addEventListener(Event.ADDED_TO_STAGE, added);
	
	// function added, this draws the menu and background and declare these below  //

	}

	function added(e:Event)
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		
		drawbackground();
		drawmenu();
		playMusic();
		
	}
	
	// funtion draw menu, this actualy draws the menu, using a and y parameters// 
	//openfl always calculates the position from the top left corner//
	
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
	
	// fucntion startGame, this stops the game music, and gets the game in to the playstate. //
	
	function startGame(e:MouseEvent) 
	{
		//startbutton.removeEventListener(MouseEvent.CLICK, startGame);
		//exitbutton.removeEventListener(MouseEvent.CLICK, exit);
		start = true;
		menuMusic.stopMusic ();
		removeChild (menuMusic);
	}
	
	// function exit, this shuts down the program and stops all code. //
	
	function exit(e:MouseEvent) 
	{
		System.exit(0);
	}
	
	// function drawbackgound, this function called the var background and draws the Background.png file, because we did not state positioning
	// x.y/0.0 its gets drawn 0.0 and used the full scale of the picture, which in this case is the size of the game.//
	
	function drawbackground() 
	
	{
		var background = new Bitmap(Assets.getBitmapData("img/Background.png"));
		addChildAt (background, 0);
	
		
	}

	public function playMusic ()
	{
		addChild(menuMusic);
		menuMusic.mainMenuMusic (musicvolume) ;
	}
}

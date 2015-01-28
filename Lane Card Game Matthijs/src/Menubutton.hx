package ;

import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.Assets;
import openfl.events.MouseEvent;

/**
 * ...
 * @Ruben Visser
 */
class Menubutton extends Sprite
{
	// Below are the variable's which declare the interactive "hoverable" buttons used in the menu.hx file and their properties//


	var mainiamge:Bitmap;
	var mainImageHover:Bitmap; 
	
	//public funtion new, this delcared that there are two images needed to initiate the the function HOVER// 
	// The eventlisters checks if the funtion is actialy is being executed, if mouse over, the menu hovers and calls
	// the hover.png file. if not the regular .png file gets loaded.//
	public function new(image:String, imageHover:String) 
	{
	
		super();

		mainiamge = new Bitmap(Assets.getBitmapData(image));
		mainImageHover = new Bitmap(Assets.getBitmapData(imageHover));
		draw();
		addEventListener(MouseEvent.MOUSE_OVER, OnMouseOver);
		addEventListener(MouseEvent.MOUSE_OUT, OnMouseOut);
	}
	
	// The draw function draws the mainimage(declared in menu,hx) // 
	
	function draw(){
		addChild(mainiamge);
	
	}
	
	// The Onmouse removes the main button and replace's the button with a hoverbutton //
	
	function OnMouseOver(e:MouseEvent) {
		removeChildren();
		addChild(mainImageHover);	
	}	
	
	// When the mouse hover away from the button the child thats is called in the draw funtion is recalled//
	
	function OnMouseOut(e:MouseEvent) {
		removeChildren();
		addChild(mainiamge);
	}

	
}

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
	
	public function new(image:String, imageHover:String) 
	{
	
		super();

		mainiamge = new Bitmap(Assets.getBitmapData(image));
		mainImageHover = new Bitmap(Assets.getBitmapData(imageHover));
		draw();
		addEventListener(MouseEvent.MOUSE_OVER, OnMouseOver);
		addEventListener(MouseEvent.MOUSE_OUT, OnMouseOut);
	}
	function draw(){
		addChild(mainiamge);
	}
	function OnMouseOver(e:MouseEvent) {
		removeChildren();
		addChild(mainImageHover);	
	}	
	function OnMouseOut(e:MouseEvent) {
		removeChildren();
		addChild(mainiamge);
	}

	
}

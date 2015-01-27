package ;
import haxe.Json;
import openfl.display.BitmapData;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.display.Tilesheet;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import typedefs.UnitStats;
import typedefs.VisualData;
import openfl.text.TextField;

/**
 * Card Class
 * 
 * a draggable card which can either spawn a squad of units via the unit handler or have an effect when played on units
 * 
 * Variables
 * recourceCost
 * unitType the type of unit this should spawn
 * cardtexture the image of the card to displat
 * 
 * @author Matthijs van Gelder
 */
class Card extends Sprite
{
	var game:Game;
	var hand:Hand;
	
	public var unitStats:UnitStats;
	public var unitGraphics:VisualData;
	
	var unitin:Dynamic;
	
	public var side:Int;
	
	var unitType:String = "YPR";
	
	public function new(handplayer:Hand, player:Int, unittype:String, soundClass:Sound) 
	{
		super();
		side = player;
		this.addEventListener(MouseEvent.MOUSE_DOWN, drag);
		unitType = unittype;
		var jsonin = Assets.getText("units/units.json");
		unitin = Json.parse(jsonin);
		hand = handplayer;
		unitStats = Reflect.getProperty(this.unitin, unittype).unitStats;
		unitGraphics = Reflect.getProperty(this.unitin, unittype).unitGraphics;
		
		/*
		switch(unitType) 
		{
			case "YPR":
				{
				unitStats = unitin.YPR.unitStats;
				
					{
						health : 20,
						armor : 2,
						softDamage : 4,
						apDamage : 3,
						accuracy : 70,
						critChance : 10,
						glancingChace : 20,
						cooldown : 40,
						burst : true,
						burstRate : 2,
						burstSize : 5,
						range : 300,
						moveSpeed : 5,
					}
				unitGraphics = unitin.YPR.unitGraphics;
					{
						spriteSheet : "img/YPR.png",
						spriteWidth : 128,
						spriteHeight: 128,
						walkStart : 1,
						walkEnd : 9,
						shootStart : 10,
						shootEnd : 14,
						deathStart : 0,
						deathEnd : 0,
						numFrames : 15,
						numRows : 4,
						numColums : 4,
						soundHandler : soundClass,
					}
				}
			case "BearRifle":
				{
				unitStats = unitin.BearRifle.unitStats;
				
					{
						health : 10,
						armor : 2,
						softDamage : 4,
						apDamage : 3,
						accuracy : 70,
						critChance : 10,
						glancingChace : 20,
						cooldown : 100,
						burst : false,
						burstRate : 2,
						burstSize : 3,
						range : 200,
						moveSpeed : 20,
					}
				unitGraphics = unitin.BearRifle.unitGraphics;
				
					{
						spriteSheet : "img/Cat_Sprint.png",
						spriteWidth : 256,
						spriteHeight: 256,
						walkStart : 1,
						walkEnd : 11,
						shootStart : 1,
						shootEnd : 11,
						deathStart : 0,
						deathEnd : 0,
						numFrames : 12,
						numRows : 4,
						numColums : 4,
						soundHandler : soundClass,
					}
				}
			case "BearAt":
				{
					unitStats = unitin.BearAt.unitStats;
					unitGraphics = unitin.BearAt.unitGraphics;
				}
		}*/
		/* Json parse test
		var jsonin = Assets.getText("units/units.json");
		var unitin = Json.parse(jsonin);
		unitStats = unitin.YPR.unitStats;
		unitGraphics = unitin.YPR.unitGraphics;
		trace(unitStats);
		trace(unitGraphics);
		*/
		addEventListener(Event.ADDED_TO_STAGE, drawCards);
		addEventListener(Event.ADDED_TO_STAGE, drawGraphics);
		//drawGraphics();
	}
	
	function drag(e:MouseEvent)
	{
		stage.addEventListener(MouseEvent.MOUSE_UP, stopdragging);
		this.startDrag();
	}
	
	public function stopdragging(e:MouseEvent)
	{
		// stage.removeEventListener(MouseEvent.MOUSE_UP, stopdragging);
		this.stopDrag();
		hand.update();
	}

	// Draws the first imageof a spirite sheet onto the card
	function drawGraphics(e:Event)
	{
		removeEventListener(Event.ADDED_TO_STAGE, drawGraphics);
		var data:BitmapData = Assets.getBitmapData(unitGraphics.spriteSheet);
		var image = new Tilesheet(data);
		var unitRectangle:Rectangle = new Rectangle( 0, 0, unitGraphics.spriteWidth, unitGraphics.spriteHeight );
		var unitRectangle2:Rectangle = new Rectangle( 0, 0, unitGraphics.spriteWidth, unitGraphics.spriteHeight );
		//add the rectangle of the next image in the sprite sheet
		image.addTileRect( unitRectangle );
		image.addTileRect( unitRectangle2 );
		image.drawTiles( this.graphics, [ ( -unitGraphics.spriteWidth / 2) + 75 , ( -unitGraphics.spriteHeight / 2 +85), 0], true );
		
		var healthText = new TextField();
		healthText.x = 50;
		healthText.y = this.height - 25;
		healthText.textColor = 0x32678B;
		healthText.scaleX = healthText.scaleY = 1;
		healthText.text = Std.string(unitStats.health);
		healthText.selectable = false;
		healthText.width = 600;
		addChild(healthText);
		
	}
	// Draws a standard Card to display stats
	function drawCards(e:Event)
	{
		removeEventListener(Event.ADDED_TO_STAGE, drawCards);
		var getCard:BitmapData = Assets.getBitmapData("img/West Card Front.png");
		graphics.beginBitmapFill (getCard);
		graphics.drawRect (0, 0, getCard.width, getCard.height);
		
	}
}
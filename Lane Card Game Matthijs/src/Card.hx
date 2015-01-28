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
	// Holds the current class of game
	var game:Game;
	// Holds the class of hand where it's in
	var hand:Hand;
	// Holds unit stats to be displayed on the card
	public var unitStats:UnitStats;
	// Holds unit grapich to be displayed on the card
	public var unitGraphics:VisualData;
	// Store information converted out of a Json file, used to retrave information
	var unitin:Dynamic;
	// Holds the side of this card
	public var side:Int;
	// Holds the 
	var unitType:String;
	
	// When a card is created it requires:
	// The hand is was played from, The player is was played from, the unit typ, and the instace of sound currently in use
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
		addEventListener(Event.ADDED_TO_STAGE, drawCards);
		addEventListener(Event.ADDED_TO_STAGE, drawGraphics);
	}
	
	// When a card is clicked it start dragging and starts lissting for a release
	function drag(e:MouseEvent)
	{
		stage.addEventListener(MouseEvent.MOUSE_UP, stopdragging);
		this.startDrag();
	}
	
	// When the mouse is released after dragging this stops the drag
	// It also calls the hand update so the cards are reset in the hand if the card was not played
	public function stopdragging(e:MouseEvent)
	{
		this.stopDrag();
		hand.update();
	}

	// Draws the first imageof a spirite sheet onto the card and Displays all it's stats that are relavent for the player
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
		// Displays the Health of a Unit
		var healthText = new TextField();
		healthText.x = 50;
		healthText.y = this.height - 25;
		healthText.textColor = 0x000000;
		healthText.scaleX = healthText.scaleY = 1;
		healthText.text = Std.string(unitStats.health);
		healthText.selectable = false;
		healthText.width = 20;
		healthText.height = 20;
		addChild(healthText);
		// Displays the Soft damage of a Unit
		var softDamageText = new TextField();
		softDamageText.x = 40;
		softDamageText.y = this.height - 41;
		softDamageText.textColor = 0x000000;
		softDamageText.scaleX = softDamageText.scaleY = 1;
		softDamageText.text = Std.string(unitStats.softDamage);
		softDamageText.selectable = false;
		softDamageText.width = 20;
		softDamageText.height = 20;
		addChild(softDamageText);
		// Displays the AP damage of a Unit
		var apDamageText = new TextField();
		apDamageText.x = 90;
		apDamageText.y = this.height - 41;
		apDamageText.textColor = 0x000000;
		apDamageText.scaleX = apDamageText.scaleY = 1;
		apDamageText.text = Std.string(unitStats.apDamage);
		apDamageText.selectable = false;
		apDamageText.width = 20;
		apDamageText.height = 20;
		addChild(apDamageText);
		// Displays the Aram of a Unit
		var armorText = new TextField();
		armorText.x = 100;
		armorText.y = this.height - 25;
		armorText.textColor = 0x000000;
		armorText.scaleX = armorText.scaleY = 1;
		armorText.text = Std.string(unitStats.armor);
		armorText.selectable = false;
		armorText.width = 20;
		armorText.height = 20;
		addChild(armorText);
		
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
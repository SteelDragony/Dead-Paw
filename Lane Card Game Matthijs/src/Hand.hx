package ;
import openfl.display.Sprite;
import openfl.events.MouseEvent;

/**
 * ...
 * @author Matthijs van Gelder
 */
class Hand extends Sprite
{
	var game:Game;
	var playerSide:Int;
	
	public function new( g:Game, side:Int ) 
	{
		super();
		game = g;
		playerSide = side;
		update();
		
	}
	
	function update()
	{
		// card dragging test need to modify
		// addCard("YPR");
		// addCard("BearRifle");
	}
	
	public function addCard(unitType:String, soundHandler:Sound)
	{
		var card = new Card(playerSide, unitType, soundHandler);
		addChild(card);
		if (unitType == "YPR") card.x += 120;
		card.addEventListener(MouseEvent.MOUSE_UP, sendToGame);
	}
	
	function sendToGame(e:MouseEvent)
	{
		game.cardDrag(e.currentTarget);
	}
	
}
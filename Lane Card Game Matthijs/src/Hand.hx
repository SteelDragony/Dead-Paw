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
	var hand = new Array<Card>();
	
	
	public function new( g:Game, side:Int ) 
	{
		super();
		game = g;
		playerSide = side;
		update();
		
	}
	
	public function update()
	{
		for ( card in hand )
		{
		card.x = 140 + 160 * hand.indexOf(card);
		card.y = 500;
		}
	}
	
	public function addCard(unitType:String, soundHandler:Sound)
	{
		var card = new Card(playerSide, unitType, soundHandler);
		addChild(card);
		hand.push(card);
		card.addEventListener(MouseEvent.MOUSE_UP, sendToGame);
	}
	
	function sendToGame(e:MouseEvent)
	{
		game.cardDrag(e.currentTarget);
	}
	
}
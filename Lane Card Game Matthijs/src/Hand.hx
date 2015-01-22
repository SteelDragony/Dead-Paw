package ;
import openfl.display.Sprite;
import openfl.events.MouseEvent;

/**
 * Stores the hands of both players and gives x and y values to the cards.
 * @author Matthijs van Gelder
 */
class Hand extends Sprite
{
	var game:Game;
	var playerSide:Int;
	public var handArray = new Array<Card>();
	
	public function new( g:Game, side:Int ) 
	{
		super();
		game = g;
		playerSide = side;
		update();
		
	}
	// Dislpay cards for player 1 & 2
	// Displays cards for player 1 on the bottom of the screen these units move from LEFT to RIGHT
	// Displays cards for player 2 on the top of the screen these units move from RIGHT to LEFT
	public function update()
	{
		// trace (handArray);
		if (playerSide == 1)
		{
			for ( card in handArray )
			{
				card.x = 245 + 160 * handArray.indexOf(card);
				card.y = 590;
			}
		}
		
		if (playerSide == 2)
		{
			for ( card in handArray)
			{
				card.x = 10 + 160 * handArray.indexOf(card);
				card.y = 10;
			}
		}
	}
	
	// Used to add cards to the hands
	public function addCard(unitType:String, soundHandler:Sound)
	{
		var card = new Card(this, playerSide, unitType, soundHandler);
		addChild(card);
		handArray.push(card);
		card.addEventListener(MouseEvent.MOUSE_UP, sendToGame);
	}
	// Sends to chosen card to the game
	// Removes it from the array so more cards fit in
	function sendToGame(e:MouseEvent)
	{
		game.cardDrag(e.currentTarget);
	}
	
}
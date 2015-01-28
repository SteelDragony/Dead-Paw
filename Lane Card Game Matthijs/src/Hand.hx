package ;
import openfl.display.Sprite;
import openfl.events.MouseEvent;

/**
 * Stores the hands of both players and gives x and y values to the cards.
 * @author Matthijs van Gelder
 */
class Hand extends Sprite
{
	// class scope vars
	// stores reference to game
	var game:Game;
	
	// stores which side it belongs to
	var playerSide:Int;
	
	// the actual public array holding cards, ui needs to know length, thus public
	public var handArray = new Array<Card>();
	
	// initilize vars when created
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
		if (playerSide == 1)
		{
			for ( card in handArray )
			{
				card.x = 245 + 160 * handArray.indexOf(card);
				card.y = 590;
			}
		}
		// This can be toggled on to show the cards present in the AI's Hand
		//if (playerSide == 2)
		//{
			//for ( card in handArray)
			//{
				//card.x = 10 + 160 * handArray.indexOf(card);
				//card.y = 10;
			//}
		//}
	}
	
	// Used to add cards to the hands
	public function addCard(unitType:String, soundHandler:Sound)
	{
		var card = new Card(this, playerSide, unitType, soundHandler);
		// This can be toggled off to show the cards present in the AI's hand
		if (playerSide == 1)
		{
		addChild(card);
		}
		handArray.push(card);
		card.addEventListener(MouseEvent.MOUSE_UP, sendToGame);
	}
	// Sends to chosen card to the game to check if it can be played
	function sendToGame(e:MouseEvent)
	{
		game.cardDrag(e.currentTarget);
	}
	
	// function for the ai to play cards, considerig the ai does not have a mouse
	public function aiPlayCard(lane:Lane)
	{
		var tempCard:Card = handArray.pop();
		game.spawnUnitOnDrag(tempCard.unitStats, tempCard.unitGraphics, this.playerSide, lane);
	}
}
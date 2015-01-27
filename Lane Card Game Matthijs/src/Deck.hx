package ;
import openfl.display.Sprite;
import openfl.display.BitmapData;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.Lib;

/**
 * the deck of the player or ai.
 * Must initilize a starting deck.
 * Can shuffle the deck.
 * Can refill the deck when empty
 * get card function to get it to return the topmost card.
 * 
 * fillDeck gets called when created to make sure the deck is filled when a new game is created
 * 
 * variables:
	 * array of type card holding the cards in the deck
 * functions:
	 * shuffleArray: to randomize the position of cards in the array
	 * getCard: returns the top card of the array
	 * fillDeck: (re)fills the array with cards
	 * drawDeck: display the backside of a card to represent the deck
	 * 
 * 
 * @author Matthijs van Gelder
 */
class Deck extends Sprite
{
	var sound:Sound; 
	var deckArray = new Array<String>();
	var hand:Hand;
	var game:Game;
	var side:Int;
	
	
	public function new(currentGame:Game,player:Int) 
	{
		super();
		side = player;
		sound = new Sound();
		game = currentGame;
		// hand = new Hand(game,0);
		fillDeck();
		shuffle();
	}
	
	function fillDeck()
	{
		trace ("filling");
		for ( i in 0 ... 10)
		{
			// var card = new Card(hand, side, "YPR", sound);
			deckArray.push("YPR");
			
		}
		for ( i in 0 ... 10)
		{
			deckArray.push("PT76");
		}
		for ( i in 0 ... 10)
		{
			deckArray.push("AMX13");
		}
		for ( i in 0 ... 10)
		{
			deckArray.push("MerkavaMK3");
		}
		for ( i in 0 ... 10)
		{
			deckArray.push("Type99");
		}
		for ( i in 0 ... 10)
		{
			deckArray.push("YPRPRAT");
		}
		for ( i in 0 ... 10)
		{
			deckArray.push("BRDMAT");
		}
		for ( i in 0 ... 10)
		{
			deckArray.push("BearLmg");
		}
		for ( i in 0 ... 10)
		{
			deckArray.push("PandaLmg");
		}
		for ( i in 0 ... 10)
		{
			deckArray.push("PandaGL");
		}
		for ( i in 0 ... 10)
		{
			deckArray.push("BearHAT");
		}
		for ( i in 0 ... 10)
		{
			deckArray.push("PandaRifle");
		}
		for( i in 0 ... 10)
		{
			// var card = new Card(hand, side, "BearRifle", sound);
			deckArray.push("BearRifle");
		}
		for (i in 0 ... 10)
		{
			// var card = new Card(hand, side, "BearAt", sound);
			deckArray.push("BearAt");
		}
	}
	
	function shuffle()
	{
		trace ("shuffeling");
		var temp = new Array<String>();
		while ( deckArray.length > 0)
		{
			var currentSpot = Std.random(deckArray.length);
			temp.push(deckArray[currentSpot]);
			deckArray.remove(deckArray[currentSpot]);
		}
		deckArray = temp;
		
	}
	public function getCard():String
	{
		var tempcard:String;
		tempcard = deckArray.pop();
		return tempcard;
	}
	
}
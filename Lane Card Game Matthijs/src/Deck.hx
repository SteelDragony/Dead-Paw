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
	 * 
 * 
 * @author Matthijs van Gelder
 */
class Deck extends Sprite
{
	// Holds the strings that make up the deck
	var deckArray = new Array<String>();
	// Holds the current current clas of Game
	var game:Game;
	// Holds the side of the player for player 1 or 2/AI
	var side:Int;
	
	// Requires the current game and the side it was created for
	// Then fills and shuffles the deck with cards
	public function new(currentGame:Game,player:Int) 
	{
		super();
		side = player;
		game = currentGame;
		fillDeck();
		shuffle();
	}
	
	// This fills the deck with 10 cards of each type we currently have implemented
	function fillDeck()
	{
		for ( i in 0 ... 10)
		{
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
			deckArray.push("BearRifle");
		}
		for (i in 0 ... 10)
		{
			deckArray.push("BearAt");
		}
	}
	// Shuffles deck in a randomly
	// Creates a temp deck then replaces the old deck with tempdeck
	function shuffle()
	{
		var temp = new Array<String>();
		while ( deckArray.length > 0)
		{
			var currentSpot = Std.random(deckArray.length);
			temp.push(deckArray[currentSpot]);
			deckArray.remove(deckArray[currentSpot]);
		}
		deckArray = temp;
		
	}
	// Pulic funtion to be called when cards are required
	// Gives the caller a string to use
	// Pick and removes the last element of the deck array
	public function getCard():String
	{
		var tempcard:String;
		tempcard = deckArray.pop();
		return tempcard;
	}
	
}
package ;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.events.KeyboardEvent;
import openfl.Lib;
import haxe.Timer;
import openfl.ui.Keyboard;
import typedefs.UnitStats;
import typedefs.VisualData;
import openfl.ui.Keyboard;

/**
 * Game Class
 * 
 * central point for one individual game from start to finish, all things relating to that one game will happen in here or in its children.
 * @author Matthijs van Gelder
 */
class Game extends Sprite
{
	var inited:Bool;
	public var exitGameBool:Bool = false;
	// unit arrays storing all the units beloning to one side
	var units1 = new Array<Unit>();
	var units2 = new Array<Unit>();
	
	//variables to store the health of the player
	public var player1hp:Int;
	public var player2hp:Int;
	
	// declare Class scope variables
	public var hand1:Hand;
	public var hand2:Hand;
	var deck1:Deck;
	var deck2:Deck;
	var unithandler:Unithandler;
	
	
	//variables to store resources
	public var resourcesPlayer1:Int;
	public var resroucesPlayer2:Int;
	
	//array for looping through the lanes
	public var lanes = new Array<Lane>();
	
	// the sound and music class and volumecontrol
	var soundvolume:Float = 0.1 ;
	var musicvolume:Float = 1.0 ;
	var music = new Music ();
	public var sound = new Sound ();
	
	// Holds current class of userinterface
	var userinterface:Userinterface;
	
	// Bools used to monitor changes used for IF statements
	public var handChange:Bool = true;
	var victoryAchieved:Bool = false;
	
	// the ai player
	var ai:AiPlayer;
	
	/* ENTRY POINT */
	
function resize(e) 
	{
		if (!inited) init();
		// else (resize or orientation change)
	}
	
	function init() 
	{
		if (inited) return;
		inited = true;
		
		// Adding children for sound and music libs //
		addChild (sound) ;
		addChild (music) ;
		// playing Ambient sound loop //
		sound.soundAmb1(soundvolume);
		// Adds background to the game
		var backGround = new Bitmap(Assets.getBitmapData("img/Map.png"));
		addChild(backGround);
		// Adds unithandler to the game
		unithandler = new Unithandler(this);
		addChild(unithandler);
		// Adds userinterface to the game
		userinterface = new Userinterface(this);
		addChild(userinterface);
		// Adds decks for player 1 and 2/AI
		deck1 = new Deck(this, 1);
		deck2 = new Deck(this, 2);
		// Adds resources for player 1 and 2/AI
		// Currently not is use
		resourcesPlayer1 = 19;
		resourcesPlayer1 = 19;
		// Sets the HP op player 1 and 2/AI
		player1hp = 100;
		player2hp = 100;
		// Adds hands for player 1 and 2/AI
		hand1 = new Hand( this, 1 );
		hand2 = new Hand( this, 2 );
		addChild(hand1);
		addChild(hand2);
		
		// Adds 5 Cards for player 1
		for (i in 0 ... 5)
		{
			hand1.addCard(deck1.getCard(), sound);
		}
		// Adds 5 Cards for player 2/AI
		for ( i in 0 ... 5)
		{
			hand2.addCard(deck1.getCard(), sound);
		}
		// Creates invisable lanes
		for ( i in 0 ... 5 )
		{
			var lane = new Lane(i);
			addChild(lane);
			setChildIndex(lane, 0);
			lanes.push(lane);
		}
		// Adds AI to the game
		ai = new AiPlayer(this, hand2);
		// Creates an funtion to exit the game and go back to menu
		escButton();
	}
	
	// Updates the game everyframe called from Main at a certain interval
	// Updaters Unithandles, Userinterface, Handupdate, Ai update and victory check.
	public function update()
	{
		unithandler.update();
		userinterface.uiUpdate(hand1, hand2, player1hp, player2hp, resourcesPlayer1, resroucesPlayer2);
		if ( handChange)
		{
			hand1.update();
			hand2.update();
			handChange = false;
		}
		ai.update();
		if ( victoryAchieved == false )
		{
			vicotryCheck();
		}
	}
	
	// Runs when victory is achieved 
	function vicotryCheck ()
	{
		if (player1hp <= 0)
		{
			victoryAchieved = true;
			trace ("Player 2 wins the game");
			Timer.delay(exitGame, 5000);
		}
		else if (player2hp <= 0)
		{
			victoryAchieved = true;
			trace ("Player 1 wins the game");
			Timer.delay(exitGame, 5000);
		}
	}
	
	// Function to add cards to hand of player 1
	public function addCard1()
	{
		hand1.addCard(deck1.getCard(), sound);
		handChange = true;
	}
	
	// Function to add cards to the hand of player 2/AI
	public function addCard2()
	{
		hand2.addCard(deck2.getCard(), sound);
	}
	
	// Add Keyboard event to stage for when ESC is pressed
	function escButton()
	{
		stage.addEventListener(KeyboardEvent.KEY_DOWN, escESC);
	}
	
	// Called when ESC is pressed changes exitBool
	function escESC(e:KeyboardEvent)
	{
		if (e.keyCode == 27)
		{
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, escESC);
			exitGame();
		}
	}
	// Sets the varibales that exits the game
	function exitGame ()	
	{
		exitGameBool = true;
	}
	
	// Starts draggin a card to play a unit, gets passed said card by hand. called from hand.
	// Calls Unithandler to create units
	// Removes the card from hand
	public function cardDrag(card:Card)
	{
		for (lane in lanes)
		{
			if (card.y < (lane.y + lane.height) && card.y > (lane.y))
			{
				spawnUnitOnDrag(card.unitStats, card.unitGraphics, card.side, lane);
				addChild(card);
				hand1.handArray.remove(card);
				removeChild(card);
				stage.removeEventListener(MouseEvent.MOUSE_UP, card.stopdragging);
				sound.playSound("click");
				handChange = true;
			}
		}
	}
	
	// Spawns units by calling Unithandler
	// Requires UnitStats, UnitGrahics, side, and Lane
	// the Zero is for size of the unit was needed in earlier biulds
 	public function spawnUnitOnDrag(unitsStats:UnitStats, unitGrahics:VisualData, side:Int, lane:Lane )
	{
		unithandler.spawnSquad(unitsStats, unitGrahics, sound, side, 0, lane);
	}
	
	/* SETUP */

	public function new() 
	{
		super();
		addEventListener(Event.ADDED_TO_STAGE, added);
	}
	
	function added(e) 
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		stage.addEventListener(Event.RESIZE, resize);
		#if ios
		haxe.Timer.delay(init, 100); // iOS 6
		#else
		init();
		#end
	}
}
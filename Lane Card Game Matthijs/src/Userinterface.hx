package ;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.Assets;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
import flash.text.TextFieldAutoSize;
import haxe.Timer;

/**
 * Draws and updates the user interface
 * @author Ezzz
 */
class Userinterface extends Sprite
{
	// These Contain the Health of player 1 and 2 to display them on the score board
	var healthBaseCount1:Int;
	var healthBaseCount2:Int;
	// Holds the resources of player 1 and 2 to display 
	var resourceCount1:Int;
	var resourceCount2:Int;
	// Holds the Array's of player 1 and 2
	var handP1:Hand;
	var handP2:Hand;
	// Current time of 
	var currentTime:Float = 0;
	// Sets the times Untill next card for player 1 and 2
	var timeUntillCard:Float = 3;
	var timeUntillCardAI:Float = 3;
	// Store time in a text field
	var time = new TextField();
	// Store score in a text field
	var score = new TextField();
	// Store resourcers in a text field
	var resources = new TextField();
	// Store timedUntill card  in a text field
	var timeCard = new TextField();
	// A format for text on the right side of the UI
	var rightFormat = new TextFormat();
	// Stores a format for text in the center of the UI
	var centerFormat = new TextFormat();
	// Stores a number used to calculated time 
	var stamp:Float;
	// Stores the running instance of game
	var game:Game;
	
	public function new(currentGame:Game) 
	{
		super();
		game = currentGame;
		drawUI();
		setUpFonts();
	}
	
	// Draws the user interface
	function drawUI()
	{
		// Top part of the UI
		var getTopUI = Assets.getBitmapData("img/Top UI.png");
		var drawTopUI = new Bitmap(getTopUI);
		drawTopUI.x = 490;
		addChild(drawTopUI);
		// Left part of the UI
		var getLeftUI = Assets.getBitmapData("img/Left UI.png");
		var drawLeftUI = new Bitmap(getLeftUI);
		drawLeftUI.y = 500;
		addChild(drawLeftUI);
		// Middle part of the UI
		var getMidUI = Assets.getBitmapData("img/Mid UI.png");
		var drawMidUI = new Bitmap(getMidUI);
		drawMidUI.x = 200;
		drawMidUI.y = 600;
		addChild(drawMidUI);
		// Right part of the UI
		var getRightUI = Assets.getBitmapData("img/Right UI.png");
		var drawRightUI = new Bitmap(getRightUI);
		drawRightUI.x = 1080;
		drawRightUI.y = 500;
		addChild(drawRightUI);
		// Initlize all the varibles and displays them
		addChild(time);
		addChild(score);
		addChild(resources);
		addChild(timeCard);
	}

	// Makes fonts for different textfields
	function setUpFonts()
	{
		// Rightformat
		rightFormat.align = TextFormatAlign.RIGHT;
		rightFormat.size = 38;
		rightFormat.color = 0xB41A11;
		var niceFont = Assets.getFont("font/Coderscrux.ttf");
		rightFormat.font = niceFont.fontName;
		rightFormat.letterSpacing = 2;
		// Centerformat
		centerFormat.align = TextFormatAlign.CENTER;
		centerFormat.size = 38;
		centerFormat.color = 0xB41A11;
		var niceFont = Assets.getFont("font/Coderscrux.ttf");
		centerFormat.font = niceFont.fontName;
		centerFormat.letterSpacing = 2;
	}
	
	// Updates the user interface every frame
	// Recieves all the variables for game needed to update the UI
	// Calls all the other fuctions that need to be updated
	public function uiUpdate(handplayer1:Hand, handplayer2:Hand, healthBaseplayer1:Int, healthBasePlayer2:Int, resourcePlayer1:Int, resourcePlayer2:Int )
	{
		handP1 = handplayer1;
		handP2 = handplayer2;
		healthBaseCount1 = healthBaseplayer1;
		healthBaseCount2 = healthBasePlayer2;
		resourceCount1 = resourcePlayer1;
		resourceCount2 = resourcePlayer2;
		showTime();
		showScore();
		showResources();
		ShowTimeCard();
	}
	
	/*  Shows the time in the upper part of UI
	 * First clears the time and inserts the new time
	 */	
	function showTime()
	{
		time.text = ("");
		stamp = Timer.stamp();
		var second = Std.int(stamp);
		time.background = false;
		time.x = 550;
		time.y = 26;
		time.width = 100;
		time.selectable = false;		
		time.defaultTextFormat = rightFormat;
		time.text = second + "";
		time.embedFonts = true;
	}
	
	// Updtaes the score in the upper part of the UI
	// Dynamicly changes if players lose health
	function showScore()
	{
		score.text = ("");
		score.x = 550;
		score.y = 62;
		score.width = 200;
		score.height = 100;
		score.background = false;
		score.selectable = false;
		score.defaultTextFormat = centerFormat;
		score.text = (healthBaseCount1 + "VS" + healthBaseCount2);
		score.embedFonts = true;
	}
	
	// Updates the Resources count in the lower left side of the UI
	// Resoucers are currently not implemented into the game show static number
	function showResources()
	{
		resources.text = ("");
		resources.x = 20;
		resources.y = 613;
		resources.width = 100;
		resources.height = 100;
		resources.background = false;
		resources.selectable = false;
		resources.defaultTextFormat = rightFormat;
		resources.text = (resourceCount1 + "/20");
		resources.embedFonts = true;
	}
	// Updates and Caulculated the time untill next card in the left side of the UI
	function ShowTimeCard()
	{
		timeCard.text = ("");
		timeCard.x = 10;
		timeCard.y = 764;
		timeCard.width = 100;
		timeCard.height = 100;
		timeCard.background = false;
		timeCard.selectable = false;
		timeCard.defaultTextFormat = rightFormat;
		// Calculation Time untill next card for the AI/ player 2
		var tempArray2:Array<Card> = handP2.handArray;
		if (tempArray2.length < 5)
		{
			if (timeUntillCardAI <= 0)
			{
				timeUntillCardAI = 4;
				game.addCard2();
			}
			if (timeUntillCardAI > 3)
			{
				timeUntillCardAI = 3;
			}
			timeUntillCardAI -= 0.05;
		}
		if (tempArray2.length == 5 )
		{
			timeUntillCard = 99;
		}
		// Calculation off time unitll next card for player 1
		var tempArray1:Array<Card> = handP1.handArray; 
		if (tempArray1.length < 5)
		{
			if (timeUntillCard <= 0)
			{
				timeUntillCard = 4;
				game.addCard1();
			}
			if (timeUntillCard > 3)
			{
				timeUntillCard = 3;
			}
			timeUntillCard -= 0.05;	
		}
		if (tempArray1.length == 5 )
		{
			timeUntillCard = 99;
		}
		var timeUntillCardSecond:Int = Std.int(timeUntillCard);
		timeCard.text = (timeUntillCardSecond + "Sec");
		timeCard.embedFonts = true;
	}
	
}

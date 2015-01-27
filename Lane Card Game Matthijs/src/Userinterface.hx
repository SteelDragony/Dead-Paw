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
	var healthBaseCount1:Int;
	var healthBaseCount2:Int;
	var resourceCount1:Int;
	var resourceCount2:Int;
	var handP1:Hand;
	var handP2:Hand;
	var currentTime:Float = 0;
	var timeUntillCard:Float = 3;
	var time = new TextField();
	var score = new TextField();
	var resources = new TextField();
	var timeCard = new TextField();
	var rightFormat = new TextFormat();
	var centerFormat = new TextFormat();
	var stamp:Float;
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
		
	}
	// Makes fonts for different textfields
	function setUpFonts()
	{
		rightFormat.align = TextFormatAlign.RIGHT;
		rightFormat.size = 38;
		rightFormat.color = 0xB41A11;
		var niceFont = Assets.getFont("font/Coderscrux.ttf");
		rightFormat.font = niceFont.fontName;
		rightFormat.letterSpacing = 2;
		
		centerFormat.align = TextFormatAlign.CENTER;
		centerFormat.size = 38;
		centerFormat.color = 0xB41A11;
		var niceFont = Assets.getFont("font/Coderscrux.ttf");
		centerFormat.font = niceFont.fontName;
		centerFormat.letterSpacing = 2;
		
	}
	
	// Updates the user interface every frame
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
		// Old code to see if the function was called used mulitple times when bugs happend
		// currentTime += 1;
		// trace (currentTime);
		// trace(stamp);
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
		addChild(time);
		
	}
	// Shows the score in the upper part of the UI
	 
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
		addChild(score);
		
	}
	// Shows the Resources count in the lower left side of the UI
	
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
		addChild(resources);
	}
	// Show the time untill next card in the left side of the UI
	
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
		// add something here to keep track of the players hand and the time
		var tempArray:Array<Card> = handP1.handArray; 
		if (tempArray.length < 5)
		{
			
			if (timeUntillCard <= 0)
			{
				timeUntillCard = 4;
				game.addCard1();
				// Add function call here to deck to add card.
			}
			if (timeUntillCard > 3)
			{
				timeUntillCard = 3;
			}
			timeUntillCard -= 0.05;
			
		}
		if (tempArray.length == 5 )
		{
			timeUntillCard = 99;
		}
		var timeUntillCardSecond:Int = Std.int(timeUntillCard);
		timeCard.text = (timeUntillCardSecond + "Sec");
		timeCard.embedFonts = true;
		addChild(timeCard);
	}
	
}

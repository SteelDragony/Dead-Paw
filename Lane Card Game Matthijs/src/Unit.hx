package ;

import enums.UnitStates;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import typedefs.UnitStats;
import typedefs.VisualData;

import openfl.display.Tilesheet;
import openfl.geom.Point;
import openfl.geom.Rectangle;

import openfl.Assets;

/**
 * ...
 * @author Matthijs van Gelder
 */
class Unit extends Sprite
{
	// initialize variables for this unit
	public var health:Float;
	public var armor:Int;
	var softDamage:Float;
	var apDamage:Float;
	var accuracy:Int;
	var critChance:Int;
	var glancingChance:Int;
	var cooldown:Int;
	var burst:Bool;
	var burstRate:Int;
	var burstSize:Int;
	var moveSpeed:Int;
	public var range:Int = 200;
	
	//local state, timers, and counter variales
	var cooldownTimer:Int = 0;
	var currentshot:Int = 1;
	
	var side:Int;
	var attacking:Bool = false;
	
	var squad:Squad;
	
	//sound stuff:
	var sound:Sound;
	var soundvolume:Float = 0.4 ;
	
	//animation vars
	
	var spritePath:String;
	
	// the total amount of frames
	var frameCount:Int;
	var spriteRows:Int;
	var spriteColums:Int;
	var animationDone:Bool = true;
	  
	// the width and height of one frame
	public	var unitWidth:Int = 128;
	public	var unitHeight:Int = 128;
	
	// the frame that is currently visible
	var currentUnitImage:Int = 10;

	
	//animation state enum
	var animState:UnitStates = STATE_IDLE;
	
	//specific animation start and end positions
	var idleFrame:Int;
	
	var walkStart:Int;
	var walkEnd:Int;
	  
	var shootStart:Int;
	var shootEnd:Int;
	
	var curStart:Int;
	var curEnd:Int;
	
	// the OpenFL tilesheet object
	var unitTilesheet:Tilesheet;
		
	//assign values to the variables for specific unit
	public function new(parentSquad:Squad,player:Int, stats:UnitStats, graphicData:VisualData, soundReference:Sound) 
	{
		super();
		health = stats.health;
		armor = stats.armor;
		softDamage = stats.softDamage;
		apDamage = stats.apDamage;
		accuracy = stats.accuracy;
		critChance = stats.critChance;
		glancingChance = stats.glancingChance;
		cooldown = stats.cooldown;
		burst = stats.burst;
		burstRate = stats.burstRate;
		burstSize = stats.burstSize;
		moveSpeed = stats.moveSpeed;
		range = stats.range;
		sound = soundReference;
		
		side = player;
		this.squad = parentSquad;
		if (side == 2) this.scaleX = -1;
		
		spritePath = graphicData.spriteSheet;
	
		// the total amount of frames
		frameCount = graphicData.numFrames;
		spriteRows = graphicData.numRows;
		spriteColums = graphicData.numColums;
		animationDone = true;
		  
		// the width and height of one frame
		unitWidth = graphicData.spriteWidth;
		unitHeight = graphicData.spriteHeight;
		
		// the frame that is currently visible
		currentUnitImage = idleFrame;

		  
		//specific animation start and end positions
		idleFrame = graphicData.idleFrame - 1;
		
		// substract one to start counting from zero but leave matching frame count and last frame in units.json
		walkStart = graphicData.walkStart - 1;
		walkEnd = graphicData.walkEnd - 1;
		  
		shootStart = graphicData.shootStart - 1;
		shootEnd = graphicData.shootEnd - 1;
		
		trace(walkStart);
		trace(walkEnd);
		
		curStart = walkStart;
		curEnd = walkEnd;
		
		//sound
		addChild (sound) ;
		//draw();
		initializeTilesheet();
	}
	
	// central update function, stop calling to pause. may need to route attack through here for neetness in the code
	public function update()
	{
		drawNextImage();
		move();
		cooldownTimer --;
		deathCheck();
	}
	
	//move it left or right, depending on witch side this unit belongs to.
	function move()
	{
		if (side == 1 && attacking == false)
		{
			this.x += moveSpeed;
		}
		if (side == 2 && attacking == false)
		{
			this.x -= moveSpeed;
		}
	}
	
	function deathCheck()
	{
		if ( this.health <= 0)
		{
			squad.squadMembers.remove(this);
			squad.removeChild(this);
		}
	}
	
	// reduce the targets health by this units damage value, aka. attacking (may need expander funcionality).
	// to be done: hit chance, crit and glancing hits, targer priority system
	public function attack(targets:Array<Unit>)
	{
		var target:Unit;
		for (unit in targets)
		{
			if ( unit.armor >= apDamage && unit.armor != 0)
			{
				targets.remove(unit);
			}
		}
		target = targets[0];
		attacking = true;
		if (target != null)
		{
			if (burst == true && cooldownTimer <= 0)
			{
				if ( -cooldownTimer > cooldown) currentshot = 1;
				if (burstSize > currentshot)
				{
					currentshot ++;
					fireShot(target, burstRate);
				}
				else 
				{
					currentshot = 1;
					fireShot(target, cooldown);
				}
			}
			else if (cooldownTimer <= 0)
			{
				fireShot(target, cooldown);
			}
		}
	}

	function fireShot(target:Unit, setCooldown:Int)
	{
		if (Std.random(101) > accuracy)
		{
			trace("Miss");
			animState = STATE_SHOOTING;
			cooldownTimer = setCooldown;
			sound.playSound("autoCannon");
		}
		else
		{
			var damageModifier:Float = 1;
			var randomNumber:Int = Std.random(101);
			if (critChance > randomNumber)
			{
				damageModifier = 1.2;
				trace("CRIT!");
			}
			else if (glancingChance + critChance > randomNumber)
			{
				damageModifier = 0.8;
				trace("GLANCING HIT!");
			}
			if (target.armor == 0)
			{
				animState = STATE_SHOOTING;
				//trace("Soft");
				target.health -= this.softDamage * damageModifier;
				cooldownTimer = setCooldown;
				sound.playSound("autoCannon");
			}
			else if (apDamage > target.armor)
			{
				animState = STATE_SHOOTING;
				//trace("armor");
				target.health -= (apDamage * damageModifier - target.armor);
				cooldownTimer = setCooldown;
				sound.playSound("autoCannon");
			}
		}
	}
	
	public function startMoving()
	{
		animState = STATE_MOVING;
		attacking = false;
	}
	
	function drawNextImage():Void
	{
		this.graphics.clear();
		
		// draw the image with 'id' currentGooseImage onto this.graphics
		// the array [ 0, 0, currentGoose ] indicates
		// * the x position (in this case zero)
		// * the y position (in this case zero)
		// * the index of the image to draw (increments from 0 to 19 by use of the modulo operator: %)
		unitTilesheet.drawTiles( this.graphics, [ -unitWidth/2, 0, currentUnitImage], true );
		// point to the next index of the tile sheet's images
		
		switch (animState)
		{
			case STATE_IDLE:
				{
					currentUnitImage = idleFrame;
				}
			case STATE_MOVING:
				{
					if( currentUnitImage >= walkEnd || currentUnitImage < walkStart) currentUnitImage = walkStart;
					
					else currentUnitImage ++;
				}
			case STATE_SHOOTING:
				{
					if (currentUnitImage > shootEnd || currentUnitImage < shootStart) currentUnitImage = shootStart;
					
					else if (currentUnitImage == shootEnd)
					{
						currentUnitImage = idleFrame;
						animState = STATE_IDLE;
					}
					
					else currentUnitImage ++;
					
				}
		}
		/*
		if ( animState == STATE_SHOOTING && currentUnitImage == curEnd)
		{
			animState = STATE_IDLE;
		}
		if ( currentUnitImage != curEnd && currentUnitImage != frameCount - 1 ) currentUnitImage += 1;
		else if ( currentUnitImage == curEnd || currentUnitImage == frameCount - 1)
		{
			currentUnitImage = curStart;
		}
		*/
		/*
		if ( attacking == false)
		{
			curStart = walkStart;
			curEnd = walkEnd;
			//trace("moveing");
		}
		else if ( attacking == true && cooldownTimer <= 1)
		{
			
			curStart = shootStart;
			currentUnitImage = shootStart;
			curEnd = shootEnd;
			//trace("shooting");
		}
		else if (attacking == true && cooldownTimer > 0 )
		{
			curStart = idleFrame;
			curEnd = idleFrame;
			//trace("waiting");
		}
		*/
		/*
		 //old animation handeling frame limit
		if( currentUnitImage >= frameCount )
		{
			currentUnitImage = 0;
		}
		// old animation handeling
		if ( attacking == false)
		{
			animationDone = false;
			if (currentUnitImage > walkEnd || currentUnitImage < walkStart)
			{
				currentUnitImage = walkStart;
				animationDone = true;
			}
		}
		else if ( attacking == true && animationDone == false)
		{
			animationDone = false;
			if (currentUnitImage == shootEnd) animationDone = true;			
		}
		else if ( attacking == true && animationDone == true)
		{
			if (cooldownTimer > 1) currentUnitImage = idleFrame;
			else if (cooldownTimer <= 1) 
			{
				currentUnitImage = shootStart;
				animationDone = false;
			}
		}
		*/
	}	

  /**
   * Initialize the Tilesheet instance with the images of the goose.png sprite sheet
   * 
   * We know there's three columns of images with a total of 19 images. So 6 rows of three and one of one
   */
	function initializeTilesheet():Void
	{
		// start at the top left of the image
		var column:Int = 0;
		var row:Int = 0;

		// get image from assets folder and create tileSheet object
		var unitBitmapData:BitmapData = Assets.getBitmapData( spritePath );
		unitTilesheet = new Tilesheet( unitBitmapData );	

		// loop to get all the seperate images from the sprite sheet
		for( unitIndex in 0...frameCount)
		{
			// calculate the rectangle of the next goose's image
			var unitRectangle:Rectangle = new Rectangle( unitWidth * column, unitHeight * row, unitWidth, unitHeight );

			// add the rectangle of the next image in the sprite sheet
			unitTilesheet.addTileRect( unitRectangle );

			// some math to recalculate the row and column for the next image of the animation
			/* broken code: results in first 2 frames being on the same spot losing the last image of the animation
			row = Math.floor( unitIndex / spriteRows );
			column = unitIndex % spriteRows;
			*/
			column ++;
			if (column == spriteRows)
			{
				column = 0;
				row ++;
			}
		}
	}
	
	// takes care of drawing the for now static graphics
	// obsolete with the animation in place, may still contain usefull code
/*	function draw():Void
	{
		var bd = Assets.getBitmapData("img/2.png");
		var unitText = new Bitmap(bd);
		//scaling test, testing purposes only
		
		if (this.side == 0) 
		{
			unitText.scaleX = 1;
			unitText.x = -unitText.width / 2;
		}
		else if (this.side == 1)
		{
			unitText.scaleX = -1;
			unitText.x = unitText.width / 2;
		}
		unitText.scaleY = 1;
		
		unitText.y = -unitText.height / 2;
		
		// unitText.alpha = Math.random(); // just random alpha test
		
		addChild(unitText);
	}*/
}
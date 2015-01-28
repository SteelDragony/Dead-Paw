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
 * a single fighting unit
 * always part of a squad
 * has visiual and combat date handed to it when created
 * can attack a unit picked from an array of possible targets handed to it
 * can move
 * displays correct animation for the action the unit is currently doing, either moving, shooting, or idle
 * 
 * @author Matthijs van Gelder
 */
class Unit extends Sprite
{
	// initialize all class scope variables
	
	// initialize combat variables for this unit
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
	var currentshot:Int = 1
	var side:Int;
	var attacking:Bool = false;
	var squad:Squad;
	
	//sound variables
	var sound:Sound;
	var soundvolume:Float = 0.4 ;
	var firingSound:String;
	
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
		// assign all the unit combat stats from the date handed to this
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
		
		// store the soundreference
		sound = soundReference;
		
		// string to hand to sound for the correct firing sound
		firingSound = graphicData.firingSound;
		
		// assign which side this unit belongs to
		side = player;
		
		// assign which squad it belongs to
		this.squad = parentSquad;
		
		// mirror the unit if it belongs to the right side
		if (side == 2) this.scaleX = -1;
		
		// the path to the spritesheet of this unit
		spritePath = graphicData.spriteSheet;
	
		// the total amount of frames, row, and colums
		frameCount = graphicData.numFrames;
		spriteRows = graphicData.numRows;
		spriteColums = graphicData.numColums;
		  
		// the width and height of one frame
		unitWidth = graphicData.spriteWidth;
		unitHeight = graphicData.spriteHeight;
		
		// the frame that is currently visible
		currentUnitImage = idleFrame;

		  
		//specific animation start and end positions
		idleFrame = graphicData.idleFrame - 1;
		// walking cycle
		walkStart = graphicData.walkStart - 1;
		walkEnd = graphicData.walkEnd - 1;
		// shooting cycle  
		shootStart = graphicData.shootStart - 1;
		shootEnd = graphicData.shootEnd - 1;
		// start in walking cycle
		curStart = walkStart;
		curEnd = walkEnd;
		
		//sound
		addChild (sound) ;
		// prepere tilesheet for animations
		initializeTilesheet();
	}
	
	// central update function, stop calling to pause.
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
	// check if the unit is still alive
	function deathCheck()
	{
		if ( this.health <= 0)
		{// if dead remove it
			squad.squadMembers.remove(this);
			squad.removeChild(this);
		}
	}
	
	// reduce the targets health by this units damage value, aka. attacking (may need expander funcionality).
	// to be done: hit chance, crit and glancing hits, targer priority system
	public function attack(targets:Array<Unit>)
	{
		// variable to store the target unit in once decided
		var target:Unit;
		// check all possible targets
		for (unit in targets)
		{
			// remove units the unit cant damage from the target list
			if ( unit.armor >= apDamage && unit.armor != 0)
			{
				targets.remove(unit);
			}
		}
		// get the first, highest health, target from the array
		target = targets[0];
		// unit is attacking
		attacking = true;
		// if there is a valid target left
		if (target != null)
		{
			// if burst fire unit
			if (burst == true && cooldownTimer <= 0)
			{
				// reset the current shot if cooldowntimer exceeds the cooldown (reload the burst)
				if ( -cooldownTimer > cooldown) currentshot = 1;
				// if inside the burst
				if (burstSize > currentshot)
				{
					// go to next shot in burst
					currentshot ++;
					// fire a shot with burstrate as cooldown
					fireShot(target, burstRate);
				}
				// if last round of burst
				else 
				{
					// reset burst current shot
					currentshot = 1;
					// fire shot with full cooldown
					fireShot(target, cooldown);
				}
			}
			// for single shot units
			else if (cooldownTimer <= 0)
			{
				// fire shot with full cooldown
				fireShot(target, cooldown);
			}
		}
	}
	
	// deal damage to the base
	public function attackBase(currentGame:Game)
	{
		// it is attacking
		attacking = true;
		// if left side, to avoid attacking own base
		if (this.side == 1)
		{
			// burst attack handeling
			if (burst == true && cooldownTimer <= 0)
			{
				// reset the current shot if cooldowntimer exceeds the cooldown (reload the burst)
				if ( -cooldownTimer > cooldown) currentshot = 1;
				// if inside the burst
				if (burstSize > currentshot)
				{
					// go to next shot in burst
					currentshot ++;
					//deal damage to target
					currentGame.player2hp -= Std.int(this.softDamage);
					// set state to shooting
					animState = STATE_SHOOTING;
					// inside a burst use the burstrate as cooldown
					cooldownTimer = burstRate;
					// play firing sound
					sound.playSound(firingSound);
				}
				// else it is the last shot of a burst
				else 
				{
					// reset current shot to 1
					currentshot = 1;
					// deal damage to target
					currentGame.player2hp -= Std.int(this.softDamage);
					// set state to shooting
					animState = STATE_SHOOTING;
					// set cooldown timer to the actual cooldown
					cooldownTimer = cooldown;
					// play firing sound
					sound.playSound(firingSound);
				}
			}
			// general single shot attack
			else if (cooldownTimer <= 0)
			{
				currentGame.player2hp -= Std.int(this.softDamage);
				animState = STATE_SHOOTING;
				cooldownTimer = cooldown;
				sound.playSound(firingSound);
			}
		}
		// same for side two, the right side
		if (this.side == 2)
		{
			if (burst == true && cooldownTimer <= 0)
			{
				if ( -cooldownTimer > cooldown) currentshot = 1;
				if (burstSize > currentshot)
				{
					currentshot ++;
					currentGame.player1hp -= Std.int(this.softDamage);
					animState = STATE_SHOOTING;
					cooldownTimer = burstRate;
					sound.playSound(firingSound);
				}
				else 
				{
					currentshot = 1;
					currentGame.player1hp -= Std.int(this.softDamage);
					animState = STATE_SHOOTING;
					cooldownTimer = cooldown;
					sound.playSound(firingSound);
				}
			}
			else if (cooldownTimer <= 0)
			{
				currentGame.player1hp -= Std.int(this.softDamage);
				animState = STATE_SHOOTING;
				cooldownTimer = cooldown;
				sound.playSound(firingSound);
			}
		}
	}
	
	function fireShot(target:Unit, setCooldown:Int)
	{
		// check if the attack hits, random number between 0 and 100 should be smaller that accuracy to hit
		if (Std.random(101) > accuracy)
		{
			// miss
			// set state to shooting
			animState = STATE_SHOOTING;
			// set cooldown
			cooldownTimer = setCooldown;
			// play sound effect
			sound.playSound(firingSound);
		}
		// else its a hit
		else
		{
			var damageModifier:Float = 1;// initialize dmg modifier var
			var randomNumber:Int = Std.random(101); // generate random number for crit or glancing hit test
			
			if (critChance > randomNumber)
			{
				// if critical hit increase dmg modifier
				damageModifier = 1.2;
			}
			else if (glancingChance + critChance > randomNumber)
			{
				// if glancing hit decrease dmg modifier
				damageModifier = 0.8;
			}
			// if target has no armor use soft dmg
			if (target.armor == 0)
			{
				animState = STATE_SHOOTING;
				target.health -= this.softDamage * damageModifier;
				cooldownTimer = setCooldown;
				sound.playSound(firingSound);
			}
			// else us apDamage
			else if (apDamage > target.armor)
			{
				animState = STATE_SHOOTING;
				target.health -= (apDamage * damageModifier - target.armor);
				cooldownTimer = setCooldown;
				sound.playSound(firingSound);
			}
		}
	}
	
	public function startMoving()
	{
		// set state to moving
		animState = STATE_MOVING;
		// it is no longer attacking
		attacking = false;
	}
	
	function drawNextImage():Void
	{
		this.graphics.clear();
		// draw the curren frame of the unit animation
		unitTilesheet.drawTiles( this.graphics, [ -unitWidth/2, 0, currentUnitImage], true );
		// point to the next index of the tile sheet's images
		
		// use defined enum states to figure out what the animation code should be doing
		switch (animState)
		{
			case STATE_IDLE:
				{
					// display idleframe
					currentUnitImage = idleFrame; 
				}
			case STATE_MOVING:
				{
					// restart walk cycle if at last frame of walk cycle
					if( currentUnitImage >= walkEnd || currentUnitImage < walkStart) currentUnitImage = walkStart;
					// else go to nextframe
					else currentUnitImage ++; 
				}
			case STATE_SHOOTING:
				{
					if (currentUnitImage > shootEnd || currentUnitImage < shootStart) currentUnitImage = shootStart; //jump to start of firing animation if either at the end of in another frame not part of the fire cycle
					
					// if done shooting
					else if (currentUnitImage == shootEnd)
					{
						// go back to idle state
						currentUnitImage = idleFrame; 
						animState = STATE_IDLE;
					}
					// otherwise go to next frame
					else currentUnitImage ++;
					
				}
		}
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
			// loops through all the frames in all the rows and colums
			column ++;
			if (column == spriteRows)
			{
				column = 0;
				row ++;
			}
		}
	}
}
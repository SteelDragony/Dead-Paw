package;

import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import flash.media.SoundChannel;
import flash.media.SoundTransform;
import openfl.display.Sprite;
import openfl.Assets;
import openfl.Assets.loadSound;


/**
 * ...
 * @author Andor
 */
class Sound extends Sprite 
{

	
	var amb1 = Assets.getSound("audio/Amb_1.mp3");
	var at4sound1 = Assets.getSound("audio/AT4_1.wav");
	var at4sound2 = Assets.getSound("audio/AT4_2.wav");
	var at4sound3 = Assets.getSound("audio/AT4_3.wav");
	var beep = Assets.getSound("audio/Beep1.wav");
	var click = Assets.getSound("audio/Click3.wav");
	var tankGunSound1 = Assets.getSound("audio/Tank_fire_1.wav");
	var tankGunSound2 = Assets.getSound("audio/Tank_fire_2.wav");
	var tankGunSound3 = Assets.getSound("audio/Tank_fire_3.wav");
	var tankGunSound4 = Assets.getSound("audio/Tank_fire_4.wav");
	var tankGunSound5 = Assets.getSound("audio/Tank_fire_5.wav");
	
	var autoCannon1 = Assets.getSound("audio/Autocannon_1.wav");
	var autoCannon2 = Assets.getSound("audio/Autocannon_2.wav");
	var autoCannon3 = Assets.getSound("audio/Autocannon_3.wav");
	
	var soundVolume: Float;
	var ambChannel:SoundChannel;
	var channel:SoundChannel;
	
	public function new() 
	{
		super();
	}
	
	public function playSound (input:String)
	{
		switch (input)
		{
			case "click" :
			soundClick (soundVolume);
			case "tankGun" :
			soundMbtGun (soundVolume);
			case "at4" :
			soundAt4 (soundVolume);
			case "autoCannon" :
			soundAutoCannon (soundVolume);
			default :
			testingSound (soundVolume);
		}
	}
	
	public function testingSound (input:Float)
	{
		this.soundVolume = input ;
		channel = beep.play( 0, 0, new SoundTransform(soundVolume ) );
		//channel.soundTransform = new SoundTransform(soundVolume);
		
	}
	
	public function updateSoundVolume (input:Float)
	{
		this.soundVolume = input ;
		ambChannel.soundTransform = new SoundTransform(soundVolume);
		channel.soundTransform = new SoundTransform(soundVolume);
	}
	
	public function soundAmb1 (input:Float)
	{
		
		this.soundVolume = input ;
		
		ambChannel = amb1.play( 0, 0, new SoundTransform(soundVolume ) );
		//ambChannel.soundTransform = new SoundTransform(soundVolume);
		ambChannel.addEventListener(Event.SOUND_COMPLETE, soundAmb1Repeat );
		
	}
	
	function soundAmb1Repeat (event:Event)
	{
		ambChannel = amb1.play( 0, 0, new SoundTransform(soundVolume ) );
		//ambChannel.soundTransform = new SoundTransform(soundVolume);
		ambChannel.addEventListener(Event.SOUND_COMPLETE, soundAmb1Repeat );
	}
	
	public function stopAmbsounds ()
	{
		ambChannel.stop();
	}
	
	function soundClick (input:Float)
	{
		this.soundVolume = input ;
		channel = click.play( 0, 0, new SoundTransform(soundVolume ) );
		//channel.soundTransform = new SoundTransform(soundVolume);
	}
	
	function soundAt4 (input:Float)
	{
		this.soundVolume = input ;
		var randomSoundNumber:Int = Std.random(3) ;
		switch( randomSoundNumber ) 
		{	
		case 0:
			channel = at4sound1.play( 0, 0, new SoundTransform(soundVolume ) );
			//channel.soundTransform = new SoundTransform(soundVolume);
		case 1:
			channel = at4sound2.play( 0, 0, new SoundTransform(soundVolume ) );
			//channel.soundTransform = new SoundTransform(soundVolume);
		case 2:
			channel = at4sound3.play( 0, 0, new SoundTransform(soundVolume ) );
			//channel.soundTransform = new SoundTransform(soundVolume);
		default:
			channel = at4sound1.play( 0, 0, new SoundTransform(soundVolume ) );
			//channel.soundTransform = new SoundTransform(soundVolume);
		}	
	}
	
		function soundAutoCannon (input:Float)
	{
		this.soundVolume = input ;
		var randomSoundNumber:Int = Std.random(3) ;
		switch( randomSoundNumber ) 
		{	
		case 0:
			channel = autoCannon1.play( 0, 0, new SoundTransform(soundVolume ) );
		case 1:
			channel = autoCannon2.play( 0, 0, new SoundTransform(soundVolume ) );
		case 2:
			channel = autoCannon3.play( 0, 0, new SoundTransform(soundVolume ) );
		default:
			channel = autoCannon1.play( 0, 0, new SoundTransform(soundVolume ) );
		}	
	}
	
	function soundMbtGun (input:Float)
	{
		this.soundVolume = input ;
		var randomSoundNumber:Int = Std.random(5) ;
		switch( randomSoundNumber ) 
		{
		case 0:
			channel = tankGunSound1.play( 0, 0, new SoundTransform(soundVolume ) );
			//channel.soundTransform = new SoundTransform(soundVolume);
		case 1:
			channel = tankGunSound2.play( 0, 0, new SoundTransform(soundVolume ) );
		case 2:
			channel = tankGunSound3.play( 0, 0, new SoundTransform(soundVolume ) );
			//channel.soundTransform = new SoundTransform(soundVolume);
		case 3:
			channel = tankGunSound4.play( 0, 0, new SoundTransform(soundVolume ) );
			//channel.soundTransform = new SoundTransform(soundVolume);
		case 4:
			channel = tankGunSound5.play( 0, 0, new SoundTransform(soundVolume ) );
			//channel.soundTransform = new SoundTransform(soundVolume);
		default:
			channel = tankGunSound1.play( 0, 0, new SoundTransform(soundVolume ) );
			//channel.soundTransform = new SoundTransform(soundVolume);
		}
		
		
		
	}
}
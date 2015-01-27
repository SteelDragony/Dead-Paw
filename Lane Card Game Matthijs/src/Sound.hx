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
 * @author Andor Reineking
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
	var ak1 = Assets.getSound("audio/AK_1.wav");
	var ak2 = Assets.getSound("audio/AK_2.wav");
	var ak3 = Assets.getSound("audio/AK_3.wav");
	var ak4 = Assets.getSound("audio/AK_4.wav");
	var atgm1 = Assets.getSound("audio/ATGM_1.wav");
	var atgm2 = Assets.getSound("audio/ATGM_2.wav");
	var atgm3 = Assets.getSound("audio/ATGM_3.wav");
	var atgm4 = Assets.getSound("audio/ATGM_4.wav");
	var burstMG3 = Assets.getSound("audio/Burst_mg3.wav");
	var burstPKP = Assets.getSound("audio/Burst_pkm.wav");
	var burstrifle = Assets.getSound("audio/Burst_rifle.wav");
	var burstsaw = Assets.getSound("audio/Burst_saw.wav");
	var g361 = Assets.getSound("audio/G36_1.wav");
	var g362 = Assets.getSound("audio/G36_2.wav");	
	var g363 = Assets.getSound("audio/G36_3.wav");
	var grenade = Assets.getSound("audio/Grenade_1.wav");
	var grenadeLauncher = Assets.getSound("audio/Grenade_launcher_1.wav");
	var smg1 = Assets.getSound("audio/SMG_1.wav");
	var smg2 = Assets.getSound("audio/SMG_2.wav");
	var smg3 = Assets.getSound("audio/SMG_3.wav");
	var sniper1 = Assets.getSound("audio/Sniper_1.wav");
	var sniper2 = Assets.getSound("audio/Sniper_2.wav");
	var rpg1 = Assets.getSound("audio/RPG7_1.wav");
	var rpg2 = Assets.getSound("audio/RPG7_2.wav");
	
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
			case "ak" :
			soundAK (soundVolume);
			case "atgm" :
			soundATGM (soundVolume) ;
			case "mg3" :
			channel = burstMG3.play( 0, 0, new SoundTransform(soundVolume ) );
			case "pkp" :
			channel = burstPKP.play( 0, 0, new SoundTransform(soundVolume ) );
			case "rifleburst" :
			channel = burstrifle.play( 0, 0, new SoundTransform(soundVolume ) );
			case "saw" :
			channel = burstsaw.play( 0, 0, new SoundTransform(soundVolume ) );
			case "grenade" :
			channel = grenade.play( 0, 0, new SoundTransform(soundVolume ) );
			case "grenadeLauncher" :
			channel = grenadeLauncher.play( 0, 0, new SoundTransform(soundVolume ) );
			case "smg" :
			soundSMG (soundVolume) ;
			case "sniper" :
			soundSniper (soundVolume) ;
			case "rpg" :
			soundRPG (soundVolume) ;
			default :
			testingSound (soundVolume);
		}
	}
	
	public function testingSound (input:Float)
	{
		this.soundVolume = input ;
		channel = beep.play( 0, 0, new SoundTransform(soundVolume ) );
		
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
		ambChannel.addEventListener(Event.SOUND_COMPLETE, soundAmb1Repeat );
		
	}
	
	function soundAmb1Repeat (event:Event)
	{
		ambChannel = amb1.play( 0, 0, new SoundTransform(soundVolume ) );
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
	}
	
	function soundAt4 (input:Float)
	{
		this.soundVolume = input ;
		var randomSoundNumber:Int = Std.random(3) ;
		switch( randomSoundNumber ) 
		{	
		case 0:
			channel = at4sound1.play( 0, 0, new SoundTransform(soundVolume ) );
		case 1:
			channel = at4sound2.play( 0, 0, new SoundTransform(soundVolume ) );
		case 2:
			channel = at4sound3.play( 0, 0, new SoundTransform(soundVolume ) );
		default:
			channel = at4sound1.play( 0, 0, new SoundTransform(soundVolume ) );
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
		case 1:
			channel = tankGunSound2.play( 0, 0, new SoundTransform(soundVolume ) );
		case 2:
			channel = tankGunSound3.play( 0, 0, new SoundTransform(soundVolume ) );
		case 3:
			channel = tankGunSound4.play( 0, 0, new SoundTransform(soundVolume ) );
		case 4:
			channel = tankGunSound5.play( 0, 0, new SoundTransform(soundVolume ) );
		default:
			channel = tankGunSound1.play( 0, 0, new SoundTransform(soundVolume ) );
		}
	}
	
	function soundAK (input:Float)
	{
		this.soundVolume = input ;
		var randomSoundNumber:Int = Std.random(4) ;
		switch( randomSoundNumber ) 
		{
		case 0:
			channel = ak1.play( 0, 0, new SoundTransform(soundVolume ) );
		case 1:
			channel = ak2.play( 0, 0, new SoundTransform(soundVolume ) );
		case 2:
			channel = ak3.play( 0, 0, new SoundTransform(soundVolume ) );
		case 3:
			channel = ak4.play( 0, 0, new SoundTransform(soundVolume ) );
		default:
			channel = ak1.play( 0, 0, new SoundTransform(soundVolume ) );
		}	
	}
	
		
	function soundATGM (input:Float)
	{
		this.soundVolume = input ;
		var randomSoundNumber:Int = Std.random(4) ;
		switch( randomSoundNumber ) 
		{
		case 0:
			channel = atgm1.play( 0, 0, new SoundTransform(soundVolume ) );
		case 1:
			channel = atgm2.play( 0, 0, new SoundTransform(soundVolume ) );
		case 2:
			channel = atgm3.play( 0, 0, new SoundTransform(soundVolume ) );
		case 3:
			channel = atgm4.play( 0, 0, new SoundTransform(soundVolume ) );
		default:
			channel = atgm1.play( 0, 0, new SoundTransform(soundVolume ) );
		}	
	}
	
	function soundSMG (input:Float)
	{
		this.soundVolume = input ;
		var randomSoundNumber:Int = Std.random(3) ;
		switch( randomSoundNumber ) 
		{
		case 0:
			channel = smg1.play( 0, 0, new SoundTransform(soundVolume ) );
		case 1:
			channel = smg2.play( 0, 0, new SoundTransform(soundVolume ) );
		case 2:
			channel = smg3.play( 0, 0, new SoundTransform(soundVolume ) );
		default:
			channel = smg1.play( 0, 0, new SoundTransform(soundVolume ) );
		}	
	}
	
	function soundSniper (input:Float)
	{
		this.soundVolume = input ;
		var randomSoundNumber:Int = Std.random(2) ;
		switch( randomSoundNumber ) 
		{
		case 0:
			channel = sniper1.play( 0, 0, new SoundTransform(soundVolume ) );
		case 1:
			channel = sniper2.play( 0, 0, new SoundTransform(soundVolume ) );
		default:
			channel = sniper1.play( 0, 0, new SoundTransform(soundVolume ) );
		}	
	}
	
	function soundRPG (input:Float)
	{
		this.soundVolume = input ;
		var randomSoundNumber:Int = Std.random(2) ;
		switch( randomSoundNumber ) 
		{
		case 0:
			channel = rpg1.play( 0, 0, new SoundTransform(soundVolume ) );
		case 1:
			channel = rpg2.play( 0, 0, new SoundTransform(soundVolume ) );
		default:
			channel = rpg1.play( 0, 0, new SoundTransform(soundVolume ) );
		}	
	}
	
}
package;

import flash.display.Sprite;
import flash.events.Event;
import haxe.Timer;
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
class Music extends Sprite 
{

	var GameBGM1 = Assets.getSound("audio/music/GameBGM1.wav");
	var Maintheme = Assets.getSound("audio/music/Maintheme.mp3");
	var Win = Assets.getSound("audio/music/GameWin.wav");
	
	var musicVolume: Float;
	var soundChannel:SoundChannel;
	
	public function new() 
	{
		super();
		
	}
	
	public function stopMusic ()
	{
		soundChannel.stop();
	}
	
	public function gameMusic (input:Float)
	
	{
		this.musicVolume = input ;
		soundChannel = GameBGM1.play();
		soundChannel.soundTransform = new SoundTransform(musicVolume);
		soundChannel.addEventListener(Event.SOUND_COMPLETE, gameMusicRepeat );
		
		
	}
	
	function gameMusicRepeat (event:Event)
	{
		soundChannel = GameBGM1.play();
		soundChannel.soundTransform = new SoundTransform(musicVolume);
		soundChannel.addEventListener(Event.SOUND_COMPLETE, gameMusicRepeat );
		
	}
	
	public function mainMenuMusic (input:Float)
	
	{
		this.musicVolume = input ;
		soundChannel = Maintheme.play();
		soundChannel.soundTransform = new SoundTransform(musicVolume);
		soundChannel.addEventListener(Event.SOUND_COMPLETE, mainMenuMusicRepeat );
		
		
	}
	
	function mainMenuMusicRepeat (event:Event)
	{
		soundChannel = Maintheme.play();
		soundChannel.soundTransform = new SoundTransform(musicVolume);
		soundChannel.addEventListener(Event.SOUND_COMPLETE, gameMusicRepeat );
		
	}
}
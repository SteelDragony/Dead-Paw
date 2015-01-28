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
 * 
 * music class for the game
 * will repeat a song until public function ends it
 * 
 * 
 */
class Music extends Sprite 
{

	// Importing all songs
	
	var GameBGM1 = Assets.getSound("audio/music/GameBGM1.wav");
	var Maintheme = Assets.getSound("audio/music/Maintheme.mp3");
	var Win = Assets.getSound("audio/music/GameWin.wav");
	
	// variables for music volume and a soundchannel
	
	var musicVolume: Float;
	var soundChannel:SoundChannel;
	
	public function new() 
	{
		super();
		this.musicVolume = 1 ; // default volume
	}
	
	// function to adjust the volume in this class, gets the musicvolume float as a input.
	
	public function updateMusicVolume (input:Float)
	{
		this.musicVolume = input ;
	}
	
	// function to stop all music
	
	public function stopMusic ()
	{
		soundChannel.stop();
	}
	
	// starts the ingame music (currently not implemented due to not having statisfactory music)
	
	public function gameMusic ()
	
	{
		soundChannel = GameBGM1.play();
		soundChannel.soundTransform = new SoundTransform(musicVolume);
		soundChannel.addEventListener(Event.SOUND_COMPLETE, gameMusicRepeat );
	}
	
	// repeats the ingame song
	
	function gameMusicRepeat (event:Event)
	{
		soundChannel = GameBGM1.play();
		soundChannel.soundTransform = new SoundTransform(musicVolume);
		soundChannel.addEventListener(Event.SOUND_COMPLETE, gameMusicRepeat );
	}
	
	// starts the menu music
	
	public function mainMenuMusic ()
	
	{
		soundChannel = Maintheme.play();
		soundChannel.soundTransform = new SoundTransform(musicVolume);
		soundChannel.addEventListener(Event.SOUND_COMPLETE, mainMenuMusicRepeat );
	}
	
	// repeats the menu music
	
	function mainMenuMusicRepeat (event:Event)
	{
		soundChannel = Maintheme.play();
		soundChannel.soundTransform = new SoundTransform(musicVolume);
		soundChannel.addEventListener(Event.SOUND_COMPLETE, gameMusicRepeat );
		
	}
}
package lime;


import lime.utils.Assets;


class AssetData {

	private static var initialized:Bool = false;
	
	public static var library = new #if haxe3 Map <String, #else Hash <#end LibraryType> ();
	public static var path = new #if haxe3 Map <String, #else Hash <#end String> ();
	public static var type = new #if haxe3 Map <String, #else Hash <#end AssetType> ();	
	
	public static function initialize():Void {
		
		if (!initialized) {
			
			path.set ("img/2.png", "img/2.png");
			type.set ("img/2.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/Animtestsheet.png", "img/Animtestsheet.png");
			type.set ("img/Animtestsheet.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/RuBearRifle.png", "img/RuBearRifle.png");
			type.set ("img/RuBearRifle.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/YPR.png", "img/YPR.png");
			type.set ("img/YPR.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("audio/Amb_1.mp3", "audio/Amb_1.mp3");
			type.set ("audio/Amb_1.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			path.set ("audio/AT4_1.wav", "audio/AT4_1.wav");
			type.set ("audio/AT4_1.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("audio/AT4_2.wav", "audio/AT4_2.wav");
			type.set ("audio/AT4_2.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("audio/AT4_3.wav", "audio/AT4_3.wav");
			type.set ("audio/AT4_3.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("audio/Beep1.wav", "audio/Beep1.wav");
			type.set ("audio/Beep1.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("audio/Click3.wav", "audio/Click3.wav");
			type.set ("audio/Click3.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("audio/music/GameBGM1.wav", "audio/music/GameBGM1.wav");
			type.set ("audio/music/GameBGM1.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("audio/music/GameWin.wav", "audio/music/GameWin.wav");
			type.set ("audio/music/GameWin.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("audio/music/Maintheme.mp3", "audio/music/Maintheme.mp3");
			type.set ("audio/music/Maintheme.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			path.set ("audio/Tank_fire_1.wav", "audio/Tank_fire_1.wav");
			type.set ("audio/Tank_fire_1.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("audio/Tank_fire_2.wav", "audio/Tank_fire_2.wav");
			type.set ("audio/Tank_fire_2.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("audio/Tank_fire_3.wav", "audio/Tank_fire_3.wav");
			type.set ("audio/Tank_fire_3.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("audio/Tank_fire_4.wav", "audio/Tank_fire_4.wav");
			type.set ("audio/Tank_fire_4.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("audio/Tank_fire_5.wav", "audio/Tank_fire_5.wav");
			type.set ("audio/Tank_fire_5.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			
			
			initialized = true;
			
		} //!initialized
		
	} //initialize
	
	
} //AssetData

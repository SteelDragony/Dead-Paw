import lime.Assets;
#if !macro


class ApplicationMain {
	
	
	public static var config:lime.app.Config;
	public static var preloader:openfl.display.Preloader;
	
	private static var app:lime.app.Application;
	
	
	public static function create ():Void {
		
		app = new openfl.display.Application ();
		app.create (config);
		
		var display = new NMEPreloader ();
		
		preloader = new openfl.display.Preloader (display);
		preloader.onComplete = init;
		preloader.create (config);
		
		#if js
		var urls = [];
		var types = [];
		
		
		urls.push ("img/Background.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("img/BearAt.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("img/BearHAT.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("img/BearLMG.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("img/Cat_Sprint.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("img/East Card Back.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("img/East Card Front.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("img/Left UI.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("img/MenuButtonExit.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("img/MenuButtonExitHover.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("img/MenuButtonStart.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("img/MenuButtonStartHover.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("img/Mid UI.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("img/Right UI.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("img/RuBearRifle.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("img/Top UI.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("img/West Card Back.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("img/West Card Front.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("img/YPR.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("img/YPRPRAT.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("audio/AK_1.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/AK_2.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/AK_3.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/AK_4.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/Amb_1.mp3");
		types.push (AssetType.MUSIC);
		
		
		urls.push ("audio/Armor_Hit1.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/Armor_Hit2.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/Armor_Hit3.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/Arty_1.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/Arty_2.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/Arty_3.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/Arty_4.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/Arty_5.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/AT4_1.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/AT4_2.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/AT4_3.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/ATGM_1.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/ATGM_2.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/ATGM_3.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/ATGM_4.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/Autocannon_1.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/Autocannon_2.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/Autocannon_3.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/Beep1.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/Burst_mg3.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/Burst_pkm.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/Burst_rifle.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/Burst_saw.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/Click1.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/Click3.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/expl_1.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/expl_2.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/expl_3.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/expl_4.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/expl_5.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/G36_1.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/G36_2.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/G36_3.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/Grenade_1.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/Grenade_launcher_1.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/music/GameBGM1.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/music/GameWin.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/music/Maintheme.mp3");
		types.push (AssetType.MUSIC);
		
		
		urls.push ("audio/Radio_1.WAV");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/Rifle_fire1.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/Rifle_hit_1.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/Rifle_hit_2.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/Rifle_hit_3.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/Rifle_hit_4.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/Rifle_hit_5.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/Rifle_hit_6.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/RPG7_1.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/RPG7_2.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/SMG_1.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/SMG_2.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/SMG_3.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/Sniper_1.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/Sniper_2.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/Tank_fire_1.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/Tank_fire_2.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/Tank_fire_3.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/Tank_fire_4.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/Tank_fire_5.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/Tank_ground_hit1.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/Tank_ground_hit2.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("audio/Tank_ground_hit3.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("units/units.json");
		types.push (AssetType.TEXT);
		
		
		urls.push ("font/Coderscrux.ttf");
		types.push (AssetType.FONT);
		
		
		urls.push ("font/Colleged.ttf");
		types.push (AssetType.FONT);
		
		
		
		preloader.load (urls, types);
		#end
		
		var result = app.exec ();
		
		#if sys
		Sys.exit (result);
		#end
		
	}
	
	
	public static function init ():Void {
		
		var loaded = 0;
		var total = 0;
		var library_onLoad = function (_) {
			
			loaded++;
			
			if (loaded == total) {
				
				start ();
				
			}
			
		}
		
		
		
		if (loaded == total) {
			
			start ();
			
		}
		
	}
	
	
	public static function main () {
		
		config = {
			
			antialiasing: Std.int (0),
			background: Std.int (0),
			borderless: false,
			depthBuffer: false,
			fps: Std.int (30),
			fullscreen: false,
			height: Std.int (800),
			orientation: "",
			resizable: true,
			stencilBuffer: false,
			title: "Lane Card Game",
			vsync: false,
			width: Std.int (1280),
			
		}
		
		#if js
		#if munit
		flash.Lib.embed (null, 1280, 800, "000000");
		#end
		#else
		create ();
		#end
		
	}
	
	
	public static function start ():Void {
		
		openfl.Lib.current.stage.align = openfl.display.StageAlign.TOP_LEFT;
		openfl.Lib.current.stage.scaleMode = openfl.display.StageScaleMode.NO_SCALE;
		
		var hasMain = false;
		
		for (methodName in Type.getClassFields (Main)) {
			
			if (methodName == "main") {
				
				hasMain = true;
				break;
				
			}
			
		}
		
		if (hasMain) {
			
			Reflect.callMethod (Main, Reflect.field (Main, "main"), []);
			
		} else {
			
			var instance:DocumentClass = Type.createInstance (DocumentClass, []);
			
			if (Std.is (instance, openfl.display.DisplayObject)) {
				
				openfl.Lib.current.addChild (cast instance);
				
			}
			
		}
		
		openfl.Lib.current.stage.dispatchEvent (new openfl.events.Event (openfl.events.Event.RESIZE, false, false));
		
	}
	
	
	#if neko
	@:noCompletion public static function __init__ () {
		
		var loader = new neko.vm.Loader (untyped $loader);
		loader.addPath (haxe.io.Path.directory (Sys.executablePath ()));
		loader.addPath ("./");
		loader.addPath ("@executable_path/");
		
	}
	#end
	
	
}


#if flash @:build(DocumentClass.buildFlash())
#else @:build(DocumentClass.build()) #end
@:keep class DocumentClass extends Main {}


#else


import haxe.macro.Context;
import haxe.macro.Expr;


class DocumentClass {
	
	
	macro public static function build ():Array<Field> {
		
		var classType = Context.getLocalClass ().get ();
		var searchTypes = classType;
		
		while (searchTypes.superClass != null) {
			
			if (searchTypes.pack.length == 2 && searchTypes.pack[1] == "display" && searchTypes.name == "DisplayObject") {
				
				var fields = Context.getBuildFields ();
				
				var method = macro {
					
					this.stage = flash.Lib.current.stage;
					super ();
					dispatchEvent (new openfl.events.Event (openfl.events.Event.ADDED_TO_STAGE, false, false));
					
				}
				
				fields.push ({ name: "new", access: [ APublic ], kind: FFun({ args: [], expr: method, params: [], ret: macro :Void }), pos: Context.currentPos () });
				
				return fields;
				
			}
			
			searchTypes = searchTypes.superClass.t.get ();
			
		}
		
		return null;
		
	}
	
	
	macro public static function buildFlash ():Array<Field> {
		
		var classType = Context.getLocalClass ().get ();
		var searchTypes = classType;
		
		while (searchTypes.superClass != null) {
			
			if (searchTypes.pack.length == 2 && searchTypes.pack[1] == "display" && searchTypes.name == "DisplayObject") {
				
				var fields = Context.getBuildFields ();
				var method = macro {
					return flash.Lib.current.stage;
				}
				
				fields.push ({ name: "get_stage", access: [ APrivate ], meta: [ { name: ":getter", params: [ macro stage ], pos: Context.currentPos() } ], kind: FFun({ args: [], expr: method, params: [], ret: macro :flash.display.Stage }), pos: Context.currentPos() });
				return fields;
				
			}
			
			searchTypes = searchTypes.superClass.t.get ();
			
		}
		
		return null;
		
	}
	
	
}


#end
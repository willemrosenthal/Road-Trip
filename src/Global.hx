package ;
import flixel.FlxCamera;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.util.FlxPoint;
import flixel.group.FlxGroup;

class Global {

    // world
	static public var speed:Float = 20;
    static public var shadowDistance:Float = 7;

    static public var player:Player;
    static public var playerSpeed:FlxPoint = new FlxPoint(0,0);

    // cameras
    static public var shadowCam:FlxCamera;
    static public var fgCam:FlxCamera;

    // groups
    static public var cars:FlxGroup;
    static public var shadows:FlxGroup;
    static public var numbers:FlxGroup;

    static public var txt:FlxText;

    static public var gMouseSet:Int = -1;
    static public var gameMouse:FlxPoint = new FlxPoint(0,0);
    static public var vMouseSet:Int = -1;
    static public var vbarMouse:FlxPoint = new FlxPoint(0,0);
    static public var hMouseSet:Int = -1;
    static public var hbarMouse:FlxPoint = new FlxPoint(0,0);

}

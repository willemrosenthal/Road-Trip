package ;
import flixel.FlxCamera;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.util.FlxPoint;
import flixel.group.FlxGroup;

class Global {

	static public var speed:Float = 20;
    static public var player:Player;

    // cameras
    static public var shadowCam:FlxCamera;
    static public var fgCam:FlxCamera;

    // groups
    static public var cars:FlxGroup;
    static public var shadows:FlxGroup;
    static public var numbers:FlxGroup;

    static public var txt:FlxText;

}

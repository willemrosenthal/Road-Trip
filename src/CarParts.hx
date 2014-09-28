package ;
import flixel.FlxCamera;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.util.FlxPoint;
import flixel.group.FlxGroup;

class CarParts {

    // world
	static public var guns:Array<Dynamic> = [
    ['machine_cannon2', 40,11,-5.5,0,1,'bullet',12,80],
    ['machine_cannon', 46,11,-8,0,12,'bullet',12,80],
    ['machine_cannon3', 40,11,-5.5,0,1,'bullet',12,80]
    ];
    //['gun name', width, height, x-offset, y-offset, fps, 'bullet name', rate-of-fire, damage]

    static public function getGun(GunId:String):Array<Dynamic> {
        for (i in 0...guns.length) {
            if (guns[i][0] == GunId)
                return guns[i];
        }
        return [];
    }
}

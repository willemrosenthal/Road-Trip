package ;
import flixel.group.FlxGroup;

class Calc {

    public static function plusOrMinus(num:Float):Float {
        return (1 - Math.round(Math.random()) * 2) * num;
    }

    public static function addShadow(shadow:Dynamic):Void {
        Global.shadows.add(shadow);
        Global.shadows.setAll("cameras", [Global.shadowCam]);
    }

}

package ;
import flixel.group.FlxGroup;

class GroupControl {

    public static function addCar(car:Dynamic):Void {
        Global.cars.add(car);
        Global.cars.setAll("cameras", [Global.fgCam]);
    }

    public static function addShadow(shadow:Dynamic):Void {
        Global.shadows.add(shadow);
        Global.shadows.setAll("cameras", [Global.shadowCam]);
    }

}

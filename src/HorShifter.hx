package ;

import flixel.util.FlxRect;
import flixel.FlxSprite;
import flixel.util.FlxPoint;

class HorShifter extends FlxSprite {

    public var maxDistance:Float = 20;
    public var moveIgnoreRange:Int = 3;
    public var moveSpeed:Float = 50;

    private var nutral:Float = 0;
    private var forward:Float = 0;
    private var reverse:Float = 0;

    private var originPoint:FlxPoint;
    private var mouseArea:FlxRect;

    private var knobDistance:Int = 16;
    private var minDistance:Int = 8;

    private var dir:String;

    public function new(X:Float, Y:Float, Area:FlxRect) {
        super(X, Y);
        originPoint = new FlxPoint(X,Y);
        mouseArea = Area;

        loadGraphic('assets/images/ui/lever_h.png', false, 17, 44);
        offset.y = height * 0.5;
        offset.x = width * 0.5;
    }

    override public function update():Void {
        super.update();

        if (Global.hMouseSet != -1)
            calculateJoystick();
        if (Global.hMouseSet == -1)
            recenterJoystick();

        Global.playerSpeed.x = (originPoint.x - x)/knobDistance;
    }

    var xDif:Float;
    private function calculateJoystick():Void {
        xDif = originPoint.x - Global.hbarMouse.x;

        x = originPoint.x - xDif;
        if (xDif > knobDistance)
            x = originPoint.x - knobDistance;
        if (xDif < knobDistance * -1)
            x = originPoint.x + knobDistance;

    }

    private function recenterJoystick():Void {
        x = originPoint.x;
        y = originPoint.y;
    }

}
package ;

import flixel.util.FlxRect;
import flixel.FlxSprite;
import flixel.util.FlxPoint;

class VertShifter extends FlxSprite {

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

		loadGraphic('assets/images/ui/lever.png', false, 44, 17);
		offset.y = height * 0.5;
		offset.x = width * 0.5;
	}

	override public function update():Void {
		super.update();

        if (Global.vMouseSet != -1)
            calculateJoystick();
        if (Global.vMouseSet == -1)
            recenterJoystick();

        Global.playerSpeed.y = (originPoint.y - y)/knobDistance;
	}

    var yDif:Float;
	private function calculateJoystick():Void {
		yDif = originPoint.y - Global.vbarMouse.y;

        y = originPoint.y - yDif;
        if (yDif > knobDistance)
            y = originPoint.y - knobDistance;
        if (yDif < knobDistance * -1)
            y = originPoint.y + knobDistance;

    }

    private function recenterJoystick():Void {
        x = originPoint.x;
        y = originPoint.y;
    }

}
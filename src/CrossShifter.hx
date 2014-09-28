package ;

import flixel.group.FlxGroup;
import flixel.util.FlxRect;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxPoint;
import flixel.FlxObject;

class CrossShifter extends FlxSprite {

	public var maxDistance:Float = 20;
	public var moveIgnoreRange:Int = 3;
	public var moveSpeed:Float = 50;

	private var nutral:Float = 0;
    private var forward:Float = 0;
    private var reverse:Float = 0;

    private var originPoint:FlxPoint;
    private var mouseDownPoint:FlxPoint;
    private var mouseArea:FlxRect;


    public var mouseDown:Bool = false;

    private var mouse:FlxPoint;
    private var knobDistance:Int = 16;
    private var minDistance:Int = 8;

    private var dir:String;

	public function new(X:Float, Y:Float, Area:FlxRect) {
		super(X, Y);
		originPoint = new FlxPoint(X,Y);
        mouseArea = Area;

		loadGraphic('assets/images/ui/knob.png', false, 17, 17);
		offset.y = height * 0.5;
		offset.x = width * 0.5;

        mouse = new FlxPoint();
        mouseDownPoint = new FlxPoint();
	}

	override public function update():Void {
		super.update();

        mouse.x = FlxG.stage.mouseX / FlxG.camera.zoom;
        mouse.y = FlxG.stage.mouseY / FlxG.camera.zoom;


        // if mouse is over correct area
        if (mouse.x > mouseArea.x && mouse.x < mouseArea.width + mouseArea.x && mouse.y > mouseArea.y && mouse.y < mouseArea.height + mouseArea.y) {
            if (FlxG.mouse.pressed && !mouseDown) {
                mouseDown = true;
                recenterJoystick();
                }
        }
		else mouseDown = false;

        if (FlxG.mouse.justReleased && mouseDown) {
            mouseDown = false;
        }

        if (mouseDown)
            calculateJoystick();
        if (!mouseDown)
            recenterJoystick();

        Global.playerSpeed.x = (originPoint.x - x)/knobDistance;
        Global.playerSpeed.y = (originPoint.y - y)/knobDistance;
	}

    var xDif:Float;
    var yDif:Float;
	private function calculateJoystick():Void {
		yDif = mouseDownPoint.y - FlxG.stage.mouseY / FlxG.camera.zoom;
        xDif = mouseDownPoint.x - FlxG.stage.mouseX / FlxG.camera.zoom;

        if (Math.abs(xDif) > minDistance || Math.abs(yDif) > minDistance) {
            if (Math.abs(xDif) > Math.abs(yDif) * 1.5) { // x access
                if (xDif < 0) {
                    x = originPoint.x + knobDistance;
                    y = originPoint.y;
                }
                else if (xDif > 0) {
                    x = originPoint.x - knobDistance;
                    y = originPoint.y;
                }
            }
            else if (Math.abs(yDif) > Math.abs(xDif) * 1.5) { // y access
                if (yDif < 0) {
                    y = originPoint.y + knobDistance;
                    x = originPoint.x;
                }
                else if (yDif > 0) {
                    y = originPoint.y - knobDistance;
                    x = originPoint.x;
                }
            }
        }
    }

    private function recenterJoystick():Void {
        x = originPoint.x;
        y = originPoint.y;
        mouseDownPoint.x = mouse.x;
        mouseDownPoint.y = mouse.y;
    }




}
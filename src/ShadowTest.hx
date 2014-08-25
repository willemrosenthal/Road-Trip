package ;

import flixel.FlxG;
import flixel.util.FlxPoint;


class ShadowTest extends Car
{

    private var deadzoneX:Float = 0.15;
    private var deadzoneY:Float = 0.08;
    private var zeroPoint:FlxPoint;

    var follow:Car;

    public function new(Follow:Car)
    {
        follow = Follow;
        super(follow.x, follow.y, 'assets/images/complextest3.png');
        this.color = 0x000000;
    }

    override public function update():Void {
        super.update();
        this.x = follow.x + follow.xSpeed;
        this.y = follow.y + Global.shadowDistance + follow.ySpeed;
        this.angle = follow.angle;

    }

}
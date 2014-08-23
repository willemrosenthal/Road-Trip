package ;

import flixel.FlxG;
import flixel.util.FlxPoint;


class ShadowTest extends Car
{

    private var deadzoneX:Float = 0.15;
    private var deadzoneY:Float = 0.08;
    private var zeroPoint:FlxPoint;

    var player:Player;

    public function new(X:Float, Y:Float)
    {
        super(X, Y, 'assets/images/player.png');
        this.color = 0x000000;
    }

    override public function update():Void {
        super.update();
        this.x = Global.player.x + Global.player.xSpeed;
        this.y = Global.player.y + 7 + Global.player.ySpeed;
        this.angle = Global.player.angle;

    }

}
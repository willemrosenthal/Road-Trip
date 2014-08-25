package ;

import flixel.util.FlxAngle;
import flixel.util.FlxPoint;
import flixel.FlxSprite;

class CarPart extends FlxSprite
{
    private var leader:Player;
    private var leaderOffset:FlxPoint = new FlxPoint();

    private var isWheel:Int = 0;

    public var shake:Float = 0.25;

    public function new(X:Float, Y:Float, Leader:Player, ?SimpleGraphic:Dynamic, Type:UInt = 0)
    {
        super(X, Y, SimpleGraphic);
        solid = false;
        leader = Leader;

        leaderOffset.x = x - leader.x;
        leaderOffset.y = y - leader.y;

        if (Type == 0)
            isWheel = 1;
        if (Type == 1)
            shake = 1;
        if (Type > 0)
            centeredOnCar();

        GroupControl.addShadow(new Shadow(this, SimpleGraphic));
    }

    override public function update():Void {
        super.update();
        this.x = leader.x + leaderOffset.x + (leader.xSpeed * isWheel);
        this.y = leader.y + leaderOffset.y + (leader.ySpeed * isWheel);
        angle = 0;
        rotateWithCar();
        shakeF();
    }

    private function rotateWithCar():Void {
        var cp:FlxPoint = new FlxPoint(x + width * 0.5, y + height * 0.5);
        var pt:FlxPoint = FlxAngleAlt.rotatePoint(cp.x, cp.y, leader.x + leader.width * 0.5, leader.y + leader.height * 0.5, leader.angle);
        x = pt.x - width * 0.5;
        y = pt.y - height * 0.5;
        angle = leader.angle;
    }

    private function shakeF():Void {
        x += Calc.plusOrMinus(Math.random() * shake);
        y += Calc.plusOrMinus(Math.random() * shake);
    }

    private function centeredOnCar():Void {
        leaderOffset.x -= width * 0.5;
        leaderOffset.y -= height * 0.5;
    }

}
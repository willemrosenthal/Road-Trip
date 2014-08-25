package ;

import flixel.util.FlxAngle;
import flixel.util.FlxPoint;
import flixel.FlxSprite;

class CarPart extends FlxSprite
{
    private var leader:Player;
    private var leaderOffset:FlxPoint = new FlxPoint();

    public function new(X:Float, Y:Float, Leader:Player, ?SimpleGraphic:Dynamic, Type:UInt = 0)
    {
        super(X, Y, SimpleGraphic);
        solid = false;
        leader = Leader;

        leaderOffset.x = x - leader.x;
        leaderOffset.y = y - leader.y;

        if (Type == 1 || Type == 2 || Type == 3)
            centeredOnCar();

        GroupControl.addShadow(new Shadow(this, SimpleGraphic));
    }

    override public function update():Void {
        super.update();
        this.x = leader.x + leaderOffset.x + leader.xSpeed;
        this.y = leader.y + leaderOffset.y + leader.ySpeed;
        angle = 0;
        rotateWithCar();
    }

    private function rotateWithCar():Void {
        var cp:FlxPoint = new FlxPoint(x + width * 0.5, y + height * 0.5);
        var pt:FlxPoint = FlxAngleAlt.rotatePoint(cp.x, cp.y, leader.x + leader.width * 0.5, leader.y + leader.height * 0.5, leader.angle);
        x = pt.x - width * 0.5;
        y = pt.y - height * 0.5;
        angle = leader.angle;
    }

    private function centeredOnCar():Void {
        leaderOffset.x -= width * 0.5;
    }

}
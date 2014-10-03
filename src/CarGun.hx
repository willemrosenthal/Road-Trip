package ;

import flixel.FlxG;
import flixel.util.FlxAngle;
import flixel.util.FlxPoint;
import flixel.FlxSprite;

class CarGun extends FlxSprite
{
    private var leader:Player;
    private var leaderOffset:FlxPoint = new FlxPoint();

    public var shake:Float = 0.25;
    public var gunStats:Array<Dynamic>;

    private var shootTimer:Int = 0;

    public function new(X:Float, Y:Float, Leader:Player, GunId:String)
    {
        super(X, Y);
        solid = false;
        leader = Leader;

        //['gun name', width, height, x-offset, y-offset, fps, shoot frames,'bullet name', rate-of-fire, damage]
        gunStats = CarParts.getGun(GunId);

        loadGraphic('assets/images/car/gun/' + gunStats[0] + '.png', true, gunStats[1],gunStats[2]);
        animation.add('shoot', gunStats[6],gunStats[5],false);
        animation.add('idle', [2]);

        animation.play('idle');

        origin.x -= gunStats[3];
        origin.y -= gunStats[4];

        leaderOffset.x = x - leader.x + gunStats[3];
        leaderOffset.y = y - leader.y + gunStats[4];
        centeredOnCar();

        //GroupControl.addShadow(new Shadow(this, 'assets/images/car/gun/' + gunStats[0] + '_shadow.png', false, gunStats[3], gunStats[4] - 10));
    }

    override public function update():Void {
        super.update();
        this.x = leader.x + leaderOffset.x;
        this.y = leader.y + leaderOffset.y;
        angle = 0;
        rotateWithCar();
        aim();
        shakeF();
        shoot();
    }

    private function shoot():Void {
        if (Global.gMouseSet != -1)
            animation.play('shoot');
        else if (animation.finished)
            animation.play('idle');

        if (shootTimer > 0)
            shootTimer --;

        if (Global.gMouseSet != -1) {
            if (shootTimer == 0) {
                Global.effects.add(new BulletShot(Global.gameMouse.x,Global.gameMouse.y,CarParts.getBullet(gunStats[7]),gunStats[9]));
                shootTimer = gunStats[8];
            }
        }

    }

    private function rotateWithCar():Void {
        var cp:FlxPoint = new FlxPoint(x + width * 0.5, y + height * 0.5);
        var pt:FlxPoint = FlxAngleAlt.rotatePoint(cp.x, cp.y, leader.x + leader.width * 0.5, leader.y + leader.height * 0.5, leader.angle);
        x = pt.x - width * 0.5;
        y = pt.y - height * 0.5;
        //angle = leader.angle;
    }

    private var _dx:Float;
    private var _dy:Float;
    private function aim():Void {
        _dx = Global.gameMouse.x - x;
        _dy = Global.gameMouse.y - y;
        angle = (Math.atan2(_dy, _dx) * 180 / Math.PI) + 180;
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
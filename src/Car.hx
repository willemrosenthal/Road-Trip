package ;

import flixel.FlxSprite;

class Car extends FlxSprite
{
    public var xSpeed:Float = 0;
    var xChange:Float = 0.1;
    var xChangeNormal:Float = 0.1;
    var xMax:Float = 4;

    public var ySpeed:Float = 0;
    var yChange:Float = 0.1;
    var yChangeNormal:Float = 0.1;
    var yMax:Float = 3;

    var impactSpeed:Float = 0;
    var impactPower:Float = 0.3;
    var impactDecay:Float = 0.7;


    public var weight:Float = 50;

    //public var health:Float = 100;

    public function new(X:Float, Y:Float, ?SimpleGraphic:Dynamic)
    {
        super(X, Y, SimpleGraphic);
    }

    override public function update():Void {
        super.update();

        if (impactSpeed != 0) {
            xSpeed += impactSpeed * (impactPower);
            impactSpeed *= impactDecay;
            if (Math.abs(impactSpeed) < 0.005)
                impactSpeed = 0;
        }


        x += xSpeed;
        y += ySpeed;
        rotateCar();
    }


    function rotateCar():Void {
        angle = (xSpeed/xMax * 40);
    }

    public function impact(xImpactSpeed:Float, power = 0.3, damage:Bool = false):Void {
        impactSpeed += xImpactSpeed;
        impactPower = power;
    }

    public function weightSpeed():Void {
        xSpeed + weight;
    }


}
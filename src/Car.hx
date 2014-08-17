package ;

import flixel.FlxSprite;

class Car extends FlxSprite
{
    public var xSpeed:Float = 0;
    var xChange:Float = 0.1;
    var xChangeNormal:Float = 0.1;
    var xMax:Float = 4;

    var swipeSpeed:Float = 0;
    var swipeTime:Float = 12;
    var swipeTimer:Float = 0;
    var swipeChange:Float = 0.6;
    var swipe:Int = 0;
    var swipeCooldown:Int = 0;

    public var ySpeed:Float = 0;
    var yChange:Float = 0.1;
    var yChangeNormal:Float = 0.1;
    var yMax:Float = 3;

    var impactSpeed:Float = 0;
    var impactPower:Float = 0.3;
    var impactDecay:Float = 0.7;


    public var weight:Float = 10;

    //public var health:Float = 100;

    public function new(X:Float, Y:Float, ?SimpleGraphic:Dynamic)
    {
        super(X, Y, SimpleGraphic);
    }

//public function updates():Void {
    override public function update():Void {
        super.update();

        if (impactSpeed != 0) {
            xSpeed += impactSpeed * (impactPower);
            x += impactSpeed * (impactPower) * 1.5;
            impactSpeed *= impactDecay;
            if (Math.abs(impactSpeed) < 0.005)
                impactSpeed = 0;
        }

        swipeCool();
        if (swipe != 0) {
            swipeAttack();
            x += swipeSpeed;
            //xSpeed = swipeSpeed * 0.8;
            y += ySpeed;
        }
        else {
            x += xSpeed;
            y += ySpeed;
        }
        rotateCar();
        stayWithinMaxSpeed();
    }


    function rotateCar():Void {
        angle = (xSpeed/xMax * 40);
        if (swipe != 0)
            angle = (swipeSpeed/xMax * 20);
    }

    public function impact(xImpactSpeed:Float, power = 0.3, damage:Bool = false):Void {
        impactSpeed += xImpactSpeed;
        impactPower = power;
    }

    public function weightSpeed():Void {
        xSpeed + weight;
    }

    // swipe attack
    function startSwipeAttack(dir:Int):Void {
        if (swipeTimer < 0)
            return;
        swipeSpeed = xSpeed * 2;
        swipe = dir;
    }
    public function endSwipeAttack():Void {
        if (swipe == 0)
            return;
        xSpeed = swipeSpeed * 0.5;
        swipe = 0;
        swipeTimer = swipeCooldown;
    }
    function swipeAttack():Void {
        swipeSpeed += swipeChange * swipe;
        swipeTimer ++;
        if (swipeTimer >= swipeTime) {
            xSpeed = xMax * 2;
            endSwipeAttack();
        }
    }

    function swipeCool():Void {
        if (swipeTimer < 0)
            swipeTimer++;
    }


    function stayWithinMaxSpeed():Void {
        if (xSpeed > xMax)
            xSpeed *= 0.8;
        if (xSpeed < xMax * -1)
            xSpeed *= 0.8;
        if (ySpeed > yMax)
            xSpeed *= 0.8;
        if (ySpeed < yMax * -1)
            xSpeed *= 0.8;
    }



}
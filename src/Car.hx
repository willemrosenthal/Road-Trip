package ;

import flixel.util.FlxPoint;
import flixel.FlxSprite;
import flixel.FlxG;

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

    var tempInvincibility:Int = 0;

    var dead:Bool = false;
    var deadStopSpeed:Float = 1;
    var deadDriftSpeed:Float = 1;
    var deadY:Float = 0;
    var deadX:Float = 0;


    public var weight:Float = 5;
    public var swipeAttackDamage:Float = 1;

    public function new(X:Float, Y:Float, ?SimpleGraphic:Dynamic)
    {
        super(X, Y, SimpleGraphic);
    }

    //function updates():Void {
    override public function update():Void {
        super.update();

        if (impactSpeed != 0) {
            xSpeed += impactSpeed * (impactPower);
            x += impactSpeed * (impactPower) * 1.5;
            impactSpeed *= impactDecay;
            if (Math.abs(impactSpeed) < 0.005)
                impactSpeed = 0;
        }

        cooldowns();
        if (dead) {
            if (deadY < Global.speed)
                deadY += deadStopSpeed;
            deadX *= deadDriftSpeed;

            y += deadY;
            x += deadX;
            killIfGone();
        }
        else if (swipe != 0) {
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
        if (dead)
            angle = (deadX/xMax * 30);
        else if (swipe != 0)
            angle = (swipeSpeed/xMax * 20);
        else angle = (xSpeed/xMax * 30);
    }


    // IMPACT + DAMAGE
    public function impact(xImpactSpeed:Float, power:Float = 0.3, damage:Bool = false, attackPower:Float = 0, damageMod:Float = 1):Void {
        impactSpeed += xImpactSpeed;
        impactPower = power;
        if (damage)
          doDamage(xImpactSpeed,power,attackPower,damageMod);
    }
    function doDamage(xImpactSpeed:Float, power:Float, attackPower:Float, damageMod:Float) {
        if (tempInvincibility > 0)
            return;
        var damage = calculateDamage(attackPower, power) * damageMod;
        if (damage == 0)
            return;
        health -= damage;
        if (health <= 0)
            carDeath(xImpactSpeed);
        Global.numbers.add(new BattleScore(getMiddle().x,getMiddle().y,30,"-"+damage));
        tempInvincibility = 2;
    }
    function calculateDamage(attackPower:Float, power:Float):Int {
        return Math.round(attackPower * (power + 1));
    }
    function carDeath(xImpact:Float = 0):Void {
        if (dead)
            return;
        dead = true;
        deadStopSpeed *= Math.random() * 0.5;
        deadDriftSpeed += Math.random() * 0.06;
        deadX = xImpact * (Math.random() * 0.5);
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

    function cooldowns():Void {
        if (tempInvincibility > 0)
            tempInvincibility--;
        if (swipeTimer < 0)
            swipeTimer++;
    }


    function stayWithinMaxSpeed():Void {
        if (Math.abs(xSpeed) > xMax)
            xSpeed *= 0.8;
        if (Math.abs(ySpeed) > yMax)
            ySpeed *= 0.8;
    }

    public function getMiddle():FlxPoint {
        return new FlxPoint(x + width * 0.5, y + height * 0.5);
    }

    function killIfGone():Void {
        if (y > FlxG.height + height * 2)
            destroy();
        if (x > FlxG.width + width * 2)
            destroy();
        if (x < 0 - width * 2)
            destroy();
    }


}
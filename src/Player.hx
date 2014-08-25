package ;

import flixel.util.FlxPoint;
import flixel.FlxG;
import flixel.FlxSprite;
#if cpp
import openfl.ui.Accelerometer;
#end

class Player extends Car
{

    public var shake:Float = 0.3;

    private var deadzoneX:Float = 0.15;
    private var deadzoneY:Float = 0.08;
    private var zeroPoint:FlxPoint;

    private var savedPosition:FlxPoint;

    public function new(X:Float, Y:Float, Body:String)
    {
        super(X, Y, Body);
        savedPosition = new FlxPoint(X,Y);
        Global.player = this;

        weight = 20;
        swipeCooldown = -40;
        health = 100;
        swipeAttackDamage = 10;


        GroupControl.addShadow(new Shadow(this, Body));

        #if cpp
			var data = Accelerometer.get();
			zeroPoint = new FlxPoint(data.x,data.y);
		#end
    }

    function preUpdate():Void {
        x = savedPosition.x;
        y = savedPosition.y;
    }

    override public function update():Void {
        preUpdate();
        super.update();

        if (impactSpeed == 0) {
            if (FlxG.keys.pressed.RIGHT)
                xSpeed += xChange;
            if (FlxG.keys.pressed.LEFT)
                xSpeed -= xChange;
            if (FlxG.keys.pressed.DOWN)
                ySpeed += xChange;
            if (FlxG.keys.pressed.UP)
                ySpeed -= xChange;

            #if cpp
                var data = Accelerometer.get();


                if (data.x > zeroPoint.x + deadzoneX) {
                    if (data.x - zeroPoint.x + deadzoneX < deadzoneX * 2)
                        xSpeed += (data.x - zeroPoint.x + deadzoneX)/(deadzoneX * 2) * xChange
                    else xSpeed += xChange;
                    }
                else if (data.x < zeroPoint.x - deadzoneX) {
                    if (data.x > zeroPoint.x - deadzoneX * 2)
                        xSpeed -= (data.x - (zeroPoint.x - deadzoneX * 2))/(deadzoneX * 2) * xChange
                    else xSpeed -= xChange;
                    }
                else breakX();


                if (data.y > zeroPoint.y + deadzoneY)  {
                    if (data.y - zeroPoint.y + deadzoneY < deadzoneY * 2)
                        ySpeed += (data.y - zeroPoint.y + deadzoneY)/(deadzoneY * 2) * yChange
                    else ySpeed -= yChange;
                    }

                else if (data.y < zeroPoint.y - deadzoneY) {
                    if (data.y > zeroPoint.y - deadzoneY * 2)
                        ySpeed += (data.y - (zeroPoint.y - deadzoneY * 2))/(deadzoneY * 2) * yChange
                    else ySpeed += yChange;
                    }

                else breakY();

                Global.txt.text = Std.string(data.y) + " " + Std.string(zeroPoint.y);
                //Global.txt.text = Std.string(Math.round(data.x * 10))

                /*
                if (data.x > 1)
                    Global.txt.text = "greater"; //Std.string(Math.round(data.x));
                if (data.x < 1)
                    Global.txt.text = "lesser"; //Std.string(Math.round(data.x));
                */

                if (FlxG.mouse.justPressed) {
                    zeroPoint = new FlxPoint(data.x,data.y);
                }

            #end
        }

        if (y < 0)
            y = 1;
        if (y > FlxG.height)
            y = FlxG.height - 1;


        if (x < FlxG.worldBounds.x)
            x = FlxG.worldBounds.x + 1;
        if (x > FlxG.worldBounds.width - width)
            x = FlxG.worldBounds.width - width - 1;

        if (FlxG.keys.justPressed.Z)
            startSwipeAttack(-1);
        if (FlxG.keys.justPressed.X)
            startSwipeAttack(1);

        if (swipe == 0 && swipeTimer < 0)
            xSpeed *= 0.96;

        savedPosition.x = x;
        savedPosition.y = y;
        shakeF();
    }

    function shakeF():Void {
        x += Calc.plusOrMinus(Math.random() * shake);
        y += Calc.plusOrMinus(Math.random() * shake);
    }

}
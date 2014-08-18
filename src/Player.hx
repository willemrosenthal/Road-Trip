package ;

import flixel.util.FlxPoint;
import flixel.FlxG;
import flixel.FlxSprite;
#if cpp
import openfl.ui.Accelerometer;
#end

class Player extends Car
{

    private var deadzoneX:Float = 0.15;
    private var deadzoneY:Float = 0.08;
    private var zeroPoint:FlxPoint;

    public function new(X:Float, Y:Float)
    {
        super(X, Y, 'assets/images/player.png');
        Global.player = this;

        weight = 20;
        swipeCooldown = -40;
        health = 100;
        swipeAttackDamage = 10;

        #if cpp
			var data = Accelerometer.get();
			zeroPoint = new FlxPoint(data.x,data.y);
		#end
    }

    override public function update():Void {
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


                if (data.x > zeroPoint.x + deadzoneX)
                    xSpeed += xChange;
                else if (data.x < zeroPoint.x - deadzoneX)
                    xSpeed -= xChange;
                else breakX();


                if (data.y > zeroPoint.y + deadzoneY)
                    ySpeed -= yChange;
                else if (data.y < zeroPoint.y - deadzoneY)
                    ySpeed += yChange;
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

        pointAtPlayer();
    }

    private function pointAtPlayer():Void {
        FlxG.camera.scroll.x = x - FlxG.camera.width * 0.5;
        //FlxG.camera.scroll.y = y - FlxG.camera.height * 0.5;
    }

}
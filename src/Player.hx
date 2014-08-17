package ;

import flixel.FlxG;
import flixel.FlxSprite;

class Player extends Car
{
    public function new(X:Float, Y:Float)
    {
        super(X, Y, 'assets/images/player.png');
        Global.player = this;

        weight = 10;
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
        }
    }

}
package ;

import flixel.FlxG;
import flixel.FlxSprite;

class Player extends FlxSprite
{

    var xSpeed:Float = 4;
    var ySpeed:Float = 3;

    public function new(X:Float, Y:Float)
    {
        super(X, Y, 'assets/images/player.png');
        Global.player = this;
    }

    override public function update():Void {
        super.update();


        if (FlxG.keys.pressed.RIGHT)
            x += xSpeed;
        if (FlxG.keys.pressed.LEFT)
            x -= xSpeed;
        if (FlxG.keys.pressed.UP)
            y -= ySpeed;
        if (FlxG.keys.pressed.DOWN)
            y += ySpeed;

    }


}
package ;

import flixel.FlxG;
import flixel.FlxSprite;

class Line extends FlxSprite
{
    public function new(X:Float, Y:Float)
    {
        super(X, Y, 'assets/images/line.png');
        alpha = 0.5;
    }

    override public function update():Void {
        super.update();
        y += Global.speed;
        if (y > FlxG.height)
            y = 0 - height;
    }

}
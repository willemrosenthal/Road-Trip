package ;

import flixel.util.FlxSpriteUtil;
import flixel.text.FlxText;
using flixel.util.FlxSpriteUtil;

class BattleScore extends FlxText
{

    var ySpeed:Float = 1;
    var lifeTimer:Int = 0;
    var lifeTime:Int = 40;
    var flciker:Int = 0;

    public function new(X:Float = 0, Y:Float = 0, FieldWidth:Float = 0, ?Text:String, Size:Int = 8, EmbeddedFont:Bool = true)
    {
        super(X, Y, FieldWidth, Text, Size, EmbeddedFont);
    }

    override public function update():Void {
        super.update();
        y -= ySpeed;
        lifeTimer ++;
        if (lifeTimer >= lifeTime * 0.5)
            flicker();
        if (lifeTimer >= lifeTime)
            this.destroy();
    }

    function flicker():Void {
        if (alpha == 0)
            alpha  = 1;
        else alpha = 0;
    }

}
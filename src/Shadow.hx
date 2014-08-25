package ;
import flixel.FlxSprite;

class Shadow extends FlxSprite
{
    var shadowParent:FlxSprite;

    public function new(Parent:FlxSprite, Image:String)
    {
        shadowParent = Parent;
        super(shadowParent.x, shadowParent.y, Image);
        this.color = 0x000000;
    }

    override public function update():Void {
        super.update();
        this.x = shadowParent.x; // + shadowParent.xSpeed;
        this.y = shadowParent.y + Global.shadowDistance; // + shadowParent.ySpeed;
        this.angle = shadowParent.angle;

    }

}
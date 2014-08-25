package ;
import flixel.FlxSprite;

class Shadow extends FlxSprite
{
    var shadowParent:FlxSprite;
    var followPlayer:Bool = false;

    public function new(Parent:FlxSprite, Image:String, FollowPlayer:Bool = false)
    {
        shadowParent = Parent;
        followPlayer = FollowPlayer;
        super(shadowParent.x, shadowParent.y, Image);
        this.color = 0x000000;
    }

    override public function update():Void {
        super.update();
        if (followPlayer) {
            this.x = shadowParent.x + Global.player.xSpeed;
            this.y = shadowParent.y + Global.shadowDistance + Global.player.ySpeed;
        }
        else if (Std.is(shadowParent, Car)) {
            this.x = shadowParent.x + cast(shadowParent,Car).xSpeed;
            this.y = shadowParent.y + Global.shadowDistance + cast(shadowParent,Car).ySpeed;
        }
        else {
            this.x = shadowParent.x;
            this.y = shadowParent.y + Global.shadowDistance;
        }
        this.angle = shadowParent.angle;

    }

}
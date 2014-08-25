package ;

import flixel.group.FlxGroup;
import flixel.FlxSprite;

class MultiSprite extends FlxGroup
{
    public var x:Float;
    public var y:Float;
    public var width:Float;
    public var height:Float;

    public var angle:Float;

    private var parts:Array<FlxSprite>;

    public function new() {
        super();
        parts = [];
    }

    override public function update():Void {
        super.update();
    }

}
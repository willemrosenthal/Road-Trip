package ;

import flixel.FlxSprite;

class GunExplosion extends FlxSprite
{


    public function new(X:Float, Y:Float, EffectId:String = 'explosion1', EffectWidth:Int = 34, EffectHeight:Int = 28)
    {
        super(X, Y);

        loadGraphic('assets/images/effects/' + EffectId + '.png', true, EffectWidth, EffectHeight);
        animation.add('shoot', [0,1,2,3], 10, false);
        animation.play('shoot');

        x -= width * 0.5;
        y -= height * 0.5;
    }

    //function updates():Void {
    override public function update():Void {
        super.update();
        if (animation.finished)
            kill();
    }
}
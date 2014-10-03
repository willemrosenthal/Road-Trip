package ;

import flixel.FlxSprite;

class BulletShot extends FlxSprite
{

    private var bulletArray:Array<Dynamic>;
    private var damage:Float;

    public function new(X:Float, Y:Float, BulletArray:Array<Dynamic>, Damage:Float)
    {
        super(X, Y);

        bulletArray = BulletArray;
        damage = Damage;

        loadGraphic('assets/images/effects/' + bulletArray[0] + '.png', true, bulletArray[1], bulletArray[2]);
        animation.add('shoot', bulletArray[3], bulletArray[4], false);
        animation.play('shoot');

        if (bulletArray[5] != 0) {
            x += Calc.plusOrMinus(Math.random() * bulletArray[5]);
            y += Calc.plusOrMinus(Math.random() * bulletArray[5]);
        }

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
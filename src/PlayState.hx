package;

import flixel.group.FlxGroup;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{

    var player:Player;
    var e:EnemyCar;

    var cars:FlxGroup;
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();

        cars = new FlxGroup();
        add(cars);

        player = new Player(50,50);
        cars.add(player);

        e = new EnemyCar(100,FlxG.height + 100);
        cars.add(e);
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
        FlxG.collide(cars,cars, carCollide);
	}

    var minImpact:Float = 2;
    private function carCollide(Obj1:FlxSprite,Obj2:FlxSprite):Void {
        if (Obj1 == Obj2)
            return;
        if (Std.is(Obj1, Car) && Std.is(Obj2, Car)) {
            var c1:Car = cast(Obj1, Car);
            var c2:Car = cast(Obj2, Car);

            // if cars are next to eachother
            if ((c1.y < c2.y && c1.y + c1.height > c2.y) || (c1.y > c2.y && c1.y < c2.y + c2.height))
                sideCollitons(c1,c2);
        }
    }

    function sideCollitons(c1:Car, c2:Car):Void {
        var c1Power:Float = Math.abs(c1.xSpeed) + c1.weight * 0.1;
        var c2Power:Float = Math.abs(c2.xSpeed) + c2.weight * 0.1;
        var hitSpeed:Float;

        // side swipe
        if (Math.abs(Math.abs(c1.xSpeed) - Math.abs(c1.ySpeed)) > minImpact) {
            if (c1Power > c2Power)  {

                if (Math.abs(c1.xSpeed) > Math.abs(c2.xSpeed))
                    hitSpeed = c1.xSpeed;
                else hitSpeed = c2.xSpeed * -0.35;

                c2.impact(hitSpeed * 2, getImpactPower(c1Power,c2Power), true);
                c1.xSpeed *= 0.5;
                c1.impact(c1.xSpeed * -1.75, 0.27);
                c1.endSwipeAttack();
                c2.endSwipeAttack();
            }
            else if (c1Power < c2Power)  {

                if (Math.abs(c2.xSpeed) > Math.abs(c1.xSpeed))
                    hitSpeed = c2.xSpeed;
                else hitSpeed = c1.xSpeed * -0.35;

                c1.impact(hitSpeed * 2, getImpactPower(c1Power,c2Power), true);
                c2.xSpeed *= 0.5;
                c2.impact(c2.xSpeed * -1.75, 0.27);
                c1.endSwipeAttack();
                c2.endSwipeAttack();
            }
        }
        // brusing
        else {
            if (Math.abs(c1.xSpeed) > Math.abs(c2.xSpeed)) {
                c2.xSpeed += c1.xSpeed * 0.1;
                c1.xSpeed *= 0.9 - getImpactPower(c1Power,c2Power); // slows both down
                c1.endSwipeAttack();
                c2.endSwipeAttack();
            }
            else if (Math.abs(c1.xSpeed) < Math.abs(c2.xSpeed)) {
                c1.xSpeed += c2.xSpeed * 0.1;
                c2.xSpeed *= 0.9 - getImpactPower(c1Power,c2Power); // slows both down
                c1.endSwipeAttack();
                c2.endSwipeAttack();
            }
        }
    }

    function getImpactPower(c1:Float, c2:Float):Float {
        return Math.abs(c1 - c2) * 0.11;
    }

}
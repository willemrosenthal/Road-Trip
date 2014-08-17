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


        e = new EnemyCar(150,FlxG.height + 300);
        cars.add(e);


        e = new EnemyCar(200,FlxG.height + 100);
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
    private function carCollide(Obj1:FlxSprite,Obj2:FlxSprite):Void {
        if (Obj1 == Obj2)
            return;
    }
}
package ;

import flixel.util.FlxPoint;
import flixel.util.FlxAngle;
import flixel.group.FlxGroup;
import flixel.FlxSprite;

class ComplexCar extends MultiSprite
{
    // car parts
    private var SUPERCHARGER:UInt = 1;
    private var BACK:UInt = 2;
    private var SIDES:UInt = 3;

    private var wa:Int;

    private var body:String;
    private var wheels:String;
    private var supercharger:String;
    private var back:String;
    private var sides:String;
    private var gun:String;

    public var leader:Player;

    public function new(X:Float, Y:Float, Body:String, Wheels:String, Supercharger:String = '', Back:String = '', Sides:String = '', Gun:String = '', WheelAdjust:Int = 0) {
        super();

        x = X;
        y = Y;

        wa = WheelAdjust;

        body = Body;
        wheels = Wheels;
        supercharger = Supercharger;
        back = 'gunmount1'; // Back;
        sides = Sides;
        gun = Gun;

        buildCar();
    }

    private function buildCar():Void {
        //adds body
        leader = new Player(x,y,'assets/images/car/body/' + body + '.png');

        //wheels
        parts.push(new CarPart(x-4 - wa,y+12, leader,'assets/images/car/wheels/' + wheels + '.png'));
        add(parts[0]);
        parts.push(new CarPart(x+28 + wa,y+12, leader,'assets/images/car/wheels/' + wheels + '.png'));
        add(parts[1]);
        parts.push(new CarPart(x-3 - wa,y+53, leader,'assets/images/car/wheels/' + wheels + '.png'));
        add(parts[2]);
        parts.push(new CarPart(x+27 + wa,y+53, leader,'assets/images/car/wheels/' + wheels + '.png'));
        add(parts[3]);

        add(leader);

        //extra parts
        if (supercharger != '') {
            parts.push(new CarPart(x+leader.width*0.5, y+13, leader, 'assets/images/car/supercharger/' + supercharger + '.png', SUPERCHARGER));
            add(parts[parts.length - 1]);
        }
        if (back != '') {
            //parts.push(new CarPart(x+leader.width*0.5, y+60, leader, 'assets/images/car/back/' + back + '.png', BACK));
            parts.push(new CarPart(x+leader.width*0.5, y+61, leader, 'assets/images/car/gun/' + back + '.png', BACK));
            add(parts[parts.length - 1]);
        }
        if (sides != '') {
            parts.push(new CarPart(x+leader.width*0.5, y+leader.height*0.5, leader, 'assets/images/car/sides/' + sides + '.png', SIDES));
            add(parts[parts.length - 1]);
        }
        if (gun != '') {
            parts.push(new CarGun(x+leader.width*0.5, y+59, leader, gun));
            add(parts[parts.length - 1]);
        }
    }


    private function rotateCar():Void {
        var pt:FlxPoint;
        for (n in 1...parts.length) {
            pt = FlxAngle.rotatePoint(parts[n].x, parts[n].y, parts[0].x, parts[0].y, angle);
            parts[n].x = pt.x;
            parts[n].y = pt.y;
            parts[n].angle = angle;
            if (n < 5) // doubles angle on wheels
                parts[n].angle *= 2;
        }
        parts[0].angle = angle;
    }

    override public function update():Void {
        super.update();
    }

}
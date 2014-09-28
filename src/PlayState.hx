package;

import flixel.FlxCamera;
import flixel.util.FlxRect;
import flixel.FlxCamera;
import flixel.util.FlxPoint;
import flixel.util.FlxColor;
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

    var shadowCamera:FlxCamera;
    var fgCamera:FlxCamera;

    var street:FlxGroup;
    var shadows:FlxGroup;
    var cars:FlxGroup;
    var numbers:FlxGroup;
    var hud:FlxGroup;

    var carTimer:Int = 0;
    var carTime:Int =  800;
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();

        FlxG.worldBounds.width *= 1.2;
        FlxG.camera.bounds = FlxG.worldBounds;

        street = new FlxGroup();
        add(street);

        shadows = new FlxGroup();
        Global.shadows = shadows;
        add(shadows);

        cars = new FlxGroup();
        Global.cars = cars;
        add(cars);


        numbers = new FlxGroup();
        Global.numbers = numbers;
        add(numbers);

        hud = new FlxGroup();
        add(hud);


        cars.add(new ComplexCar(84,130,'interceptor-yellow','wheel-1','supercharger-2','oil-1','','machine_cannon',-2));

        e = new EnemyCar(100,FlxG.height + 100);
        GroupControl.addCar(e);

        makeRoad();
        //FlxG.camera.follow(player, 2, 1.3);

        setupCameras();
        makeHud();

	}

    function setupCameras():Void {
        shadowCamera = new FlxCamera();
        shadowCamera.alpha = 0.45;
        shadowCamera.bgColor = FlxColor.TRANSPARENT;
        shadowCamera.bounds = FlxG.worldBounds;
        FlxG.cameras.add(shadowCamera);
        Global.shadowCam = shadowCamera;

        fgCamera = new FlxCamera();
        fgCamera.bgColor = FlxColor.TRANSPARENT;
        fgCamera.bounds = FlxG.worldBounds;
        FlxG.cameras.add(fgCamera);
        Global.fgCam = fgCamera;

        shadows.setAll("cameras", [shadowCamera]);

        cars.setAll("cameras", [fgCamera]);
        street.setAll("cameras", [FlxG.camera]);
        numbers.setAll("cameras", [FlxG.camera]);
        hud.setAll("cameras", [FlxG.camera], true);
    }

    function makeRoad():Void {
        var images:Array<String> = ['assets/images/road/dirt.png'];
        var dirt = new Parallax(FlxG.worldBounds.width * 0.5, 0, images, 300, 50, true, true);
        dirt.speed = Global.speed;
        street.add(dirt);

        var images:Array<String> = ['assets/images/road/road0.png','assets/images/road/road1.png','assets/images/road/road2.png'];
        var road = new Parallax(FlxG.worldBounds.width * 0.5, 0, images, 210, 151, true, true);
        road.speed = Global.speed;
        street.add(road);

        var images:Array<String> = ['assets/images/road/line0.png','assets/images/road/line1.png','assets/images/road/line2.png','assets/images/road/line3.png'];
        var roadLines = new Parallax(FlxG.worldBounds.width * 0.5, 0, images, 4, 151, true, true);
        roadLines.speed = Global.speed;
        street.add(roadLines);
    }

    function makeHud():Void {
        var txt = new FlxText(0, 2, 0, "debug");
        Global.txt = txt;
        txt.setFormat(null, 8, FlxColor.WHITE, "center", FlxText.BORDER_NONE, FlxColor.BLACK);
        hud.add(txt);

        var dash:FlxSprite = new FlxSprite(0, FlxG.height - 53,"assets/images/ui/dash.png");   //"assets/joystick_ring_big.png"
        hud.add(dash);

        var shiftPannel:FlxSprite = new FlxSprite(22, FlxG.height - 66,"assets/images/ui/shiftPannel.png");   //"assets/joystick_ring_big.png"
        hud.add(shiftPannel);
        var shiftPannelRt:FlxSprite = new FlxSprite(FlxG.width - 22 - 64, FlxG.height - 66,"assets/images/ui/shiftPannel_right.png");   //"assets/joystick_ring_big.png"
        hud.add(shiftPannelRt);

        var sab:Float = 40; //shifter area buffer
        var shifter:VertShifter = new VertShifter(54,FlxG.height - 40.5, new FlxRect(shiftPannel.x - sab,shiftPannel.y - sab,shiftPannel.width + sab * 2,shiftPannel.height + sab * 2));
        hud.add(shifter);

        var shifter:HorShifter = new HorShifter(FlxG.width - 54,FlxG.height - 40.5, new FlxRect(shiftPannelRt.x - sab,shiftPannelRt.y - sab,shiftPannelRt.width + sab * 2,shiftPannelRt.height + sab * 2));
        hud.add(shifter);

        var endOfGameArea:Float = FlxG.stage.stageHeight/FlxG.camera.zoom * 0.8258;
        var multiTouch:MultitouchField = new MultitouchField(new FlxRect(0,0,FlxG.width,endOfGameArea),new FlxRect(0,endOfGameArea,FlxG.width * 0.5,66),new FlxRect(FlxG.width * 0.5,endOfGameArea,FlxG.width * 0.5,66));
        FlxG.stage.addChild(multiTouch);

        hud.setAll("scrollFactor", new FlxPoint(0, 0));
    }

    function makeLines():Void {
        for (i in 0...Math.round(FlxG.height/100)) {
            street.add(new Line(FlxG.width * 0.5, i * 100));
        }
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

        carTimer++;
        if (carTimer > carTime)
            newCarAttack();

        cameraControl();
	}

    function cameraControl():Void {
        FlxG.camera.scroll.x = Global.player.x - FlxG.camera.width * 0.5;
        shadowCamera.scroll.x = Global.player.x - shadowCamera.width * 0.5;
        fgCamera.scroll.x = Global.player.x - shadowCamera.width * 0.5;
    }

    function newCarAttack():Void {
        e = new EnemyCar(-100 + Math.random() * (FlxG.width + 200),FlxG.height + 100);
        GroupControl.addCar(e);
        carTimer = 0;
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

                c2.impact(hitSpeed * 2, getImpactPower(c1Power,c2Power), true, c1.swipeAttackDamage);
                c1.xSpeed *= 0.5;
                c1.impact(c1.xSpeed * -1.75, 0.27);
                c1.endSwipeAttack();
                c2.endSwipeAttack();
            }
            else if (c1Power < c2Power)  {

                if (Math.abs(c2.xSpeed) > Math.abs(c1.xSpeed))
                    hitSpeed = c2.xSpeed;
                else hitSpeed = c1.xSpeed * -0.35;

                c1.impact(hitSpeed * 2, getImpactPower(c1Power,c2Power), true, c2.swipeAttackDamage);
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
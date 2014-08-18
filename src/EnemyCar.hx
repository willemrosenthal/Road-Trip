package ;

import flixel.group.FlxGroup;
import flixel.util.FlxPoint;
import flixel.FlxG;
import flixel.FlxSprite;

class EnemyCar extends Car
{

    var maxGasDistance:Float = 200;

    var destination:FlxPoint;
    var destinationBreakRange:Float = 50; //  when to break = destinationBreakRange * speed
    var maxBreakDistance:Float = 200;

    var offscreen:Bool = true;
    var onScreenRange:Float =  50;

    var updateDestinationTime:Int = 50;
    var updateDestinationTimer:Int = 30;


    public function new(X:Float, Y:Float)
    {
        super(X, Y, 'assets/images/e1.png');
        destination = startingDestination();
        updateDestinationTimer = Math.floor(updateDestinationTime * Math.random());

        xChange = 0.05;
        xChangeNormal = 0.05;
        xMax = 3;
        yChange = 0.05;
        yChangeNormal = 0.05;
        yMax = 3;

        weight = 10;
        health = 50;
    }

    override public function update():Void {
        super.update();

        stayNextToCar();

        if (destination != null) {
            gotoDesination();
            breakForDestination();
        }
    }

    var carDistance:Float = 50;
    function stayNextToCar():Void {
        updateDestinationTimer++;
        if (updateDestinationTimer == updateDestinationTime) {
            updateDestinationTimer = 0;
            if (x < Global.player.x)
                destination = new FlxPoint(Global.player.x - carDistance, Global.player.y);
            else
                destination = new FlxPoint(Global.player.x + carDistance, Global.player.y);
        }
    }

    function startingDestination():FlxPoint {
        if (x < 0)
            return new FlxPoint(FlxG.width * 0.3,y + 200 * Math.random());
        if (x > FlxG.width)
            return new FlxPoint(FlxG.width * 0.7,y + 200 * Math.random());
        if (y < 0)
            return new FlxPoint(x,FlxG.height * 0.3);
        if (y > FlxG.height)
            return new FlxPoint(x,FlxG.height * 0.7);

        return new FlxPoint(x,y);
    }

    function gotoDesination():Void {
        //if (breaking)
        //    return;
        if (x < destination.x)
            xSpeed += xChange; //gassBasedOnDistance(x,destination.x,xChange);
        if (x > destination.x)
            xSpeed -= xChange; //gassBasedOnDistance(destination.x,x,xChange);
        if (y < destination.y)
            ySpeed += xChange; //gassBasedOnDistance(y,destination.y,yChange);
        if (y > destination.y)
            ySpeed -= xChange; //gassBasedOnDistance(destination.y,y,yChange);
    }

    /*
    function gassBasedOnDistance(smaller:Float, bigger:Float, change:Float):Float {
        if (bigger - smaller > maxGasDistance)
            return maxGasDistance;
        if (bigger - smaller < maxGasDistance)
            return ((bigger - smaller)/maxGasDistance) * change;
        return 0;
    }
    */



    function breakForDestination():Void {
        breaking = false;
        if (x + destinationBreakRange * Math.abs(xSpeed) > destination.x && x - destinationBreakRange * Math.abs(xSpeed) < destination.x)
            breakX(0.96);
        if (y + destinationBreakRange * Math.abs(ySpeed) > destination.y && y - (destinationBreakRange * Math.abs(ySpeed)) < destination.y)
            breakY(0.96);
    }

    var buffer:Float = 10;
    function reachedDestination():Void {
        if ((x + buffer > destination.x && x - buffer < destination.x && Math.abs(xSpeed) < 0.05 * xMax) && (y + buffer > destination.y && y - buffer < destination.y && Math.abs(ySpeed) < 0.05 * yMax))
            turnOffDestination();
    }


    function turnOffDestination():Void {
        destination = null;
        breaking = true;
    }


}
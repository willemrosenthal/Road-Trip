package ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;

class Parallax extends FlxGroup
{
	public var images:Array<String>;
    public var speed:Float = -10;
    public var iWidth:Int;
    public var iHeight:Int;
    public var yPos:Float;
    public var xPos:Float;
    public var initialY:Float;

    public var vertical:Bool = false;

    // overlaps the pieces a bit to prevent gaps
    public var safety:Float = 1;

    private var totalWide:Int;
    private var totalTall:Int;
    private var pieces:Array<FlxSprite>;

	public function new(X:Float, Y:Float, Images:Array<String>, Width:Int, Height:Int, Vert:Bool = true, Centered:Bool = false)
	{
		super();

		yPos = Y;
        xPos = X;
        images = Images;
        iWidth = Width;
        iHeight = Height;
        vertical = Vert;

        if (Centered) {
            if (vertical)
                xPos -= iWidth * 0.5;
            else yPos -= iHeight * 0.5;
        }

        initialY = Y;

        if (vertical)
            buildCol();
        else buildRow();
	}


	private function buildRow():Void
	{
        pieces = [];

        totalWide = Math.ceil((FlxG.width + safety) / iWidth) + 1;

        for (i in 0...totalWide)
        {
            pieces.push(new FlxSprite(i * iWidth - i * safety, yPos));
            pieces[i].loadGraphic(images[0], false, iWidth, iHeight);
            add(pieces[i]);
        }
	}


    private function buildCol():Void
    {
        pieces = [];

        totalTall = Math.ceil((FlxG.worldBounds.height + safety) / iHeight) + 1;

        for (i in 0...totalTall)
        {
            pieces.push(new FlxSprite(xPos, i * iHeight - i * safety));
            pieces[i].loadGraphic(images[0], false, iWidth, iHeight);
            add(pieces[i]);
        }
    }

	override public function update():Void {
		super.update();

        if (vertical)
            scrollVertical();
        else scrollHorizontal();
	}


	private function scrollHorizontal():Void
	{
	    for (i in 0...pieces.length)
	    {
	        pieces[i].x += speed;
	        pieces[i].y = yPos;
	    }
	    for (i in 0...pieces.length)
	    {
	        if (pieces[i].x + iWidth <= 0)
	        {
	            if (i > 0)
	                pieces[i].x = pieces[i - 1].x + iWidth - safety;
	            if (i == 0)
	                pieces[i].x = pieces[pieces.length - 1].x + iWidth - safety;
                if (images.length > 1)
                    pieces[i].loadGraphic(randomImage(), false, iWidth, iHeight);
	        }
	    }
	}


    private function scrollVertical():Void
    {
        for (i in 0...pieces.length)
        {
            pieces[i].x = xPos;
            pieces[i].y += speed;
        }
        for (i in 0...pieces.length)
        {
            if (pieces[i].y >= FlxG.worldBounds.y + FlxG.worldBounds.height)
            {
                if (i == pieces.length - 1)
                    pieces[i].y = pieces[0].y - iHeight + safety;
                if (i < pieces.length - 1)
                    pieces[i].y = pieces[i + 1].y - iHeight + safety;
                if (images.length > 1)
                    pieces[i].loadGraphic(randomImage(), false, iWidth, iHeight);
            }
        }
    }

    private function randomImage():String {
        return images[Math.round(Math.random() * (images.length - 1))];
    }
}
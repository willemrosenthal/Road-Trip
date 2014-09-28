package ;


import flixel.util.FlxRect;
import flixel.util.FlxPoint;
import flash.events.TouchEvent;
import flixel.FlxCamera;
import flixel.FlxG;
import flash.ui.MultitouchInputMode;
import flash.ui.Multitouch;
import flash.display.Sprite;

class MultitouchField extends Sprite
{

	private var s:Sprite;
	private var ignoreRange:Float = 28;

    private var gameZone:FlxRect;
    private var vbarZone:FlxRect;
    private var hbarZone:FlxRect;

    private var mouse:FlxPoint;

	public function new(GameZone:FlxRect, VbarZone:FlxRect, HbarZone:FlxRect)
	{
		super();
        gameZone = GameZone;
        vbarZone = VbarZone;
        hbarZone = HbarZone;

		Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;

        mouse = new FlxPoint();

		s = new Sprite();
		s.graphics.beginFill(0x000ff0,1);
		s.graphics.drawRect(0,0,FlxG.width * FlxCamera.defaultZoom,FlxG.height * FlxCamera.defaultZoom);
		s.graphics.endFill();
		addChild(s);

		s.addEventListener(TouchEvent.TOUCH_BEGIN, onBegin);
		s.addEventListener(TouchEvent.TOUCH_MOVE, onMove);
		s.addEventListener(TouchEvent.TOUCH_END, onEnd);
		s.alpha = 0;
	}

	private function onBegin(e:TouchEvent):Void
	{
        mouse.x = e.stageX / FlxG.camera.zoom;
        mouse.y = e.stageY / FlxG.camera.zoom;

        // left slider
        if (mouse.x > vbarZone.x && mouse.x < vbarZone.width + vbarZone.x && mouse.y > vbarZone.y && mouse.y < vbarZone.height + vbarZone.y && Global.vMouseSet == -1) {
            Global.vMouseSet = e.touchPointID;
            Global.vbarMouse.x = e.stageX / FlxG.camera.zoom;
            Global.vbarMouse.y = e.stageY / FlxG.camera.zoom;
            trace('left');
        }
        // right slider
        if (mouse.x > hbarZone.x && mouse.x < hbarZone.width + hbarZone.x && mouse.y > hbarZone.y && mouse.y < hbarZone.height + hbarZone.y && Global.hMouseSet == -1) {
            Global.hMouseSet = e.touchPointID;
            Global.hbarMouse.x = e.stageX / FlxG.camera.zoom;
            Global.hbarMouse.y = e.stageY / FlxG.camera.zoom;
            trace('right');
        }
        // game mouse
        if (mouse.x > gameZone.x && mouse.x < gameZone.width + gameZone.x && mouse.y > gameZone.y && mouse.y < gameZone.height + gameZone.y && Global.gMouseSet == -1) {
            Global.gMouseSet = e.touchPointID;
            Global.gameMouse.x = e.stageX / FlxG.camera.zoom;
            Global.gameMouse.y = e.stageY / FlxG.camera.zoom;
            trace('game');
        }
	}


	private function onMove(e:TouchEvent):Void
	{
        mouse.x = e.stageX / FlxG.camera.zoom;
        mouse.y = e.stageY / FlxG.camera.zoom;

        if (e.touchPointID == Global.gMouseSet) {
            Global.gameMouse.x = mouse.x;
            Global.gameMouse.y = mouse.y;
        }
        if (e.touchPointID == Global.vMouseSet) {
            Global.vbarMouse.x = mouse.x;
            Global.vbarMouse.y = mouse.y;
        }
        if (e.touchPointID == Global.hMouseSet) {
            Global.hbarMouse.x = mouse.x;
            Global.hbarMouse.y = mouse.y;
        }
	}

	private function onEnd(e:TouchEvent):Void
	{
        if (e.touchPointID == Global.gMouseSet)
            Global.gMouseSet = -1;
        if (e.touchPointID == Global.vMouseSet)
            Global.vMouseSet = -1;
        if (e.touchPointID == Global.hMouseSet)
            Global.hMouseSet = -1;
	}

	public function kill():Void
	{
		s.removeEventListener(TouchEvent.TOUCH_BEGIN, onBegin);
		s.removeEventListener(TouchEvent.TOUCH_MOVE, onMove);
		s.removeEventListener(TouchEvent.TOUCH_END, onEnd);

		removeChild(s);
	}
}

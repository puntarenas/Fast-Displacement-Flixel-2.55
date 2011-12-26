package 
{
	import org.flixel.*;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	
	/**
	 * <code>FXGroup</code> is a special FlxGroup which should only handle rendering effects.
	 * 
	 * @author Ryan "Rybar" Malm, Tim "SeiferTim" Hely
	 */
	public class FXGroup extends FlxGroup
	{
		public var FXBuffer:BitmapData;
		public function FXGroup() 
		{
			FXBuffer = new BitmapData(FlxG.width, FlxG.height)
		}
		
		override public function draw():void
		{
			
		}
		
		/**
		 * Call <code>doRender</code> in the state's render function (after <code>super.render()</code>
		 */
		public function doRender():void
		{
			FXBuffer.copyPixels(FlxG.camera.buffer, new Rectangle(0, 0, FlxG.width, FlxG.height), new Point(0, 0));
			super.draw();
		}
		
	}

}
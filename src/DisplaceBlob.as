package 
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.sampler.NewObjectSample;
	import org.flixel.*;
	import com.gskinner.utils.Rnd;
	
	/**
	 * <code>DisplaceBlob</code> is a <code>FlxSprite</code> object which copies from an area nearby to make a displacement effect.
	 * Usually emitted from the <code>Displacement</code> object, they can be added directly to the stage for neat effects.
	 * 
	 * @author Ryan "Rybar" Malm, Tim "SeiferTim" Hely
	 */
	public class DisplaceBlob extends FlxSprite
	{
		
		private var blob:Rectangle;
		private var StartSize:FlxPoint;
		private var maxLife:Number = -1;
		private var _displaceAmt:FlxPoint = new FlxPoint(1, 1);
		private var _life:Number = -1;
		private var Size:FlxPoint;
		private var _buffer:BitmapData;
		
		/**
		 * Use a <code>DisplaceBlob</code> to make an area on the screen displaced.
		 * 
		 * @param	Buffer			This should point to your FXGroup's Buffer
		 * @param	X				The X position of the blob.
		 * @param	Y				The Y position of the blob.
		 * @param	Size			The size of the blob. 1-8 is valid. Defaults to 8.
		 * @param	Life			The lifespan of the blob. Defaults to -1 or, never dies.
		 * @param	DisplaceAmtX	How much displacement on the X axis to apply.
		 * @param	DisplaceAmtY	How much displacement on the Y axis to apply.
		 */
		public function DisplaceBlob(Buffer:BitmapData, X:Number, Y:Number, Width:Number = 1, Height:Number = 1, Life:Number = -1, DisplaceAmtX:Number = 1, DisplaceAmtY:Number = 1):void 
		{
			_buffer = Buffer;
			super(X, Y);
			_displaceAmt = new FlxPoint(DisplaceAmtX,DisplaceAmtX);
			if (Width < 1) Width = 1;
			if (Height < 1) Height = 1;
			StartSize = new FlxPoint(Width, Height);
			Size = StartSize;
			if (Life < -1) Life = -1;
			maxLife = Life;
			makeGraphic(Width, Height, 0xffffffff);
			width = Width;
			height = Height;
			exists = false;
		}
		
		/**
		 * Call <code>rebuild</code> to reset the blob back to specific size and position.
		 * 
		 * @param	X				The X position of the blob.
		 * @param	Y				The Y position of the blob.
		 * @param	Size			The size of the blob. 1-8 is valid..
		 * @param	Life			The lifespan of the blob. Defaults to -1 or, never dies.
		 * @param	DisplaceAmtX	How much displacement on the X axis to apply.
		 * @param	DisplaceAmtY	How much displacement on the Y axis to apply.
		 */
		public function rebuild(X:Number, Y:Number, Width:Number = 1, Height:Number = 1, Life:Number = -2, DisplaceAmtX:Number = 1, DisplaceAmtY:Number = 1):void
		{
			super.reset(X, Y);
			_displaceAmt = new FlxPoint(DisplaceAmtX, DisplaceAmtX);
			if (Width < 2) Width = 2;
			if (Height < 2) Height = 2;
			StartSize = new FlxPoint(Width, Height);
			if (Life == -2) Life = maxLife;
			else if (Life < -1) Life = -1;
			maxLife = Life;
			Size = StartSize;
			width = Width;
			height = Height;
			exists = false;
		}
		
		/**
		 * Set <code>blobWidth<code> to change how wide the blob is.
		 */
		public function get blobWidth():Number
		{
			return StartSize.x;
		}
		
		/**
		 * Set <code>blobWidth<code> to change how wide the blob is. 
		 */
		public function set blobWidth(Width:Number):void
		{
			if (Width < 2) Width = 2;
			StartSize.x = Width;
		}
		
		/**
		 * Set <code>blobHeight<code> to change how wide the blob is.
		 */
		public function get blobHeight():Number
		{
			return StartSize.y;
		}
		
		/**
		 * Set <code>blobHeight<code> to change how high the blob is. 
		 */
		public function set blobHeight(Height:Number):void
		{
			if (Height < 2) Height = 2;
			StartSize.y = Height;
		}
		
		/**
		 * Set <code>life</code> to set how long the blob lives. -1 to make the blob live forever.
		 */
		public function get life():Number
		{
			return maxLife;
		}
		
		/**
		 * Set <code>life</code> to set how long the blob lives. -1 to make the blob live forever.
		 */
		public function set life(Life:Number):void
		{
			if (Life < -1) Life = -1;
			maxLife = Life;
		}
		
		/**
		 * Set <code>displaceAmtX</code> to set the amount of displacement along the X axis.
		 */
		public function get displaceAmtX():Number
		{
			return _displaceAmt.x;
		}
		
		/**
		 * Set <code>displaceAmtX</code> to set the amount of displacement along the X axis.
		 */
		public function set displaceAmtX(Amt:Number):void
		{
			_displaceAmt.x = Amt;
		}
		
		/**
		 * Set <code>displaceAmtY</code> to set the amount of displacement along the Y axis.
		 */
		public function get displaceAmtY():Number
		{
			return _displaceAmt.y;
		}
		
		/**
		 * Set <code>displaceAmtY</code> to set the amount of displacement along the Y axis.
		 */
		public function set displaceAmtY(Amt:Number):void
		{
			_displaceAmt.y = Amt;
		}
		
		/**
		 * Set <code>displaceAmt</code> to set the amount of displacement along both axis.
		 */
		public function get displaceAmt():FlxPoint
		{
			return _displaceAmt;
		}
		
		/**
		 * Set <code>displaceAmt</code> to set the amount of displacement along both axis.
		 */
		public function set displaceAmt(Amt:FlxPoint):void
		{
			_displaceAmt = Amt;
		}
		
		public function onEmit():void
		{
			
			Size = StartSize;
			width = StartSize.x;
			height = StartSize.y;
			_life = maxLife;
			exists = true;
		}
		
		override public function update():void
		{
			if (!exists) return;
			super.update();
			
			if (maxLife != -1)
			{
				if (_life <= 0)
				{
					if (_life == -50)
					{	
						Size.x -= 2;
						Size.y -= 2;
						if (Size.x <= 0 || Size.y <= 0) exists = false;
					}
					else
						_life = -50;
				}
				else
					_life-= FlxG.elapsed;
			}
		}
		
		override public function draw():void
		{
			//if (!onScreen() || !exists) return;
			var pnt:FlxPoint = getScreenXY();
			var dx:Number = Rnd.float( -_displaceAmt.x, _displaceAmt.x); 
			var dy:Number = Rnd.float( -_displaceAmt.y, _displaceAmt.y); 
			var w:int = Size.x;
			
			var h:int = Size.y;
			FlxG.camera.buffer.copyPixels(_buffer, new Rectangle(pnt.x + (w * .5), pnt.y + (h * .5), w, h), new Point(pnt.x + dx + (w * .5), pnt.y + dy + (h * .5)), framePixels, null, true);
		}
	}

}
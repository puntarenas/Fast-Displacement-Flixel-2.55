package 
{
	import org.flixel.*;
	import Displacement;
	import com.gskinner.utils.Rnd;
	
	/**
	 * @author Ryan "Rybar" Malm, Tim "SeiferTim" Hely
	 */
	public class PlayState extends FlxState
	{
		[Embed(source = 'assets/noisechecker.png')]private var ImgBG:Class;
		[Embed(source = 'assets/protoTiles.png')]private var ImgTiles:Class;
		[Embed(source = 'assets/waterfall.png')]private var ImgWater:Class;
		[Embed(source = 'assets/fire.png')]private var ImgFire:Class;
		[Embed(source = 'assets/part.png')] private var ImgPart:Class;
		
		private var displaceEmitter:Displacement;
		private var displacedisplaceEmitter2:Displacement;
		private var FxGroup:FXGroup;
		private var mousedisplaceEmitter:Displacement;
		private var particles:FlxEmitter;
		private var particles2:FlxEmitter;
		
		
		override public function create():void
		{	
			
			//background stuff
			var bg:FlxBackdrop = new FlxBackdrop(ImgBG);
			add(bg);
			
			var water:FlxSprite = new FlxSprite(100, 160, ImgWater);
			add(water);
			var fire:FlxSprite = new FlxSprite(380 - 32, 160 - 70, ImgFire);
			add(fire);
			var wallThickness:int = 16;
			var b:FlxTileblock = new FlxTileblock(0, 0, FlxG.width, wallThickness); //ceiling
			b.makeGraphic(FlxG.width, wallThickness,0x88000000);
			add(b);
			b = new FlxTileblock(0, 0, wallThickness, FlxG.height); //left wall
			b.makeGraphic(wallThickness, FlxG.height,0x88000000);
			add(b);
			b = new FlxTileblock(FlxG.width - wallThickness, 0, wallThickness, FlxG.height); //right wall
			b.makeGraphic(wallThickness,FlxG.height,0x88000000);
			add(b);
			b = new FlxTileblock(0, FlxG.height - wallThickness, FlxG.width, wallThickness); //floor
			b.makeGraphic(FlxG.width,wallThickness,0x88000000);
			add(b);
			
			
			//top emitter (non displacement)
			add(particles = new FlxEmitter(0,0,200));
			particles.makeParticles(ImgPart,200,16);
			
			particles.setXSpeed( -15, 15);
			particles.setYSpeed(0, 100);
			particles.setRotation( 0, 0);
			particles.gravity =0;
			particles.setSize(FlxG.width, 1);
			
			//bottom emitter (non displacement)
			add(particles2 = new FlxEmitter(0, FlxG.height,200));
			particles2.makeParticles(ImgPart,200,16);
			
			particles2.setXSpeed( -15, 15);
			particles2.setYSpeed(0, -100);
			particles2.setRotation( 0, 0);
			particles2.gravity = 0;
			particles2.setSize(FlxG.width,1);
			
			
			
			//create and add fx group
			FxGroup = new FXGroup;
			add(FxGroup);
			
			//These are the displacement emitters
			FxGroup.add(displaceEmitter = new Displacement(FxGroup.FXBuffer,100, 160,200));
			displaceEmitter.maxSize = 200;
			
			displaceEmitter.setSize(32, 1);
			displaceEmitter.setXSpeed(-5, 5);
			displaceEmitter.setYSpeed( 30, 60);
			displaceEmitter.blobHeight = 4;
			displaceEmitter.blobWidth = 10;
			displaceEmitter.gravity = 0;
			displaceEmitter.displaceAmtX = 2;
			displaceEmitter.displaceAmtY = 4;
			displaceEmitter.alpha = .6;
			displaceEmitter.life = 2.5;
			displaceEmitter.blobCount = 300;
			displaceEmitter.begin();
			
			//displacement emitter no.2
			FxGroup.add(displacedisplaceEmitter2 = new Displacement(FxGroup.FXBuffer,380-32,160));
			displacedisplaceEmitter2.maxSize = 200;
			
			displacedisplaceEmitter2.setSize(32, 1);
			displacedisplaceEmitter2.setXSpeed(-5, 5);
			displacedisplaceEmitter2.setYSpeed( -20, -60);
			displacedisplaceEmitter2.blobHeight = 16;
			displacedisplaceEmitter2.blobWidth = 8;
			displacedisplaceEmitter2.displaceAmtX = 2;
			displacedisplaceEmitter2.displaceAmtY = 3;
			displacedisplaceEmitter2.alpha = .6;
			displacedisplaceEmitter2.life = 2.5;
			displacedisplaceEmitter2.blobCount = 300;
			displacedisplaceEmitter2.begin();
			
			
			//displacement mouse emitter
			FxGroup.add(mousedisplaceEmitter = new Displacement(FxGroup.FXBuffer,0,0));
			mousedisplaceEmitter.maxSize = 200;
			
			mousedisplaceEmitter.setSize(24, 24);
			mousedisplaceEmitter.setXSpeed(-15, 15);
			mousedisplaceEmitter.setYSpeed( -90, -100);
			mousedisplaceEmitter.blobHeight = 16;
			mousedisplaceEmitter.blobWidth = 16;
			mousedisplaceEmitter.displaceAmtX = 3;
			mousedisplaceEmitter.displaceAmtY = 2;
			mousedisplaceEmitter.alpha = .8;
			mousedisplaceEmitter.life = 2;
			mousedisplaceEmitter.blobCount = 200;
			mousedisplaceEmitter.begin();
		
			FlxG.mouse.show();
		}
		
		override public function update():void
		{
			
			//start emitters
			particles.start(true,1,2,3);
			particles2.start(true,1,2,3);
			
			//start displacement emitter
			displacedisplaceEmitter2.start(true,1,0.5,1);
			displaceEmitter.start(true,1,0.5,1);
			mousedisplaceEmitter.start(true,1,0.5,1);
			
			super.update();
			
			mousedisplaceEmitter.x = FlxG.mouse.x-4;
			mousedisplaceEmitter.y = FlxG.mouse.y-4;
			
			if(FlxG.mouse.justPressed()){
				
				mousedisplaceEmitter.emitRing(FlxG.mouse.x,FlxG.mouse.y,100);
			
			}
			
		}
		
		override public function draw():void
		{
			super.draw();	
			FxGroup.doRender();
		}
	}
}
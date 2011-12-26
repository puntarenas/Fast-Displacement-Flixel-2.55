package   {
	
	
	import org.flixel.*;
	
	
	[SWF(width = "480", height = "320", backgroundColor = "#ffffff")]
	[Frame(factoryClass="Preloader")]
	
	
	
	public class Main extends FlxGame
	{
		public function Main():void
		{	
			super(480,320,PlayState,1,60,60);	
			forceDebugger = true;	
			
		}
	}
}

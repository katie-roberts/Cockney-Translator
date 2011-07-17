package com.wunderman.translator {
	import flash.display.MovieClip;

	/**
	 * @author StocktonK
	 */
	public class SpeechBubble extends MovieClip{
		
		public function SpeechBubble()
		{
		//	super();
		}
		
		public function init():void
		{
			createLights();
		}
		
		private function createLights():void
		{
			// top lights
			for (var i=0; i<8;i++)
			{
				var newLight : LightBulb = new LightBulb();
				newLight.x = 7.35+ i*29.25;
				newLight.y = 7;
				this.addChild(newLight);
			}
			
			
			// bottom lights
		}
	}
}

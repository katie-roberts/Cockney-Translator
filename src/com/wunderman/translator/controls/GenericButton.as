package com.wunderman.translator.controls {
	import flash.events.MouseEvent;
	import com.wunderman.translator.abstract.AbstractButton;

	/**
	 * @author StocktonK
	 */
	public class GenericButton extends AbstractButton{
		
		public var textContent : String;
		public function GenericButton()
		{
			super();
			
		}
		
		override protected function over(evt : MouseEvent) : void {
			super.over(evt);
			
			this.gotoAndStop("over");
			
		}

		override protected function out(evt : MouseEvent) : void {
			super.out(evt);	
			
			this.gotoAndStop("out");
			
		}

		override protected function click(evt : MouseEvent) : void {
			super.click(evt);		
		}
	}
}

package com.wunderman.translator.abstract {

import flash.events.MouseEvent;				

	/**
	 * @author chris@acleveraddress.com
	 */
	 
	public class AbstractButton extends AbstractMovieClip {
		public function AbstractButton() {
			super();
			buttonMode = true;
			mouseChildren = false;
		
			addEvent(this, MouseEvent.ROLL_OVER, over);
			addEvent(this, MouseEvent.ROLL_OUT, out);
			addEvent(this, MouseEvent.CLICK, click);
		}

		protected function over(evt : MouseEvent) : void {
		}

		protected function out(evt : MouseEvent) : void {
		}

		protected function click(evt : MouseEvent) : void {
		}
		
	}

}

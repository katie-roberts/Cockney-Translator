package com.wunderman.translator.abstract {
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	/**
	 * @author chris@acleveraddress.com
	 */

		public class AbstractMovieClip extends MovieClip {
		public function AbstractMovieClip() {
			addEvent(this, Event.ADDED_TO_STAGE, added);
			addEvent(this, Event.REMOVED_FROM_STAGE, removed);
		}

		protected function added(e : Event) : void {
			removeEvent(this, Event.ADDED_TO_STAGE, added);
			addEvent(stage, Event.RESIZE, resize);
			resize();
		}

		protected function removed(e : Event) : void {
			addEvent(this, Event.ADDED_TO_STAGE, added);
			removeEvent(stage, Event.RESIZE, resize);
		}

		protected function resize(e : Event = null) : void {
		}

		protected function addEvent(item : EventDispatcher, type : String, listener : Function) : void {
			item.addEventListener(type, listener, false, 0, true);
		}

		protected function removeEvent(item : EventDispatcher, type : String, listener : Function) : void {
			item.removeEventListener(type, listener);
		}
		
		protected function removeIfExists(child : DisplayObjectContainer, container : DisplayObjectContainer) : void {
			if((child != null) && (container != null)) {
				if(container.contains(child)) container.removeChild(child);
			}
		}
	
	}
}

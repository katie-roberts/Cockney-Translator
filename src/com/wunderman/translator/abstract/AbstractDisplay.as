package com.wunderman.translator.abstract {

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;	

	/**
	 * @author chris@acleveraddress.com
	 */
	public class AbstractDisplay extends Sprite {

		public function AbstractDisplay() {
			addEvent(this, Event.ADDED_TO_STAGE, added);
			addEvent(this, Event.REMOVED_FROM_STAGE, removed);
		}

		protected function added(evt : Event) : void {
			removeEvent(this, Event.ADDED_TO_STAGE, added);
			addEvent(stage, Event.RESIZE, resize);
			resize();
		}

		protected function removed(evt : Event) : void {
			addEvent(this, Event.ADDED_TO_STAGE, added);
			removeEvent(stage, Event.RESIZE, resize);
		}

		protected function resize(evt : Event = null) : void {
		}

		protected function addEvent(item : EventDispatcher, type : String, listener : Function, weakReference : Boolean = true, priority : int = 0) : void {
			item.addEventListener(type, listener, false, priority, weakReference);
		}

		protected function removeEvent(item : EventDispatcher, type : String, listener : Function) : void {
			item.removeEventListener(type, listener);
		}

		protected function removeIfExists(child : DisplayObject, container : DisplayObjectContainer) : void {
			if((child != null) && (container != null)) {
				if(container.contains(child)) container.removeChild(child);
			}
		}
	}
}

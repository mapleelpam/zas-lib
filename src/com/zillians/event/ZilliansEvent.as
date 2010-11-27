/*
 * Copyright 
 *
 */
package com.zillians.event
{
	import flash.events.Event;

	/**
	 * 公共事件类
	 * @author twl.tan
	 * @version: 1.0
	 */
	public class ZilliansEvent extends Event
	{
		private var data_value:*;
		
		public function ZilliansEvent(data_value:Object,type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.data_value=data_value;
		}
		
		public function get data():Object{
			return data_value;
		}
		
	}
}
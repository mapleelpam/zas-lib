/*
 * Copyright 
 *
 */
package com.zillians.event
{
	import flash.events.IEventDispatcher;
	import flash.events.EventDispatcher;

	/**
	 * 公共事件 Dispatcher
	 * @author twl.tan
	 * @version: 1.0
	 */
	public class ZilliansEventDispatcher extends EventDispatcher
	{
		public function ZilliansEventDispatcher(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		private static var instance:ZilliansEventDispatcher;
		
		public static function getInstance():ZilliansEventDispatcher{
			if(instance==null){
				instance=new ZilliansEventDispatcher();
			}
			return instance;
		}
		
	}
}
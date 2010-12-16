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
		//Public Events
		public static const event_cloud_response_auth_ok:String = "cloud_response_auth_ok";
	
		
		public function ZilliansEventDispatcher(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		private static var mInstance:ZilliansEventDispatcher;
		public static function instance():ZilliansEventDispatcher{
			if(mInstance==null){
				mInstance=new ZilliansEventDispatcher();
			}
			return mInstance;
		}
		
	}
}
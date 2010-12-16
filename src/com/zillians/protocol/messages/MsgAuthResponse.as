package com.zillians.protocol.messages
{

	public class MsgAuthResponse extends MessageBase
	{
		public var result:int;
		
		public function MsgAuthResponse()
		{
			addIntField("result");
		}
		
		public function toString():String{
			return "";
		}
	}
}
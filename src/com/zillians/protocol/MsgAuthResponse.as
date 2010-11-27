package com.zillians.protocol
{

	public class MsgAuthResponse extends ProtocolBase
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
package com.zillians.protocol.messages
{
	import com.zillians.protocol.ProtocolBase;

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
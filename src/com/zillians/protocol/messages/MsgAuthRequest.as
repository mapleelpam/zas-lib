package com.zillians.protocol.messages
{
	import com.zillians.protocol.ProtocolBase;

	public class MsgAuthRequest extends ProtocolBase
	{
		public var userName:String;
		public var passWord:String;
		
		public function MsgAuthRequest(userName:String,passWord:String)
		{
			super();
			this.userName=userName;
			this.passWord=passWord;
			
			addStringField("userName");
			addStringField("passWord");
		}
		
	}
}
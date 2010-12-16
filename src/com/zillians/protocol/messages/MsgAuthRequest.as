package com.zillians.protocol.messages
{

	public class MsgAuthRequest extends MessageBase
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
package com.zillians.protocol
{

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
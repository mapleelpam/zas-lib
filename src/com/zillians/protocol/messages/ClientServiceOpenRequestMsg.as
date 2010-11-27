package com.zillians.protocol.messages
{
	import com.zillians.common.UUID;

	public class ClientServiceOpenRequestMsg extends MessageBase
	{
		public var ServiceID:uint;
		public var ServiceToken:UUID;
		
		public function ClientServiceOpenRequestMsg( sid:uint, token:UUID )
		{
			super();
			addUIntField("ServiceID");
			addUUIDField("ServiceToken");
			
			ServiceID = sid;
			ServiceToken = token;
		}
	}
}
package com.zillians.protocol.messages
{
	import com.zillians.common.UUID;
	import com.zillians.protocol.ProtocolBase;

	public class ClientServiceOpenRequestMsg extends ProtocolBase
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
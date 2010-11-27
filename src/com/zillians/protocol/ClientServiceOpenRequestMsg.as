package com.zillians.protocol
{
	import com.zillians.common.UUID;

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
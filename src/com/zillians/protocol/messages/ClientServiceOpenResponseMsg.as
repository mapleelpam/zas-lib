package com.zillians.protocol.messages
{
	import com.zillians.common.UUID;
	import com.zillians.protocol.ProtocolBase;
	
	public class ClientServiceOpenResponseMsg extends ProtocolBase
	{
		public var ServiceID:uint;
		public var Result:int;
		public var ObjectIDs:UUID;
		
		public function ClientServiceOpenResponseMsg()
		{
			super();
			addUIntField("ServiceID");
			addUIntField("Result");
			addUUIDField("ObjectIDs");
		}
	}
}
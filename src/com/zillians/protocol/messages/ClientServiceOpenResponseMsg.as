package com.zillians.protocol.messages
{
	import com.zillians.common.UUID;
	
	public class ClientServiceOpenResponseMsg extends MessageBase
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
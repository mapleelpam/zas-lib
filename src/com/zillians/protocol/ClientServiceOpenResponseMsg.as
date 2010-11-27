package com.zillians.protocol
{
	import com.zillians.common.UUID;
	
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
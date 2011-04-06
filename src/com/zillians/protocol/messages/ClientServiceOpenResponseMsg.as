package com.zillians.protocol.messages
{
	import com.zillians.common.UUID;
	
	public class ClientServiceOpenResponseMsg extends MessageBase
	{
		public var ServiceID:uint;
		public var Result:int;
		public var ObjectIDs:Vector.<UUID>;
		
		public function ClientServiceOpenResponseMsg()
		{
			super();
			addUIntField("ServiceID");
			addUIntField("Result");
			addVectorField("ObjectIDs");
		}
	}
}
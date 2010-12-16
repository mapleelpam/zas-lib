package com.zillians.protocol.messages
{
	import flash.utils.ByteArray;

	public class ClientRemoteProcedureCallMsgSend extends MessageBase
	{
		public var FunctionID:uint;
		public var Parameters:ByteArray;
		
		public function ClientRemoteProcedureCallMsgSend(id:uint, data:ByteArray )
		{
			super();
			addUIntField("FunctionID");
			addParamField("Parameters");
			
			FunctionID = id;
			Parameters = data;
		}
	}
}
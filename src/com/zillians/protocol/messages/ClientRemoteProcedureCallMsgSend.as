package com.zillians.protocol.messages
{
	import flash.utils.ByteArray;
	import com.zillians.protocol.ProtocolBase;

	public class ClientRemoteProcedureCallMsgSend extends ProtocolBase
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
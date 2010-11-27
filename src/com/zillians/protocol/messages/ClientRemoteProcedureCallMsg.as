package com.zillians.protocol.messages
{
	import flash.utils.ByteArray;
	import com.zillians.protocol.ProtocolBase;

	public class ClientRemoteProcedureCallMsg extends ProtocolBase
	{
		public var FunctionID:uint;
		public var Parameters:ByteArray;
		
		public function ClientRemoteProcedureCallMsg()
		{
			super();
			addUIntField("FunctionID");
			addParamField("Parameters");
		}
	}
}
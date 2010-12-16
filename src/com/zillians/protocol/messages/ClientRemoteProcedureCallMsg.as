package com.zillians.protocol.messages
{
	import flash.utils.ByteArray;

	public class ClientRemoteProcedureCallMsg extends MessageBase
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
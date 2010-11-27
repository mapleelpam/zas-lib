package com.zillians.protocol
{
	import flash.utils.ByteArray;

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
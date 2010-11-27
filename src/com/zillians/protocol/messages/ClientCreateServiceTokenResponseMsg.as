package com.zillians.protocol.messages
{
	import com.zillians.common.UUID;
	import com.zillians.protocol.ProtocolBase;
	
	public class ClientCreateServiceTokenResponseMsg extends ProtocolBase
	{
		public var ServiceID:uint;
		public var GatewayAddress:String;
		public var ServiceToken:UUID;
		public var Result:int;
		
		public function ClientCreateServiceTokenResponseMsg()
		{
			super();
			addUIntField("ServiceID");
			addStringField("GatewayAddress");
			addUUIDField("ServiceToken");
			addIntField("Result");
		}
	}
}
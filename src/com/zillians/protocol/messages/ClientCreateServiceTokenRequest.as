package com.zillians.protocol.messages
{
	
	import mx.messaging.channels.StreamingAMFChannel;
	import com.zillians.protocol.ProtocolBase;
	
	public class ClientCreateServiceTokenRequest extends ProtocolBase
	{
		public var ServiceID:uint;
		public var ServiceVersion:String;
		public var ProtocolVersion:String;
		
		public function ClientCreateServiceTokenRequest( sid:uint, sv:String, pv:String )
		{
			super();
			addUIntField("ServiceID");
			addStringField("ServiceVersion");
			addStringField("ProtocolVersion");
			
			ServiceID = sid;
			ServiceVersion = sv;
			ProtocolVersion = pv;
		}
	}
}
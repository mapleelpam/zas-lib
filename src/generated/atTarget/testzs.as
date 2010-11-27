package generated.atTarget
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	import com.zillians.protocol.messages.ClientRemoteProcedureCallMsgSend;
	import com.zillians.protocol.ProtocolID;
	import com.zillians.proxy.SocketProxy;
	
	public class testzs
	{
		public function testzs()
		{
		}
		
		//setPlayer( id:uint ):void
		public static var setPlayer:Function;
		
		//cantHearYou( id:uint ):void
		public static var cantHearYou:Function;
		
		//hearHello( id:uint ):void
		public static var hearHello:Function;
		
		static public function sayHelloTo( id:uint ):void
		{
			trace(" say hello to id "+id);
			var params:ByteArray = new ByteArray;
			params.endian = Endian.LITTLE_ENDIAN;
			
			params.writeUnsignedInt( id );
			
			var msg:ClientRemoteProcedureCallMsgSend = 
				new ClientRemoteProcedureCallMsgSend( /*FunctionID*/0x06, /*param*/params );
			SocketProxy.sendMessage(ProtocolID.CLIENT_RPC_MSG, msg, "GameService" );
		}
	}
}
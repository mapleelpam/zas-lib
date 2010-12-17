package generated.avatar.local_player 
 { 
 	import flash.utils.ByteArray;
 	import flash.utils.Endian;
 
 	import com.zillians.protocol.messages.ClientRemoteProcedureCallMsgSend;
 	import com.zillians.protocol.ProtocolID;
 	import com.zillians.proxy.SocketProxy;
 
 	public class RpcFunctions
 	{
 		public function RpcFunctions()
 		{
		}
 
 		public static var registerID:Function;

 		static public function changeAvatarID ( id:Number ):void
 		{
 			var params:ByteArray = new ByteArray;
 			params.endian = Endian.LITTLE_ENDIAN;
 			params.writeUnsignedInt( id )


 			var msg:ClientRemoteProcedureCallMsgSend = new ClientRemoteProcedureCallMsgSend( /*FunctionID*/7, /*param*/params );
 			SocketProxy.sendMessage(ProtocolID.CLIENT_RPC_MSG, msg, "GameService" );
 		}
 
 		static public function tryChangeDirection ( dir:Number ):void
 		{
 			var params:ByteArray = new ByteArray;
 			params.endian = Endian.LITTLE_ENDIAN;
 			params.writeUnsignedInt( dir )


 			var msg:ClientRemoteProcedureCallMsgSend = new ClientRemoteProcedureCallMsgSend( /*FunctionID*/8, /*param*/params );
 			SocketProxy.sendMessage(ProtocolID.CLIENT_RPC_MSG, msg, "GameService" );
 		}
 
 		static public function tryMove ( x:Number, y:Number ):void
 		{
 			var params:ByteArray = new ByteArray;
 			params.endian = Endian.LITTLE_ENDIAN;
 			params.writeUnsignedInt( x )
			params.writeUnsignedInt( y )


 			var msg:ClientRemoteProcedureCallMsgSend = new ClientRemoteProcedureCallMsgSend( /*FunctionID*/5, /*param*/params );
 			SocketProxy.sendMessage(ProtocolID.CLIENT_RPC_MSG, msg, "GameService" );
 		}
 	}
}

package generated.avatar.remote_player 
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
 
 		public static var remoteChangeAvatar:Function;
		public static var remoteChangeDirection:Function;
		public static var remoteLogin:Function;
		public static var remoteLogout:Function;
		public static var remoteTryMove:Function;
	}
}

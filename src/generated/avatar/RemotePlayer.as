package generated.avatar
{
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	import com.zillians.protocol.messages.ClientRemoteProcedureCallMsgSend;
	import com.zillians.protocol.ProtocolID;
	import com.zillians.proxy.SocketProxy;
	
	public class RemotePlayer
	{
		public function RemotePlayer()
		{
		}
		
		public static var remoteTryMove:Function;
		
		public static var remoteLogout:Function;
		
		public static var remoteChangeAvatar:Function;
		
		public static var remoteLogin:Function;
		
		public static var remoteChangeDirection:Function;
		
	}
}
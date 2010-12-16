package generated.avatar
{
	
	import com.zillians.protocol.ProtocolID;
	import com.zillians.protocol.messages.ClientRemoteProcedureCallMsgSend;
	import com.zillians.proxy.SocketProxy;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	public class LocalPlayer
	{
		public function LocalPlayer()
		{
		}
		
		public static var registerID:Function;
		
		
		static public function tryMove( x:uint, y:uint):void
		{
			var params:ByteArray = new ByteArray;
			params.endian = Endian.LITTLE_ENDIAN;
			
			params.writeUnsignedInt( x );
			params.writeUnsignedInt( y );
			
			var msg:ClientRemoteProcedureCallMsgSend = 
				new ClientRemoteProcedureCallMsgSend( /*FunctionID*/0x05, /*param*/params );
			SocketProxy.sendMessage(ProtocolID.CLIENT_RPC_MSG, msg, "GameService" );
		}
		
		static public function changeAvatarID( id:uint ):void
		{
			trace("  LocalPlayer:changeAvatarID " );
			var params:ByteArray = new ByteArray;
			params.endian = Endian.LITTLE_ENDIAN;
			
			params.writeUnsignedInt( id );
			
			var msg:ClientRemoteProcedureCallMsgSend = 
				new ClientRemoteProcedureCallMsgSend( /*FunctionID*/0x07, /*param*/params );
			SocketProxy.sendMessage(ProtocolID.CLIENT_RPC_MSG, msg, "GameService" );
		}
		
		static public function tryChangeDirection( dir:uint ):void
		{
			trace(" LocalPlayer:tryChangeDirection " );
			var params:ByteArray = new ByteArray;
			params.endian = Endian.LITTLE_ENDIAN;
			
			params.writeUnsignedInt( dir );
			
			var msg:ClientRemoteProcedureCallMsgSend = 
				new ClientRemoteProcedureCallMsgSend( /*FunctionID*/0x08, /*param*/params );
			SocketProxy.sendMessage(ProtocolID.CLIENT_RPC_MSG, msg, "GameService" )
		}
		
	}
}
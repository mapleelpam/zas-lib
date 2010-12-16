package generated.avatar
{
	import com.zillians.protocol.messages.ClientRemoteProcedureCallMsg;
	import com.zillians.service.gameservice.IGameFunctionDispatcher;

	public class AtClientFunctionDispatcher implements IGameFunctionDispatcher
	{
		public function AtClientFunctionDispatcher()
		{
		}
		public function dispatchFunction( msg:ClientRemoteProcedureCallMsg ):Boolean
		{
			
			trace("in switch." + msg.FunctionID);
			switch( msg.FunctionID ){
				case 0x06:
				{
					var id0x06:uint = msg.Parameters.readUnsignedInt();
					if( LocalPlayer.registerID != null )
						LocalPlayer.registerID( id0x06 );
					else;/*TODO*/
					return true;
				}
				case 0x09:
				{	
					var id0x09_id:uint = msg.Parameters.readUnsignedInt();
					var id0x09_x:int = msg.Parameters.readUnsignedInt();
					var id0x09_y:int = msg.Parameters.readUnsignedInt();
					if( RemotePlayer.remoteTryMove != null )
					{
						RemotePlayer.remoteTryMove( id0x09_id, id0x09_x, id0x09_y  );
					}
						
					else;/*TODO*/
					return true;
				}
				case 0x0a:
				{
					var id0x0a:uint = msg.Parameters.readUnsignedInt();
					if( RemotePlayer.remoteLogout != null )
						RemotePlayer.remoteLogout( id0x0a );
					else;/*TODO*/
					return true;
				}
				case 0x0b:
				{
					var id0x0b_id:uint = msg.Parameters.readUnsignedInt();
					var id0x0b_avatarId:uint = msg.Parameters.readUnsignedInt();
					if( RemotePlayer.remoteChangeAvatar != null )
						RemotePlayer.remoteChangeAvatar( id0x0b_id, id0x0b_avatarId );
					else;/*TODO*/
					return true;
				}
				case 0x0c:
				{
					var id0x0c:uint = msg.Parameters.readUnsignedInt();
					if( RemotePlayer.remoteLogin != null )
						RemotePlayer.remoteLogin(id0x0c);
					else;/*TODO*/
					return true;
				}
				case 0x0d:
				{
					var id0x0d_id:uint = msg.Parameters.readUnsignedInt();
					var id0x0d_dir:uint = msg.Parameters.readUnsignedInt();
					if( RemotePlayer.remoteChangeDirection != null )
						RemotePlayer.remoteChangeDirection(id0x0d_id, id0x0d_dir);
					else;/*TODO*/
					return true;
				}
				default:
					trace(" GameService: unresolved functionID "+msg.FunctionID);
					return false
			}
			return false;
		}
	}
}
 package generated.avatar
 {
 	import com.zillians.protocol.messages.ClientRemoteProcedureCallMsg;
 	import com.zillians.service.gameservice.IGameFunctionDispatcher;
 

	import generated.avatar.local_player.*;
	import generated.avatar.remote_player.*;
	import generated.avatar.zillians.*;


 	public class FunctionDispatcher implements IGameFunctionDispatcher
 	{
 		public function FunctionDispatcher()
 		{
 		}
 		public function dispatchFunction( msg:ClientRemoteProcedureCallMsg ):Boolean
 		{
 			switch( msg.FunctionID ){
 
				case 6:
				{
					var ID_6:Number = msg.Parameters.readUnsignedInt();
					if(generated.avatar.local_player.RpcFunctions.registerID != null )
						generated.avatar.local_player.RpcFunctions.registerID( ID_6 );
					else /*TODO*/;
					return true;
				}

				case 11:
				{
					var ID_11:Number = msg.Parameters.readUnsignedInt();
					var avatar_id_11:Number = msg.Parameters.readUnsignedInt();
					if(generated.avatar.remote_player.RpcFunctions.remoteChangeAvatar != null )
						generated.avatar.remote_player.RpcFunctions.remoteChangeAvatar( ID_11, avatar_id_11 );
					else /*TODO*/;
					return true;
				}

				case 13:
				{
					var ID_13:Number = msg.Parameters.readUnsignedInt();
					var dir_13:Number = msg.Parameters.readUnsignedInt();
					if(generated.avatar.remote_player.RpcFunctions.remoteChangeDirection != null )
						generated.avatar.remote_player.RpcFunctions.remoteChangeDirection( ID_13, dir_13 );
					else /*TODO*/;
					return true;
				}

				case 12:
				{
					var ID_12:Number = msg.Parameters.readUnsignedInt();
					if(generated.avatar.remote_player.RpcFunctions.remoteLogin != null )
						generated.avatar.remote_player.RpcFunctions.remoteLogin( ID_12 );
					else /*TODO*/;
					return true;
				}

				case 10:
				{
					var ID_10:Number = msg.Parameters.readUnsignedInt();
					if(generated.avatar.remote_player.RpcFunctions.remoteLogout != null )
						generated.avatar.remote_player.RpcFunctions.remoteLogout( ID_10 );
					else /*TODO*/;
					return true;
				}

				case 9:
				{
					var ID_9:Number = msg.Parameters.readUnsignedInt();
					var x_9:Number = msg.Parameters.readUnsignedInt();
					var y_9:Number = msg.Parameters.readUnsignedInt();
					if(generated.avatar.remote_player.RpcFunctions.remoteTryMove != null )
						generated.avatar.remote_player.RpcFunctions.remoteTryMove( ID_9, x_9, y_9 );
					else /*TODO*/;
					return true;
				}

 			}/*switch*/
 			return false;
 		}/*function*/
 	}/*class*/
 }/*package*/
 
 
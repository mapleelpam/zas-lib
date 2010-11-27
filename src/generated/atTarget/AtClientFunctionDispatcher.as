package generated.atTarget
{
	import com.zillians.protocol.ClientRemoteProcedureCallMsg;
	import com.zillians.service.gameservice.IGameFunctionDispatcher;
	
	import generated.atTarget.testzs;

	public class AtClientFunctionDispatcher implements IGameFunctionDispatcher
	{
		public function AtClientFunctionDispatcher()
		{
		}
		public function dispatchFunction( msg:ClientRemoteProcedureCallMsg ):Boolean
		{
			switch( msg.FunctionID ){
				case 0x05:
				{
					var id:int = msg.Parameters.readUnsignedInt();
					if( testzs.setPlayer != null )
						testzs.setPlayer(id);
					else;/*TODO*/
					return true;
				}
				case 0x07:
				{
					var id:int = msg.Parameters.readUnsignedInt();
					if( testzs.cantHearYou != null )
						testzs.cantHearYou(id);
					else;/*TODO*/
					return true;
				}
				case 0x08:
				{
					var id:int = msg.Parameters.readUnsignedInt();
					if( testzs.hearHello != null )
						testzs.hearHello(id);
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
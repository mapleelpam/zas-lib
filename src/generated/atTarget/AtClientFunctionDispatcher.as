package generated.atTarget
{
	import com.zillians.protocol.messages.ClientRemoteProcedureCallMsg;
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
					var id0x05:int = msg.Parameters.readUnsignedInt();
					if( testzs.setPlayer != null )
						testzs.setPlayer(id0x05);
					else;/*TODO*/
					return true;
				}
				case 0x07:
				{
					var id0x07:int = msg.Parameters.readUnsignedInt();
					if( testzs.cantHearYou != null )
						testzs.cantHearYou(id0x07);
					else;/*TODO*/
					return true;
				}
				case 0x08:
				{
					var id0x08:int = msg.Parameters.readUnsignedInt();
					if( testzs.hearHello != null )
						testzs.hearHello(id0x08);
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
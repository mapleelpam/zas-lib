package com.zillians.service.gameservice
{
	import com.zillians.protocol.messages.ClientRemoteProcedureCallMsg;
	public interface IGameFunctionDispatcher
	{
		function dispatchFunction( msg:ClientRemoteProcedureCallMsg ):Boolean;		
	}
}
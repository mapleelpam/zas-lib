package com.zillians.service.gameservice
{
	import com.zillians.protocol.ClientRemoteProcedureCallMsg;
	public interface IGameFunctionDispatcher
	{
		function dispatchFunction( msg:ClientRemoteProcedureCallMsg ):Boolean;		
	}
}
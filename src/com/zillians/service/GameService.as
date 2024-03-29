package com.zillians.service
{
	import com.zillians.logger.Logger;
	import com.zillians.proxy.SocketProxy;
	import com.zillians.resource.Localizator;
	import com.zillians.protocol.ProtocolID;
	import com.zillians.common.UUID;
	import com.zillians.common.utilities.ObjectTWLUtils;
	import com.zillians.event.ZilliansEvent;
	import com.zillians.event.ZilliansEventDispatcher;
	import com.zillians.protocol.ProtocolIDMapper;
	import com.zillians.protocol.messages.*;
	import com.zillians.service.gameservice.IGameFunctionDispatcher;
	import com.zillians.proxy.SocketProxy;
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	public class GameService
	{
		private var serviceName:String = "GameService";
		public function GameService( name:String = "GameService" )
		{
			serviceName = name;
			
			ZilliansEventDispatcher.instance().addEventListener(
				serviceName+Event.CONNECT,
				socket_connect_handler);//GameServiceConnect
			ZilliansEventDispatcher.instance().addEventListener(
				String(ProtocolID.CLIENT_SERVICE_OPEN_RESPONSE_MSG),
				service_open_res_handler);
			ZilliansEventDispatcher.instance().addEventListener(
				String(ProtocolID.CLIENT_RPC_MSG),
				at_client_rpc_handler);
			
			SocketProxy.bind(
				serviceName
				,new SocketService(serviceName));
		}
		public function getServiceID():uint
		{
			return 0x00;
		}
		public function getServiceName():String
		{
			return "GameService";
		}
		private function socket_connect_handler(event:Event):void 
		{
			if(Logger.getInstance().isInfo()){
				Logger.getInstance().log(Localizator.getInstance().getText("socket.connected"),"GameService");
			}
			//serviceOpen
			serviceOpen();
		}
		
		public var gameFunctionDispatcher:IGameFunctionDispatcher;
		private function at_client_rpc_handler(e:ZilliansEvent):void
		{
			trace("@GameSerice:rpc_ivoker");	
			var msg:ClientRemoteProcedureCallMsg = ClientRemoteProcedureCallMsg(e.data);
			trace("function id "+msg.FunctionID);

			if( gameFunctionDispatcher != null )
				gameFunctionDispatcher.dispatchFunction(msg);
			else
				;/*TODO: throw a error event or alert */
		}

		private function service_open_res_handler(e:ZilliansEvent):void
		{
			trace("@GameSerice:service_open_res_handler");
		}

		private function serviceOpen():void
		{
			var msg:ClientServiceOpenRequestMsg = new ClientServiceOpenRequestMsg(getServiceID(),serviceToken);
			SocketProxy.sendMessage(ProtocolID.CLIENT_SERVICE_OPEN_REQUEST_MSG ,msg,serviceName);
		}

		private var serviceToken:UUID;
		public function open( address:String, port:Number, token:UUID ):void
		{
			serviceToken = token;
			SocketProxy.connect( address, port, serviceName );
		}
	}
}
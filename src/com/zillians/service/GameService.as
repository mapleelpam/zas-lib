package com.zillians.service
{
	import com.general.constants.BaseConstants;
	import com.general.logger.Logger;
	import com.general.proxy.SocketProxy;
	import com.general.resource.Localizator;
	import com.zillians.Protocols;
	import com.zillians.common.UUID;
	import com.zillians.common.utilities.ObjectTWLUtils;
	import com.zillians.event.ZilliansEvent;
	import com.zillians.event.ZilliansEventDispatcher;
	import com.zillians.protocol.*;
	import com.zillians.service.gameservice.IGameFunctionDispatcher;
	import com.zillians.stub.*;
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	public class GameService
	{
		public function GameService()
		{
			ZilliansEventDispatcher.getInstance().addEventListener(
				SocketProxy.socketService_name_game+Event.CONNECT,
				socket_connect_handler);//身份验证服务器连接成功
			
			ZilliansEventDispatcher.getInstance().addEventListener(
				String(Protocols.ClientServiceOpenResponseMsg),service_open_res_handler);
			/*TODO -- Move to Somewhere other */
			BaseConstants.getInstance().setProtocolClassPath(
				Protocols.ClientServiceOpenResponseMsg
				,ObjectTWLUtils.getClassPath(ClientServiceOpenResponseMsg));
			
			ZilliansEventDispatcher.getInstance().addEventListener(
				String(Protocols.ClientRemoteProcedureCallMsg),rpc_invoker);
			/*TODO -- Move to Somewhere other */
			BaseConstants.getInstance().setProtocolClassPath(
				Protocols.ClientRemoteProcedureCallMsg
				,ObjectTWLUtils.getClassPath(ClientRemoteProcedureCallMsg));
		}
		public function getServiceID():uint
		{
			return 0x00;
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
		private function rpc_invoker(e:ZilliansEvent):void
		{
			trace("@GameSerice:rpc_ivoker");	
			var msg:ClientRemoteProcedureCallMsg = ClientRemoteProcedureCallMsg(e.data);
			trace("function id "+msg.FunctionID);

			if(gameFunctionDispatcher!=null)
				gameFunctionDispatcher.dispatchFunction(msg);
			/*TODO: throw a error event or alert */
		}
		private function service_open_res_handler(e:ZilliansEvent):void
		{
			trace("@GameSerice:service_open_res_handler");
		}
		private function serviceOpen()
		{
			var msg:ClientServiceOpenRequestMsg = new ClientServiceOpenRequestMsg(getServiceID(),serviceToken);
			SocketProxy.sendMessage(Protocols.ClientServiceOpenRequestMsg ,msg,SocketProxy.socketService_name_game);
		}
		
		private var serviceToken:UUID;
		public function open( address:String, port:Number, token:UUID ):void
		{
			serviceToken = token;	
			
			SocketProxy.connect( address, port
				,SocketProxy.socketService_name_game);
		}
		
		
		static private var instance:GameService;
		static public function getInstance():GameService
		{
			if( instance==null )	instance = new GameService();
			return instance;
		}
		

		/* TODO: move to others */
		public function sayHelloTo( id:uint )
		{
			trace(" say hello to id "+id);
			var data:ByteArray = new ByteArray;
			data.endian = Endian.LITTLE_ENDIAN;
			data.writeUnsignedInt( id );
			
			var msg:ClientRemoteProcedureCallMsgSend = new ClientRemoteProcedureCallMsgSend( 0x06, data );
			SocketProxy.sendMessage(Protocols.ClientRemoteProcedureCallMsg, msg, SocketProxy.socketService_name_game);
		}
	}
}
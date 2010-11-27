package com.zillians.service
{
	import com.general.logger.Logger;
	import com.general.resource.Localizator;
	import com.general.service.SystemService;
	import com.zillians.event.ZilliansEvent;
	import com.zillians.event.ZilliansEventDispatcher;
	import com.zillians.protocol.messages.ClientCreateServiceTokenResponseMsg;
	import com.zillians.proxy.SocketProxy;
	import com.zillians.service.GameService;
	import com.zillians.service.TokenService;
	
	import flash.events.*;
	
	import mx.messaging.channels.StreamingAMFChannel;
	
	public class ServiceEngine extends EventDispatcher
	{
		private var tokenService:TokenService;
		public var gameService:GameService;
		
		public function ServiceEngine()
		{	
			ZilliansEventDispatcher.getInstance().addEventListener(
				TokenService.auth_response_ok,
				afterTokenServiceAuthOK);//身份验证服务器認證成功
			
			ZilliansEventDispatcher.getInstance().addEventListener(
				TokenService.token_response_ok,
				afterTokenServiceTokenRequestOK);//TokenRequest成功 
		}
		
		private var mUsername:String;
		private var mPassword:String;
		public function init( u:String, p:String ):void
		{
			SocketProxy.init(null);
		
			tokenService = new TokenService();
			gameService = new GameService();
			
			//TODO? remove this line?
			SocketProxy.setCurrentSocketService(tokenService.getServiceName());
			
			/* TODO: Move To TokenService Inside ! */
			ZilliansEventDispatcher.getInstance().addEventListener(
				tokenService.getServiceName()+Event.CONNECT,
				socket_connect_handler);//身份验证服务器连接成功
			
			/* TODO: just using TokenService.login() */
			SocketProxy.connect(
				SystemService.getInstance().socketserver_ip
				,SystemService.getInstance().socketserver_port
				,tokenService.getServiceName() );
			
			mUsername = u;
			mPassword = p;
		}
		
		//连接成功
		private function socket_connect_handler(event:Event):void 
		{
			if(Logger.getInstance().isInfo()){
				Logger.getInstance().log(Localizator.getInstance().getText("socket.connected"),"ServiceEngine");
			}
//			atxt.text=Localizator.getInstance().getText("socket.connected");
			//TODO? how to do?
			//身份验证
			tokenService.login(mUsername, mPassword);
		}
		//認證成功
		private function afterTokenServiceAuthOK(event:Event):void
		{
			trace(" @ServiceEngine AuthOK");
			tokenService.request_token( 0 );//GameService		
		}
		private function afterTokenServiceTokenRequestOK(event:ZilliansEvent):void
		{
			trace(" @ServiceEngine TokenOK");
			var msg:ClientCreateServiceTokenResponseMsg = ClientCreateServiceTokenResponseMsg( event.data );
			var comment:int = msg.GatewayAddress.search(":");
			var addr:String = msg.GatewayAddress.substr(0,comment);
			var port:String = msg.GatewayAddress.substr(comment+1,msg.GatewayAddress.length);
			
			gameService.open( addr, Number(port), msg.ServiceToken );
			//TODO? remove this line?
			SocketProxy.setCurrentSocketService(gameService.getServiceName());
		}
	}
}
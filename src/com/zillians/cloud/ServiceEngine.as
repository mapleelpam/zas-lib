package com.zillians.cloud
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
		
		public function init( u:String, p:String ):void
		{
			SocketProxy.init(null);
		
			tokenService = new TokenService();
			gameService = new GameService();
			
			//TODO? remove this line?
			SocketProxy.setCurrentSocketService(tokenService.getServiceName());
			
			/* TODO: just using TokenService.login() */
			SocketProxy.connect(
				SystemService.getInstance().socketserver_ip
				,SystemService.getInstance().socketserver_port
				,tokenService.getServiceName() );
			
			tokenService.open(
				SystemService.getInstance().socketserver_ip
				,SystemService.getInstance().socketserver_port
				, u, p
			);
		}
		
		//認證成功
		private function afterTokenServiceAuthOK(event:Event):void
		{
			trace(" @ServiceEngine AuthOK");
			tokenService.request_token( gameService.getServiceID() );//GameService		
		}
		//取得Token : TODO - Move to Service inside
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
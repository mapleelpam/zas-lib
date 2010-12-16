package com.zillians.cloud
{
	import com.zillians.logger.Logger;
	import com.zillians.resource.Localizator;
	import com.zillians.service.SystemService;
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
		public var tokenService:TokenService;
		public var gameService:GameService;
		
		public function ServiceEngine()
		{	
			ZilliansEventDispatcher.instance().addEventListener(
				ZilliansEventDispatcher.event_cloud_response_auth_ok,
				afterTokenServiceAuthOK);//身份验证服务器認證成功
			
			ZilliansEventDispatcher.instance().addEventListener(
				TokenService.event_token_response_ok,
				afterTokenServiceTokenRequestOK);//TokenRequest成功
			
			tokenService = new TokenService();
			gameService = new GameService();
			
		}
		
		public function cloudLogin( username:String, password:String ):void
		{
			tokenService.open(
				SystemService.getInstance().socketserver_ip
				,SystemService.getInstance().socketserver_port
				, username, password
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
		}
	}
}
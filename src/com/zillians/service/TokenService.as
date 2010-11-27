/*
 * Copyright 
 *
 */
package com.zillians.service
{
	import com.general.constants.BaseConstants;
	import com.general.logger.Logger;
	import com.general.proxy.SocketProxy;
	import com.zillians.common.utilities.ObjectTWLUtils;
	import com.zillians.Protocols;
	import com.zillians.event.ZilliansEvent;
	import com.zillians.event.ZilliansEventDispatcher;
	import com.zillians.protocol.ClientCreateServiceTokenRequest;
	import com.zillians.protocol.ClientCreateServiceTokenResponseMsg;
	import com.zillians.protocol.MsgAuthRequest;
	import com.zillians.protocol.MsgAuthResponse;
	
	/**
	 * 身份验证服务类
	 * @author twl
	 * @version: 1.0
	 */
	public class TokenService
	{
		public static const auth_response_ok:String = "auth_response_ok"; 
		public static const token_response_ok:String = "token_response_ok";
		
		/* AUTH RESULT ENUM (BEGIN) */
		public static const AUTH_OK:uint					= 0x00;
		public static const AUTH_MSG_FORMAT_ERROR:uint		= 0x01;
		public static const AUTH_USER_NOT_FOUND:uint		= 0x02;
		public static const AUTH_USER_TEMP_INVALID:uint		= 0x03;
		public static const AUTH_USER_NOT_LOGIN:uint		= 0x04;
		public static const AUTH_USER_WRONG_PASSWORD:uint	= 0x05;
		public static const AUTH_SERVICE_NOT_FOUND:uint		= 0x06;
		public static const AUTH_SERVICE_TEMP_INVALID:uint	= 0x07;
		public static const AUTH_SERVICE_BUSY:uint			= 0x08;
		public static const AUTH_INVALID_SERVICE:uint		= 0x09;
		public static const AUTH_MULTIPLE_AUTHENTICATED:uint= 0x0a;
		public static const AUTH_EXCEPTION:uint				= 0x0b;
		public static const AUTH_GET_NO_SERVICE:uint		= 0x0c;
		public static const AUTH_GET_GATEWAY_FAILED:uint	= 0x0d;
		public static const AUTH_GET_GATEWAY_SUCCESS:uint	= 0x0e;
		public static const AUTH_GATEWAY_OVERLOADING:uint	= 0x0f;
		/* AUTH RESULT ENUM (END) */
		
		public function login(userName:String, passWord:String ) : void 
		{
			var msgAuthRequest:MsgAuthRequest=new MsgAuthRequest(userName,passWord);
			SocketProxy.sendMessage(Protocols.MsgAuthRequest,msgAuthRequest,SocketProxy.socketService_name_auth);
		}
		
		private function login_res_handler(e:ZilliansEvent):void{
			if(Logger.getInstance().isInfo()){
				Logger.getInstance().log(e.data.toString(),"AMF1Test");
			}
			trace("auth - response ");
			
			var msg:MsgAuthResponse = MsgAuthResponse( e.data );
			switch( msg.result ) {
				case AUTH_OK:  {
					trace(" auth ok ");
					var e:ZilliansEvent = new ZilliansEvent({result:AUTH_OK}, auth_response_ok);
					ZilliansEventDispatcher.getInstance().dispatchEvent( e );
					break;
				}					
				case AUTH_MSG_FORMAT_ERROR:
				case AUTH_USER_NOT_FOUND:
				default:
					trace(" auth error ");
					break;
			}
			
		}
		
		public function requestToken( serviceID:uint ) : void 
		{
			var msg:ClientCreateServiceTokenRequest = new ClientCreateServiceTokenRequest(serviceID,"1","0");
			SocketProxy.sendMessage(Protocols.ClientCreateServiceTokenRequestMsg,msg,SocketProxy.socketService_name_auth);
		}
		
		private function token_res_handler(e:ZilliansEvent):void
		{
			if(Logger.getInstance().isInfo()){
				Logger.getInstance().log(e.data.toString(),"Token Request");
			}
			trace("tokenReq - response ");
			
			var msg:ClientCreateServiceTokenResponseMsg = ClientCreateServiceTokenResponseMsg( e.data );
			trace( "tokenReq "+msg.ServiceID );
			trace( "tokenReq "+msg.GatewayAddress );
			trace( "tokenReq "+msg.Result );
//			trace( "tokenReq "+msg.ServiceToken );
			
			if( msg.Result == 14 ) { //TODO: ask is it right 
				var e:ZilliansEvent = new ZilliansEvent(msg, token_response_ok);
				ZilliansEventDispatcher.getInstance().dispatchEvent( e );
			}
		}
		
		public function TokenService()
		{
			ZilliansEventDispatcher.getInstance().addEventListener(
				String(Protocols.MsgAuthResponse),login_res_handler);
			/*TODO -- Move to Somewhere other */
			BaseConstants.getInstance().setProtocolClassPath(
				Protocols.MsgAuthResponse
				,ObjectTWLUtils.getClassPath(MsgAuthResponse));
			
			ZilliansEventDispatcher.getInstance().addEventListener(
				String(Protocols.ClientCreateServiceTokenResponseMsg),token_res_handler);
			/*TODO -- Move to Somewhere other */
			BaseConstants.getInstance().setProtocolClassPath(
				Protocols.ClientCreateServiceTokenResponseMsg
				,ObjectTWLUtils.getClassPath(ClientCreateServiceTokenResponseMsg));
		}
		
		private static var instance:TokenService;
		
		public static function getInstance():TokenService
		{
			if(instance==null)	instance=new TokenService();
			return instance;
		}
		
	}
}
/*
 * Copyright 
 *
 */
package com.zillians.proxy
{
	import com.zillians.protocol.ProtocolIDMapper;
	import com.zillians.event.ZilliansEventDispatcher;
	import com.zillians.event.ZilliansEvent;
	import com.zillians.logger.Logger;
	import com.zillians.protocol.messages.MessageBase;
	import com.zillians.resource.Localizator;
	import com.zillians.service.SocketService;
	import com.zillians.common.utilities.ByteArrayUtils;
	import com.zillians.common.utilities.StringTWLUtil;
	
	import de.polygonal.ds.HashMap;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	/**
	 * socket管理类
	 * @author twl
	 * @version: 1.0
	 */
	public class SocketProxy 
	{
		//Only acces by socketService
		public static const socket_data_receive:String="socket_data_receive";
	
		private static var socketPoolMap:HashMap; 
		private static var currentSocketService:SocketService;
		
		//******************************************公共静态方法**********************************************
		/**
		 * 初始化socket代理类 
		 * @param param
		 * 
		 */				
		public static function init(param:Object):void{
			if(socketPoolMap!=null){
				socketPoolMap.clear();
			}else{
				socketPoolMap=new HashMap();
			}
		}
		
		/**
		 * 新增一个socketservice 
		 * @param serviceName
		 * @param socket
		 * 
		 */		
		public static function bind(serviceName:String,socket:SocketService):void{
			socketPoolMap.insert(serviceName,socket);
			socket.addEventListener(Event.CLOSE, function (e:ZilliansEvent):void{
					if(Logger.getInstance().isInfo()){
						Logger.getInstance().log(e.data.serviceName+"-->"+Localizator.getInstance().getText("socket.disconnected"),"AMF1Test");
					}
					doAfterClose(e.data.serviceName+"");
				});//服务器连接断开
        	socket.addEventListener(Event.CONNECT, 
				function (e:ZilliansEvent):void{
        			if(Logger.getInstance().isInfo()){
						Logger.getInstance().log(e.data.serviceName+"-->"+Localizator.getInstance().getText("socket.connected"),"AMF1Test");
					}
					doAfterConnected(e.data.serviceName+"");
        		});//连接成功
        	socket.addEventListener(IOErrorEvent.IO_ERROR, 
				function (e:ZilliansEvent):void{
        			if(Logger.getInstance().isInfo()){
						Logger.getInstance().log(e.data.serviceName+"-->"+Localizator.getInstance().getText("socket.ioError"),"AMF1Test");
					}
					doAfterIoError(e.data.serviceName+"");
        		});//服务器连接失败
        	socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, 
				function (e:ZilliansEvent):void{
        			if(Logger.getInstance().isInfo()){
						Logger.getInstance().log(e.data.serviceName+"-->"+Localizator.getInstance().getText("socket.securityError"),"AMF1Test");
					}
					doAfterSecError(e.data.serviceName+"");
        		});//连接安全域问题
        	socket.addEventListener(socket_data_receive, 
				function (e:ZilliansEvent):void{
        			if(Logger.getInstance().isInfo()){
						Logger.getInstance().log(e.data.serviceName+"-->"+Localizator.getInstance().getText("socket.securityError"),"AMF1Test");
					}
        			doAfterReceiveData(e.data.t,e.data.d);
        		});//从服务器端接收到数据
		}
		
		/**
		 * 连接server 
		 * @param socket_url
		 * @param socket_port
		 * @param serviceName
		 * 
		 */		
		public static function connect(socket_url:String,socket_port:Number,serviceName:String):void
		{
			socketPoolMap.find(serviceName).connSocket(socket_url,socket_port);
		}
		
		/**
		 * 发送消息 
		 * @param scoketprotocol
		 * @param bm
		 * @param serviceName
		 * 
		 */		
		public static function sendMessage(scoketprotocol:uint,bm:MessageBase,serviceName:String):void{
			var bt:ByteArray=new ByteArray();
			bt.endian=Endian.LITTLE_ENDIAN;
//			bt.objectEncoding = BYTEARRAY_ENCODING; 
			//消息体
			var payload : ByteArray = new ByteArray;
			payload.endian = Endian.LITTLE_ENDIAN;
			ByteArrayUtils.convertObjectToByteArray(payload,bm);
			//消息头+消息体
			bt.writeInt( scoketprotocol );
			bt.writeInt( payload.length );
			bt.writeBytes( payload, 0 , payload.length );
			//发送
			if(socketPoolMap.containsKey(serviceName)){
				socketPoolMap.find(serviceName).sendToServer(bt);
			}

		}
		
		//*****************************私有方法**************************************
		/**
		 * 连接关闭后dosomething 
		 * @param serviceName
		 * 
		 */		
		private static function doAfterClose(serviceName:String):void{
			
		}
		
		/**
		 * 连接成功后dosomething 
		 * @param serviceName
		 * 
		 */		
		private static function doAfterConnected(serviceName:String):void{
			ZilliansEventDispatcher.instance().dispatchEvent(new Event(serviceName+Event.CONNECT));
		}
		
		/**
		 * 连接发生IoError后dosomething 
		 * @param serviceName
		 * 
		 */		
		private static function doAfterIoError(serviceName:String):void{
			ZilliansEventDispatcher.instance().dispatchEvent(
				new ZilliansEvent(null,serviceName+IOErrorEvent.IO_ERROR));
		}
		private static function doAfterSecError(serviceName:String):void{
			ZilliansEventDispatcher.instance().dispatchEvent(
				new ZilliansEvent(null,serviceName+SecurityErrorEvent.SECURITY_ERROR));
		}
		
		/**
		 * 连接发生 SecurityError后dosomething
		 * @param serviceName
		 * 
		 */		
		private static function doAfterSecurityError(serviceName:String):void{
			
		}
		
		/**
		 * 从服务器端接收到数据后 dosomething
		 * @param msgType
		 * @param bt
		 * 
		 */		
		private static function doAfterReceiveData(msgType:uint,bt:ByteArray):void
		{
			var re:ZilliansEvent=new ZilliansEvent(
				ByteArrayUtils.convertByteArrayToObject(
					bt,ProtocolIDMapper.getInstance().getProtocolClassPath(msgType))
				,String(msgType));
			ZilliansEventDispatcher.instance().dispatchEvent(re);
		}
		
	}
}
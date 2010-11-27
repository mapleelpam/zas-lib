/*
 * Copyright 
 *
 */
package com.zillians.service
{
	import com.general.logger.Logger;
	import com.zillians.proxy.SocketProxy;
	import com.general.resource.Localizator;
	import com.zillians.event.ZilliansEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.ObjectEncoding;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	
	/**
	 * socket服务类,此类为基类，如有需要继承它，覆盖相关方法即可
	 * @author twl
	 * @version: 1.0
	 */
	public class SocketService extends EventDispatcher
	{
		
		private const BYTEARRAY_ENCODING:uint=ObjectEncoding.AMF0;
		private const TIME_OUT:int=30;
		
		private var connect:Socket;
		private var serviceName:String;
		
		//******************************************公共方法**********************************************
		/**
		 * 连接服务器
		 * 
		 */ 
		public function connSocket(socket_url:String , socket_port:Number):void
		{
			if(!checkConnState()){
				if(Logger.getInstance().isInfo()){
					Logger.getInstance().log(Localizator.getInstance().getText("socket.connect.begin"),"AMF1Test");
				}
				connect.connect(socket_url , socket_port);
			}
		}
		
		/**
		 * 断开连接 
		 * 
		 */		
		public function disConnSocket():void{
			if(checkConnState()){
				connect.close();
			}
		}
		
		/**
		 * 向服务器端发送数据 
		 * @param bt
		 * 
		 */		
		public function sendToServer(bt:ByteArray):void
		{
			if(checkConnState()){
				connect.writeBytes(bt);
				connect.flush();
			}
		}
		
		/**
		 * 得到当前服务器 
		 * @return 
		 * 
		 */		
		public function checkConnState():Boolean{
			return connect.connected;
		}
		
		//******************************私有方法****************************************
		/**
		 * 
		 * 接收服务器socket返回值
		 * 
		 * bytesAvailable输入缓冲区中可读取的数据的字节数。代码必须访问 bytesAvailable 以确保在尝试使用其中一种 read 方法读取数据之前，有足够的数据可用。
		 * readInt():int 从套接字读取一个带符号的 32 位整数。
		 * readBytes(bytes:ByteArray, offset:uint = 0, length:uint = 0):void 从套接字读取 length 参数所指定的数据的字节数。
		 */ 
		private function parseSocketServerData():void
		{
			if(connect.bytesAvailable > 8)
			{
				var typeId:int = connect.readInt();
				var len:int = connect.readInt();
				
				while(connect.bytesAvailable)
				{
					if(connect.bytesAvailable >= len)
					{
						var bt:ByteArray = new ByteArray();
						bt.endian = Endian.LITTLE_ENDIAN;
						connect.readBytes(bt,0,len);
						
						var event:ZilliansEvent = new ZilliansEvent(
							{serviceName:this.serviceName,t:typeId,d:bt}
							,SocketProxy.socket_data_receive);
						this.dispatchEvent( event );
						break;
					}
				}
			}
			if(connect.bytesAvailable)
			{
				 parseSocketServerData();
			}
		}
		
		//*****************************事件监听**************************************
		/**
		 * 服务器连接断开 
		 * @param event
		 * 
		 */		
		private function socket_close_handler(e:Event):void 
		{
			this.dispatchEvent(new ZilliansEvent({serviceName:this.serviceName},Event.CLOSE));
	    }
	
	    /**
	     * 连接成功 
	     * @param event
	     * 
	     */		
	    private function socket_connect_handler(e:Event):void 
	    {
	    	this.dispatchEvent(new ZilliansEvent({serviceName:this.serviceName},Event.CONNECT));
	    }
	
	    /**
	     * 服务器连接io错误
	     * @param event
	     * 
	     */		
	    private function socket_ioError_handler(e:IOErrorEvent):void 
	    {
	    	this.dispatchEvent(new ZilliansEvent({serviceName:this.serviceName},IOErrorEvent.IO_ERROR));
	    }
	
	    /**
	     * 服务器连接安全域问题 
	     * @param event
	     * 
	     */		
	    private function socket_securityError_handler(e:SecurityErrorEvent):void 
	    {
	    	this.dispatchEvent(new ZilliansEvent({serviceName:this.serviceName},SecurityErrorEvent.SECURITY_ERROR));
	    }
	
	    /**
	     * 从服务端接收到数据 
	     * @param event
	     * 
	     */		
	    private function socket_receiveData_handler(e:ProgressEvent):void 
	    {
	        parseSocketServerData();
	    }
		
		/**
		 * 构造函数 
		 * @param serviceName
		 * 
		 */		
		public function SocketService(serviceName:String)
		{
			this.serviceName=serviceName;
			connect=new Socket();
			connect.endian = Endian.LITTLE_ENDIAN;
			connect.objectEncoding=BYTEARRAY_ENCODING;
			connect.addEventListener(Event.CLOSE, socket_close_handler);//服务器连接断开
        	connect.addEventListener(Event.CONNECT, socket_connect_handler);//连接成功
        	connect.addEventListener(IOErrorEvent.IO_ERROR, socket_ioError_handler);//服务器连接失败
        	connect.addEventListener(SecurityErrorEvent.SECURITY_ERROR, socket_securityError_handler);//连接安全域问题
        	connect.addEventListener(ProgressEvent.SOCKET_DATA, socket_receiveData_handler);//从服务器端接收到数据
		}

	}
}
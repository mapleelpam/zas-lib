/*
 * Copyright 
 *
 */
package com.general.service
{
	
	import com.general.cache.DataCache;
	import com.general.logger.Logger;
	import com.general.proxy.StaticDataProxy;
	import com.general.resource.Localizator;
	
	import de.polygonal.ds.HashMap;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	

	/**
	 * 系统服务类
	 * @author twl.tan
	 * @version: 1.0
	 */
	public class SystemService extends EventDispatcher
	{
		
		public static const t_sys_config_loaded:String="t_sys_config_loaded";
		
		public var socketserver_ip:String="";
		public var socketserver_port:uint;
		public var loggerLevel:int;
		public var languagePath:XML;
		public var defaultLanguage:String;
		public var currentLanguage:String;
		public var config:XML;
		public var uKey:String;
		
		//****************************公共方法*********************************
		/**
		 * 初始化系统
		 * @param configPath
		 * 
		 */		
		public function initSystem(configPath:String="config/config.xml"):void{
			var tmpXmlStr:String="<load id=\"mainconfig\"><i id=\"config\" path=\""+configPath+"\"/></load>";
			DataCache.getInstance().clearCacheData();			
			StaticDataProxy.getInstance().loadStaticData(new XML(tmpXmlStr));
		}
		
		/**
		 * 重置socket服务器地址与端口 
		 * @param addr
		 * @param port
		 * 
		 */		
		public function resetSocketAddr(addr:String,port:uint):void{
			this.socketserver_ip=addr;
			this.socketserver_port=port;
		}
		
		//***************************************事件监听**************************************
		/**
		 * 加载配置文件的回调
		 * @param e
		 * 
		 */		
		private function config_load_success(e:Event):void{
			config=XML(DataCache.getInstance().getCacheData("config"));
			
			this.socketserver_ip=config.socketserver[0].ip[0];
			this.socketserver_port=config.socketserver[0].port[0];
			this.loggerLevel=int(config.logger[0].@level);
			this.languagePath=config.language[0];
			this.defaultLanguage=config.language[0].@defaultlan+"";
			this.currentLanguage=config.language[0].@currentlan+"";
			//初始化logger
			initLogger(loggerLevel);
			loadLanguage();
			
		}
		 
		/**
		 * 加载国际化语言版本的回调
		 * @param e
		 * 
		 */		
		private function languages_load_success(e:Event):void{
			var lanMap:HashMap=new HashMap();
			for each(var x:XML in this.languagePath.lan){
				lanMap.insert(x.@id+"",DataCache.getInstance().getCacheData(x.@id+"")+"");
	    	}
	    	initLanguage(lanMap);
		}
		
		//*************************************私有方法*****************************************
		/**
		 * 初始化日志
		 * @param logLevel
		 * 
		 */		
		private function initLogger(logLevel:int):void {
            Logger.getInstance().initLogger(logLevel);
	    }
		
		/**
		 * 加载国际化文件 
		 * 
		 */		
		private function loadLanguage():void{
	    	//<lan id="zh_CN" path="config/zh_CN.txt"/>
	    	var tmpXmlStr:String="<load id=\"languages\">";
	    	for each(var x:XML in this.languagePath.lan){
	    		tmpXmlStr+="<i id=\""+x.@id+"\" path=\""+x.@path+"\"/>";	
	    	}
	    	tmpXmlStr+="</load>";
	    	StaticDataProxy.getInstance().loadStaticData(new XML(tmpXmlStr));
	    }
	    
	    /**
	     * 初始化国际化语言文本 
	     * @param lanMap
	     * 
	     */		
	    private function initLanguage(lanMap:HashMap):void{
	    	Localizator.getInstance().initData(lanMap,this.defaultLanguage,this.currentLanguage);
	    	this.dispatchEvent(new Event(t_sys_config_loaded));
	    }
		
		//***************************************单例*******************************************
		private static var instance:SystemService;
		
		public static function getInstance():SystemService{
			if(instance==null){
				instance=new SystemService();
			}
			return instance;
		}
		
		public function SystemService(target:IEventDispatcher=null)
		{
			StaticDataProxy.getInstance().addEventListener("mainconfig"+StaticDataProxy.t_sys_load_queue_complete,config_load_success);
			StaticDataProxy.getInstance().addEventListener("languages"+StaticDataProxy.t_sys_load_queue_complete,languages_load_success);
		}
		
	}
}
/*
 * Copyright 
 *
 */
package com.general.logger
{
	/**
	 * 日志服务
	 * @author twl
	 * @version: 1.0
	 */
	public class Logger
	{
	    private var currentLogLevel:int = LogLevel.FATAL;
	    
	    //**********************************公共方法*************************************  
	    /**
	     * 日志输出等级是否是Fatal
	     * @return 
	     * 
	     */	      
	    public function isFatal():Boolean
	    {
	        return (currentLogLevel <= LogLevel.FATAL) ? true : false;
	    }
	    
	    /**
	     * 日志输出等级是否是 Error
	     * @return 
	     * 
	     */	    
	    public function isError():Boolean
	    {
	        return (currentLogLevel <= LogLevel.ERROR) ? true : false;
	    }
	    
	    /**
	     * 日志输出等级是否是Warn 
	     * @return 
	     * 
	     */	    
	    public function isWarn():Boolean
	    {
	        return (currentLogLevel <= LogLevel.WARN) ? true : false;
	    }
	
	    /**
	     * 日志输出等级是否是 Info 
	     * @return 
	     * 
	     */		
	    public function isInfo():Boolean
	    {
	        return (currentLogLevel <= LogLevel.INFO) ? true : false;
	    }
	    
	    /**
	     * 日志输出等级是否是 debug 
	     * @return 
	     * 
	     */	    
	    public function isDebug():Boolean
	    {
	        return (currentLogLevel <= LogLevel.DEBUG) ? true : false;
	    }
		
		/**
		 * 打印日志 
		 * @param msg
		 * @param logName
		 * 
		 */		
		public function log(msg:String,logName:String="system"):void{
			trace("Log====>["+logName+"] "+msg);
		}
		
		/**
		 * 初始化日志 
		 * @param logLevel 日志等级
		 * 
		 */		
		public function initLogger(logLevel:int):void{
			currentLogLevel=logLevel;
		}
		
		//***************************************单例********************************
		private static var instance:Logger;
		
		public static function getInstance():Logger{
			if(instance==null) instance=new Logger(); 
			return instance;
		}
		
		public function Logger(){
			
		}

	}
}
/*
 * Copyright 
 *
 */
package com.general.proxy
{
	
	import com.general.cache.DataCache;
	import com.zillians.event.ZilliansEvent;
	import com.hydrotik.queueloader.QLManager;
	import com.hydrotik.queueloader.QueueLoader;
	import com.hydrotik.queueloader.QueueLoaderEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	

	/**
	 * 加载静态资源的代理类
	 * @author twl
	 * @version: 1.0
	 */
	public class StaticDataProxy extends EventDispatcher
	{
		public static const t_sys_load_queue_start:String="t_sys_load_queue_start";
		public static const t_sys_load_item_start:String="t_sys_load_item_start";
		public static const t_sys_load_item_progress:String="t_sys_load_item_progress";
		public static const t_sys_load_queue_progress:String="t_sys_load_queue_progress";
		public static const t_sys_load_item_complete:String="t_sys_load_item_complete";
		public static const t_sys_load_item_error:String="t_sys_load_item_error";
		public static const t_sys_load_item_http_error:String="t_sys_load_item_http_error";
		public static const t_sys_load_queue_complete:String="t_sys_load_queue_complete";
		
		private var _oLoader:QueueLoader;
		
		private var current_load_task_name:String="";
		
		private var addedDefinitions : LoaderContext;
	
		/**
		 * 构造函数 
		 * @param target
		 * 
		 */			
		public function StaticDataProxy(target:IEventDispatcher=null)
		{
			addedDefinitions = new LoaderContext();
			addedDefinitions.applicationDomain = ApplicationDomain.currentDomain;
		}
		
		/**
		 * 重置加载队列 
		 * 
		 */		
		public function reset():void{
			current_load_task_name="";
			if(_oLoader && _oLoader.getQueuedItems()!=null && _oLoader.getQueuedItems().length>0){
				_oLoader.dispose();
				QLManager.disposeAll();
			}
		}
		
		/**
		 * 加载静态资源
		 *  
		 * @param loadXml : <load id=""><i id="" path=""/></load>
		 * 
		 */			
		public function loadStaticData(loadXml:XML):void{
			reset();
			current_load_task_name=loadXml.@id;
			_oLoader= new QueueLoader(false, addedDefinitions, true, current_load_task_name);
			_oLoader.addEventListener(QueueLoaderEvent.QUEUE_START, onQueueStart, false, 0, true);
			_oLoader.addEventListener(QueueLoaderEvent.ITEM_START, onItemStart, false, 0, true);
			_oLoader.addEventListener(QueueLoaderEvent.ITEM_PROGRESS, onItemProgress, false, 0, true);
			_oLoader.addEventListener(QueueLoaderEvent.ITEM_COMPLETE, onItemComplete, false, 0, true);
			_oLoader.addEventListener(QueueLoaderEvent.ITEM_ERROR, onItemError, false, 0, true);
			_oLoader.addEventListener(QueueLoaderEvent.QUEUE_PROGRESS, onQueueProgress, false, 0, true);
			_oLoader.addEventListener(QueueLoaderEvent.QUEUE_COMPLETE, onQueueComplete, false, 0, true);
			_oLoader.addEventListener(QueueLoaderEvent.ITEM_HTTP_STATUS, onHTTPError, false, 0, true);
			
			for each(var tmp:XML in loadXml.i){
				_oLoader.addItem(tmp.@path, null ,{title:tmp.@id});
			}
			_oLoader.execute();
		}
		
		//*********************************事件监听*******************************************
		/**
		 * 加载队列启动
		 * 将抛出当前加载任务的标示+t_sys_load_queue_start的Event事件
		 * @param event
		 * 
		 */		
		private function onQueueStart(event:QueueLoaderEvent) : void {
			trace("** " + QueueLoaderEvent(event).type);
			this.dispatchEvent(new Event(current_load_task_name+t_sys_load_queue_start));
		}
	
		/**
		 * 某个资源开始加载
		 * 将抛出当前加载任务的标示+t_sys_load_item_start的CommonEvent事件,其中数据为：t-资源标示
		 * @param event
		 * 
		 */	
		private function onItemStart(e:QueueLoaderEvent) : void {
			trace("\t>> " + e.type, "item title: " + e.title);
			this.dispatchEvent(new ZilliansEvent({t:e.title},current_load_task_name+t_sys_load_item_start));
		}

		/**
		 * 某个资源的加载进度
		 * 将抛出当前加载任务的标示+t_sys_load_item_progress的CommonEvent事件,其中数据为：t-资源标示,p-加载进度
		 * @param event
		 * 
		 */	
		private function onItemProgress(e:QueueLoaderEvent) : void {
			trace("LOADING " + e.title.toUpperCase() + ": " + Math.round((e.percentage * 100)).toString() + "% COMPLETE");
			this.dispatchEvent(new ZilliansEvent({t:e.title,p:Math.round((e.percentage * 100)).toString()},current_load_task_name+t_sys_load_item_progress));
		}

		/**
		 * 队列的加载进度 
		 * 将抛出当前加载任务的标示+t_sys_load_queue_progress的CommonEvent事件,其中数据为：t-加载任务标示,p-队列加载进度
		 * @param e
		 * 
		 */		
		private function onQueueProgress(e:QueueLoaderEvent) : void {
			trace("QUEUE: " + Math.round((e.queuepercentage * 100)).toString() + "% COMPLETE");
			this.dispatchEvent(new ZilliansEvent({t:current_load_task_name,p:Math.round((e.queuepercentage * 100)).toString()},current_load_task_name+t_sys_load_queue_progress));
		}
	
		/**
		 * 资源加载完成 
		 * 将抛出当前加载任务的标示+t_sys_load_item_complete的CommonEvent事件,其中数据为：t-资源标示
		 * @param e
		 * 
		 */		
		private function onItemComplete(e:QueueLoaderEvent) : void {
			trace("\t>> " + e.type, "item title: " + e.title);
			DataCache.getInstance().setCacheData(e.title,e.content);
			this.dispatchEvent(new ZilliansEvent({t:e.title},current_load_task_name+t_sys_load_item_complete));
		}
	
		/**
		 * 资源加载错误 
		 * 将抛出当前加载任务的标示+t_sys_load_item_error的CommonEvent事件,其中数据为：t-资源标示,m-出错信息
		 * @param e
		 * 
		 */		
		private function onItemError(e:QueueLoaderEvent) : void {
//			trace("\n>>" + e.message + "\n");
			this.dispatchEvent(new ZilliansEvent({t:e.title,m:e.message},current_load_task_name+t_sys_load_item_error));
		}

		/**
		 * 加载地址网络错误 
		 * 将抛出当前加载任务的标示+t_sys_load_item_http_error的CommonEvent事件,其中数据为：t-资源标示,m-出错信息
		 * @param e
		 * 
		 */		
		private function onHTTPError(e:QueueLoaderEvent) : void {
//			trace("\n\t\t>>"+e.message+"\n");
			this.dispatchEvent(new ZilliansEvent({t:e.title,m:e.message},current_load_task_name+t_sys_load_item_http_error));
		}
	
		/**
		 * 队列加载完毕 
		 * 将抛出当前加载任务的标示+t_sys_load_queue_complete的Event事件
		 * @param e
		 * 
		 */		
		private function onQueueComplete(e:QueueLoaderEvent) : void {
			trace("** " + e.type);
			this.dispatchEvent(new Event(current_load_task_name+t_sys_load_queue_complete));
		}
		
		//*********************************************单例*******************************************
		private static var instance:StaticDataProxy;
		
		public static function getInstance():StaticDataProxy{
			if(instance==null){
				instance=new StaticDataProxy();
			}
			return instance;
		}
		
	}
}
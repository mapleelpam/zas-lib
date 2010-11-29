/*
 * Copyright 
 *
 */
package com.general.cache
{
	import de.polygonal.ds.HashMap;
	
	import flash.events.EventDispatcher;

	/**
	 * 资源缓存类
	 * @author twl
	 * @version: 1.0
	 */
	public class DataCache extends EventDispatcher
	{
		
		private var cache_data_map:HashMap;
		
		//**********************************公共方法*************************************
		/**
		 * 得到缓存的数据
		 * @param dName 缓存数据标示
		 * @return 缓存数据标示对应的缓存数据,可以是任何对象
		 * 
		 */		
		public function getCacheData(dName:String):*{
			return cache_data_map.find(dName);
		}
		
		/**
		 * 把数据加入缓存 
		 * @param dName 缓存数据的标示
		 * @param d 缓存的数据
		 * @param isReplace 是否替代
		 * @return 成功-true,失败-false
		 * 
		 */		
		public function setCacheData(dName:String,d:*,isReplace:Boolean=true):Boolean{
			if(cache_data_map.containsKey(dName)){
				if(isReplace){
					cache_data_map.update(dName,d);
					return true;
				}
				return false;
			}
			cache_data_map.insert(dName,d);
			return true;
		}
		
		/**
		 * 删除缓存数据 
		 * @param dName 缓存数据的标示
		 * 
		 */		
		public function deleteCacheData(dName:String):void{
			if(cache_data_map.containsKey(dName)){
				cache_data_map.remove(dName);
			}
		}
		
		/**
		 * 清空缓存 
		 * 
		 */		
		public function clearCacheData():void{
			cache_data_map.clear();
		}
		
		//***************************************单例********************************
		private static var _instance:DataCache;
		
		public static function instance():DataCache{
			if(_instance==null){
				_instance=new DataCache();
			}
			return _instance;
		}
		
		public function DataCache()
		{
			cache_data_map=new HashMap();
		}
		
	}
}
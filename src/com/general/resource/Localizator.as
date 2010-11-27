/*
 * Copyright 
 *
 */
package com.general.resource
{
	
	import com.zillians.common.utilities.StringTWLUtil;
	
	import de.polygonal.ds.HashMap;
	
	/**
	 * 国际化
	 * @author twl
	 * @version: 1.0
	 */
	public class Localizator {
		
		private var languageMap:HashMap;
		
		private var language:String;
		
		private var defaultLanguage:String;
		
		//**********************************公共方法*************************************
		/**
		 * 初始化资源文件
		 * @param lanMap
		 * @param defaultLan
		 * @param currentLan
		 * 
		 */		
		public function initData(lanMap:HashMap,defaultLan:String="zh_CN",currentLan:String="zh_CN"):void{
			selectLanguage(defaultLan,currentLan);
			for each(var k:String in lanMap.getKeySet()){
				parseLanData(k,lanMap.find(k));
			}
		}
		
		/**
		 * 取得国际化资源 
		 * @param lan 语言版本
		 * @return 
		 * 
		 */		
		public function getLanguage(lan:String):HashMap{
			if(!languageMap.containsKey(lan)){
				return null;
			}
			return HashMap(languageMap.find(language));
		}
		
		/**
		 * 得到国际化文本信息 
		 * @param k
		 * @return 
		 * 
		 */		
		public function getText(k:String):String {
			return HashMap(languageMap.find(language)).find(k)+"";
		}
		
		//**********************************私有方法*************************************
		/**
		 * 解析国际化文件
		 * @param lan
		 * @param d
		 * 
		 */		
		private function parseLanData(lan:String,d:*):void{
			var tmpMap:HashMap=new HashMap();
			var tmpArr:Array=String(d).split("\n");
			for each(var s:String in tmpArr){
				if(!StringTWLUtil.equals("",s) && StringTWLUtil.hasSubString(s,"=")){
					var lArr:Array=s.split("=");
					tmpMap.insert(StringTWLUtil.trim(lArr[0]),StringTWLUtil.trim(lArr[1]));
				}
			}
			languageMap.insert(lan,tmpMap);
		}
		
		/**
		 * 设置默认语言与当前语言 
		 * @param defaultLan
		 * @param currentLan
		 * 
		 */		
		private function selectLanguage(defaultLan:String,currentLan:String):void {
			this.defaultLanguage=defaultLan;
			if(StringTWLUtil.isEmpty(currentLan)){
				this.language=this.defaultLanguage;
			}else{
				this.language=currentLan;
			}
		}
		
		//*********************************单例模式*************************************
		private static var _instance : Localizator;
		
		public function Localizator() {
			languageMap=new HashMap();
		}
		
		public static function getInstance():Localizator {
			if (_instance == null) {
				_instance = new Localizator();
			}
			return _instance;
		}
	}
}
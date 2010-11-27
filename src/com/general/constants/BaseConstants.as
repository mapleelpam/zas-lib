package com.general.constants
{
	import de.polygonal.ds.HashMap;
	
	public class BaseConstants
	{

		
		public var protocal_model:HashMap;
		
		public function setProtocolClassPath(protocal:uint,mPath:String):void{
			if(protocal_model.containsKey(protocal)){
				protocal_model.update(protocal,mPath);
			}else{
				protocal_model.insert(protocal,mPath);
			}
		}
		
		public function getModelPath(protocal:uint):String{
			return protocal_model.find(protocal)+"";
		}
		
		private static var instance:BaseConstants;
		
		public static function getInstance():BaseConstants{
			if(instance==null){
				instance=new BaseConstants();
			}
			return instance;
		}
		
		public function BaseConstants()
		{
			protocal_model=new HashMap();
		}

	}
}
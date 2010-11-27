package com.zillians.common.utilities
{
	
	import com.zillians.common.UUID;
	import com.zillians.protocol.ProtocolBase;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	public class ByteArrayUtils
	{
		/**
		 * 把 ByteArray转换成对象
		 * @param bt
		 * @param model_class_path 需要转成的对象
		 * @return 
		 * 
		 */				
		public static function convertByteArrayToObject(bt:ByteArray,model_class_path:String):*{
			var returnVal:ProtocolBase=ObjectTWLUtils.getClassByName(model_class_path);
			trace(" toObject - size "+bt.length);
			for each(var o:Object in returnVal.fieldSequence){
				trace( "ByteArrayUtils::toObject "+o.t+"");
				if(StringTWLUtil.equals(ProtocolBase.field_type_string,o.t+"")){
					var strLength:uint = bt.readInt();
					var strBytes:ByteArray = new ByteArray();
					strBytes.endian = Endian.LITTLE_ENDIAN;
					bt.readBytes( strBytes, 0, strLength );
					returnVal[o.n]=strBytes.toString();
				} else if(StringTWLUtil.equals(ProtocolBase.field_type_uuid,o.t+"")){
					var uuid:UUID = new UUID();
					bt.readBytes( uuid,0,16);
					returnVal[o.n]=uuid;
				} else if(StringTWLUtil.equals(ProtocolBase.field_type_param,o.t+"")){
					
					var length:uint = bt.readUnsignedByte();
					var param:ByteArray = new ByteArray();
					bt.readBytes( param, 0, length );
					returnVal[o.n] = param;
				}else{
					returnVal[o.n]=bt[ProtocolBase[o.t+"_decode"]]();
				}
			}
			return returnVal;
		}
		
		/**
		 * 把对象加入到 ByteArray中
		 * @param bt
		 * @param model
		 * @return 
		 * 
		 */		
		public static function convertObjectToByteArray(bt:ByteArray,model:ProtocolBase):ByteArray{
				
			for each(var o:Object in model.fieldSequence){
				if(StringTWLUtil.equals(ProtocolBase.field_type_string,o.t+"")){
					bt.writeInt(String(model[o.n]).length);
					bt.writeMultiByte(model[o.n],"utf8");
				} else 	if(StringTWLUtil.equals(ProtocolBase.field_type_param,o.t+"")){
					bt.writeInt(model[o.n].length);
					bt.writeBytes(model[o.n]);
				}else{
					bt[ProtocolBase[o.t+"_encode"]](model[o.n]);
				}
			}
			return bt;
		}

	}
}
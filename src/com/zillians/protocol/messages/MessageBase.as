package com.zillians.protocol.messages
{
	
	public class MessageBase
	{
		public static const field_type_string:String="field_type_string";
		public static const field_type_string_encode:String="writeMultiByte";
		public static const field_type_string_decode:String="readMultiByte";
		
		public static const field_type_uuid:String="field_type_uuid";
		public static const field_type_uuid_encode:String="writeBytes";
		public static const field_type_uuid_decode:String="readBytes";
		
		public static const field_type_param:String="field_type_para";
		public static const field_type_param_encode:String="writeBytes";
		public static const field_type_param_decode:String="readBytes";
		
		public static const field_type_int:String="field_type_int";
		public static const field_type_int_encode:String="writeInt";
		public static const field_type_int_decode:String="readInt";		
		
		
		public static const field_type_uint:String="field_type_uint";
		public static const field_type_uint_encode:String="writeUnsignedInt";
		public static const field_type_uint_decode:String="readUnsignedInt";		
		
		// 加入 vector 实现
		public static const field_type_vector:String="field_type_vector";
		public static const field_type_vector_encode:String="writeVector";
		public static const field_type_vector_decode:String="readVector";
		
		
		public function addStringField(fName:String):void{
			fieldSequence_value.push({n:fName,t:field_type_string});
		}
		public function addUUIDField(fName:String):void{
			fieldSequence_value.push({n:fName,t:field_type_uuid});
		}
		public function addIntField(fName:String):void{
			fieldSequence_value.push({n:fName,t:field_type_int});
		}
		public function addUIntField(fName:String):void{
			fieldSequence_value.push({n:fName,t:field_type_uint});
		}
		
		public function addParamField(fName:String):void{
			fieldSequence_value.push({n:fName,t:field_type_param});
		}
		
		public function addVectorField(fName:String):void {
			fieldSequence_value.push({n:fName,t:field_type_vector});
		}
		
		public function MessageBase()
		{
			fieldSequence_value=new Array();
		}
		
		private var fieldSequence_value:Array;
		
		public function get fieldSequence():Array{
			return fieldSequence_value;
		}
		
		public function set fieldSequence(fieldSequence:Array):void{
			fieldSequence_value=fieldSequence;
		}
		
	}
}

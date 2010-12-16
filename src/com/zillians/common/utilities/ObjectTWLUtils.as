
package com.zillians.common.utilities
{
import flash.net.registerClassAlias;
import flash.utils.ByteArray;
import flash.utils.describeType;
import flash.utils.getDefinitionByName;
import flash.utils.getQualifiedClassName;

public class ObjectTWLUtils
{
	public static function getClassPath(source:*):String{
		return getQualifiedClassName(source);
	}
	
	public static function getClassName(source:*):String{
		var typeName:String = getQualifiedClassName(source);
        var clzName:String = typeName.split("::")[0];
        return clzName;
	}
	
	public static function getClassByName(clzName:String):*{
        var packageName:String = clzName.split("::")[1];
        var type:Class = Class(getDefinitionByName(clzName));
        registerClassAlias(packageName, type);
        var returnModel:*=new type();
        return returnModel;
	}
	
	public static function baseClone(source:*):*{
		var typeName:String = getQualifiedClassName(source);
        var packageName:String = typeName.split("::")[1];
        var type:Class = Class(getDefinitionByName(typeName));

        registerClassAlias(packageName, type);
        
        var copier:ByteArray = new ByteArray();
        copier.writeObject(source);
        copier.position = 0;
        return copier.readObject();
	}
	
	/**
	 * 判断属性名是否是类的一个属性
	 * @param source 检测的对象
	 * @param fieldName 属性名
	 * @return 
	 * 
	 */	
	public static function isClassIsProperty(source:*,fieldName:String):Boolean{
		var typeName:String = getQualifiedClassName(source);
		var packageName:String = typeName.split("::")[1];
        var type:Class = Class(getDefinitionByName(typeName));
        registerClassAlias(packageName, type);
        var tmp:*=new type();
        //得到属性
	    var instanceInfo:XML = describeType(type);
		var properties:XMLList = instanceInfo..accessor.(@access!="readonly") + instanceInfo..variable;
		for each (var propertyInfo:XML in properties) {
			var propertyName:String = propertyInfo.@name;
			if(StringTWLUtil.equals(propertyName,fieldName)){
				return true;
			}
		}
		return false;
	}
	
	public static function isEquals(sOne:*,sTwo:*):Boolean{
		var typeNameOne:String = getQualifiedClassName(sOne);
		var typeNameTwo:String = getQualifiedClassName(sTwo);
		trace(typeNameOne);
		trace(typeNameTwo);
		if(!StringTWLUtil.equals(typeNameOne,typeNameTwo)){
			return false;
		}
		if(isNumber(sOne)||isBoolean(sOne)){
			//如果是数字
			return sOne==sTwo;
		}else if(isString(sOne)){
			return StringTWLUtil.equals(sOne,sTwo);
		}else if(StringTWLUtil.hasSubString(typeNameOne,"::")){
			trace("is object");
			//是对象
			var packageName:String = typeNameOne.split("::")[1];
	        var type:Class = Class(getDefinitionByName(typeNameOne));
	        registerClassAlias(packageName, type);
	        var tmp:Object=new type();
	        //得到属性
	        var instanceInfo:XML = describeType(type);
			var properties:XMLList = instanceInfo..accessor.(@access!="readonly") + instanceInfo..variable;
			for each (var propertyInfo:XML in properties) {
				var propertyName:String = propertyInfo.@name;
				if(!isEquals(sOne[propertyName],sTwo[propertyName])){
					return false;
				}
			}
			return true;
		}else{
			return false;
		}
	}
	
	/**
	 * Checks wherever passed-in value is <code>String</code>.
	 */
	public static function isString(value:*):Boolean {
		return ( typeof(value) == "string" || value is String );
	}
	
	/**
	 * Checks wherever passed-in value is <code>Number</code>.
	 */
	public static function isNumber(value:*):Boolean {
		return ( typeof(value) == "number" || value is Number );
	}

	/**
	 * Checks wherever passed-in value is <code>Boolean</code>.
	 */
	public static function isBoolean(value:*):Boolean {
		return ( typeof(value) == "boolean" || value is Boolean );
	}

	/**
	 * Checks wherever passed-in value is <code>Function</code>.
	 */
	public static function isFunction(value:*):Boolean {
		return ( typeof(value) == "function" || value is Function );
	}

	
}
}
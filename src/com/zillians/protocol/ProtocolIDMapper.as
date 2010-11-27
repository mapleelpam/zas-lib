package com.zillians.protocol
{
	import de.polygonal.ds.HashMap;
	import com.zillians.Protocols;
	import com.zillians.protocol.messages.*;
	import com.zillians.common.utilities.ObjectTWLUtils;
	
	public class ProtocolIDMapper
	{		
		public var protocal_model:HashMap;
		
		public function setProtocolClassPath(protocal:uint,protocolClassPath:String):void{
			if(protocal_model.containsKey(protocal)){
				protocal_model.update(protocal,protocolClassPath);
			}else{
				protocal_model.insert(protocal,protocolClassPath);
			}
		}
		
		public function getProtocolClassPath(protocal:uint):String{
			return protocal_model.find(protocal)+"";
		}
		
		private static var instance:ProtocolIDMapper;
		public static function getInstance():ProtocolIDMapper{
			if(instance==null){
				instance=new ProtocolIDMapper();
				instance.registProtocolsToModle();	
			} 
			return instance;
		}
		
		public function ProtocolIDMapper()
		{
			protocal_model=new HashMap();
		}

		private function registProtocolsToModle():void
		{
			setProtocolClassPath(
				Protocols.MsgAuthResponse
				,ObjectTWLUtils.getClassPath(MsgAuthResponse));
			setProtocolClassPath(
				Protocols.ClientCreateServiceTokenResponseMsg
				,ObjectTWLUtils.getClassPath(ClientCreateServiceTokenResponseMsg));
			setProtocolClassPath(
				Protocols.ClientServiceOpenResponseMsg
				,ObjectTWLUtils.getClassPath(ClientServiceOpenResponseMsg));
			setProtocolClassPath(
				Protocols.ClientRemoteProcedureCallMsg
				,ObjectTWLUtils.getClassPath(ClientRemoteProcedureCallMsg));
			
			/*TODO: others? only need to map from server ? */
		}
	}
}
package com.zillians.protocol
{
	public class ProtocolID
	{
		public static const AUTH_REQUEST_MSG:uint = 0x0B;
		public static const AUTH_RESPONSE_MSG:uint = 0x0C;
		public static const CLIENT_CREATE_TOKEN_REQUEST_MSG:uint	= 0x0D;
		public static const CLIENT_CREATE_TOKEN_RESPONSE_MSG:uint= 0x0E;
		public static const CLIENT_SERVICE_OPEN_REQUEST_MSG:uint	= 0x0F;
		public static const CLIENT_SERVICE_OPEN_RESPONSE_MSG:uint	= 0x10;
		public static const CLIENT_RPC_MSG:uint	= 0x17;
		public static const CLEINT_OBJECT_UPDATE_MSG:uint = 0x1C;
	}
}
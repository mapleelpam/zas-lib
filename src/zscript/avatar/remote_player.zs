
package RemotePlayer
{
	@client
	function remoteTryMove( var ID:uint32, var x:uint32, var y:uint32):void;
	
	@client
	function remoteLogout( var ID:uint32 ):void;

	@client
	function remoteChangeAvatar( var ID:uint32, var avatar_id:uint32):void;
	
	@client
	function remoteLogin( var ID:uint32 ):void;
	
	@client
	function remoteChangeDirection( var ID:uint32, var dir:uint32 ):void;
}

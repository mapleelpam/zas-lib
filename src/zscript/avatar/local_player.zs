
package local_player
{
	import zillians.api.debug.*;
	import remote_player.*;


	object PlayerObject
	{
		var posX:uint32;
		var posY:uint32;
		var id:uint32;
	}

	object GlobalGameObject
	{
		var p1	:PlayerObject;
		var p2	:PlayerObject;
		var p3	:PlayerObject;
		var p4	:PlayerObject;
	}

	@handler { handle="SessionOpen"; }	
	function doSessionOpen():void
	{
		var global_object:GlobalGameObject;
		var player_object:PlayerObject;

		if( global == null ) {
			global_object = new GlobalGameObject;
			global = global_object;

			global_object . p1 = null;
			global_object . p2 = null;
		}
		global_object = cast( global, GlobalGameObject );

		if( global_object . p1 == null ) {
			player_object = global_object . p1 = new PlayerObject;
                        self = global_object . p1;
			registerID( 1 );
		} else if( global_object . p2 == null ) {
			player_object = global_object . p2 = new PlayerObject;
                        self = global_object . p2; 
			registerID( 2 );
		} else if( global_object . p3 == null ) {
			player_object = global_object . p3 = new PlayerObject;
                        self = global_object . p3; 
			registerID( 3 );
		} else if( global_object . p4 == null ) {
			player_object = global_object . p4 = new PlayerObject;
                        self = global_object . p4; 
			registerID( 4 );
		} else {
			puts(" user register nothing ");
		}

		

		if( global_object . p1 != null && global_object . p1 != self ) {
			@target{ id =  global_object . p1; }
			remoteLogin( player_object.id);
		} else if( global_object . p2 != null && global_object . p2 != self  ) {
			@target{ id =  global_object . p2; }
			remoteLogin( player_object.id);
		} else if( global_object . p3 != null && global_object . p3 != self  ) {
			@target{ id =  global_object . p3; }
			remoteLogin( player_object.id);
		} else if( global_object . p4 != null && global_object . p4 != self  ) {
			@target{ id =  global_object . p4; }
			remoteLogin( player_object.id);
		} else {
			puts(" user register nothing ");
		}

	}


	@handler { handle="SessionClose"; }
	function doSessionClose():void
	{
		var global_object:GlobalGameObject;
		var remove_id:uint32 = 0; 
		global_object = cast( global, GlobalGameObject );
		if( global_object . p1 != null && global_object . p1 == self ) {
			remove_id = 1;
		//	delete global_object.p1;
			global_object.p1 = null;
		}else if( global_object . p2 != null && global_object . p2 == self ) {
			remove_id = 2;
		//	delete global_object.p1;
			global_object.p1 = null;
		}else if( global_object . p3 != null && global_object . p3 == self ) {
			remove_id = 3;
		//	delete global_object.p1;
			global_object.p1 = null;
		}else if( global_object . p4 != null && global_object . p4 == self ) {
			remove_id = 4;
		//	delete global_object.p1;
			global_object.p1 = null;
		}

		if( global_object . p1 != null && global_object . p1 != self ) {
			@target{ id =  global_object . p1; }
			remoteLogin( remove_id );
		}else if( global_object . p2 != null && global_object . p2 != self ) {
			@target{ id =  global_object . p2; }
			remoteLogin( remove_id );
		}else if( global_object . p3 != null && global_object . p3 != self ) {
			@target{ id =  global_object . p3; }
			remoteLogin( remove_id );
		}else if( global_object . p4 != null && global_object . p4 != self ) {
			@target{ id =  global_object . p4; }
			remoteLogin( remove_id );
		}
		
	}

	@server
	function tryMove( var x:uint32, var y:uint32):void
	{
		var global_object:GlobalGameObject;
		var remove_id:uint32 = 0; 
		global_object = cast( global, GlobalGameObject );
		if( global_object . p1 != null && global_object . p1 == self ) {
			remove_id = 1;
		}else if( global_object . p2 != null && global_object . p2 == self ) {
			remove_id = 2;
		}else if( global_object . p3 != null && global_object . p3 == self ) {
			remove_id = 3;
		}else if( global_object . p4 != null && global_object . p4 == self ) {
			remove_id = 4;
		}

		if( global_object . p1 != null && global_object . p1 != self ) {
			@target{ id =  global_object . p1; }
			remoteTryMove( remove_id, x, y );
		}else if( global_object . p2 != null && global_object . p2 != self ) {
			@target{ id =  global_object . p2; }
			remoteTryMove( remove_id, x, y );
		}else if( global_object . p3 != null && global_object . p3 != self ) {
			@target{ id =  global_object . p3; }
			remoteTryMove( remove_id, x, y );
		}else if( global_object . p4 != null && global_object . p4 != self ) {
			@target{ id =  global_object . p4; }
			remoteTryMove( remove_id, x, y );
		}
	}

	@client
	function registerID( var ID:uint32 ):void;

	@server
	function changeAvatarID( var id:uint32 ):void
	{
		var global_object:GlobalGameObject;
		var remove_id:uint32 = 0; 
		global_object = cast( global, GlobalGameObject );
		if( global_object . p1 != null && global_object . p1 == self ) {
			remove_id = 1;
		}else if( global_object . p2 != null && global_object . p2 == self ) {
			remove_id = 2;
		}else if( global_object . p3 != null && global_object . p3 == self ) {
			remove_id = 3;
		}else if( global_object . p4 != null && global_object . p4 == self ) {
			remove_id = 4;
		}

		if( global_object . p1 != null && global_object . p1 != self ) {
			@target{ id =  global_object . p1; }
			remoteChangeAvatar( remove_id, id );
		}else if( global_object . p2 != null && global_object . p2 != self ) {
			@target{ id =  global_object . p2; }
			remoteChangeAvatar( remove_id, id );
		}else if( global_object . p3 != null && global_object . p3 != self ) {
			@target{ id =  global_object . p3; }
			remoteChangeAvatar( remove_id, id );
		}else if( global_object . p4 != null && global_object . p4 != self ) {
			@target{ id =  global_object . p4; }
			remoteChangeAvatar( remove_id, id );
		}
	}
	
	@server
	function tryChangeDirection( var dir:uint32 ):void
	{
		var global_object:GlobalGameObject;
		var remove_id:uint32 = 0; 
		global_object = cast( global, GlobalGameObject );
		if( global_object . p1 != null && global_object . p1 == self ) {
			remove_id = 1;
		}else if( global_object . p2 != null && global_object . p2 == self ) {
			remove_id = 2;
		}else if( global_object . p3 != null && global_object . p3 == self ) {
			remove_id = 3;
		}else if( global_object . p4 != null && global_object . p4 == self ) {
			remove_id = 4;
		}

		if( global_object . p1 != null && global_object . p1 != self ) {
			@target{ id =  global_object . p1; }
			remoteChangeDirection( remove_id, dir );
		}else if( global_object . p2 != null && global_object . p2 != self ) {
			@target{ id =  global_object . p2; }
			remoteChangeDirection( remove_id, dir );
		}else if( global_object . p3 != null && global_object . p3 != self ) {
			@target{ id =  global_object . p3; }
			remoteChangeDirection( remove_id, dir );
		}else if( global_object . p4 != null && global_object . p4 != self ) {
			@target{ id =  global_object . p4; }
			remoteChangeDirection( remove_id, dir);
		}
	}
}

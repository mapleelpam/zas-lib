
/** /page Tut-1 Tutorial (2)

**/

/// @cond
package testzs
/// @endcond
{
	import zillians.api.debug.*;

	// To-be-self
	object gamePlayer
	{
		var pid:int32;
	}

	// To-be-global
	object gameGlobal
	{
		var af:bool;
		var ag:gamePlayer;
		var bf:bool;
		var bg:gamePlayer;
		var cf:bool;
		var cg:gamePlayer;
		var df:bool;
		var dg:gamePlayer;
	}


	@handler { handle="SessionOpen"; }
	function doSessionInit():void
	{
		var p:gamePlayer;
		var gg:gameGlobal;

		if( (global != null) )
		{
			puts("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ No GameInit");
			gg = cast(global, gameGlobal);
		}
		else
		{
			puts("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$GameInit");
			// GameInit
			gg = new gameGlobal;
			gg.af = false;
			gg.bf = false;
			gg.cf = false;
			gg.df = false;
			global = gg;
		}
		
		// Session init start here
		if(gg.af == false)// Problem, if two player reach here at the same time, there may be a race condition
		{
			gg.af = true;
			p = new gamePlayer;
			p.pid = 1;
			gg.ag = p;
			self = gg.ag;
			setPlayer(1);
			puts("Assign new player as player 1");
		}
		else if(gg.bf == false)
		{
			gg.bf = true;
			p = new gamePlayer;
			p.pid = 2;
			gg.bg = p;
			self = gg.bg;
			setPlayer(2);
			puts("Assign new player as player 2");
		}
		else if(gg.cf == false)
		{
			gg.cf = true;
			p = new gamePlayer;
			p.pid = 3;
			gg.cg = p;
			self = gg.cg;
			setPlayer(3);
			puts("Assign new player as player 3");
		}
		else if(gg.df == false)
		{
			gg.df = true;
			p = new gamePlayer;
			p.pid = 4;
			gg.dg = p;
			self = gg.dg;
			setPlayer(4);
			puts("Assign new player as player 4");
		}
		else
		{
			setPlayer(0);
			puts("No place for the new player");
		}
	}

	@handler { handle="SessionClose"; }
	function doSessionKill():void
	{
		var p:gamePlayer;
		var gg:gameGlobal;
		puts("doSessionKill() called");
		if(global instanceof gameGlobal)
		{
			gg = cast(global, gameGlobal);
		}
		else
		{
			return;
		}
	
		if(self instanceof gamePlayer)
		{
			p = cast(self, gamePlayer);
			if(p.pid == 1)
			{
				gg.af = false;
				puts("Player 1 left");
			}
			else if(p.pid == 2)
			{
				gg.bf = false;
				puts("Player 2 left");
			}
			else if(p.pid == 3)
			{
				gg.cf = false;
				puts("Player 3 left");
			}
			else if(p.pid == 4)
			{
				gg.df = false;
				puts("Player 4 left");
			}
		}
		else
		{
			puts("Player left");
			return;
		}
	}

	// pos: 1, 2, 3, 4 for a, b, c, d; 0 for fail
	@client
	function setPlayer(var pos:int32):void;

	@server
	function sayHelloTo(var player:int32):void
	{
		//puts("sayHelloTo()");
		var from:int32;
		var targetPlayer:gamePlayer;
		var gg:gameGlobal;
		var p:gamePlayer;
		
		if(global instanceof gameGlobal)
		//if(global != null)
		{
			//puts("found global");
			gg = cast(global, gameGlobal);
		}
		else
		{
			puts("ERROR : global not found ");
			return;
		}
		if(self instanceof gamePlayer)
		{
			//puts("found self");
			p = cast(self, gamePlayer);
		}
		else
		{
			puts("ERROR : self not found ");
			return;
		}

		if((player == 1) && (gg.af))
		{
			//puts("target == player1");
			targetPlayer = gg.ag;	
		}		
		else if((player == 2) && (gg.bf))
		{
			//puts("target == player2");
			targetPlayer = gg.bg;	
		}
		else if((player == 3) && (gg.cf))
		{
			//puts("target == player3");
			targetPlayer = gg.cg;	
		}
		else if((player == 4) && (gg.df))
		{
			//puts("target == player4");
			targetPlayer = gg.dg;	
		}
		else
		{
			//puts("call cantHearYou()");
			cantHearYou(player);
			return;
		}
		from = p.pid;
		@target { id = targetPlayer; } hearHello(from);
	
	}

	@client
	function cantHearYou(var he:int32):void;

	@client
	function hearHello(var from:int32):void;

/// @cond
}
/// @endcond


package demo.avatar
{
	import flash.display.*;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	import flashx.textLayout.formats.Float;
	
	import generated.avatar.LocalPlayer;
	
	import mx.collections.*;
	import mx.controls.Label;
	import mx.controls.TextArea;
	import mx.core.*;
	
	import spark.components.Application;

	public class GameObjectManager
	{
		//double buffer
		public var backBuffer:BitmapData;
		//colour to use to clear backbuffer with
		public var clearColor:uint=0x548B54;
		//static instance
		protected static var instance:GameObjectManager = null;
		//the last frame time
		protected var lastFrame:Date;
		
		
		/** 玩家控制的当前英雄 */
		private	var	currentPlayer:Hero = new Hero(9999);
		
		/** 网络上其他游戏玩家的英雄 */
		private	var networkPlayers:Dictionary = new Dictionary();
		
		private var logText:TextArea = null;
		
		
		//游戏信息参数========================================
		private var textBar:TextField	= new TextField();
		private var textBarMa:Matrix	= new Matrix();
		private var fps:uint			= 0;
		
		private var netEventTimer:Timer	= null;
		
		
		
		static public function get Instance():GameObjectManager
		{
			if(instance == null)
				instance = new GameObjectManager();
			return instance;
		}
		
		public function set LogText( textArea:TextArea ):void {
			this.logText = textArea;
		}
		
		//服务器通信接口=======================================
		public function registerID ( id:uint ):void {
			currentPlayer.ID = id;
			netEventTimer.start();
		}
		
		public function remoteLogin ( id:uint ):void {
			addNetworkPlayer ( id );
		}
		
		public function remoteLogout ( id:uint ):void {
			deleteNetworkPlayer ( id );
		}
		
		public function remoteTryMove ( id:uint, x:uint, y:uint ):void {
			var h:Hero = networkPlayers[id];
			h.moveToXY(x, y);
		}
		
		public function remoteChangeDirection ( id:uint, dir:uint ):void {
			var h:Hero = networkPlayers[id];
			h.dir = dir;
		}
		
		public function remoteChangeAvatar ( id:uint, avatar_id:uint ):void {
			var h:Hero = networkPlayers[id];
			h.Avatar_id = avatar_id;
		}
		
		
		//公有方法
		public function changeAvatarID ( id:uint ):void {
			currentPlayer.Avatar_id = id;
			LocalPlayer.changeAvatarID(id);
		}
		
		
		//游戏基本控制流程=======================================
		public function GameObjectManager()
		{
			if(instance != null)
				throw new Error("Only one Singleton instance should be instantiated");
			backBuffer = new BitmapData(FlexGlobals.topLevelApplication.width ,
				FlexGlobals.topLevelApplication.height,false);

			
			netEventTimer = new Timer(20);
			netEventTimer.addEventListener(TimerEvent.TIMER, onNetEventTimer);
			
			
			textBarMa.scale(2,2);
			textBarMa.translate(300,350);
			
		}
		public function startup():void
		{
			lastFrame = new Date();
		}
		public function shutdown():void
		{
			if ( netEventTimer.running ) {
				netEventTimer.stop();
			}
			
		}
		public function enterFrame():void
		{
			//Calculate the time since the last frame
			var thisFrame:Date=new Date();
			
			var time:Number = thisFrame.getTime() - lastFrame.getTime();
			fps ++;
			if ( time >= 1000 ) {
				textBar.text = "FPS:" + fps;
				lastFrame = thisFrame;
				fps = 0;
			}
			
			logicLoop();
			
			drawObjects();

		}
		
		
		
		
		//私有方法=======================================
		
		private function logicLoop ():void {
			currentPlayer.doLoop();

		}
		private function onNetEventTimer( e:Event ):void {
			LocalPlayer.tryMove(currentPlayer.x, currentPlayer.y);
		}
		
		
		
		
		
		protected function drawObjects():void {
			backBuffer.fillRect(backBuffer.rect,clearColor);
			
			
			
			
			backBuffer.draw(textBar,textBarMa);
			
			for each ( var h:Hero in networkPlayers ) {
				backBuffer.draw( h.Display, h.Loaction );
			}
			
			backBuffer.draw( currentPlayer.Display, currentPlayer.Loaction );
		}
		
		private function addNetworkPlayer ( id:uint ):void {
			var newHero:Hero = new Hero( id );
			networkPlayers[id] = newHero;
		}
		
		private function deleteNetworkPlayer ( id:uint ):void {
			var h:Hero = networkPlayers[id];
			if ( h == null ) {
				trace("###没有找到要删除的英雄：" + id );
			}
			
			delete networkPlayers[id];networkPlayers
			
		}
		
		
		
		//事件响应=======================================
		public function onKeyDown( e:KeyboardEvent ):void {
			if ( e.keyCode == Keyboard.UP ) {
				currentPlayer.dir = Direction.UP;
				currentPlayer.moveable = true;
				LocalPlayer.tryChangeDirection( currentPlayer.dir );
			}
			else if ( e.keyCode == Keyboard.RIGHT ) {
				currentPlayer.dir = Direction.RIGHT;
				currentPlayer.moveable = true;
				LocalPlayer.tryChangeDirection( currentPlayer.dir );
			}
			else if ( e.keyCode == Keyboard.DOWN ) {
				currentPlayer.dir = Direction.DOWN;
				currentPlayer.moveable = true;
				LocalPlayer.tryChangeDirection( currentPlayer.dir );
			}
			else if ( e.keyCode == Keyboard.LEFT ) {
				currentPlayer.dir = Direction.LEFT;
				currentPlayer.moveable = true;
				LocalPlayer.tryChangeDirection( currentPlayer.dir );
			}
		}
		
		public function onKeyUp ( e:KeyboardEvent ):void {
			
			
			if ( e.keyCode == Keyboard.UP
				&& currentPlayer.dir == Direction.UP ) {
				currentPlayer.moveStop();
			}
			else if ( e.keyCode == Keyboard.RIGHT
				&& currentPlayer.dir == Direction.RIGHT ) {
				currentPlayer.moveStop();
			}
			else if ( e.keyCode == Keyboard.DOWN
				&& currentPlayer.dir == Direction.DOWN ) {
				currentPlayer.moveStop();
			}
			else if ( e.keyCode == Keyboard.LEFT
				&& currentPlayer.dir == Direction.LEFT ) {
				currentPlayer.moveStop();
			}
		}
	} 
}
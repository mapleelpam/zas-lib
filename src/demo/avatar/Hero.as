package demo.avatar
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.IBitmapDrawable;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	/**
	 * 英雄类
	 * @author merlyle, flreey
	 * 
	 */	
	public class Hero extends Sprite {
		
		//静态属性================================
		/** 英雄移动速度，单位：像素每帧 */
		private static var _SPEED:uint = 2;
		/** 英雄动画每帧显示时间，单位ms */
		private static var frameTime:uint		= 200; 
		
		
		//英雄属性================================
		private	var id:uint;
		private	var avatar_id:uint = 0;
		
		
		
		//英雄状态================================
		public	var dir:uint = Direction.DOWN;
		
		/** 英雄移动状态标志 */
		public var moveable:Boolean = false;
		
		
		/** 当前要显示的帧序列数，移动时从 frameArr 取得 */
		private var currentFrame:uint = 0;
		
		/** 英雄移动时帧序列的显示顺序 */
		private var frameArr:Array = new Array(0,1,2,1);
		/** frameArr 定位下标 */
		private	var frameArrIndex:uint = 0;
		
		
		//控制显示================================
		/** 要显示的英雄位图，从 imgManager 获得 */
		private var display:Bitmap = null;
		
		/** 要显示的英雄位置 */
		private var loaction:Matrix = new Matrix();
		
		
		//内部变量================================
		private var lastFrameTime:Date	= new Date();
		private var lastMoveTime:Date	= new Date();
		private static var avatarSkin:AvatarSkin = new AvatarSkin();
		
		
		public function Hero( id:uint ) {
			super();
			this.id = id;
		}
		
		//公有方法================================
		
		public function doLoop():void {
			doMove();
			
		}
		
		public function moveStop():void {
			currentFrame = 1;
			frameArrIndex = 1;
			moveable = false;
		}
		
		public function get Display():Bitmap {
			if ( moveable == true ) {
				doChangeFrame();//移动状态执行帧变换
			}
			display = avatarSkin.getImage(avatar_id, dir, currentFrame);
			return display;
		}
		
		public function get Loaction():Matrix {
			loaction.tx = x;
			loaction.ty = y;
			return loaction;
		}
		
		public function moveToXY ( x:uint, y:uint ):void {
//			if ( this.x != x || this.y != y ) {
//				moveable = true;
				this.x = x;
				this.y = y;
				doChangeFrame();
//			}
//			else if ( moveable == true ) {
//				moveable = false;
//				var thisMoveTime:Date=new Date();
//				
//				
//				var time:Number = thisMoveTime.getTime() - lastMoveTime.getTime();
//				if ( time >= frameTime ) {
//					
//					lastMoveTime = thisMoveTime;
//				}
//			}
			
		}
		
		
		//私有方法================================
		

		
		private function doMove():void {
			if ( !moveable ) {
				return;
			}
			switch (dir) {
				case Direction.UP:
					y -= _SPEED;
					break;
				case Direction.RIGHT:
					x += _SPEED;
					break;
				case Direction.DOWN:
					y += _SPEED;
					break;
				case Direction.LEFT:
					x -= _SPEED;
					break;
				default:break;
			}
			
		}
		
		private function doChangeFrame():Boolean {
			var thisFrameTime:Date=new Date();
			
			
			var time:Number = thisFrameTime.getTime() - lastFrameTime.getTime();
			if ( time >= frameTime ) {
				frameArrIndex = ( ++frameArrIndex )%frameArr.length;
				currentFrame = frameArr[frameArrIndex];
				lastFrameTime = thisFrameTime;
				return true;
			}
			return false;
		}

		public function get Avatar_id():uint
		{
			return avatar_id;
		}

		public function set Avatar_id(value:uint):void
		{
			avatar_id = value;
		}

		public function get ID():uint
		{
			return id;
		}

		public function set ID(value:uint):void
		{
			id = value;
		}
		
		
		
		
		
		
	}
}
package demo.avatar
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.IBitmapDrawable;
	import flash.display.Loader;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	import spark.primitives.BitmapImage;
	
	public class AvatarSkin
	{
		private var direc:int;	//1 left, 2 right, 3 up, 4 down
		private var h:int;
		private var w:int;
		private var image:Bitmap;
		private var loader:Loader = new Loader();
		private var objects:Sprite  = new Sprite();
		
		private static var instance:AvatarSkin = null;
		
		static public function get Instance():AvatarSkin
		{
			if(instance == null)
				instance = new AvatarSkin();
			return instance;
		}
		
		public function AvatarSkin()
		{
			var url:String = "avatar.png";
			var request:URLRequest = new URLRequest(url);
			trace("###" + request.url );
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, ldr_complete);
			
			loader.load(request);			
		}
		
		public function ldr_complete(e:Event):void
		{
			image = loader.content as Bitmap;
			w = image.width / 12;
			h = image.height / 8;
		}
		
		public function getImage(player:uint, dir:uint, num:uint): Bitmap 
		{			
			if (image == null)
			{
				return new Bitmap();
			}
			
			var ob:DisplayObject =  objects.getChildByName(player * 12 + dir * 3 + num + "");
			//objects.getChildAt(player * 12 + dir * 3 + num);
			if (ob != null)
			{
				var b:BitmapData = new BitmapData(w, h);	
				b.draw(ob);
				return new Bitmap(b);
			}
			else 
			{			
				var data:BitmapData = new BitmapData(w, h, false);
				var rect:Rectangle = new Rectangle();
				data.fillRect(new Rectangle(0,0,w,h), 0x548B54);
				rect.x = 0;
				rect.y = 0;
				rect.width = w;
				rect.height = h;
				var matrix:Matrix = new Matrix();
				if (player >= 0 && player < 4)
				{
					matrix.translate(-w * (num + player * 3), -h * dir);
				} 
				else if (player >= 4 && player <= 6)
				{
					matrix.translate(-w * ((num + (player - 4) * 3)), -h * dir - 4 * h);
				}
				data.draw(image, matrix, null, null, rect);		
				var sprite:Sprite = new Sprite();
				sprite.name = player * 12 + dir * 3 + num + "";
				sprite.addChild(new Bitmap(data));
				objects.addChild(sprite);
				return new Bitmap(data) ;
			}
		}
	}
}
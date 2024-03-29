package models.vo
{
	import flash.events.EventDispatcher;
	import flash.geom.Rectangle;
	import flash.media.Camera;
	import flash.media.Microphone;
	
	[Event(type="flash.events.Event",name="msgLengthChange")]
	
	[Bindable]
	public class UserVO extends EventDispatcher
	{
		public static var self:UserVO = new UserVO({av:(Camera.names.length?'1':'0')+(Microphone.names.length?'1':'0')});
		public static var all:UserVO = new UserVO({id:"all",name:"所有人",role:ALL,av:"00"});
		public static const ADMIN:int = 2;
		public static const ALL:int = 1;
		public static const GUEST:int = 0;
		public static const icons:Vector.<String> = function():Vector.<String>{
			var _icon:Vector.<String> = new Vector.<String>(3,true);
			_icon[GUEST] = "assets/user.png";
			_icon[ALL] = "assets/group.png";
			_icon[ADMIN] = "assets/user_suit.png";
			return _icon;
		}();
		
		public var id:String;
		public var name:String;
		public var ip:String;
		public var address:String;
		public var role:int;
		public var groupAddress:String;
		public var av:String;
//		public var messages:Vector.<ChatMsgVO> = new Vector.<ChatMsgVO>();
		public var windowRect:Rectangle;
		public function UserVO(o:Object=null)
		{
			for(var i:String in o){
				try{
					this[i] = o[i];
				}catch(e:Error){
					
				}
			}
		}
		public function hasVideo():Boolean{
			return av.charAt(0) == "1";
		}
		public function hasAudio():Boolean{
			return av.charAt(1) == "1";
		}
//		public function getMsgLength():int{
//			return messages.length;
//		}
		public function getIcon():String{
			return icons[role];
		}
		public function get toObject():Object{
			return {id:id,name:name,ip:ip,role:role,av:av};
		}
		public function get isSelf():Boolean{
			return id == self.id;
		}
	}
}
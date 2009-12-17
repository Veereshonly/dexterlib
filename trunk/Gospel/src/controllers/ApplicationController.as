package controllers
{
	
	import models.GospelModel;
	import models.LocalSetting;
	import models.vo.UserVO;
	
	import mx.controls.Alert;
	
	import views.ChangeNickWindow;
	import views.WaitWindow;

	public class ApplicationController
	{
		[DexterBinding]
		public var gospelModel:GospelModel;
		[DexterBinding]
		public var localSetting:LocalSetting;
		[DexterEvent]
		public function appStart():void{
			gospelModel.loadConfig();
			WaitWindow.wait("加载配置文件");
		}
		[DexterEvent]
		public function configComplete():void{
			WaitWindow.waitThingDone("加载配置文件");
			if(localSetting.autoLogin){
				login();
			}
		}
		[DexterEvent]
		public function enterRoom(room:XML,userName:String,pwd:String):void{
			localSetting.userName = userName;
			localSetting.pwd = pwd;
			localSetting.room = room.@code;
			if(pwd == room.@pwd){
				localSetting.role = UserVO.ADMIN;
				login();
			}else if(!pwd){
				localSetting.role = UserVO.GUEST;
				login();
			}else{
				Alert.show("密码错误！");
			}
		}
		private function login():void{
			WaitWindow.wait("进入房间");
			sendDexterEvent("ConnectServer");
		}
		[DexterEvent]
		public function changeNick(user:UserVO):void{
			ChangeNickWindow.show(user);
		}
	}
}
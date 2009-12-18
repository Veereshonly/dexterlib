package models
{
	
	import air.update.ApplicationUpdaterUI;
	
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import mx.collections.XMLListCollection;
	[Bindable]
	public class GospelModel
	{
		public const connectUrl:String = "rtmfp://stratus.adobe.com";
		public const developerKey:String = "39eb05e76eabb57deb96b56a-937bc372b0a4";
		public const configURL:String = "http://dexterlib.googlecode.com/files/config.xml";
		public const roomURL:String = "https://connectnow.acrobat.com/langhuihui/";
		public const appDesc:XML = NativeApplication.nativeApplication.applicationDescriptor;
		public const appUpdater:ApplicationUpdaterUI = new ApplicationUpdaterUI();
		public var statusBarText:String;
		public var roomList:XMLListCollection;
		public var selectedRoom:XML;
		public var serverAddr:String;
		public var helpURL:String;
		public function getVersion():String{
			return appDesc.children()[3];
		}
		public function loadConfig():void{
			new URLLoader(new URLRequest(configURL)).addEventListener(Event.COMPLETE,onConfigLoaded,false,0,true);
		}
		private function onConfigLoaded(event:Event):void{
			var config:XML = new XML(event.target.data);
			roomList = new XMLListCollection(config.roomList[0].children());
			new GospelUpdater(config.updateURL,getVersion());
			serverAddr = config.server;
			helpURL = config.helpURL;
		}
	}
}
package gltf;

typedef Asset = {
	>ChildOfRootProperty,

	@:optional var copyright:String;
	@:optional var generator:String;
	@:optional var premultipliedAlpha:Bool;
	@:optional var profile:AssetProfile;
	var version:String;
}
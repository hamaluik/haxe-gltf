package gltf;

import haxe.ds.StringMap;

@:enum
abstract CameraType(String) {
	var Orthographic = "orthographic";
	var Perspective = "perspective";
}

typedef OrthographicCamera = {
	>Property,
	var xmag:Float;
	var ymag:Float;
	var zfar:Float;
	var znear:Float;
}

typedef PerspectiveCamera = {
	>Property,
	@:optional var aspectRatio:Float;
	var yfov:Float;
	var zfar:Float;
	var znear:Float;
}

typedef Camera = {
	>ChildOfRootProperty,

	@:optional var orthographic:OrthographicCamera;
	@:optional var perspective:PerspectiveCamera;
	var type:CameraType;
}
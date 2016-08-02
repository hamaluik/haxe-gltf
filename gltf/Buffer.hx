package gltf;

import gltf.type.BufferType;

typedef Buffer = {
	>ChildOfRootProperty,

	var uri:String;
	@:optional var byteLength:Int;
	@:optional var type:BufferType;
}
package gltf;

import gltf.type.BufferType;

typedef BufferView = {
	>ChildOfRootProperty,

	var buffer:String;
	var byteOffset:Int;
	var byteLength:Int;
	@:optional var target:BufferType;
}
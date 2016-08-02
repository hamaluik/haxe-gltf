package gltf;

import gltf.type.BufferViewType;

typedef BufferView = {
	>ChildOfRootProperty,

	var buffer:String;
	var byteOffset:Int;
	var byteLength:Int;
	@:optional var target:BufferViewType;
}
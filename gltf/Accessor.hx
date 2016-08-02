package gltf;

import gltf.type.AccessorType;
import gltf.type.DataType;

typedef Accessor = {
	>ChildOfRootProperty,

	var bufferView:String;
	var byteOffset:Int;
	@:optional var byteStride:Int;
	var componentType:DataType;
	var count:Int;
	var type:AccessorType;
	@:optional var max:Array<Float>;
	@:optional var min:Array<Float>;
}
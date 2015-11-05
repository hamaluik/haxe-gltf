package gltf;

@:enum
abstract BufferType(String) {
	var ArrayBuffer = "ArrayBuffer";
	var Text = "Text";
}

typedef Buffer = {
	>ChildOfRootProperty,

	var uri:String;
	@:optional var byteLength:Int;
	@:optional var type:BufferType;
}
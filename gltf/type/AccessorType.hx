package gltf.type;

@:enum
abstract AccessorType(String) {
	var SCALAR = "SCALAR";
	var VEC2 = "VEC2";
	var VEC3 = "VEC3";
	var VEC4 = "VEC4";
	var MAT2 = "MAT2";
	var MAT3 = "MAT3";
	var MAT4 = "MAT4";
}
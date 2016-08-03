package gltf;

@:enum
abstract FilterType(Int) {
	var NEAREST = 9728;
	var LINEAR = 9729;
	var NEAREST_MIPMAP_NEAREST = 9984;
	var LINEAR_MIPMAP_NEAREST = 9985;
	var NEAREST_MIPMAP_LINEAR = 9986;
	var LINEAR_MIPMAP_LINEAR = 9987;
}

@:enum
abstract WrapMode(Int) {
	var CLAMP_TO_EDGE = 33071;
	var MIRRORED_REPEAT = 33648;
	var REPEAT = 10497;
}

typedef Sampler = {
	>ChildOfRootProperty,

	@:optional var magFilter:FilterType;
	@:optional var minFilter:FilterType;
	@:optional var wrapS:WrapMode;
	@:optional var wrapT:WrapMode;
}
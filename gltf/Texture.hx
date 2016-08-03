package gltf;

@:enum 
abstract TextureFormat(Int) {
	var ALPHA = 6406;
	var RGB = 6407;
	var RGBA = 6408;
	var LUMINANCE = 6409;
	var LUMINANCE_ALPHA = 6410;
}

@:enum 
abstract TextureTarget(Int) {
	var TEXTURE_2D = 3553;
}

@:enum 
abstract TexelDataType(Int) {
	var UNSIGNED_BYTE = 5121;
	var UNSIGNED_SHORT_5_6_5 = 33635;
	var UNSIGNED_SHORT_4_4_4_4 = 32819;
	var UNSIGNED_SHORT_5_5_5_1 = 32820;
}

typedef Texture = {
	>ChildOfRootProperty,

	@:optional var format:TextureFormat;
	@:optional var internalFormat:TextureFormat;
	var sampler:GLTFID;
	var source:GLTFID;
	@:optional var target:TextureTarget;
	@:optional var type:TexelDataType;
}
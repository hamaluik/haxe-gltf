package gltf.type;

/**
 * Values corresponding to WebGL enums
 */
@:enum
abstract DataType(Int) {
	var BYTE = 5120;
	var UNSIGNED_BYTE = 5121;
	var SHORT = 5122;
	var UNSIGNED_SHORT = 5123;
	var FLOAT = 5126;
	var FLOAT_VEC2 = 35664;
	var FLOAT_VEC3 = 35665;
	var FLOAT_VEC4 = 35666;
	var INT_VEC2 = 35667;
	var INT_VEC3 = 35668;
	var INT_VEC4 = 35669;
	var BOOL = 35670;
	var BOOL_VEC2 = 35671;
	var BOOL_VEC3 = 35672;
	var BOOL_VEC4 = 35673;
	var FLOAT_MAT2 = 35674;
	var FLOAT_MAT3 = 35675;
	var FLOAT_MAT4 = 35676;
	var SAMPLER_2D = 35678;
}
package gltf.type;

/**
 * Values corresponding to WebGL states
 */
@:enum
abstract StateType(Int) {
	var BLEND = 3042;
	var CULL_FACE = 2884;
	var DEPTH_TEST = 2929;
	var POLYGON_OFFSET_FILL = 32823;
	var SAMPLE_ALPHA_TO_COVERAGE = 32926;
	var SCISSOR_TEST = 3089;
}
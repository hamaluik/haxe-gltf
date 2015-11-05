package gltf;

import haxe.ds.StringMap;

typedef TechniqueParameters = {
	>Property,

	var count:Int;
	var node:GLTFID;
	var type:gltf.type.DataType;
	var semantic:String;
	var value:Dynamic;
}

@:enum
abstract BlendEquationType(Int) {
	var FUNC_ADD = 32774;
	var FUNC_SUBTRACT = 32778;
	var FUNC_REVERSE_SUBTRACT = 32779;
}

@:enum
abstract BlendFunctionType(Int) {
	var ZERO = 0;
	var ONE = 1;
	var SRC_COLOR = 768;
	var ONE_MINUS_SRC_COLOR = 769;
	var DST_COLOR = 774;
	var ONE_MINUS_DST_COLOR = 775;
	var SRC_ALPHA = 770;
	var ONE_MINUS_SRC_ALPHA = 771;
	var DST_ALPHA = 772;
	var ONE_MINUS_DST_ALPHA = 773;
	var CONSTANT_COLOR = 32769;
	var ONE_MINUS_CONSTANT_COLOR = 32770;
	var CONSTANT_ALPHA = 32771;
	var ONE_MINUS_CONSTANT_ALPHA = 32772;
	var SRC_ALPHA_SATURATE = 776;
}

@:enum
abstract CullFaceType(Int) {
	var FRONT = 1028;
	var BACK = 1029;
	var FRONT_AND_BACK = 1032;
}

@:enum
abstract DepthFuncType(Int) {
	var NEVER = 512;
	var LESS = 513;
	var LEQUAL = 515;
	var EQUAL = 514;
	var GREATER = 516;
	var NOTEQUAL = 517;
	var GEQUAL = 518;
	var ALWAYS = 519;
}

@:enum
abstract FrontFaceType(Int) {
	var CW = 2304;
	var CCW = 2305;
}

typedef TechniqueStateFunctions = {
	var blendColor:Array<Float>;
	var blendEquationSeparate:Array<BlendEquationType>;
	var blendFuncSeparate:Array<BlendFunctionType>;
	var colorMask:Array<Bool>;
	var cullFace:Array<CullFaceType>;
	var depthFunc:Array<DepthFuncType>;
	var depthMask:Array<Bool>;
	var depthRange:Array<Float>;
	var frontFace:Array<FrontFaceType>;
	var lineWidth:Array<Float>;
	var polygonOffset:Array<Float>;
	var scissor:Array<Float>;
}

typedef TechniqueStates = {
	>Property,

	var enable:Array<gltf.type.StateType>;
	var functions:TechniqueStateFunctions;
}

typedef Technique = {
	>ChildOfRootProperty,

	var parameters:StringMap<TechniqueParameters>;
	var attributes:StringMap<GLTFID>;
	var program:GLTFID;
	var uniforms:StringMap<GLTFID>;
	var states:TechniqueStates;
}
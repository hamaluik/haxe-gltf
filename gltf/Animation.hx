package gltf;

import haxe.ds.StringMap;

@:enum
abstract AnimationChannelTargetPath(String) {
	var Translation = "translation";
	var Rotation = "rotation";
	var Scale = "scale";
}

typedef AnimationChannelTarget = {
	>Property,
	var id:String;
	var path:AnimationChannelTargetPath;
}

typedef AnimationChannel = {
	>Property,
	var sampler:String;
	var target:AnimationChannelTarget;
}

typedef AnimationSampler = {
	>Property,
	var input:String;
	@:optional var interpolation:String;
	var output:String;
}

typedef Animation = {
	>ChildOfRootProperty,

	var channels:Array<AnimationChannel>;
	var parameters:StringMap<String>;
	var samplers:StringMap<AnimationSampler>;
}
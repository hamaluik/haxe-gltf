package gltf;

import haxe.ds.StringMap;

typedef Node = {
	>ChildOfRootProperty,

	@:optional var camera:GLTFID;
	@:optional var children:Array<GLTFID>;
	@:optional var skeletons:Array<GLTFID>;
	@:optional var skin:GLTFID;
	@:optional var jointName:GLTFID;
	@:optional var matrix:Array<Float>;
	@:optional var meshes:Array<GLTFID>;
	@:optional var rotation:Array<Float>;
	@:optional var scale:Array<Float>;
	@:optional var translation:Array<Float>;
}
package gltf;

typedef Skin = {
	>ChildOfRootProperty,

	var bindShapeMatrix:Array<Float>;
	var inverseBindMatrices:GLTFID;
	var jointNames:Array<GLTFID>;
}
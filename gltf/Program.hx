package gltf;

typedef Program = {
	>ChildOfRootProperty,

	var attributes:Array<String>;
	var fragmentShader:GLTFID;
	var vertexShader:GLTFID;
}
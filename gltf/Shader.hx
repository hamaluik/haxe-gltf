package gltf;

@:enum
abstract ShaderType(Int) {
	var FRAGMENT_SHADER = 35632;
	var VERTEX_SHADER = 35633;
}

typedef Shader = {
	>ChildOfRootProperty,

	var uri:String;
	var type:ShaderType;
}
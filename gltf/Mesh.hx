package gltf;

import haxe.ds.StringMap;

typedef MeshPrimitiveAttribute = String;

@:enum
abstract PrimitiveType(Int) {
	var POINTS = 0;
	var LINES = 1;
	var LINE_LOOP = 2;
	var LINE_STRIP = 3;
	var TRIANGLES = 4;
	var TRIANGLE_STRIP = 5;
	var TRIANGLE_FAN = 6;
}

typedef MeshPrimitive = {
	>Property,

	var attributes:StringMap<MeshPrimitiveAttribute>;
	var indices:GLTFID;
	var material:GLTFID;
	var mode:PrimitiveType;
}

typedef Mesh = {
	>ChildOfRootProperty,

	var primitives:Array<MeshPrimitive>;
}
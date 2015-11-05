package gltf;

import haxe.ds.StringMap;

typedef Material = {
	>ChildOfRootProperty,

	var technique:String;
	var values:StringMap<Dynamic>;
}
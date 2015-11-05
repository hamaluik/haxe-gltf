package gltf;

import haxe.ds.StringMap;

class GLTF {
	var accessors:StringMap<Accessor>;
	var animations:StringMap<Animation>;
	var asset:Asset;
	var bufferViews:StringMap<BufferView>;
	var buffers:StringMap<Buffer>;
	var materials:StringMap<Material>;

	private function new(){}

	public static function load(data:Dynamic):GLTF {
		var gltf:GLTF = new GLTF();

		// load acessors
		if(!Reflect.hasField(data, "accessors")) {
			throw "Missing field: accessors";
		}
		gltf.accessors = new StringMap<Accessor>();
		for(accessorID in Reflect.fields(data.accessors)) {
			var accessor:Accessor = Reflect.field(data.accessors, accessorID);
			gltf.accessors.set(accessorID, accessor);
		}

		// TODO: load animations

		// load asset
		if(!Reflect.hasField(data, "asset")) {
			throw "Missing field: asset";
		}
		gltf.asset = Reflect.field(data, "asset");

		// load buffer views
		if(!Reflect.hasField(data, "bufferViews")) {
			throw "Missing field: bufferViews";
		}
		gltf.bufferViews = new StringMap<BufferView>();
		for(bufferViewID in Reflect.fields(data.bufferViews)) {
			var bufferView:BufferView = Reflect.field(data.bufferViews, bufferViewID);
			gltf.bufferViews.set(bufferViewID, bufferView);
		}

		// load buffers
		if(!Reflect.hasField(data, "buffers")) {
			throw "Missing field: buffers";
		}
		gltf.buffers = new StringMap<Buffer>();
		for(bufferID in Reflect.fields(data.buffers)) {
			var buffer:Buffer = Reflect.field(data.buffers, bufferID);
			gltf.buffers.set(bufferID, buffer);
		}

		// load materials
		if(!Reflect.hasField(data, "materials")) {
			throw "Missing field: materials";
		}
		gltf.materials = new StringMap<Material>();
		for(materialID in Reflect.fields(data.materials)) {
			//var material:Material = Reflect.field(data.materials, materialID);
			var materialData:Dynamic = Reflect.field(data.materials, materialID);
			var material:Material = {
				extensions: materialData.extensions,
				extras: materialData.extras,
				name: materialData.name,
				technique: materialData.technique,
				values: new StringMap<Dynamic>()
			};
			for(valueID in Reflect.fields(materialData.values)) {
				var valueData:Dynamic = Reflect.field(materialData.values, valueID);
				material.values.set(valueID, valueData);
			}
			gltf.materials.set(materialID, material);
		}

		return gltf;
	}

	public static function parse(gltf:String):GLTF {
		return GLTF.load(haxe.Json.parse(gltf));
	}
}
package gltf;

import haxe.ds.StringMap;

class GLTF {
	var accessors:StringMap<Accessor>;
	var animations:StringMap<Animation>;
	var asset:Asset;
	var bufferViews:StringMap<BufferView>;
	var buffers:StringMap<Buffer>;
	var materials:StringMap<Material>;
	var meshes:StringMap<Mesh>;
	var nodes:StringMap<Node>;
	var programs:StringMap<Program>;
	var scene:GLTFID;
	var scenes:StringMap<Scene>;
	var shaders:StringMap<Shader>;

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

		// load meshes
		if(!Reflect.hasField(data, "meshes")) {
			throw "Missing field: meshes";
		}
		gltf.meshes = new StringMap<Mesh>();
		for(meshID in Reflect.fields(data.meshes)) {
			var meshData:Dynamic = Reflect.field(data.meshes, meshID);
			var mesh:Mesh = {
				extensions: meshData.extensions,
				extras: meshData.extensions,
				name: meshData.name,
				primitives: new Array<Mesh.MeshPrimitive>()
			}
			var primitives:Array<Dynamic> = meshData.primitives;
			for(primitiveData in primitives) {
				var primitive:Mesh.MeshPrimitive = {
					extensions: primitiveData.extensions,
					extras: primitiveData.extras,
					attributes: new StringMap<Mesh.MeshPrimitiveAttribute>(),
					indices: primitiveData.indices,
					material: primitiveData.material,
					mode: primitiveData.mode
				};
				for(attributeID in Reflect.fields(primitiveData.attributes)) {
					var attribute:Mesh.MeshPrimitiveAttribute = Reflect.field(primitiveData.attributes, attributeID);
					primitive.attributes.set(attributeID, attribute);
				}
				mesh.primitives.push(primitive);
			}
			gltf.meshes.set(meshID, mesh);
		}

		// load nodes
		if(!Reflect.hasField(data, "nodes")) {
			throw "Missing field: nodes";
		}
		gltf.nodes = new StringMap<Node>();
		for(nodeID in Reflect.fields(data.nodes)) {
			var node:Node = Reflect.field(data.nodes, nodeID);
			gltf.nodes.set(nodeID, node);
		}

		// load programs
		if(!Reflect.hasField(data, "programs")) {
			throw "Missing field: programs";
		}
		gltf.programs = new StringMap<Program>();
		for(programID in Reflect.fields(data.programs)) {
			var program:Program = Reflect.field(data.programs, programID);
			gltf.programs.set(programID, program);
		}

		// load the main scene
		if(!Reflect.hasField(data, "scene")) {
			throw "Missing field: scene";
		}
		gltf.scene = data.scene;

		// load scenes
		if(!Reflect.hasField(data, "scenes")) {
			throw "Missing field: scenes";
		}
		gltf.scenes = new StringMap<Scene>();
		for(sceneID in Reflect.fields(data.scenes)) {
			var scene:Scene = Reflect.field(data.scenes, sceneID);
			gltf.scenes.set(sceneID, scene);
		}

		// load shaders
		if(!Reflect.hasField(data, "shaders")) {
			throw "Missing field: shaders";
		}
		gltf.shaders = new StringMap<Shader>();
		for(shaderID in Reflect.fields(data.shaders)) {
			var shader:Shader = Reflect.field(data.shaders, shaderID);
			gltf.shaders.set(shaderID, shader);
		}

		return gltf;
	}

	public static function parse(gltf:String):GLTF {
		return GLTF.load(haxe.Json.parse(gltf));
	}
}
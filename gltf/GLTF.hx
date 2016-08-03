package gltf;

import haxe.ds.StringMap;

class GLTF {
	public var accessors:StringMap<Accessor>;
	public var animations:StringMap<Animation>;
	public var asset:Asset;
	public var bufferViews:StringMap<BufferView>;
	public var buffers:StringMap<Buffer>;
	public var cameras:StringMap<Camera>;
	//public var images:StringMap<Image>;
	public var materials:StringMap<Material>;
	public var meshes:StringMap<Mesh>;
	public var nodes:StringMap<Node>;
	public var programs:StringMap<Program>;
	//public var samplers:StringMap<Sampler>;
	public var scene:GLTFID;
	public var scenes:StringMap<Scene>;
	public var shaders:StringMap<Shader>;
	public var skins:StringMap<Skin>;
	public var techniques:StringMap<Technique>;
	//public var textures:StringMap<Texture>;

	private function new(){}

	public static function load(data:Dynamic):GLTF {
		if(data == null) throw "Provided GLTF data is null!";

		var gltf:GLTF = new GLTF();

		// load acessors
		if(Reflect.hasField(data, "accessors")) {
			gltf.accessors = new StringMap<Accessor>();
			for(accessorID in Reflect.fields(data.accessors)) {
				var accessor:Accessor = Reflect.field(data.accessors, accessorID);
				gltf.accessors.set(accessorID, accessor);
			}
		}

		// TODO: load animations

		// load asset
		if(Reflect.hasField(data, "asset")) {
			gltf.asset = Reflect.field(data, "asset");
		}

		// load buffer views
		if(Reflect.hasField(data, "bufferViews")) {
			gltf.bufferViews = new StringMap<BufferView>();
			for(bufferViewID in Reflect.fields(data.bufferViews)) {
				var bufferView:BufferView = Reflect.field(data.bufferViews, bufferViewID);
				gltf.bufferViews.set(bufferViewID, bufferView);
			}
		}

		// load buffers
		if(Reflect.hasField(data, "buffers")) {
			gltf.buffers = new StringMap<Buffer>();
			for(bufferID in Reflect.fields(data.buffers)) {
				var buffer:Buffer = Reflect.field(data.buffers, bufferID);
				gltf.buffers.set(bufferID, buffer);
			}
		}

		// load cameras
		if(Reflect.hasField(data, "cameras")) {
			gltf.cameras = new StringMap<Camera>();
			for(cameraID in Reflect.fields(data.cameras)) {
				var camera:Camera = Reflect.field(data.cameras, cameraID);
				gltf.cameras.set(cameraID, camera);
			}
		}

		// load materials
		if(Reflect.hasField(data, "materials")) {
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
		}

		// load meshes
		if(Reflect.hasField(data, "meshes")) {
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
		}

		// load nodes
		if(Reflect.hasField(data, "nodes")) {
			gltf.nodes = new StringMap<Node>();
			for(nodeID in Reflect.fields(data.nodes)) {
				var node:Node = Reflect.field(data.nodes, nodeID);
				gltf.nodes.set(nodeID, node);
			}
		}

		// load programs
		if(Reflect.hasField(data, "programs")) {
			gltf.programs = new StringMap<Program>();
			for(programID in Reflect.fields(data.programs)) {
				var program:Program = Reflect.field(data.programs, programID);
				gltf.programs.set(programID, program);
			}
		}

		// load the main scene
		if(Reflect.hasField(data, "scene")) {
			gltf.scene = data.scene;
		}

		// load scenes
		if(Reflect.hasField(data, "scenes")) {
			gltf.scenes = new StringMap<Scene>();
			for(sceneID in Reflect.fields(data.scenes)) {
				var scene:Scene = Reflect.field(data.scenes, sceneID);
				gltf.scenes.set(sceneID, scene);
			}
		}

		// load shaders
		if(Reflect.hasField(data, "shaders")) {
			gltf.shaders = new StringMap<Shader>();
			for(shaderID in Reflect.fields(data.shaders)) {
				var shader:Shader = Reflect.field(data.shaders, shaderID);
				gltf.shaders.set(shaderID, shader);
			}
		}

		// load skins
		if(Reflect.hasField(data, "skins")) {
			gltf.skins = new StringMap<Skin>();
			for(skinID in Reflect.fields(data.skins)) {
				var skin:Skin = Reflect.field(data.skins, skinID);
				gltf.skins.set(skinID, skin);
			}
		}

		// load techniques
		if(Reflect.hasField(data, "techniques")) {
			gltf.techniques = new StringMap<Technique>();
			for(techniqueID in Reflect.fields(data.techniques)) {
				var techniqueData:Dynamic = Reflect.field(data.techniques, techniqueID);
				var technique:Technique = {
					extensions: techniqueData.extensions,
					extras: techniqueData.extensions,
					name: techniqueData.name,
					parameters: new StringMap<Technique.TechniqueParameters>(),
					attributes: new StringMap<GLTFID>(),
					program: techniqueData.program,
					uniforms: new StringMap<GLTFID>(),
					states: techniqueData.states
				}
				for(parameterID in Reflect.fields(techniqueData.parameters)) {
					var parameterData:Technique.TechniqueParameters = Reflect.field(techniqueData.parameters, parameterID);
					technique.parameters.set(parameterID, parameterData);
				}
				for(attributeID in Reflect.fields(techniqueData.attributes)) {
					technique.attributes.set(attributeID, Reflect.field(techniqueData.attributes, attributeID));
				}
				for(uniformID in Reflect.fields(techniqueData.uniforms)) {
					technique.uniforms.set(uniformID, Reflect.field(techniqueData.uniforms, uniformID));
				}
				gltf.techniques.set(techniqueID, technique);
			}
		}

		return gltf;
	}

	public static function parse(gltf:String):GLTF {
		if(gltf == null) throw "Provided GLTF string is null!";
		if(StringTools.trim(gltf).length < 2) throw "Provided GLTF string is empty!";
		return GLTF.load(haxe.Json.parse(gltf));
	}
}
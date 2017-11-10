package gltf.types;

import gltf.schema.TGLTF;
import gltf.schema.TMesh;
import haxe.ds.Vector;

@:allow(gltf.GLTF)
class Mesh {
    public var name(default, null):Null<String> = null;
    public var primitives(default, null):Vector<MeshPrimitive> = new Vector<MeshPrimitive>(0);
    public var weights(default, null):Vector<Float> = new Vector<Float>(0);

    function new() {}

    function load(gltf:GLTF, mesh:TMesh):Void {
        name = mesh.name;
        primitives = new Vector<MeshPrimitive>(mesh.primitives.length);
        for(i in 0...mesh.primitives.length) {
            primitives[i] = new MeshPrimitive();
            primitives[i].load(gltf, mesh.primitives[i]);
        }

        if(mesh.weights != null) weights = Vector.fromArrayCopy(mesh.weights);
    }

    static function loadFromRaw(gltf:GLTF, raw:TGLTF):Vector<Mesh> {
        var meshes:Vector<Mesh> = new Vector<Mesh>(raw.meshes.length);
        for(i in 0...raw.meshes.length) {
            meshes[i] = new Mesh();
        }
        for(i in 0...raw.meshes.length) {
            meshes[i].load(gltf, raw.meshes[i]);
        }
        return meshes;
    }
}

package gltf.types;

import gltf.schema.TGLTF;
import gltf.schema.TMesh;
import haxe.ds.Vector;

@:allow(gltf.GLTF)
class Mesh {
    public var primitives(default, null):Vector<MeshPrimitive> = new Vector<MeshPrimitive>(0);
    public var weights(default, null):Vector<Float> = new Vector<Float>(0);

    function new() {}

    function load(gltf:GLTF, Mesh:TMesh, existingMeshes:Vector<Mesh>):Void {
        // TODO:
    }

    static function loadFromRaw(gltf:GLTF, raw:TGLTF):Vector<Mesh> {
        var existingMeshes:Vector<Mesh> = new Vector<Mesh>(raw.meshes.length);
        for(i in 0...raw.meshes.length) {
            existingMeshes[i] = new Mesh();
        }
        for(i in 0...raw.meshes.length) {
            existingMeshes[i].load(gltf, raw.meshes[i], existingMeshes);
        }
        return existingMeshes;
    }
}

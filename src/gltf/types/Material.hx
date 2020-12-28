package gltf.types;

import haxe.ds.Vector;
import gltf.schema.TGLTF;
import gltf.schema.TMaterialPBRMetallicRoughness;
import gltf.schema.TMaterial;

@:allow(gltf.GLTF)
class Material {
    public var name(default, null):Null<String> = null;
    public var pbrMetallicRoughness(default, null):Null<TMaterialPBRMetallicRoughness> = null;

    function new() {}

    function load(gltf:GLTF, material:TMaterial):Void {
        name = material.name;
        pbrMetallicRoughness = material.pbrMetallicRoughness;
    }

    static function loadFromRaw(gltf:GLTF, raw:TGLTF):Vector<Material> {
        var materials:Vector<Material> = new Vector<Material>(raw.materials.length);
        for(i in 0...raw.materials.length) {
            materials[i] = new Material();
        }
        for(i in 0...raw.materials.length) {
            materials[i].load(gltf, raw.materials[i]);
        }
        return materials;
    }
}
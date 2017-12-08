package gltf.types;

import haxe.ds.Vector;
import gltf.types.Accessor;
import gltf.schema.TGLTF;
import gltf.schema.TSkin;

@:allow(gltf.GLTF)
class Skin {
    public var skeleton(default, null):Node;
    public var joints(default, null):Vector<Node>;
    public var inverseBindMatrices(default, null):Vector<Vector<Float>>;

    function new() {}

    function load(gltf:GLTF, skin:TSkin):Void {
        skeleton = gltf.nodes[skin.skeleton];

        joints = new Vector<Node>(skin.joints.length);
        for(i in 0...skin.joints.length) {
            joints[i] = gltf.nodes[skin.joints[i]];
        }

        inverseBindMatrices = new Vector<Vector<Float>>(skin.joints.length);
        var accessor:Accessor = gltf.accessors[skin.inverseBindMatrices];
        var matrices:Vector<Float> = accessor.getFloats();
        for(i in 0...skin.joints.length) {
            inverseBindMatrices[i] = new Vector<Float>(16);
            for(j in 0...16) {
                inverseBindMatrices[i][j] = matrices[i * 16 + j];
            }
        }
    }

    static function loadFromRaw(gltf:GLTF, raw:TGLTF):Vector<Skin> {
        var skins:Vector<Skin> = new Vector<Skin>(raw.skins.length);
        for(i in 0...raw.skins.length) {
            var skin:Skin = new Skin();
            skin.load(gltf, raw.skins[i]);
            skins[i] = skin;
        }
        return skins;
    }
}

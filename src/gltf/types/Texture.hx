package gltf.types;

import gltf.types.Image;
import gltf.types.Sampler;
import gltf.schema.TGLTF;
import gltf.schema.TTexture;
import haxe.ds.Vector;

@:allow(gltf.GLTF)
class Texture {
    public var name(default, null):String = null;
    public var image(default, null):Image = null;
    public var sampler(default, null):Sampler = null;

    function new() {}

    function load(gltf:GLTF, texture:TTexture):Void {
        this.name = texture.name;
        if(texture.source != null) this.image = gltf.images[texture.source];
        if(texture.sampler != null) this.sampler = gltf.samplers[texture.sampler];
    }

    static function loadFromRaw(gltf:GLTF, raw:TGLTF):Vector<Texture> {
        var textures:Vector<Texture> = new Vector<Texture>(raw.textures.length);
        for(i in 0...raw.textures.length) {
            textures[i] = new Texture();
        }
        for(i in 0...raw.textures.length) {
            textures[i].load(gltf, raw.textures[i]);
        }
        return textures;
    }
}
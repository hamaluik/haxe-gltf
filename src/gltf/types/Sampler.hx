package gltf.types;

import gltf.schema.TGLTF;
import gltf.schema.TSampler;
import gltf.schema.TMagFilter;
import gltf.schema.TMinFilter;
import gltf.schema.TWrapMode;
import haxe.ds.Vector;

@:allow(gltf.GLTF)
class Sampler {
    public var name(default, null):String;
    public var magFilter(default, null):TMagFilter;
    public var minFilter(default, null):TMinFilter;
    public var wrapS(default, null):TWrapMode;
    public var wrapT(default, null):TWrapMode;

    function new() {}

    function load(gltf:GLTF, sampler:TSampler):Void {
        this.name = sampler.name;
        this.magFilter = sampler.magFilter;
        this.minFilter = sampler.minFilter;
        this.wrapS = sampler.wrapS;
        this.wrapT = sampler.wrapT;
    }

    static function loadFromRaw(gltf:GLTF, raw:TGLTF):Vector<Sampler> {
        var samplers:Vector<Sampler> = new Vector<Sampler>(raw.samplers.length);
        for(i in 0...raw.samplers.length) {
            samplers[i] = new Sampler();
        }
        for(i in 0...raw.samplers.length) {
            samplers[i].load(gltf, raw.samplers[i]);
        }
        return samplers;
    }
}
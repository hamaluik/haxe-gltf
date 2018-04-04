package gltf.types;

import gltf.schema.TGLTF;
import gltf.schema.TAnimation;
import haxe.ds.Vector;

@:allow(gltf.GLTF)
class Animation {
    public var name(default, null):String = null;
    public var channels(default, null):Vector<AnimationChannel> = null;

    function new() {}

    function load(gltf:GLTF, animation:TAnimation):Void {
        this.name = animation.name;
        this.channels = new Vector<AnimationChannel>(animation.channels.length);

        for(i in 0...animation.channels.length) {
            channels[i] = new AnimationChannel();
            channels[i].node = gltf.nodes[animation.channels[i].target.node];
            channels[i].loadSampler(gltf, animation.samplers[animation.channels[i].sampler]);
            channels[i].path = animation.channels[i].target.path;
        }
    }

    static function loadFromRaw(gltf:GLTF, raw:TGLTF):Vector<Animation> {
        var animations:Vector<Animation> = new Vector<Animation>(raw.animations.length);
        for(i in 0...raw.animations.length) {
            animations[i] = new Animation();
        }
        for(i in 0...raw.animations.length) {
            animations[i].load(gltf, raw.animations[i]);
        }
        return animations;
    }
}
package gltf.types;

import haxe.ds.Vector;
import gltf.schema.TAnimationChannelTargetPath;
import gltf.schema.TAnimationSampler;

@:allow(gltf.types.AnimationChannel)
class AnimationSample {
    public var input(default, null):Float = null;
    public var output(default, null):Vector<Float> = null;

    private function new(input:Float, output:Vector<Float>) {
        this.input = input;
        this.output = output;
    }
}

@:allow(gltf.types.Animation)
class AnimationChannel {
    public var node(default, null):Node = null;
    public var samples(default, null):Vector<AnimationSample> = null;
    public var path(default, null):TAnimationChannelTargetPath = null;

    private function new() {}

    private function loadSampler(gltf:GLTF, sampler:TAnimationSampler):Void {
        var inputSampler:Accessor = gltf.accessors[sampler.input];
        var outputSampler:Accessor = gltf.accessors[sampler.output];

        var inputs:Vector<Float> = inputSampler.getFloats();
        var outputs:Vector<Float> = outputSampler.getFloats();
        samples = new Vector<AnimationSample>(inputs.length);
        for(i in 0...inputs.length) {
            samples[i] = new AnimationSample(
                inputs[i],
                switch(outputSampler.type) {
                    case SCALAR: {
                        var o:Vector<Float> = new Vector<Float>(1);
                        o[0] = outputs[i];
                        o;
                    }

                    case VEC2: {
                        var o:Vector<Float> = new Vector<Float>(2);
                        o[0] = outputs[(i * 2) + 0];
                        o[1] = outputs[(i * 2) + 1];
                        o;
                    }

                    case VEC3: {
                        var o:Vector<Float> = new Vector<Float>(3);
                        o[0] = outputs[(i * 3) + 0];
                        o[1] = outputs[(i * 3) + 1];
                        o[2] = outputs[(i * 3) + 2];
                        o;
                    }

                    case VEC4: {
                        var o:Vector<Float> = new Vector<Float>(4);
                        o[0] = outputs[(i * 4) + 0];
                        o[1] = outputs[(i * 4) + 1];
                        o[2] = outputs[(i * 4) + 2];
                        o[3] = outputs[(i * 4) + 3];
                        o;
                    }

                    default: {
                        throw 'Unhandled animation sampler accessor type: \'' + outputSampler.type + '\'!';
                    }
                }
            );
        }
    }
}
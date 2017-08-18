package gltf;

import gltf.Schema;

/**
 *  An object representing a glTF scene
 */
class GLTF {
    /**
     *  The raw glTF data structures; you probably don't care about these if you've called `load()`
     */
    public var raw:TGLTF = null;

    public function new(?raw:TGLTF) {
        this.raw = raw;
    }

    /**
     *  Parse a glTF string into the `raw` field of the GLTF
     *  @param src - The glTF source
     *  @return GLTF
     */
    public static function parse(src:String):GLTF {
        var gltf:GLTF = new GLTF();
        gltf.raw = cast(haxe.Json.parse(src));

        if(gltf.raw.accessors == null) gltf.raw.accessors = new Array<TAccessor>();
        for(accessor in gltf.raw.accessors) {
            if(accessor.bufferView == null){} // TODO: initialize the accessor with zeros
            if(accessor.byteOffset == null) accessor.byteOffset = 0;
            if(accessor.normalized == null) accessor.normalized = false;
            if(accessor.max == null) accessor.max = new Array<Float>();
            if(accessor.min == null) accessor.min = new Array<Float>();

            if(accessor.sparse != null) {
                if(accessor.sparse.indices.byteOffset == null) accessor.sparse.indices.byteOffset = 0;
                if(accessor.sparse.values.byteOffset == null) accessor.sparse.values.byteOffset = 0;
            }
        }

        if(gltf.raw.buffers == null) gltf.raw.buffers = new Array<TBuffer>();

        if(gltf.raw.bufferViews == null) gltf.raw.bufferViews = new Array<TBufferView>();
        for(bufferView in gltf.raw.bufferViews) {
            if(bufferView.byteOffset == null) bufferView.byteOffset = 0;
        }

        if(gltf.raw.images == null) gltf.raw.images = new Array<TImage>();

        if(gltf.raw.samplers == null) gltf.raw.samplers = new Array<TSampler>();
        for(sampler in gltf.raw.samplers) {
            if(sampler.magFilter == null) sampler.magFilter = TMagFilter.LINEAR;
            if(sampler.minFilter == null) sampler.minFilter = TMinFilter.LINEAR;
            if(sampler.wrapS == null) sampler.wrapS = TWrapMode.REPEAT;
            if(sampler.wrapT == null) sampler.wrapT = TWrapMode.REPEAT;
        }

        if(gltf.raw.scene == null) gltf.raw.scene = 0;

        if(gltf.raw.scenes == null) gltf.raw.scenes = new Array<TScene>();

        if(gltf.raw.textures == null) gltf.raw.textures = new Array<TTexture>();
        for(texture in gltf.raw.textures) {
            if(texture.sampler == null) texture.sampler = -1; // TODO: better index to default sampler?
        }

        return gltf;
    }

    /**
     *  Loads the full GLTF data declared in this object's `raw` field
     *  @return GLTF
     */
    public function load():GLTF {


        return this;
    }
}
package gltf;

import haxe.io.Bytes;
import gltf.Schema;
import tink.core.Promise;
import tink.core.Future;

using StringTools;

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
     *  Parses and loads a glTF file in one step
     *  @param uri - The uri of the glTF file to load
     *  @param assetFetcher - a function which takes in a URI and returns a promise with the contents
     *  @return Promise<GLTF>
     */
    public static function parseAndLoad(uri:String, assetFetcher:String->Promise<Bytes>):Promise<GLTF> {
        return assetFetcher(uri)
        .next(function(data:Bytes):Promise<GLTF> {
            return GLTF.parse(data.toString());
        })
        .next(function(glTF:GLTF) {
            return glTF.load(assetFetcher);
        });
    }

    /**
     *  Parse a glTF string into the `raw` field of the GLTF
     *  @param src - The glTF source
     *  @return GLTF
     */
    public static function parse(src:String):Future<GLTF> {
        var f:FutureTrigger<GLTF> = new FutureTrigger<GLTF>();

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

        f.trigger(gltf);
        return f;
    }

    /**
     *  Loads the raw glTF data into a more usable object
     *  @param assetFetcher - a function which takes in a URI and returns a promise with the contents
     *  @return Surprise<GLTF, Dynamic>
     */
    public function load(assetFetcher:String->Promise<Bytes>):Promise<GLTF> {
        var _buffers:Array<Bytes> = new Array<Bytes>();

        return Promise.inParallel([for(buffer in raw.buffers) assetFetcher(buffer.uri)])
        .next(function(buffers:Array<Bytes>) {
            _buffers = buffers;

            for(buffer in buffers) {
                trace('Loaded ${buffer.length} bytes into buffer!');
            }

            var f:FutureTrigger<GLTF> = Future.trigger();
            f.trigger(this);
            return f.asFuture();
        });
    }
}
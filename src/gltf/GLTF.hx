package gltf;

import haxe.io.Bytes;
import gltf.Schema;
import tink.core.Promise;
import tink.core.Future;
import glm.Mat4;

// TODO: node types?
typedef Node = {
    @:optional var transform:Mat4;
}

typedef Scene = {
    var nodes:Array<Node>;
}

/**
 *  An object representing a glTF scene
 */
class GLTF {
    /**
     *  The raw glTF data structures; you probably don't care about these if you've called `load()`
     */
    public var raw:TGLTF = null;

    // TODO: object layout?
    public var scenes:Array<Scene> = new Array<Scene>();
    public var defaultScene:Scene = null;

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

        if(gltf.raw.cameras == null) gltf.raw.cameras = new Array<TCamera>();

        if(gltf.raw.images == null) gltf.raw.images = new Array<TImage>();

        if(gltf.raw.materials == null) gltf.raw.materials = new Array<TMaterial>();
        for(material in gltf.raw.materials) {
            if(material.normalTexture != null) {
                if(material.normalTexture.texCoord == null) material.normalTexture.texCoord = 0;
                if(material.normalTexture.scale == null) material.normalTexture.scale = 1.0;
            }

            if(material.occlusionTexture != null) {
                if(material.occlusionTexture.texCoord == null) material.occlusionTexture.texCoord = 0;
                if(material.occlusionTexture.strength == null) material.occlusionTexture.strength = 1.0;
            }

            if(material.pbrMetallicRoughness != null) {
                if(material.pbrMetallicRoughness.baseColorFactor == null) material.pbrMetallicRoughness.baseColorFactor = [1.0, 1.0, 1.0, 1.0];
                if(material.pbrMetallicRoughness.baseColorTexture != null) {
                    if(material.pbrMetallicRoughness.baseColorTexture.texCoord == null) material.pbrMetallicRoughness.baseColorTexture.texCoord = 0;
                }
                if(material.pbrMetallicRoughness.metallicFactor == null) material.pbrMetallicRoughness.metallicFactor = 1.0;
                if(material.pbrMetallicRoughness.roughnessFactor == null) material.pbrMetallicRoughness.roughnessFactor = 1.0;
                if(material.pbrMetallicRoughness.metallicRoughnessTexture != null) {
                    if(material.pbrMetallicRoughness.metallicRoughnessTexture.texCoord == null) material.pbrMetallicRoughness.metallicRoughnessTexture.texCoord = 0;
                }
            }

            if(material.emissiveTexture != null) {
                if(material.emissiveTexture.texCoord == null) material.emissiveTexture.texCoord = 0;
            }

            if(material.emissiveFactor == null) material.emissiveFactor = [0.0, 0.0, 0.0];
            if(material.alphaCutoff == null) material.alphaCutoff = 0.5;
            if(material.doubleSided == null) material.doubleSided = false;
        }

        if(gltf.raw.meshes == null) gltf.raw.meshes = new Array<TMesh>();
        for(mesh in gltf.raw.meshes) {
            if(mesh.primitives == null) mesh.primitives = new Array<TMeshPrimitive>();
            for(primitive in mesh.primitives) {
                if(primitive.mode == null) primitive.mode = TMeshPrimitiveType.TRIANGLES;
            }
        }

        if(gltf.raw.nodes == null) gltf.raw.nodes = new Array<TNode>();
        for(node in gltf.raw.nodes) {
            // if they all need filling in...
            if(node.matrix == null && node.rotation == null && node.scale == null && node.translation == null) {
                // ignore the transform for this node!
            }
            // if the components need filling in...
            else if(node.matrix != null) {
                // TODO: verify the correctness of this!
                // TODO: move these calculations into GLM!
                trace('calculating transform components');
                var a:Array<Float> = node.matrix;

                node.translation = new Array<Float>();
                node.translation.push(a[12]);
                node.translation.push(a[13]);
                node.translation.push(a[14]);

                var sx:Float = Math.sqrt(a[0]*a[0] + a[1]*a[1] + a[2]*a[2] + a[3]*a[3]);
                var sy:Float = Math.sqrt(a[4]*a[4] + a[5]*a[5] + a[6]*a[6] + a[7]*a[7]);
                var sz:Float = Math.sqrt(a[8]*a[8] + a[9]*a[9] + a[10]*a[10] + a[11]*a[11]);
                node.scale = new Array<Float>();
                node.scale.push(sx); node.scale.push(sy); node.scale.push(sz);

                var m00 = a[0] / sx; var m11 = a[5] / sy; var m22 = a[10] / sz;
                node.rotation = new Array<Float>();
                node.rotation.push(Math.sqrt(Math.max(0.0, 1.0 + m00 - m11 - m22)) / 2.0);
                node.rotation.push(Math.sqrt(Math.max(0.0, 1.0 - m00 + m11 - m22)) / 2.0);
                node.rotation.push(Math.sqrt(Math.max(0.0, 1.0 - m00 - m11 + m22)) / 2.0);
                node.rotation.push(Math.sqrt(Math.max(0.0, 1.0 + m00 + m11 + m22)) / 2.0);
            }
            // if the matrix needs filling in..
            else if(node.matrix == null && (node.rotation != null || node.scale != null || node.translation != null)) {
                trace('filling in matrix');
                if(node.rotation == null) node.rotation = [ 0.0, 0.0, 0.0, 1.0 ];
                if(node.scale == null) node.scale = [ 1.0, 1.0, 1.0 ];
                if(node.translation == null) node.translation = [ 0.0, 0.0, 0.0 ];

                var m:Mat4 = glm.GLM.transform(node.translation, node.rotation, node.scale, new Mat4());
                node.matrix = m;
            }
            else {
                throw 'Unhandled transform case: ${node.matrix == null} ${node.translation == null} ${node.rotation == null} ${node.scale == null}';
            }
        }

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

            // TODO: actually link and load stuff!

            var nodes:Array<Node> = new Array<Node>();
            for(rawNode in raw.nodes) {
                var node:Node = {
                    transform: rawNode.matrix == null ? null : rawNode.matrix
                };
                nodes.push(node);
            }

            var scenes:Array<Scene> = new Array<Scene>();
            for(rawScene in raw.scenes) {
                var scene:Scene = {
                    nodes: new Array<Node>()
                };
                for(nid in rawScene.nodes) {
                    scene.nodes.push(nodes[nid]);
                }
                scenes.push(scene);
            }
            this.scenes = scenes;
            this.defaultScene = scenes[raw.scene];

            var f:FutureTrigger<GLTF> = Future.trigger();
            f.trigger(this);
            return f.asFuture();
        });
    }
}
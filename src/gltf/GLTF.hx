package gltf;

import gltf.schema.TTexture;
import gltf.schema.TSkin;
import gltf.schema.TScene;
import gltf.schema.TWrapMode;
import gltf.schema.TMinFilter;
import gltf.schema.TMagFilter;
import gltf.schema.TSampler;
import gltf.schema.TNode;
import gltf.schema.TMeshPrimitiveType;
import gltf.schema.TMeshPrimitive;
import gltf.schema.TMesh;
import gltf.schema.TMaterial;
import gltf.schema.TImage;
import gltf.schema.TCamera;
import gltf.schema.TBufferView;
import gltf.schema.TBuffer;
import gltf.schema.TAnimationInterpolation;
import gltf.schema.TAnimation;
import gltf.schema.TGLTF;
import gltf.schema.TAccessor;
import haxe.ds.Vector;
import gltf.types.Accessor;
import gltf.types.Animation;
import gltf.types.Buffer;
import gltf.types.BufferView;
import gltf.types.Camera;
import gltf.types.Mesh;
import gltf.types.Skin;
import gltf.types.Node;
import gltf.types.Scene;
import gltf.types.Image;
import gltf.types.Texture;
import gltf.types.Sampler;
import haxe.io.Bytes;

/**
 *  An object representing a glTF scene
 */
class GLTF {
    public var accessors(default, null):Vector<Accessor> = new Vector<Accessor>(0);
    public var animations(default, null):Vector<Animation> = new Vector<Animation>(0);
    public var buffers(default, null):Vector<Buffer> = new Vector<Buffer>(0);
    public var bufferViews(default, null):Vector<BufferView> = new Vector<BufferView>(0);
    public var cameras(default, null):Vector<Camera> = new Vector<Camera>(0);
    public var images(default, null):Vector<Image> = new Vector<Image>(0);
    //  TODO: materials
    public var meshes(default, null):Vector<Mesh> = new Vector<Mesh>(0);
    public var samplers(default, null):Vector<Sampler> = new Vector<Sampler>(0);
    public var skins(default, null):Vector<Skin> = new Vector<Skin>(0);
    public var textures(default, null):Vector<Texture> = new Vector<Texture>(0);
    public var nodes(default, null):Vector<Node> = new Vector<Node>(0);
    public var defaultScene(default, null):Scene = null;
    public var scenes(default, null):Vector<Scene> = new Vector<Scene>(0);

    function new() {}

    public inline static function parseAndLoad(src:String, buffers:Array<Bytes>):GLTF {
        return load(parse(src), buffers);
    }

    public static function load(raw:TGLTF, buffers:Array<Bytes>):GLTF {
        var gltf:GLTF = new GLTF();

        gltf.buffers = Buffer.loadFromRaw(gltf, raw, buffers);
        gltf.bufferViews = BufferView.loadFromRaw(gltf, raw);
        gltf.accessors = Accessor.loadFromRaw(gltf, raw);
        gltf.cameras = Camera.loadFromRaw(gltf, raw);
        gltf.images = Image.loadFromRaw(gltf, raw);
        gltf.samplers = Sampler.loadFromRaw(gltf, raw);
        gltf.textures = Texture.loadFromRaw(gltf, raw);
        gltf.meshes = Mesh.loadFromRaw(gltf, raw);
        gltf.nodes = Node.loadFromRaw(gltf, raw);
        gltf.skins = Skin.loadFromRaw(gltf, raw);
        gltf.animations = Animation.loadFromRaw(gltf, raw);
        gltf.scenes = Scene.loadFromRaw(gltf, raw);
        gltf.defaultScene = gltf.scenes[raw.scene];

        return gltf;
    }

    /**
     *  Parse a glTF json string into typedef'd structs
     *  @param src The glTF source
     *  @return TGLTF
     */
    public static function parse(src:String):TGLTF {
        var gltf:TGLTF = cast(haxe.Json.parse(src));

        if(gltf.accessors == null) gltf.accessors = new Array<TAccessor>();
        for(accessor in gltf.accessors) {
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

        if(gltf.animations == null) gltf.animations = new Array<TAnimation>();
        for(animation in gltf.animations) {
            for(sampler in animation.samplers) {
                if(sampler.interpolation == null) sampler.interpolation = TAnimationInterpolation.LINEAR;
            }
        }

        if(gltf.buffers == null) gltf.buffers = new Array<TBuffer>();

        if(gltf.bufferViews == null) gltf.bufferViews = new Array<TBufferView>();
        for(bufferView in gltf.bufferViews) {
            if(bufferView.byteOffset == null) bufferView.byteOffset = 0;
        }

        if(gltf.cameras == null) gltf.cameras = new Array<TCamera>();

        if(gltf.images == null) gltf.images = new Array<TImage>();

        if(gltf.materials == null) gltf.materials = new Array<TMaterial>();
        for(material in gltf.materials) {
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

        if(gltf.meshes == null) gltf.meshes = new Array<TMesh>();
        for(mesh in gltf.meshes) {
            if(mesh.primitives == null) mesh.primitives = new Array<TMeshPrimitive>();
            for(primitive in mesh.primitives) {
                if(primitive.mode == null) primitive.mode = TMeshPrimitiveType.TRIANGLES;
            }
        }

        if(gltf.nodes == null) gltf.nodes = new Array<TNode>();
        for(node in gltf.nodes) {
            // if they all need filling in...
            if(node.matrix == null && node.rotation == null && node.scale == null && node.translation == null) {
                // use the identity matrix
                node.matrix = [
                    1, 0, 0, 0,
                    0, 1, 0, 0,
                    0, 0, 1, 0,
                    0, 0, 0, 1
                ];
            }
            // if the components need filling in...
            if(node.matrix != null) {
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
                if(node.rotation == null) node.rotation = [ 0.0, 0.0, 0.0, 1.0 ];
                if(node.scale == null) node.scale = [ 1.0, 1.0, 1.0 ];
                if(node.translation == null) node.translation = [ 0.0, 0.0, 0.0 ];

                var x2:Float = node.rotation[0] + node.rotation[0];
                var y2:Float = node.rotation[1] + node.rotation[1];
                var z2:Float = node.rotation[2] + node.rotation[2];

                var xx:Float = node.rotation[0] * x2;
                var xy:Float = node.rotation[0] * y2;
                var xz:Float = node.rotation[0] * z2;
                var yy:Float = node.rotation[1] * y2;
                var yz:Float = node.rotation[1] * z2;
                var zz:Float = node.rotation[2] * z2;
                var wx:Float = node.rotation[3] * x2;
                var wy:Float = node.rotation[3] * y2;
                var wz:Float = node.rotation[3] * z2;

                node.matrix = [
                    (1 - (yy + zz)) * node.scale[0],
                    (xy + wz) * node.scale[0],
                    (xz - wy) * node.scale[0],
                    0,

                    (xy - wz) * node.scale[1],
                    (1 - (xx + zz)) * node.scale[1],
                    (yz + wx) * node.scale[1],
                    0,

                    (xz + wy) * node.scale[2],
                    (yz - wx) * node.scale[2],
                    (1 - (xx + yy)) * node.scale[2],
                    0,

                    node.translation[0],
                    node.translation[1],
                    node.translation[2],
                    1
                ];
            }
            else {
                throw 'Unhandled transform case: ${node.matrix == null} ${node.translation == null} ${node.rotation == null} ${node.scale == null}';
            }
        }

        if(gltf.samplers == null) gltf.samplers = new Array<TSampler>();
        for(sampler in gltf.samplers) {
            if(sampler.magFilter == null) sampler.magFilter = TMagFilter.LINEAR;
            if(sampler.minFilter == null) sampler.minFilter = TMinFilter.LINEAR;
            if(sampler.wrapS == null) sampler.wrapS = TWrapMode.REPEAT;
            if(sampler.wrapT == null) sampler.wrapT = TWrapMode.REPEAT;
        }

        if(gltf.scene == null) gltf.scene = 0;

        if(gltf.scenes == null) gltf.scenes = new Array<TScene>();

        if(gltf.skins == null) gltf.skins = new Array<TSkin>();

        if(gltf.textures == null) gltf.textures = new Array<TTexture>();
        for(texture in gltf.textures) {
            if(texture.sampler == null) texture.sampler = -1; // TODO: better index to default sampler?
        }

        return gltf;
    }
}

package gltf.schema;

/**
 *  The root object for a glTF asset.
 */
typedef TGLTF = {
    >TGLTFProperty,

    /**
     *  Names of glTF extensions used somewhere in this asset
     */
    @:optional var extensionsUsed:Array<String>;

    /**
     *  Names of glTF extensions required to properly load this asset.
     */
    @:optional var extensionsRequired:Array<String>;

    /**
     *  An array of accessors.
     */
    @:optional var accessors:Array<TAccessor>;

    /**
     *  An array of keyframe animations.
     */
    @:optional var animations:Array<TAnimation>;

    /**
     *  Metadata about the glTF asset.
     */
    var asset:TAsset;

    /**
     *  An array of buffers.
     */
    @:optional var buffers:Array<TBuffer>;

    /**
     *  An array of bufferViews.
     */
    @:optional var bufferViews:Array<TBufferView>;

    /**
     *  An array of cameras.
     */
    @:optional var cameras:Array<TCamera>;

    /**
     *  An array of images.
     */
    @:optional var images:Array<TImage>;

    /**
     *  An array of materials.
     */
    @:optional var materials:Array<TMaterial>;

    /**
     *  An array of meshes.
     */
    @:optional var meshes:Array<TMesh>;

    /**
     *  An array of nodes.
     */
    @:optional var nodes:Array<TNode>;

    /**
     *  An array of samplers.
     */
    @:optional var samplers:Array<TSampler>;

    /**
     *  The index of the default scene.
     */
    @:optional var scene:TGLTFID;

    /**
     *  An array of scenes.
     */
    @:optional var scenes:Array<TScene>;

    /**
     *  An array of skins.
     */
    @:optional var skins:Array<TSkin>;

    /**
     *  An array of textures.
     */
    @:optional var textures:Array<TTexture>;
}

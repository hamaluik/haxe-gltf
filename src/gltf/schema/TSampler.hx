package gltf.schema;

/**
 *  Texture sampler properties for filtering and wrapping modes.
 */
typedef TSampler = {
    >TGLTFChildOfRootProperty,
    >TGLTFProperty,

    /**
     *  Magnification filter.  Valid values correspond to WebGL enums: `9728` (NEAREST) and `9729` (LINEAR).
     */
    @:optional var magFilter:TMagFilter;

    /**
     *  Minification filter.  All valid values correspond to WebGL enums.
     */
    @:optional var minFilter:TMinFilter;

    /**
     *  s wrapping mode.  All valid values correspond to WebGL enums.
     */
    @:optional var wrapS:TWrapMode;

    /**
     *  t wrapping mode.  All valid values correspond to WebGL enums.
     */
    @:optional var wrapT:TWrapMode;
}

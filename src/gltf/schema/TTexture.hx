package gltf.schema;

/**
 *  A texture and its sampler.
 *  
 *  WebGL functions: `createTexture()`, `deleteTexture()`, `bindTexture()`, `texImage2D()`, and `texParameterf()`
 */
typedef TTexture = {
    >TGLTFChildOfRootProperty,
    >TGLTFProperty,

    /**
     *  The index of the sampler used by this texture. When undefined, a sampler with repeat wrapping and auto filtering should be used.
     */
    @:optional var sampler:TGLTFID;

    /**
     *  The index of the image used by this texture.
     */
    @:optional var source:TGLTFID;
}

package gltf;

/**
 *  A typed view into a bufferView.  A bufferView contains raw binary data.  An accessor provides a typed view into a bufferView or a subset of a bufferView similar to how WebGL's `vertexAttribPointer()` defines an attribute in a buffer.
 */
typedef TAccessor = {
    >TGLTFChildOfRootProperty,

    /**
     *  The index of the bufferView. When not defined, accessor must be initialized with zeros; `sparse` property or extensions could override zeros with actual values.
     */
    @:optional var bufferView:TGLTFID;

    /**
     *  The offset relative to the start of the bufferView in bytes.  This must be a multiple of the size of the component datatype.
     */
    @:optional var byteOffset:Int;

    /**
     *  The datatype of components in the attribute.  All valid values correspond to WebGL enums.  The corresponding typed arrays are `Int8Array`, `Uint8Array`, `Int16Array`, `Uint16Array`, `Uint32Array`, and `Float32Array`, respectively.  5125 (UNSIGNED_INT) is only allowed when the accessor contains indices, i.e., the accessor is only referenced by `primitive.indices`.
     */
    var componentType:TComponentType;

    /**
     *  Specifies whether integer data values should be normalized (`true`) to [0, 1] (for unsigned types) or [-1, 1] (for signed types), or converted directly (`false`) when they are accessed. This property is defined only for accessors that contain vertex attributes or animation output data.
     */
    @:optional var normalized:Bool;

    /**
     *  The number of attributes referenced by this accessor, not to be confused with the number of bytes or number of components.
     */
    var count:Int;

    /**
     *  Specifies if the attribute is a scalar, vector, or matrix.
     */
    var type:TAttributeType;

    /**
     *  Maximum value of each component in this attribute.  Array elements must be treated as having the same data type as accessor's `componentType`. Both min and max arrays have the same length.  The length is determined by the value of the type property; it can be 1, 2, 3, 4, 9, or 16.\n\n`normalized` property has no effect on array values: they always correspond to the actual values stored in the buffer. When accessor is sparse, this property must contain max values of accessor data with sparse substitution applied.
     */
    @:optional var max:Array<Float>;

    /**
     *  Minimum value of each component in this attribute.  Array elements must be treated as having the same data type as accessor's `componentType`. Both min and max arrays have the same length.  The length is determined by the value of the type property; it can be 1, 2, 3, 4, 9, or 16.\n\n`normalized` property has no effect on array values: they always correspond to the actual values stored in the buffer. When accessor is sparse, this property must contain min values of accessor data with sparse substitution applied.
     */
    @:optional var min:Array<Float>;

    /**
     *  Sparse storage of attributes that deviate from their initialization value.
     */
    @:optional var sparse:TAccessorSparse;
}

/**
 *  Sparse storage of attributes that deviate from their initialization value.
 */
typedef TAccessorSparse = {
    >TGLTFProperty,

    /**
     *  The number of attributes encoded in this sparse accessor.
     */
    var count:Int;

    /**
     *  Index array of size `count` that points to those accessor attributes that deviate from their initialization value. Indices must strictly increase.
     */
    var indices:TAccessorSparseIndices;

    /**
     *  Array of size `count` times number of components, storing the displaced accessor attributes pointed by `indices`. Substituted values must have the same `componentType` and number of components as the base accessor.
     */
    var values:TAccessorSparseValues;
}

/**
 *  Indices of those attributes that deviate from their initialization value.
 */
typedef TAccessorSparseIndices = {
    >TGLTFProperty,

    /**
     *  The index of the bufferView with sparse indices. Referenced bufferView can't have ARRAY_BUFFER or ELEMENT_ARRAY_BUFFER target.
     */
    var bufferView:TGLTFID;

    /**
     *  The offset relative to the start of the bufferView in bytes. Must be aligned.
     */
    @:optional var byteOffset:Int;

    /**
     *  The indices data type.  Valid values correspond to WebGL enums: `5121` (UNSIGNED_BYTE), `5123` (UNSIGNED_SHORT), `5125` (UNSIGNED_INT).
     */
    var componentType:TComponentType;
}

/**
 *  Array of size `accessor.sparse.count` times number of components storing the displaced accessor attributes pointed by `accessor.sparse.indices`.
 */
typedef TAccessorSparseValues = {
    >TGLTFProperty,

    /**
     *  The index of the bufferView with sparse values. Referenced bufferView can't have ARRAY_BUFFER or ELEMENT_ARRAY_BUFFER target.
     */
    var bufferView:TGLTFID;
    
    /**
     *  The offset relative to the start of the bufferView in bytes. Must be aligned.
     */
    @:optional var byteOffset:Int;
}

/**
 *  TODO: implement the Animation schema!
 */
typedef TAnimation = {

}

/**
 *  Metadata about the glTF asset
 */
typedef TAsset = {
    >TGLTFProperty,

    /**
     *  A copyright message suitable for display to credit the content creator.
     */
    @:optional var copyright:String;

    /**
     *  Tool that generated this glTF model. Useful for debugging.
     */
    @:optional var generator:String;

    /**
     *  The minimum glTF version that this asset targets.
     */
    var version:String;

    /**
     *  The minimum glTF version that this asset targets.
     */
    @:optional var minVersion:String;
}

@:enum abstract TAttributeType(String) {
    var SCALAR = "SCALAR";
    var VEC2 = "VEC2";
    var VEC3 = "VEC3";
    var VEC4 = "VEC4";
    var MAT2 = "MAT2";
    var MAT3 = "MAT3";
    var MAT4 = "MAT4";
}

/**
 *  A buffer points to binary geometry, animation, or skins.
 */
typedef TBuffer = {
    >TGLTFChildOfRootProperty,

    /**
     *  The uri of the buffer.  Relative paths are relative to the .gltf file.  Instead of referencing an external file, the uri can also be a data-uri.
     */
    @:optional var uri:String;

    /**
     *  The length of the buffer in bytes.
     */
    var byteLength:Int;
}

/**
 *  The target that the GPU buffer should be bound to.
 */
@:enum abstract TBufferTarget(Int) {
    var ARRAY_BUFFER = 34962;
    var ELEMENT_ARRAY_BUFFER = 34963;
}

/**
 *  A view into a buffer generally representing a subset of the buffer.
 */
typedef TBufferView = {
    /**
     *  The index of the buffer.
     */
    var buffer:TGLTFID;
    
    /**
     *  The offset into the buffer in bytes
     */
    @:optional var byteOffset:Int;

    /**
     *  The length of the bufferView in bytes.
     */
    var byteLength:Int;

    /**
     *  The stride, in bytes, between vertex attributes.  When this is not defined, data is tightly packed. When two or more accessors use the same bufferView, this field must be defined.
     */
    var byteStride:Int;

    /**
     *  The target that the GPU buffer should be bound to.
     */
    @:optional var target:TBufferTarget;
}

/**
 *  TODO: implement the Camera schema!
 */
typedef TCamera = {

}

/**
 *  The datatype of components in the attribute.  All valid values correspond to WebGL enums.  The corresponding typed arrays are `Int8Array`, `Uint8Array`, `Int16Array`, `Uint16Array`, `Uint32Array`, and `Float32Array`, respectively.  5125 (UNSIGNED_INT) is only allowed when the accessor contains indices, i.e., the accessor is only referenced by `primitive.indices`.
 */
@:enum abstract TComponentType(Int) {
    var BYTE = 5120;
    var UNSIGNED_BYTE = 5121;
    var SHORT = 5122;
    var UNSIGNED_SHORT = 5123;
    var UNSIGNED_INT = 5125;
    var FLOAT = 5126;
}

/**
 *  The root object for a glTF asset.
 */
typedef TGLTF = {
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

typedef TGLTFChildOfRootProperty = {
    /**
     *  The user-defined name of this object.  This is not necessarily unique, e.g., an accessor and a buffer could have the same name, or two accessors could even have the same name.
     */
    @:optional var name:String;
}

typedef TGLTFProperty = {
    @:optional var extensions:Dynamic;
    @:optional var extras:Dynamic;
}

typedef TGLTFID = Int;

/**
 *  Image data used to create a texture. Image can be referenced by URI or `bufferView` index. `mimeType` is required in the latter case.
 */
typedef TImage = {
    >TGLTFChildOfRootProperty,

    /**
     *  The uri of the image.  Relative paths are relative to the .gltf file.  Instead of referencing an external file, the uri can also be a data-uri.  The image format must be jpg or png.
     */
    @:optional var uri:String;

    /**
     *  The image's MIME type.
     */
    var mimeType:TImageMimeType;

    /**
     *  The index of the bufferView that contains the image. Use this instead of the image's uri property.
     */
    @:optional var bufferView:TGLTFID;
}

/**
 *  TODO: implement the Material schema!
 */
typedef TMaterial = {

}

/**
 *  TODO: implement the Mesh schema!
 */
typedef TMesh = {

}

/**
 *  The image's MIME type.
 */
@:enum abstract TImageMimeType(String) {
    var JPEG = "image/jpeg";
    var PNG = "image/png";
}

/**
 *  A node in the node hierarchy.  When the node contains `skin`, all `mesh.primitives` must contain `JOINTS_0` and `WEIGHTS_0` attributes.  A node can have either a `matrix` or any combination of `translation`/`rotation`/`scale` (TRS) properties. TRS properties are converted to matrices and postmultiplied in the `T * R * S` order to compose the transformation matrix; first the scale is applied to the vertices, then the rotation, and then the translation. If none are provided, the transform is the identity. When a node is targeted for animation (referenced by an animation.channel.target), only TRS properties may be present; `matrix` will not be present.
 */
typedef TNode = {
    /**
     *  The index of the camera referenced by this node.
     */
    @:optional var camera:TCamera;

    /**
     *  The indices of this node's children.
     */
    @:optional var children:Array<TGLTFID>;

    /**
     *  The index of the skin referenced by this node.
     */
    @:optional var skin:TGLTFID;

    /**
     *  A floating-point 4x4 transformation matrix stored in column-major order.
     */
    @:optional var matrix:Array<Float>;

    /**
     *  The index of the mesh in this node.
     */
    @:optional var mesh:TGLTFID;

    /**
     *  The node's unit quaternion rotation in the order (x, y, z, w), where w is the scalar.
     */
    @:optional var rotation:Array<Float>;

    /**
     *  The node's non-uniform scale.
     */
    @:optional var scale:Array<Float>;

    /**
     *  The node's translation.
     */
    @:optional var translation:Array<Float>;

    /**
     *  The weights of the instantiated Morph Target. Number of elements must match number of Morph Targets of used mesh.
     */
    @:optional var weights:Array<Float>;
}

/**
 *  Magnification filter.  Valid values correspond to WebGL enums: `9728` (NEAREST) and `9729` (LINEAR).
 */
@:enum abstract TMagFilter(Int) {
    var NEAREST = 9728;
    var LINEAR = 9729;
}

/**
 *  Minification filter.  All valid values correspond to WebGL enums.
 */
@:enum abstract TMinFilter(Int) {
    var NEAREST = 9728;
    var LINEAR = 9729;
    var NEAREST_MIPMAP_NEAREST = 9984;
    var LINEAR_MIPMAP_NEAREST = 9985;
    var NEAREST_MIPMAP_LINEAR = 9986;
    var LINEAR_MIPMAP_LINEAR = 9987;
}

/**
 *  s-t wrapping mode.  All valid values correspond to WebGL enums.
 */
@:enum abstract TWrapMode(Int) {
    var CLAMP_TO_EDGE = 33071;
    var MIRROR_REPEAT = 33648;
    var REPEAT = 10497;
}

/**
 *  Texture sampler properties for filtering and wrapping modes.
 */
typedef TSampler = {
    >TGLTFChildOfRootProperty,

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

/**
 *  The root nodes of a scene.
 */
typedef TScene = {
    /**
     *  The indices of each root node.
     */
    var nodes:Array<TGLTFID>;
}

/**
 *  TODO: implement the Skin schema!
 */
typedef TSkin = {

}

/**
 *  A texture and its sampler.
 *  
 *  WebGL functions: `createTexture()`, `deleteTexture()`, `bindTexture()`, `texImage2D()`, and `texParameterf()`
 */
typedef TTexture = {
    >TGLTFChildOfRootProperty,

    /**
     *  The index of the sampler used by this texture. When undefined, a sampler with repeat wrapping and auto filtering should be used.
     */
    @:optional var sampler:TGLTFID;

    /**
     *  The index of the image used by this texture.
     */
    @:optional var source:TGLTFID;
}
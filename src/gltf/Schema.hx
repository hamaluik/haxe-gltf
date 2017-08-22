package gltf;

typedef TGLTFProperty = {
    @:optional var extensions:Dynamic;
    @:optional var extras:Dynamic;
}

typedef TGLTFChildOfRootProperty = {
    /**
     *  The user-defined name of this object.  This is not necessarily unique, e.g., an accessor and a buffer could have the same name, or two accessors could even have the same name.
     */
    @:optional var name:String;
}

typedef TGLTFID = Int;

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
 *  Specifies if the camera uses a perspective or orthographic projection.  Based on this, either the camera's `perspective` or `orthographic` property will be defined.
 */
@:enum abstract TCameraType(String) {
    var PERSPECTIVE = "perspective";
    var ORTHOGRAPHIC = "orthographic";
}

/**
 *  An orthographic camera containing properties to create an orthographic projection matrix.
 */
typedef TCameraOrthographic = {
    >TGLTFProperty,

    /**
     *  The floating-point horizontal magnification of the view. Must not be zero.
     */
    var xmag:Float;

    /**
     *  The floating-point vertical magnification of the view. Must not be zero.
     */
    var ymag:Float;

    /**
     *  The floating-point distance to the far clipping plane. `zfar` must be greater than `znear`.
     */
    var zfar:Float;

    /**
     *  The floating-point distance to the near clipping plane.
     */
    var znear:Float;
}

/**
 *  A perspective camera containing properties to create a perspective projection matrix.
 */
typedef TCameraPerspective = {
    >TGLTFProperty,

    /**
     *  The floating-point aspect ratio of the field of view. When this is undefined, the aspect ratio of the canvas is used.
     */
    @:optional var aspectRatio:Float;

    /**
     *  The floating-point vertical field of view in radians.
     */
    var yfov:Float;

    /**
     *  The floating-point distance to the far clipping plane. When defined, `zfar` must be greater than `znear`. If `zfar` is undefined, runtime must use infinite projection matrix.
     */
    @:optional var zfar:Float;

    /**
     *  The floating-point distance to the near clipping plane.
     */
    var znear:Float;
}

/**
 *  A camera's projection.  A node can reference a camera to apply a transform to place the camera in the scene.
 */
typedef TCamera = {
    >TGLTFChildOfRootProperty,

    /**
     *  An orthographic camera containing properties to create an orthographic projection matrix.
     */
    @:optional var orthographic:TCameraOrthographic;

    /**
     *  A perspective camera containing properties to create a perspective projection matrix.
     */
    @:optional var perspective:TCameraPerspective;

    /**
     *  Specifies if the camera uses a perspective or orthographic projection.  Based on this, either the camera's `perspective` or `orthographic` property will be defined.
     */
    var type:TCameraType;
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
 *  Reference to a texture.
 */
typedef TTextureInfo = {
    >TGLTFProperty,

    /**
     *  The index of the texture.
     */
    var index:TGLTFID;

    /**
     *  This integer value is used to construct a string in the format TEXCOORD_<set index> which is a reference to a key in mesh.primitives.attributes (e.g. A value of 0 corresponds to TEXCOORD_0).
     */
    @:optional var texCoord:Int;
}

/**
 *  A set of parameter values that are used to define the metallic-roughness material model from Physically-Based Rendering (PBR) methodology.
 */
typedef TMaterialPBRMetallicRoughness = {
    >TGLTFProperty,

    /**
     *  The RGBA components of the base color of the material. The fourth component (A) is the alpha coverage of the material. The `alphaMode` property specifies how alpha is interpreted. These values are linear. If a baseColorTexture is specified, this value is multiplied with the texel values.
     */
    @:optional var baseColorFactor:Array<Float>;

    /**
     *  The base color texture. This texture contains RGB(A) components in sRGB color space. The first three components (RGB) specify the base color of the material. If the fourth component (A) is present, it represents the alpha coverage of the material. Otherwise, an alpha of 1.0 is assumed. The `alphaMode` property specifies how alpha is interpreted. The stored texels must not be premultiplied.
     */
    @:optional var baseColorTexture:TTextureInfo;

    /**
     *  The metalness of the material. A value of 1.0 means the material is a metal. A value of 0.0 means the material is a dielectric. Values in between are for blending between metals and dielectrics such as dirty metallic surfaces. This value is linear. If a metallicRoughnessTexture is specified, this value is multiplied with the metallic texel values.
     */
    @:optional var metallicFactor:Float;

    /**
     *  The roughness of the material. A value of 1.0 means the material is completely rough. A value of 0.0 means the material is completely smooth. This value is linear. If a metallicRoughnessTexture is specified, this value is multiplied with the roughness texel values.
     */
    @:optional var roughnessFactor:Float;

    /**
     *  The metallic-roughness texture. The metalness values are sampled from the B channel. The roughness values are sampled from the G channel. These values are linear. If other channels are present (R or A), they are ignored for metallic-roughness calculations.
     */
    @:optional var metallicRoughnessTexture:TTextureInfo;
}

/**
 *  Material Normal Texture Info
 */
typedef TMaterialNormalTextureInfo = {
    >TTextureInfo,

    /**
     *  The scalar multiplier applied to each normal vector of the texture. This value scales the normal vector using the formula: `scaledNormal =  normalize((normalize(<sampled normal texture value>) * 2.0 - 1.0) * vec3(<normal scale>, <normal scale>, 1.0))`. This value is ignored if normalTexture is not specified. This value is linear.
     */
    @:optional var scale:Float;
}

/**
 *  Material Occlusion Texture Info
 */
typedef TMaterialOcclusionTextureInfo = {
    >TTextureInfo,

    /**
     *  A scalar multiplier controlling the amount of occlusion applied. A value of 0.0 means no occlusion. A value of 1.0 means full occlusion. This value affects the resulting color using the formula: `occludedColor = lerp(color, color * <sampled occlusion texture value>, <occlusion strength>)`. This value is ignored if the corresponding texture is not specified. This value is linear.
     */
    @:optional var strength:Float;
}

/**
 *  The material's alpha rendering mode enumeration specifying the interpretation of the alpha value of the main factor and texture.
 */
@:enum abstract TAlphaMode(String) {
    /**
     *  The alpha value is ignored and the rendered output is fully opaque.
     */
    var OPAQUE = "OPAQUE";

    /**
     *  The rendered output is either fully opaque or fully transparent depending on the alpha value and the specified alpha cutoff value.
     */
    var MASK = "MASK";

    /**
     *  The alpha value is used to composite the source and destination areas. The rendered output is combined with the background using the normal painting operation (i.e. the Porter and Duff over operator).
     */
    var BLEND = "BLEND";
}

/**
 *  The material appearance of a primitive.
 */
typedef TMaterial = {
    >TGLTFChildOfRootProperty,

    /**
     *  A set of parameter values that are used to define the metallic-roughness material model from Physically-Based Rendering (PBR) methodology. When not specified, all the default values of `pbrMetallicRoughness` apply.
     */
    @:optional var pbrMetallicRoughness:TMaterialPBRMetallicRoughness;

    /**
     *  A tangent space normal map. The texture contains RGB components in linear space. Each texel represents the XYZ components of a normal vector in tangent space. Red [0 to 255] maps to X [-1 to 1]. Green [0 to 255] maps to Y [-1 to 1]. Blue [128 to 255] maps to Z [1/255 to 1]. The normal vectors use OpenGL conventions where +X is right and +Y is up. +Z points toward the viewer. In GLSL, this vector would be unpacked like so: `float3 normalVector = tex2D(<sampled normal map texture value>, texCoord) * 2 - 1`.
     */
    @:optional var normalTexture:TMaterialNormalTextureInfo;

    /**
     *  The occlusion map texture. The occlusion values are sampled from the R channel. Higher values indicate areas that should receive full indirect lighting and lower values indicate no indirect lighting. These values are linear. If other channels are present (GBA), they are ignored for occlusion calculations.
     */
    @:optional var occlusionTexture:TMaterialOcclusionTextureInfo;

    /**
     *  The emissive map controls the color and intensity of the light being emitted by the material. This texture contains RGB components in sRGB color space. If a fourth component (A) is present, it is ignored.
     */
    @:optional var emissiveTexture:TTextureInfo;

    /**
     *  The RGB components of the emissive color of the material. These values are linear. If an emissiveTexture is specified, this value is multiplied with the texel values.
     */
    @:optional var emissiveFactor:Array<Float>;

    /**
     *  The material's alpha rendering mode enumeration specifying the interpretation of the alpha value of the main factor and texture.
     */
    @:optional var alphaMode:TAlphaMode;

    /**
     *  Specifies the cutoff threshold when in `MASK` mode. If the alpha value is greater than or equal to this value then it is rendered as fully opaque, otherwise, it is rendered as fully transparent. A value greater than 1.0 will render the entire material as fully transparent. This value is ignored for other modes.
     */
    @:optional var alphaCutoff:Float;

    /**
     *  Specifies whether the material is double sided. When this value is false, back-face culling is enabled. When this value is true, back-face culling is disabled and double sided lighting is enabled. The back-face must have its normals reversed before the lighting equation is evaluated.
     */
    @:optional var doubleSided:Bool;
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
package gltf.schema;

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

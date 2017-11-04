package gltf.schema;

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

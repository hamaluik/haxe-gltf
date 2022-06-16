package gltf.schema;

/**
 *  A view into a buffer generally representing a subset of the buffer.
 */
typedef TBufferView = {
    >TGLTFProperty,

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
    @:optional var byteStride:Int;

    /**
     *  The target that the GPU buffer should be bound to.
     */
    @:optional var target:TBufferTarget;
}

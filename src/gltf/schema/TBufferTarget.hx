package gltf.schema;

/**
 *  The target that the GPU buffer should be bound to.
 */
@:enum abstract TBufferTarget(Int) {
    var ARRAY_BUFFER = 34962;
    var ELEMENT_ARRAY_BUFFER = 34963;
}

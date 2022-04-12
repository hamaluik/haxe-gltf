package gltf.schema;

/**
 *  A node in the node hierarchy.  When the node contains `skin`, all `mesh.primitives` must contain `JOINTS_0` and `WEIGHTS_0` attributes.  A node can have either a `matrix` or any combination of `translation`/`rotation`/`scale` (TRS) properties. TRS properties are converted to matrices and postmultiplied in the `T * R * S` order to compose the transformation matrix; first the scale is applied to the vertices, then the rotation, and then the translation. If none are provided, the transform is the identity. When a node is targeted for animation (referenced by an animation.channel.target), only TRS properties may be present; `matrix` will not be present.
 */
typedef TNode = {
    >TGLTFChildOfRootProperty,
    >TGLTFProperty,

    /**
     *  The index of the camera referenced by this node.
     */
    @:optional var camera:TGLTFID;

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

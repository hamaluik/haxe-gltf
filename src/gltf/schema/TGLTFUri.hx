package gltf.schema;

typedef TGLTFUri = {
    /**
     *  The uri of the buffer.  Relative paths are relative to the .gltf file.  Instead of referencing an external file, the uri can also be a data-uri.
     */
    @:optional var uri:String;
}

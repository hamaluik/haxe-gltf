package gltf.types;

import gltf.GLTF;
import gltf.schema.TGLTFID;
import gltf.types.Accessor;
import gltf.schema.TMeshPrimitive;
import haxe.ds.Vector;
import gltf.schema.TComponentType;

typedef TAttribute = {
    var name:String;
    var accessor:Accessor;
}

@:allow(gltf.types.Mesh)
class MeshPrimitive {
    public var attributes(default, null):Vector<TAttribute> = new Vector<TAttribute>(0);
    public var indices(default, null):Null<Accessor> = null;
    public var material(default, null):Null<TGLTFID> = null;
    // TODO: mode
    // TODO: morph targets

    function new() {}

    function load(gltf:GLTF, primitive:TMeshPrimitive):Void {
        // load the attributes
        var names:Array<String> = Reflect.fields(primitive.attributes);
        attributes = new Vector<TAttribute>(names.length);
        for(i in 0...names.length) {
            var aid:Int = Reflect.field(primitive.attributes, names[i]);
            attributes[i] = {
                name: names[i],
                accessor: gltf.accessors[aid]
            };
        }

        if(primitive.indices != null) indices = gltf.accessors[primitive.indices];
        if(primitive.material != null) material = primitive.material;
    }

    public function getFloatAttributeValues(attribute:String):Vector<Float> {
        var accessor:Accessor = null;
        for(a in attributes) {
            if(a.name == attribute) {
                accessor = a.accessor;
                break;
            }
        }
        if(accessor == null) {
            throw 'This mesh primitive doesn\'t contain the \'${attribute}\' attribute!';
        }

        // allow ints to be used as floats
        if(accessor.componentType != TComponentType.FLOAT) {
            var ints: Vector<Int> = accessor.getInts();
            if(accessor.normalized) {
                return switch(accessor.componentType) {
                    case TComponentType.BYTE: ints.map((v: Int) -> ((v / 255.0) - 0.5) * 2.0);
                    case TComponentType.SHORT: ints.map((v: Int) -> ((v / 65535.0) - 0.5) * 2.0);
                    case TComponentType.UNSIGNED_BYTE: ints.map((v: Int) -> v / 255.0);
                    case TComponentType.UNSIGNED_SHORT: ints.map((v: Int) -> v / 65535.0);
                    case TComponentType.UNSIGNED_INT: ints.map((v: Int) -> v / 4294967295.0);
                    default: ints.map((v: Int) -> cast(v, Float));
                };
            }
            else {
                return ints.map((v: Int) -> cast(v, Float));
            }
        }
        else {
            return accessor.getFloats();
        }
    }

    public function getIntAttributeValues(attribute:String):Vector<Int> {
        var accessor:Accessor = null;
        for(a in attributes) {
            if(a.name == attribute) {
                accessor = a.accessor;
                break;
            }
        }
        if(accessor == null) {
            throw 'This mesh primitive doesn\'t contain the \'${attribute}\' attribute!';
        }

        return accessor.getInts();
    }

    public function getIndexValues():Vector<Int> {
        if(indices == null) {
            throw 'This mesh primitive doesn\'t have indices!';
        }
        return indices.getInts();
    }
}

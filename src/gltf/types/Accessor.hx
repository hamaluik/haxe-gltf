package gltf.types;

import gltf.schema.TGLTF;
import gltf.schema.TAccessor;
import gltf.schema.TComponentType;
import gltf.schema.TAttributeType;
import haxe.ds.Vector;

@:allow(gltf.GLTF)
class Accessor {
    public var bufferView(default, null):BufferView = null;
    public var byteOffset(default, null):Int = 0;
    public var count(default, null):Int = 0;
    public var componentType(default, null):TComponentType = TComponentType.BYTE;
    public var type(default, null):TAttributeType = TAttributeType.SCALAR;
    // TODO: normalized
    // TODO: min / max
    // TODO: sparse accessors

    function new() {}

    function load(gltf:GLTF, accessor:TAccessor):Void {
        bufferView = gltf.bufferViews[accessor.bufferView];
        byteOffset = accessor.byteOffset;
        count = accessor.count;
        componentType = accessor.componentType;
        type = accessor.type;
    }

    static function loadFromRaw(gltf:GLTF, raw:TGLTF):Vector<Accessor> {
        var accessors:Vector<Accessor> = new Vector<Accessor>(raw.accessors.length);
        for(i in 0...raw.accessors.length) {
            accessors[i] = new Accessor();
        }
        for(i in 0...raw.accessors.length) {
            accessors[i].load(gltf, raw.accessors[i]);
        }
        return accessors;
    }

    public function getInts():Vector<Int> {
        if(this.componentType == TComponentType.FLOAT) {
            throw 'This accessor points to `float` data, use `getFloats()` instead of `getInts()`!';
        }

        var componentSize:Int = switch(this.type) {
            case SCALAR: 1;
            case VEC2: 2;
            case VEC3: 3;
            case VEC4: 4;
            case MAT2: 4;
            case MAT3: 9;
            case MAT4: 16;
        };

        var data:Vector<Int> = new Vector<Int>(count*componentSize);

        var pos:Int = byteOffset;
        // TODO: signed / unsigned versions..
        var accessor:Int->Void = switch(this.componentType) {
            case BYTE | UNSIGNED_BYTE: function(i:Int) { data[i] = bufferView.data.get(pos); pos++; }
            case SHORT | UNSIGNED_SHORT: function(i:Int) { data[i] = bufferView.data.getUInt16(pos); pos += 2; }
            case UNSIGNED_INT: function(i:Int) { data[i] = bufferView.data.getInt32(pos); pos += 4; }
            case _: throw 'Floats aren\'t supported with this function!';
        }
        for(i in 0...(count*componentSize)) accessor(i);

        return data;
    }

    public function getFloats():Vector<Float> {
        if(this.componentType != TComponentType.FLOAT) {
            throw 'This accessor points to `int` data, use `getInts()` instead of `getFloats()`!';
        }

        var size:Int = switch(this.type) {
            case SCALAR: 1;
            case VEC2: 2;
            case VEC3: 3;
            case VEC4: 4;
            case MAT2: 4;
            case MAT3: 9;
            case MAT4: 16;
        };
        var data:Vector<Float> = new Vector<Float>(count*size);

        var pos:Int = byteOffset;
        for(i in 0...(count*size)) {
            data[i] = bufferView.data.getFloat(pos);
            pos += 4;
        }

        return data;
    }
}

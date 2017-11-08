package gltf.types;

import gltf.schema.TGLTF;
import gltf.schema.TBufferView;
import gltf.schema.TBufferTarget;
import haxe.ds.Vector;
import haxe.io.Bytes;

@:allow(gltf.GLTF)
class BufferView {
    public var buffer(default, null):Buffer = null;
    public var byteOffset(default, null):Int = 0;
    public var byteLength(default, null):Int = 0;
    public var byteStride(default, null):Int = 0;
    public var target(default, null):TBufferTarget = TBufferTarget.ARRAY_BUFFER;

    private var _data:Bytes = null;
    public var data(get, never):Bytes;
    private function get_data():Bytes {
        // TODO: deal with byteStride (https://github.com/KhronosGroup/glTF/tree/master/specification/2.0#data-alignment)
        if(_data == null) {
            _data = buffer.data.sub(byteOffset, byteLength);
        }
        return _data;
    }

    function new() {}

    function load(gltf:GLTF, bufferView:TBufferView):Void {
        this.buffer = gltf.buffers[bufferView.buffer];
        this.byteOffset = bufferView.byteOffset;
        this.byteLength = bufferView.byteLength;
        this.byteStride = bufferView.byteStride;
        this.target = bufferView.target;
    }

    static function loadFromRaw(gltf:GLTF, raw:TGLTF):Vector<BufferView> {
        var views:Vector<BufferView> = new Vector<BufferView>(raw.bufferViews.length);
        for(i in 0...raw.bufferViews.length) {
            views[i] = new BufferView();
        }
        for(i in 0...raw.bufferViews.length) {
            views[i].load(gltf, raw.bufferViews[i]);
        }
        return views;
    }
}

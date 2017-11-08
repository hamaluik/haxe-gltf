package gltf.types;

import gltf.types.BufferView;
import gltf.schema.TGLTF;
import gltf.schema.TImage;
import gltf.schema.TImageMimeType;
import haxe.ds.Vector;

@:allow(gltf.GLTF)
class Image {
    public var name(default, null):String = null;
    public var uri(default, null):Null<String> = null;
    public var mimeType(default, null):TImageMimeType = TImageMimeType.PNG;
    public var bufferView(default, null):Null<BufferView> = null;

    function new() {}

    function load(gltf:GLTF, image:TImage):Void {
        this.name = image.name;
        this.uri = image.uri;
        this.mimeType = image.mimeType;
        if(image.bufferView != null) this.bufferView = gltf.bufferViews[image.bufferView];
    }

    static function loadFromRaw(gltf:GLTF, raw:TGLTF):Vector<Image> {
        var images:Vector<Image> = new Vector<Image>(raw.images.length);
        for(i in 0...raw.images.length) {
            images[i] = new Image();
        }
        for(i in 0...raw.images.length) {
            images[i].load(gltf, raw.images[i]);
        }
        return images;
    }
}
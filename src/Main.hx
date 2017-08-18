package;

import gltf.GLTF;

class Main {
    public static function main() {
        var src:String = sys.io.File.getContent("sample-models/box/Box.gltf");

        var model:GLTF = GLTF.parse(src).load();
        trace(model.raw);
    }
}
package;

import haxe.io.Bytes;
import tink.CoreApi;
import gltf.GLTF;

using tink.core.Outcome;

class Main {
    private static function fetchAsset(uri:String):Promise<Bytes> {
        var p:Promise<Bytes> = null;
        uri = "sample-models/box/" + uri;
        if(!sys.FileSystem.exists(uri)) {
            p = new Error(tink.core.Error.ErrorCode.NotFound, "File not found: " + uri);
        }
        else {
            var ft:FutureTrigger<Bytes> = Future.trigger();
            ft.trigger(sys.io.File.getBytes(uri));
            p = ft.asFuture();
        }

        return  p;
    }

    public static function main() {
        GLTF.parseAndLoad('Box.gltf', fetchAsset)
        .handle(function(result:Outcome<GLTF, Error>) {
            switch(result) {
                case Success(glTF): {
                    trace('glTF loaded!');
                    trace(glTF);
                }

                case Failure(error): {
                    trace('Error loading glTF:');
                    trace(error.toString());
                }
            }
        });
    }
}
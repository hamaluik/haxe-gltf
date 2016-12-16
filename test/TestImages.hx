import buddy.*;
using buddy.Should;

import haxe.ds.StringMap;
import gltf.GLTF;

class TestImages extends BuddySuite {
	public function new(sources:StringMap<String>) {
		describe("Loading images", {
			var duck:GLTF = GLTF.parse(sources.get("duck"));
			it("should load a URI", {
				duck.images.get('file2').uri.should.be('DuckCM.png');
			});
		});
	}
}
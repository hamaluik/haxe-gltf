import buddy.*;
using buddy.Should;

import haxe.ds.StringMap;
import gltf.GLTF;

class TestScene extends BuddySuite {
	public function new(sources:StringMap<String>) {
		describe("Loading scene", {
			var box:GLTF = GLTF.parse(sources.get("box"));
			it("", {});
		});
	}
}
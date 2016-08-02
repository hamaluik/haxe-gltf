import buddy.*;
using buddy.Should;

import haxe.ds.StringMap;
import gltf.GLTF;

class TestSamplers extends BuddySuite {
	public function new(sources:StringMap<String>) {
		describe("Loading samplers", {
			var box:GLTF = GLTF.parse(sources.get("box"));
			it("", {});
		});
	}
}
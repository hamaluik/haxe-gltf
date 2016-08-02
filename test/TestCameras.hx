import buddy.*;
using buddy.Should;

import haxe.ds.StringMap;
import gltf.GLTF;

class TestCameras extends BuddySuite {
	public function new(sources:StringMap<String>) {
		describe("Loading cameras", {
			var box:GLTF = GLTF.parse(sources.get("box"));
			it("", {});
		});
	}
}
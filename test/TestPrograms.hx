import buddy.*;
using buddy.Should;

import haxe.ds.StringMap;
import gltf.GLTF;

class TestPrograms extends BuddySuite {
	public function new(sources:StringMap<String>) {
		describe("Loading programs", {
			var box:GLTF = GLTF.parse(sources.get("box"));
			it("", {});
		});
	}
}
import buddy.*;
using buddy.Should;

import haxe.ds.StringMap;
import gltf.GLTF;

class TestMeshes extends BuddySuite {
	public function new(sources:StringMap<String>) {
		describe("Loading meshes", {
			var box:GLTF = GLTF.parse(sources.get("box"));
			it("", {});
		});
	}
}
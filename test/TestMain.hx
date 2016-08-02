using buddy.Should;

import gltf.*;
import haxe.ds.StringMap;

class TestMain extends buddy.SingleSuite {
	public function new() {
		describe("Loading GLTF", {
			// load the test files
			var sources:StringMap<String> = new StringMap<String>();
			sources.set("box", haxe.Resource.getString("box"));

			it("should parse and load a standard file without error", {
				GLTF.parse.bind(sources.get("box")).should.not.throwAnything();
			});
		});
	}
}
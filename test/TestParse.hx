import buddy.*;
using buddy.Should;

import gltf.*;
import haxe.ds.StringMap;

class TestParse extends BuddySuite {
	public function new(sources:StringMap<String>) {
		describe("Loading GLTF", {
			it("should parse and load a standard file without error", {
				GLTF.parse.bind(sources.get("box")).should.not.throwAnything();
			});

			it("should complain about null being passed in for parsing", {
				GLTF.parse.bind(null).should.throwAnything();
			});

			it("should complain about null being passed in for loading", {
				GLTF.load.bind(null).should.throwAnything();
			});
		});
	}
}
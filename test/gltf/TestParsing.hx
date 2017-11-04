package gltf;

import buddy.*;
using buddy.Should;

using gltf.GLTF;

class TestParsing extends BuddySuite {
	public function new() {
		describe('Parsing GLTF', {
			it("should parse gltf files");
			it("should parse glb files");
		});
	}
}
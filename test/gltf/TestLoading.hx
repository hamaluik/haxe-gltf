package gltf;

import buddy.*;
using buddy.Should;

using gltf.GLTF;

class TestLoading extends BuddySuite {
	public function new() {
		describe('Loading GLTFs', {
			it("should load an array of nodes");
			it("should load an array of scenes and set the default scene");
		});
	}
}
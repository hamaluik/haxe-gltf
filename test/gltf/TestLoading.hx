package gltf;

import buddy.*;
using buddy.Should;

class TestLoading extends BuddySuite {
	public function new() {
		describe('Loading GLTFs', {
			var boxSrc:String = '{}';
			var raw:Schema.TGLTF = GLTF.parse(boxSrc);
			var gltf:GLTF = GLTF.load(raw);

			it("should load an array of nodes", {
				
			});

			it("should load an array of scenes and set the default scene");
		});
	}
}
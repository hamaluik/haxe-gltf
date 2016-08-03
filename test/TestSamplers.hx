import buddy.*;
using buddy.Should;

import gltf.Sampler;
import gltf.Sampler.FilterType;
import gltf.Sampler.WrapMode;
import haxe.ds.StringMap;
import gltf.GLTF;

class TestSamplers extends BuddySuite {
	public function new(sources:StringMap<String>) {
		describe("Loading samplers", {
			var duck:GLTF = GLTF.parse(sources.get("duck"));
			var s:Sampler = duck.samplers.get('sampler_0');

			it("should load filters", {
				s.magFilter.should.be(FilterType.LINEAR);
				s.minFilter.should.be(FilterType.LINEAR_MIPMAP_LINEAR);
			});

			it("should load wrap modes", {
				s.wrapS.should.be(WrapMode.REPEAT);
				s.wrapT.should.be(WrapMode.REPEAT);
			});
		});
	}
}
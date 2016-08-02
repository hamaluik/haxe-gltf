import buddy.*;
using buddy.Should;

import gltf.type.BufferType;
import haxe.ds.StringMap;
import gltf.GLTF;

class TestBuffers extends BuddySuite {
	public function new(sources:StringMap<String>) {
		describe("Loading buffers", {
			var box:GLTF = GLTF.parse(sources.get("box"));

			it("should load the raw URI", {
				box.buffers.get("Box").uri.should.be("Box.bin");
			});

			it("should load the byte length", {
				box.buffers.get("Box").byteLength.should.be(648);
			});

			it("should reference a buffer type", {
				box.buffers.get("Box").type.should.be(BufferType.ARRAY_BUFFER);
			});

			it("should reference a name", {
				box.buffers.get("Box").name.should.be(null);
			});
		});
	}
}
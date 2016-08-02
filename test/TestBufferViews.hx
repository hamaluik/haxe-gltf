import buddy.*;
using buddy.Should;

import gltf.BufferView;
import gltf.type.BufferViewType;
import haxe.ds.StringMap;
import gltf.GLTF;

class TestBufferViews extends BuddySuite {
	public function new(sources:StringMap<String>) {
		describe("Loading buffer views", {
			var box:GLTF = GLTF.parse(sources.get("box"));
			var view:BufferView = box.bufferViews.get("bufferView_30");
			it("should reference the ID of a buffer", {
				view.buffer.should.be("Box");
				box.buffers.get(view.buffer).should.not.be(null);
			});

			it("should specify the byte offset into the buffer", {
				view.byteOffset.should.be(72);
			});

			it("should specify the length of the view in bytes", {
				view.byteLength.should.be(576);
			});

			it("should reference a buffer view type", {
				view.target.should.be(BufferViewType.ARRAY_BUFFER);
			});
		});
	}
}
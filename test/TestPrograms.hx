import buddy.*;
using buddy.Should;

import haxe.ds.StringMap;
import gltf.GLTF;

class TestPrograms extends BuddySuite {
	public function new(sources:StringMap<String>) {
		describe("Loading programs", {
			var box:GLTF = GLTF.parse(sources.get("box"));
			it("should reference vertex and fragment shaders", {
				box.programs.get('program_0').vertexShader.should.be('Box0VS');
				box.programs.get('program_0').fragmentShader.should.be('Box0FS');
			});

			it("should list program attributes", {
				box.programs.get('program_0').attributes.length.should.be(2);
				box.programs.get('program_0').attributes[0].should.be('a_normal');
				box.programs.get('program_0').attributes[1].should.be('a_position');
			});
		});
	}
}
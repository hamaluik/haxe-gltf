import buddy.*;
using buddy.Should;

import gltf.Shader.ShaderType;
import haxe.ds.StringMap;
import gltf.GLTF;

class TestShaders extends BuddySuite {
	public function new(sources:StringMap<String>) {
		describe("Loading shaders", {
			var box:GLTF = GLTF.parse(sources.get("box"));
			it("should load the shader type", {
				box.shaders.get('Box0FS').type.should.be(ShaderType.FRAGMENT_SHADER);
				box.shaders.get('Box0VS').type.should.be(ShaderType.VERTEX_SHADER);
			});

			it('should load the shader URIs', {
				box.shaders.get('Box0FS').uri.should.be('Box0FS.glsl');
				box.shaders.get('Box0VS').uri.should.be('Box0VS.glsl');
			});
		});
	}
}
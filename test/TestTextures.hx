import buddy.*;
using buddy.Should;

import gltf.Texture;
import gltf.Texture.TexelDataType;
import gltf.Texture.TextureFormat;
import gltf.Texture.TextureTarget;
import haxe.ds.StringMap;
import gltf.GLTF;

class TestTextures extends BuddySuite {
	public function new(sources:StringMap<String>) {
		describe("Loading textures", {
			var duck:GLTF = GLTF.parse(sources.get("duck"));
			var texture:Texture = duck.textures.get('texture_file2');
			it("should load texture information", {
				texture.format.should.be(TextureFormat.RGBA);
				texture.internalFormat.should.be(TextureFormat.RGBA);
				texture.sampler.should.be('sampler_0');
				texture.source.should.be('file2');
				texture.target.should.be(TextureTarget.TEXTURE_2D);
				texture.type.should.be(TexelDataType.UNSIGNED_BYTE);
			});
		});
	}
}
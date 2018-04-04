package gltf;

import gltf.schema.TGLTF;
import buddy.*;
using buddy.Should;

class TestParsing extends BuddySuite {
    public function new() {
        describe('Parsing GLTF', {
            var boxSrc:String = sys.io.File.getContent('samples/Box.gltf');
            var riggedSimpleSrc:String = sys.io.File.getContent('samples/RiggedSimple.gltf');
            var riggedSimpleRaw:TGLTF = GLTF.parse(riggedSimpleSrc);

            it("should parse gltf files", {
                var raw:TGLTF = GLTF.parse(boxSrc);

                raw.asset.generator.should.be("COLLADA2GLTF");
                raw.asset.version.should.be("2.0");

                raw.scene.should.be(0);
                raw.scenes.length.should.be(1);
                raw.scenes[0].nodes.length.should.be(1);
                raw.scenes[0].nodes[0].should.be(0);

                raw.nodes.length.should.be(2);
                raw.nodes[0].children.length.should.be(1);
                raw.nodes[1].children.should.be(null);
            });

            it('should parse all nodes', {
                riggedSimpleRaw.nodes.length.should.be(5);
            });

            it('should parse children arrays', {
                riggedSimpleRaw.nodes[0].children.should.not.be(null);
                riggedSimpleRaw.nodes[0].children.length.should.be(2);
                riggedSimpleRaw.nodes[0].children[0].should.be(4);
                riggedSimpleRaw.nodes[0].children[1].should.be(1);
                riggedSimpleRaw.nodes[4].children.should.not.be(null);
                if(riggedSimpleRaw.nodes[4].children != null) {
                    riggedSimpleRaw.nodes[4].children.length.should.be(1);
                    riggedSimpleRaw.nodes[4].children[0].should.be(2);
                }
                riggedSimpleRaw.nodes[1].children.should.be(null);
            });

            it('should parse matrices', {
                riggedSimpleRaw.nodes[0].matrix.length.should.be(16);
                riggedSimpleRaw.nodes[0].matrix[6].should.be(-1.0);
            });

            it('should parse mesh and skin', {
                if(riggedSimpleRaw.nodes[0].mesh != null) fail('node 0 mesh is not null');
                if(riggedSimpleRaw.nodes[0].skin != null) fail('node 0 skin is not null');

                riggedSimpleRaw.nodes[1].mesh.should.be(0);
                riggedSimpleRaw.nodes[1].skin.should.be(0);
            });

            it('should auto-supply matrix and transform components', {
                riggedSimpleRaw.nodes[0].translation.should.not.be(null);
                riggedSimpleRaw.nodes[1].matrix.should.not.be(null);
            });

            it('should load the animations', {
                riggedSimpleRaw.animations.should.not.be(null);
                riggedSimpleRaw.animations.length.should.be(1);
            });

            it('should load the animation channels', {
                riggedSimpleRaw.animations[0].channels.should.not.be(null);
                riggedSimpleRaw.animations[0].channels.length.should.be(6);

                riggedSimpleRaw.animations[0].channels[0].should.not.be(null);
                riggedSimpleRaw.animations[0].channels[1].should.not.be(null);
                riggedSimpleRaw.animations[0].channels[2].should.not.be(null);
                riggedSimpleRaw.animations[0].channels[3].should.not.be(null);
                riggedSimpleRaw.animations[0].channels[4].should.not.be(null);
                riggedSimpleRaw.animations[0].channels[5].should.not.be(null);

                riggedSimpleRaw.animations[0].channels[5].sampler.should.be(5);
                riggedSimpleRaw.animations[0].channels[5].target.node.should.be(3);
                riggedSimpleRaw.animations[0].channels[5].target.path.should.be(gltf.schema.TAnimationChannelTargetPath.SCALE);
            });

            it('should load the animation samplers', {
                riggedSimpleRaw.animations[0].samplers.should.not.be(null);
                riggedSimpleRaw.animations[0].samplers.length.should.be(6);

                riggedSimpleRaw.animations[0].samplers[0].should.not.be(null);
                riggedSimpleRaw.animations[0].samplers[1].should.not.be(null);
                riggedSimpleRaw.animations[0].samplers[2].should.not.be(null);
                riggedSimpleRaw.animations[0].samplers[3].should.not.be(null);
                riggedSimpleRaw.animations[0].samplers[4].should.not.be(null);
                riggedSimpleRaw.animations[0].samplers[5].should.not.be(null);
            });

            it("should parse glb files");
        });
    }
}

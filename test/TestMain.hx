import buddy.reporting.ConsoleColorReporter;
import haxe.ds.StringMap;

class TestMain {
	public static function main() {
		// load all our resource files
		var sources:StringMap<String> = new StringMap<String>();
		sources.set("box", haxe.Resource.getString("box"));

		// use coloured console
		var reporter = new ConsoleColorReporter();

		// build our suite runner
		var runner = new buddy.SuitesRunner([
			new TestParse(sources),
			new TestAccessors(sources),
			new TestAnimations(sources),
			new TestAsset(sources),
			new TestBufferViews(sources),
			new TestBuffers(sources),
			new TestCameras(sources),
			new TestImages(sources),
			new TestMaterials(sources),
			new TestMeshes(sources),
			new TestNodes(sources),
			new TestPrograms(sources),
			new TestSamplers(sources),
			new TestScene(sources),
			new TestScenes(sources),
			new TestShaders(sources),
			new TestSkins(sources),
			new TestTechniques(sources),
			new TestTextures(sources),
		], reporter);

		// and run!
		runner.run();

		#if sys
		Sys.exit(runner.statusCode());
		#end
	}
}
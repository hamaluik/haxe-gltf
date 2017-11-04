import gltf.*;

class TestMain {
	public static function main() {
		var reporter = new buddy.reporting.ConsoleFileReporter(true);
		var runner = new buddy.SuitesRunner([
			new TestGLTF(),
		], reporter);

		runner.run();
	}
}
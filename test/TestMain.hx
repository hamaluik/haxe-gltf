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
            new TestMaterials(sources)
        ], reporter);

        // and run!
        runner.run();

        #if sys
        Sys.exit(runner.statusCode());
        #end
    }
}
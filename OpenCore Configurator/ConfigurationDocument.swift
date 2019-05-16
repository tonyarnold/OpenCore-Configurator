import AppKit

final class ConfigurationDocument: NSDocument {
    var configuration: Configuration = Configuration()

    override func makeWindowControllers() {
        guard let windowController = NSStoryboard.main.instantiateInitialController() as? DocumentWindowController else {
            fatalError("Document window controller could not be instantiated from storyboard!")
        }

        windowController.shouldCloseDocument = true
        addWindowController(windowController)
    }

    override func read(from url: URL, ofType _: String) throws {
        let data = try Data(contentsOf: url)
        let decoder = PropertyListDecoder()
        configuration = try decoder.decode(Configuration.self, from: data)
    }

    override func write(to url: URL, ofType _: String) throws {
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml
        let data = try encoder.encode(configuration)
        try data.write(to: url)
    }
}

import AppKit

final class ConfigurationDetailViewController: NSTabViewController {
    override var representedObject: Any? {
        didSet {
            children.setEach(\.representedObject, to: representedObject)
        }
    }

    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        (segue.destinationController as? NSViewController)?.representedObject = representedObject
    }
}

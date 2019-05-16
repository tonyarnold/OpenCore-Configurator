import AppKit

final class DocumentWindowController: NSWindowController {
    override var document: AnyObject? {
        didSet {
            contentViewController?.representedObject = (document as? ConfigurationDocument)?.configuration
        }
    }

    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        guard
            let document = document as? ConfigurationDocument,
            let controller = segue.destinationController as? NSViewController
        else {
            return
        }

        controller.representedObject = document.configuration
    }
}

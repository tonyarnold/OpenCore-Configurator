import AppKit

final class TextEditingTableCellView: NSTableCellView {
    var provideValue: ((Any?) -> String?)?
    var handleValueChange: ((Any?, String) -> Void)?

    override var objectValue: Any? {
        didSet {
            textField?.stringValue = provideValue?(objectValue) ?? ""
        }
    }

    override var textField: NSTextField? {
        didSet {
            textField?.target = self
            textField?.action = #selector(updateValue(_:))
        }
    }

    @IBAction func updateValue(_ sender: NSTextField) {
        handleValueChange?(objectValue, sender.stringValue)
    }
}

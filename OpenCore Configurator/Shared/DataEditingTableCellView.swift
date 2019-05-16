import AppKit

final class DataEditingTableCellView: NSTableCellView {
    var provideValue: ((Any?) -> Data?)?
    var handleValueChange: ((Any?, Data?) -> Void)?

    override var objectValue: Any? {
        didSet {
            textField?.stringValue = (provideValue?(objectValue) ?? Data(count: 0)).hexEncodedString()
        }
    }

    override var textField: NSTextField? {
        didSet {
            textField?.target = self
            textField?.action = #selector(updateValue(_:))
        }
    }

    @IBAction func updateValue(_ sender: NSTextField) {
        handleValueChange?(objectValue, Data(hexString: sender.stringValue))
    }
}

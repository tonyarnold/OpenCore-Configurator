import AppKit

final class NumberEditingTableCellView: NSTableCellView {
    var provideValue: ((Any?) -> NSNumber?)?
    var handleValueChange: ((Any?, NSNumber?) -> Void)?

    override var objectValue: Any? {
        didSet {
            guard
                let number = provideValue?(objectValue),
                let displayNumber = numberFormatter.string(from: number)
            else {
                textField?.stringValue = ""
                return
            }

            textField?.stringValue = displayNumber
        }
    }

    override var textField: NSTextField? {
        didSet {
            textField?.target = self
            textField?.action = #selector(updateValue(_:))
        }
    }

    @IBAction func updateValue(_ sender: NSTextField) {
        handleValueChange?(objectValue, numberFormatter.number(from: sender.stringValue))
    }

    private let numberFormatter = NumberFormatter()
}

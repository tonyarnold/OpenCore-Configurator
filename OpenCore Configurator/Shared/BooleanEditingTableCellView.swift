import AppKit

final class BooleanEditingTableCellView: NSTableCellView {
    var provideValue: ((Any?) -> Bool?)?
    var handleValueChange: ((Any?, Bool) -> Void)?

    @IBOutlet var checkbox: NSButton! {
        didSet {
            checkbox.target = self
            checkbox.action = #selector(updateValue(_:))
        }
    }

    override var objectValue: Any? {
        didSet {
            checkbox.state = provideValue?(objectValue) ?? false ? .on : .off
        }
    }

    @IBAction func updateValue(_ sender: NSButton) {
        handleValueChange?(objectValue, sender.state == .on)
    }
}

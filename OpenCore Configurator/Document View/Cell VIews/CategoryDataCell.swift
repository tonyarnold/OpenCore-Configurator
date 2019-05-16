import AppKit

final class CategoryDataCell: NSTableCellView {
    override var objectValue: Any? {
        didSet {
            textField?.stringValue = (objectValue as? NSViewController)?.title ?? ""
        }
    }
}

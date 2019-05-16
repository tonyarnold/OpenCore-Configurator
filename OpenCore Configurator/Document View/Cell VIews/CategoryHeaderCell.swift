import AppKit

final class CategoryHeaderCell: NSTableCellView {
    override var objectValue: Any? {
        didSet {
            textField?.stringValue = (objectValue as? Configuration.Category)?.localizedDescription ?? ""
        }
    }
}

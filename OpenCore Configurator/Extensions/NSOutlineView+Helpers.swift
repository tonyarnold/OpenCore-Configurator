import AppKit

extension NSOutlineView {
    /// Returns the represented item for the currently selected row, or nil
    var selectedItem: Any? {
        if numberOfSelectedRows == 1 {
            return item(atRow: selectedRow)
        } else {
            return nil
        }
    }

    var selectedItems: [Any] {
        return selectedRowIndexes.compactMap { self.item(atRow: $0) }
    }
}
